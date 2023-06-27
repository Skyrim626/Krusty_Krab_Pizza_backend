<?php
include('cors.php');

// Database configuration
$host = 'localhost';
$username = 'root';
$password = '';
$database = 'pizza_runner';

// Create a new mysqli instance
$mysqli = new mysqli($host, $username, $password, $database);

// Check the connection
if ($mysqli->connect_errno) {
    echo json_encode(['error' => 'Failed to connect to MySQL: ' . $mysqli->connect_error]);
    exit();
}

// Handle PUT request to update cancellation
if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    $orderId = $_GET['order_id'];
    $requestData = json_decode(file_get_contents('php://input'), true);
    file_put_contents('debug.txt', print_r($requestData, true));

    if (isset($requestData['cancellation'])) {
        $cancellation = $requestData['cancellation'];
        updateCancellation($orderId, $cancellation);
    } else {
        echo json_encode(['error' => 'Cancellation data is missing']);
    }
}

// Fetch all data from the runner_orders table
function fetchAllData()
{
    global $mysqli; // Access the $mysqli object

    $sql = "SELECT * FROM runner_orders";

    $result = $mysqli->query($sql);

    $data = array();
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }

    return $data;
}

// Update the cancellation for a specific order ID
function updateCancellation($orderId, $cancellation)
{
    global $mysqli; // Access the $mysqli object

    $sql = "UPDATE runner_orders SET cancellation = '$cancellation' WHERE order_id = $orderId";
    if ($mysqli->query($sql) === TRUE) {
        echo json_encode(['message' => 'Cancellation updated successfully']);
    } else {
        echo json_encode(['error' => 'Error updating cancellation']);
    }
}

// Handle GET request to fetch all data
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $data = fetchAllData();
    echo json_encode($data);
}

// Close the database connection
$mysqli->close();

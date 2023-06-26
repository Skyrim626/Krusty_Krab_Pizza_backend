<?php
include_once('db.php');
include_once('request.php');
include('cors.php');

$data = json_decode(file_get_contents('php://input'), true);
$email = $data['email'];
$password = $data['password'];

$query = "SELECT * FROM customers WHERE email = ? AND password = ?";
$stmt = $mysqli->prepare($query);
$stmt->bind_param("ss", $email, $password);
$stmt->execute();

$result = $stmt->get_result();

if ($result->num_rows === 1) {
    $customerData = $result->fetch_assoc();
    $response = array(
        'status' => true,
        'customerData' => $customerData
    );
} else {
    $response = array('status' => false);
}

$stmt->close();
$mysqli->close();

header('Content-Type: application/json');
echo json_encode($response);

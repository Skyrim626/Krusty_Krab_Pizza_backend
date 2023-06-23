<?php
include_once('db.php');

$requestData = json_decode(file_get_contents('php://input'), true);
$searchValue = $requestData['searchValue'];

$stmt = $mysqli->prepare("CALL total_customer_orders_in_a_day(?)");
$searchTerm = '%' . $searchValue . '%';

// Convert the search value to the appropriate date format
$searchDate = date('Y-m-d', strtotime($searchValue));

$stmt->bind_param("s", $searchDate);
$stmt->execute();
$result = $stmt->get_result();

$searchResults = [];
while ($row = $result->fetch_assoc()) {
    $searchResults[] = $row;
}

$stmt->close();

// Return the search results as JSON
header('Content-Type: application/json');
echo json_encode($searchResults);

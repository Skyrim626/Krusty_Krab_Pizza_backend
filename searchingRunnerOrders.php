<?php
include_once('db.php');

$requestData = json_decode(file_get_contents('php://input'), true);
$searchValue = $requestData['searchValue'];

$stmt = $mysqli->prepare("CALL getRunnerOrders(?)");
$searchTerm = '%' . $searchValue . '%';

$stmt->bind_param("i", $searchValue); // Use "i" for integer data type
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

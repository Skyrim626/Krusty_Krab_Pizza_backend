<?php

include_once('db.php');

$data = json_decode(file_get_contents('php://input'), true);

$pizza_id = $data['pizza_id'];
$customer_id = $data['customer_id'];
$order_id = 1; // Set a value for the order_id column

$stmt = $mysqli->prepare("INSERT INTO customer_orders (order_id, pizza_id, customer_id) VALUES (?, ?, ?)");
$stmt->bind_param("iii", $order_id, $pizza_id, $customer_id);

if ($stmt->execute()) {
    $response = array('status' => $pizza_id, 'message' => $customer_id);
    echo json_encode($response);
} else {
    $response = array('status' => 'error', 'message' => 'Error inserting data');
    echo json_encode($response);
}

$stmt->close();

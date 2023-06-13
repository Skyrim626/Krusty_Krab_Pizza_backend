<?php

include_once('db.php');

// Retrieve customer data from the database
$sql = "SELECT COUNT(*) as total FROM runner_orders WHERE cancellation IS NULL || cancellation = ''";
$result = $mysqli->query($sql);

if ($result->num_rows > 0) {
    $customers = array();
    while ($row = $result->fetch_assoc()) {
        $customers[] = $row;
    }

    // Return customer data as JSON response

    echo json_encode($customers);
} else {
    echo json_encode(["status" => false, "message" => "No Customers Data"]);
}

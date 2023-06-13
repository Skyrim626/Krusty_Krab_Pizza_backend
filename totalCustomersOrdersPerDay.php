<?php

include_once('db.php');

// Retrieve customer data from the database
$sql = "CALL total_customer_orders_per_day;";
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

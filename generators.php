<?php

include_once('db.php');

$requestData = json_decode(file_get_contents('php://input'), true);
$searchValue = $requestData['procedureType'];

switch ($searchValue) {

    case "getTotalRunners":
        $sql = "SELECT COUNT(*) AS total FROM runners";
        break;

    case "getTop10Pizza":
        $sql = "CALL getTopPizzas";
        break;

    case "getAllRunners":
        $sql =
            "SELECT * FROM runners";
        break;

    case "getAllToppings":
        $sql = "SELECT * FROM pizza_toppings";
        break;

    case "getAllCancelledOrders":
        $sql = "SELECT COUNT(*) AS total FROM audit_table";
        break;

    case "getPizzasSold":
        $sql = "SELECT COUNT(*) as total FROM runner_orders WHERE cancellation IS NULL || cancellation = ''";
        break;

    case "getTotalCustomers":
        $sql = "SELECT COUNT(*) AS total FROM customers";
        break;

    case "procedure2":
        $sql = "CALL total_customer_orders_per_day";
        break;

    case "procedure3":
        $sql = "CALL number_of_customer_orders";
        break;

    case "procedure9":
        $sql = "CALL get20RecentlyRegistered";
        break;
}

$result = $mysqli->query($sql);

if ($result->num_rows > 0) {
    $data = array();
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }

    // Return customer data as JSON response

    echo json_encode($data);
} else {
    echo json_encode(["status" => false, "message" => "No Data"]);
}

<?php

include_once('db.php');
include_once('request.php');
include('cors.php');

$requestType = $_SERVER['REQUEST_METHOD'];

if (!check("POST", $requestType)) {
    echo "Error: 403 Forbidden Access";
    exit();
}

$data = json_decode(file_get_contents('php://input'), true);

/* $sql = 'SELECT * FROM users WHERE username="'.$data["username"].'" AND password="'.$data["password"].'"'; */
$sql = 'SELECT * FROM admins WHERE username = "' . $data["username"] . '" AND password = "' . $data["password"] . '"';
$result = $mysqli->query($sql);

if ($result->num_rows > 0) {
    echo json_encode(["status" => true, "message" => "account found"]);
} else {
    echo json_encode(["status" => false, "message" => "account not found"]);
}

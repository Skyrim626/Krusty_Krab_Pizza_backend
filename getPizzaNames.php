<?php

include_once('db.php');


$query = "SELECT * FROM pizza_names";

$result = mysqli_query($mysqli, $query);

// Fetch the query results and store them in an array
$data = array();
while ($row = mysqli_fetch_assoc($result)) {
    $data[] = $row;
}

// Return the data as JSON
header('Content-Type: application/json');
echo json_encode($data);

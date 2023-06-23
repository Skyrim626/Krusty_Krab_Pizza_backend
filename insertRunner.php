<?php
include_once('db.php');

$firstName = $_POST['firstName'];
$lastName = $_POST['lastName'];
$date = date('Y-m-d', strtotime($_POST['date']));
$age = intval($_POST['age']);


// Validate input values
if (empty($firstName) || empty($lastName) || empty($date) || empty($age)) {
    $response = array('firstName1' => $firstName, 'lastName2' => $lastName, 'date3' => $date, 'age4' => $age);
    echo json_encode($response);
    exit;
}

// Perform additional validation as needed (e.g., validate age as a numeric value)

// Use prepared statements to prevent SQL 
$stmt = $mysqli->prepare("INSERT INTO runners (first_name, last_name, age, birth_date) VALUES (?, ?, ?, ?)");
$stmt->bind_param("ssis", $firstName, $lastName, $age, $date);

if ($stmt->execute()) {
    $response = array('status' => 'success', 'message' => 'Data inserted successfully');
    echo json_encode($response);
} else {
    $response = array('status' => 'error', 'message' => 'Error inserting data');
    echo json_encode($response);
}

$stmt->close();
$mysqli->close();

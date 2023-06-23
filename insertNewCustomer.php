<?php
include_once('db.php');

$firstName = $_POST['firstName'];
$lastName = $_POST['lastName'];
$email = $_POST['email'];
$password = $_POST['password'];
$phoneNumber = $_POST['phone_number'];
$address = $_POST['address'];
$city = $_POST['city'];
$state = $_POST['state'];
$postalCode = $_POST['postal_code'];
$country = $_POST['country'];

// Validate input values
if (empty($firstName) || empty($lastName) || empty($email) || empty($password) || empty($address) || empty($city) || empty($country)) {
    $response = array('status' => 'error', 'message' => 'Please provide all required fields');
    echo json_encode($response);
    exit;
}

// Perform additional input validation if needed
// ...

try {
    // Use prepared statements to prevent SQL injection
    $stmt = $mysqli->prepare("INSERT INTO customers (first_name, last_name, email, password, phone_number, address, city, state, postal_code, country) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("ssssssssss", $firstName, $lastName, $email, $password, $phoneNumber, $address, $city, $state, $postalCode, $country);

    if ($stmt->execute()) {
        $response = array('status' => 'success', 'message' => 'Data inserted successfully');
        echo json_encode($response);
    } else {
        $response = array('status' => 'error', 'message' => 'Error inserting data');
        echo json_encode($response);
    }

    $stmt->close();
} catch (Exception $e) {
    $response = array('status' => 'error', 'message' => 'An error occurred');
    echo json_encode($response);
}

$mysqli->close();

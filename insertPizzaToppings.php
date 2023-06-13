<?php

include_once('db.php');

$targetDir = "";

$targetFile = $targetDir . basename($_FILES["file"]["name"]);

/* $response = array(
    "status" => $targetFile,
    "message" => "Invalid file type. Only XML files are allowed."
);
echo json_encode($response);
exit; */

$fileType = pathinfo($targetFile, PATHINFO_EXTENSION);

// Check if file is a valid XML file
if ($fileType != "xml") {
    $response = array(
        "status" => "error",
        "message" => "Invalid file type. Only XML files are allowed."
    );
    echo json_encode($response);
    exit;
}

// Move uploaded file to the target directory
if (move_uploaded_file($_FILES["file"]["tmp_name"], $targetFile)) {



    if ($mysqli->connect_error) {
        $response = array(
            "status" => "error",
            "message" => "Failed to connect to the database: " . $mysqli->connect_error
        );
        echo json_encode($response);
        exit;
    }

    // Parse the XML file and extract the data
  $xml = simplexml_load_file($targetFile);

  // Extract the toppings from the XML and perform necessary insertions into the database

  $sql = "INSERT INTO pizza_toppings (topping_name) VALUES (?)";
  $stmt = $mysqli->prepare($sql);

  foreach ($xml->topping as $topping) {
    $toppingName = (string)$topping;

    $stmt->bind_param("s", $toppingName);
    $stmt->execute();
  }

  $stmt->close();
  $mysqli->close();

  // Clean up the uploaded file
  unlink($targetFile);

  $response = array(
    "status" => "success",
    "message" => "File uploaded and data inserted successfully."
  );
  echo json_encode($response);

} else {
    // Failed to move the uploaded file
    $response = array(
      "status" => "error",
      "message" => "Error uploading the file. Please try again."
    );
    echo json_encode($response);
  }

?>
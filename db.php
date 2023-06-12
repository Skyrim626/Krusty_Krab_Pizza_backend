<?php
$mysqli = new mysqli("localhost", "root", "", "pizza_runner");

// Check connection
if ($mysqli->connect_errno) {
  echo "Failed to connect to MySQL: " . $mysqli->connect_error;
  exit();
}

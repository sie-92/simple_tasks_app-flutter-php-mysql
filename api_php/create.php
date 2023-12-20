<?php
header('Content-Type: application/json');
include "db.php";

$name = $_GET['name'];
$age = (int) $_GET['user_id'];

$stmt = $db->prepare("INSERT INTO task (name, user_id) VALUES (?, ?)");
$result = $stmt->execute([$name, $age]);

if ($result) {
		echo json_encode("Success");
	}else{
		echo json_encode("Error");
	}

?>

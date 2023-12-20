<?php
header('Content-Type: application/json');
include "db.php";

$stmt = $db->prepare("SELECT id, username FROM user");
$stmt->execute();
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);
?>
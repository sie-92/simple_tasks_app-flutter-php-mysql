<?php
header('Content-Type: application/json');
include "db.php";

$stmt = $db->prepare("SELECT id, name, user_id FROM task");
$stmt->execute();
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);
?>
<?php

$db_name = "4226750_task";
$db_server = "fdb28.awardspace.net";
$db_user = "4226750_task";
$db_pass = "aaaa1234";

$db = new PDO("mysql:host={$db_server};dbname={$db_name};charset=utf8", $db_user, $db_pass);
$db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
?>
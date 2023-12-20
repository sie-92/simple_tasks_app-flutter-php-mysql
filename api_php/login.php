<?php 
include "db.php";

	$db = mysqli_connect($db_server,$db_user,$db_pass,$db_name);

	$username = $_GET['username'];
	$password = $_GET['password'];

	$sql = "SELECT * FROM user WHERE username = '".$username."' AND password = '".$password."'";

	$result = mysqli_query($db,$sql);
	$count = mysqli_num_rows($result);

	if ($count == 1) {
		echo json_encode("Success");
	}else{
		echo json_encode("Error");
	}

?>
<?php
	$linkid = $_POST['linkid'];
	$direction = $_POST['direction'];
	$ip = $_SERVER['REMOTE_ADDR'];
	
	$dbconn = pg_connect("host=localhost dbname=linkorgs user=linkorgs password=test123123")
			or die('Failure: ' . pg_last_error());

		// Query
		$query = "INSERT INTO votes (fk_link_id, direction, ip) VALUES ('$linkid', '$direction', '$ip')";    ## Make SQL Injection Proof / use PDOs
		$result = pg_query($query) or die('Query failed: ' . pg_last_error());
		
	    //Free Space
		pg_free_result($result);

		// Close Connection
		pg_close($dbconn);
		
		echo "success";
?>
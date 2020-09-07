<?php
	$ckan_api = $_POST['ckan_api'];
	$wikilink = $_POST['wikilink'];
	$ip = $_SERVER['REMOTE_ADDR'];
	
	//need PDO Sec
	
	$dbconn = pg_connect("host=localhost dbname=linkorgs user=linkorgs password=test123123")
			or die('Failure: ' . pg_last_error());

		// Query
		$query = "INSERT INTO links (fk_ckan_api, wiki_url, ip) VALUES ('$ckan_api', '$wikilink', '$ip')";    ## Make SQL Injection Proof / use PDOs
		$result = pg_query($query) or die('Query failed: ' . pg_last_error());
		
	    //Free Space
		pg_free_result($result);

		// Close Connection
		pg_close($dbconn);
		
		echo "success";
?>
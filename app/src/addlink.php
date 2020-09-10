<?php
	include 'database.php';
	$ckan_api = $_POST['ckan_api'];
	$wikilink = $_POST['wikilink'];
	$ip = $_SERVER['REMOTE_ADDR'];
	
	//need PDO Sec
	$statement = $conn->prepare("INSERT INTO linkorgs.links (fk_ckan_api, wiki_url, ip) VALUES (:ckan_api, :wikilink, :ip)");
				$statement->execute(array(
				    "ckan_api" => $ckan_api,
				    "wikilink" => $wikilink,
				    "ip" => $ip
				));
		echo "success";
?>

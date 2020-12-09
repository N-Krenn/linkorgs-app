<?php
	include 'database.php';
	$ckan_api = $_POST['ckan_api'];
	$wikilink = $_POST['wikilink'];
	$ip = $_SERVER['REMOTE_ADDR'];
	$useragent = $_SERVER['HTTP_USER_AGENT'];
	
	$statement = $conn->prepare("INSERT INTO linkorgs.links (fk_ckan_api, wiki_url, ip, useragent) SELECT :ckan_api, :wikilink, :ip, :useragent WHERE NOT EXISTS(SELECT 1 FROM linkorgs.links WHERE ip = :ip AND useragent = :useragent AND fk_ckan_api = :ckan_api AND created_at >= NOW() - '24 hours'::INTERVAL);");
				$statement->execute(array(
				    "ckan_api" => $ckan_api,
				    "wikilink" => $wikilink,
				    "ip" => $ip,
				    "useragent" => $useragent
				));
		if($statement->rowCount() == 1){
			echo "success"; #we need this for the ajax script to confirm	
		}
		elseif($statement->rowCount() == 0) {
			echo("This is your second added link for the same dataset within 24 hours. Please wait until the cooldown is finished and note that we do not want users to mass-vote on links!");
			#note that other errors are not part of the output.
		}
?>

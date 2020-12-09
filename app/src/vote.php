<?php
	include 'database.php';
	$linkid = $_POST['linkid'];
	$direction = $_POST['direction'];
	$ip = $_SERVER['REMOTE_ADDR'];
	$useragent = $_SERVER['HTTP_USER_AGENT']
	
	#statement enforces check of already preexisting votes here. 
	$statement = $conn->prepare("INSERT INTO linkorgs.votes (fk_link_id, direction, ip, useragent) SELECT :linkid, :direction, :ip, :useragent WHERE NOT EXISTS(SELECT 1 FROM linkorgs.votes WHERE ip = :ip AND useragent = :useragent AND fk_link_id = :linkid AND created_at >= NOW() - '24 hours'::INTERVAL);");
		$statement->execute(array(
			"linkid" => $linkid,
			"direction" => $direction,
			"ip" => $ip,
			"useragent" => $useragent
		));
		
		echo "success";
?>

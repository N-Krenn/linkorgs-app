<?php
	$linkid = $_POST['linkid'];
	$direction = $_POST['direction'];
	$ip = $_SERVER['REMOTE_ADDR'];
	
	$statement = $conn->prepare("INSERT INTO votes (fk_link_id, direction, ip) VALUES (:linkid, :direction, :ip)");
		$statement->execute(array(
			"linkid" => $linkid,
			"direction" => $direction,
			"ip" => $ip
		));
		
		echo "success";
?>

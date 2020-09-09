<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Starter Template for Bootstrap</title>
    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">

    <!-- Custom styles for this template -->
    <link href="starter-template.css" rel="stylesheet">
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
    
	
	<div class="container-fluid">
	<h1>Linkorgs</h1>
		<?php
			#Including the database
			include 'database.php';

			#Prerequisites, might outsource this into a class or another php file, do not know if we only use it once in here.
			
			#based on source: https://github.com/seanburlington/drupal-ckan/blob/master/ckan.php
			
			function transfer_metadata($url){
				#Maybe think about filtering metadata to the respective fields right now, instead of pulling everything. Reduces traffic.
				$ch = curl_init();

				curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
				curl_setopt($ch, CURLOPT_HEADER, 0);
				curl_setopt($ch, CURLOPT_TIMEOUT, 30);
				
				curl_setopt($ch, CURLOPT_URL, $url);
				
				$result = curl_exec($ch);
				$info = curl_getinfo($ch, CURLINFO_HTTP_CODE);
				curl_close($ch);
				if ($info != 200){
				throw new Exception('Error Code received from API:' . $info['http_code']);
				}
				if (!$result){
					throw new Exception('No Result');
				}
				return $result;
			}
			
			function storenewdataset($jsonresult){
				global $api_link, $page_link; #need to solve this better in later dev
				$statement = $conn->prepare("INSERT INTO linkorgs.datasets (ckan_api, portallink, metadata, name) VALUES (':api_link', ':page_link', ':jsonresult', '')");
				$statement->execute(array(
					"api_link" => $api_link,
					"page_link" => $page_link,
					"jsonresult" => $jsonresult  
				));
			}



			# The purpose of this app is to provide the iframe for CKAN distributions. At the moment, on-page voting and adding is not supported.
			
			
			#Getting the Get parameters. Maybe implement an Injection-Safe method or check for XSS
			$pack_id = $_GET['pack_id'];
			$api_link = $_GET['api_link'];
			$page_link = $_GET['page_link'];
			
			
			
			#Step 1: Checking if the dataset is stored in our database already
				
				$statement = $conn->prepare("SELECT * FROM linkorgs.datasets WHERE ckan_api=:api_link");
				$statement->execute(array(
				    "api_link" => $api_link
				));

				// Check if empty
				if($statement->rowCount() == 0)
				{
					//empty
						//Insert dataset into our database - coming soon
						echo "Please wait a minute. This dataset is new for us and we are storing the data in our database...";
					
						storenewdataset(transfer_metadata($api_link));
						
						echo "<script>window.location.reload()</script> Javascript reload triggered. <h1>Reload your page manually if you do see this!</h1>";
				}

			#Step 2: If in the database --> call page and load needed data
			echo "Found in Database... Loading data now<br>";
				$statement = $conn->prepare("SELECT * FROM linkorgs.v_app WHERE ckan_api=':api_link' ORDER BY sum DESC");
				$statement->execute(array(
				    "api_link" => $api_link
				));
				
				if($statement->rowCount() == 0)
				{
					#result empty
					echo "No matched links found. Help us out by adding one now!";
				}
				else
				{
					while ($row = $statement->fetch(PDO::FETCH_NUM, PDO::FETCH_ORI_NEXT)) {
						echo "<div class='row'> Wikidata Url: <a href='$row[0]' target='_blank'>$row[0]</a>  Total Votes: $row[1]  Rating: $row[2]  <div class='vertical-input-group' role='group'><span class='input-group upvote_button glyphicon glyphicon-plus' style='width: 30px;' value='$row[4]'></span> <span class='input-group downvote_button glyphicon glyphicon-minus' style='width:30px;' value='$row[4]'></span></div></div>";
						#Need to implement Google Recaptcha here!
						echo "<br />\n";
					}
				}
				
				
				
			#Step 3: Provide the user the respective Interface


				// Free Space
				#pg_free_result($result);

				// Close Connection
				#pg_close($dbconn);
		?>
		
		<a href="#" id="show-entry-form"> Add alternative Wikidata entry </a>
		<div id="entry-form">
			<input id="form-link" type="text" value="https://www.wikidata.org/wiki/">
			<input id="button-submit" type="button" value="submit">
			<input id="button-cancel" type="button" value="cancel">
		</div>
	</div>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha384-nvAa0+6Qg9clwYCGGPpDQLVpLNn0fRaROjHqs13t4Ggj3Ez50XnGQqc/r8MhnRDZ" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js" integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd" crossorigin="anonymous"></script>
  </body>
</html>

<script>
	// Ajax PHP request; need to implement below tips furthermore to make it secure.
	//https://stackoverflow.com/questions/37912937/how-to-send-secure-ajax-requests-with-php-and-jquery
	$('.upvote_button').click(function() {
		var val = $(this).attr('value');

		$.ajax({
			url: "vote.php",
			type: "POST",
			data: {
				linkid:val,
				direction:1
			},
			success: function(data) {
				//alert(data);
				if (data == "success") {
					// if vote.php returns success
					alert("Successfully voted. Thank you for your help!");
					window.location.reload();
				} else {
					// if vote.php returns failure, display error
					alert("Failure. Please try again.");
					window.location.reload();
				}  
			}
		});
	});
	
	$('.downvote_button').click(function() {
		var val = $(this).attr('value');

		$.ajax({
			url: "vote.php",
			type: "POST",
			data: {
				linkid:val,
				direction:-1
			},
			success: function(data) {
				//alert(data);
				if (data == "success") {
					// if vote.php returns success
					alert("Successfully voted. Thank you for your help!");
					window.location.reload();
				} else {
					// if vote.php returns failure, display error
					alert("Failure. Please reload and try again.");
					window.location.reload();
				}  
			}
		});
	});
	
	//Future notes: maybe add a callback success
	$("#button-submit").click(function() {
		var val = $("#form-link").val();

		$.ajax({
			url: "addlink.php",
			type: "POST",
			data: {
				wikilink:val,
				ckan_api: "<?php echo $api_link; ?>"
			},
			success: function(data) {
				//alert(data);
				if (data == "success") {
					// if vote.php returns success
					alert("Successfully added the link. Thank you for your help!");
					window.location.reload();
				} else {
					// if vote.php returns failure, display error
					alert("Failure. Please reload and try again.");
					window.location.reload();
				}  
			}
		});
	});
	
	//Interaction Alternative Link
	$("#show-entry-form").click(function() {
		$("#entry-form").toggle();
		$("#show-entry-form").toggle();
	});
	
	$("#button-cancel").click(function() {
		$("#entry-form").toggle();
		$("#show-entry-form").toggle();
	});
	
	$("#entry-form").hide();
	
</script>

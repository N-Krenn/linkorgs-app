<?php
      #Security Clarification:
      #We are safe to assume that the datasets in the external Applications are uploaded by organisations that have a governmental background.
      #Therefore, data received by the CKAN API is assumed to be correct and right.
      #In order to limit potential intruders ability to set up a own CKAN version with a modified API, we filter allowed domains by using a list of domains, which has been
      #provided by Dr. Sebastian Neumaier (WU Vienna) in his portalwatch project.
      
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
			
			function storenewdataset($jsonresult, $page_link, $api_link){
				$statement = $conn->prepare("INSERT INTO linkorgs.datasets (ckan_api, portallink, metadata, name) VALUES (':api_link', ':page_link', ':jsonresult', '')");
				$statement->execute(array(
					"api_link" => $api_link,
					"page_link" => $page_link,
					"jsonresult" => $jsonresult  
				));
			}
      
      
      #URL Checking
      
      $csv = array_map('str_getcsv', file('portalurls.csv'));
      
      $url = parse_url($ckan_api);
      if(in_array($url->host, $csv)) {
        echo("Found url, is whitelisted");
      
        $jsonresult = transfer_metadata($ckan_api);
        $metadata = json_decode($jsonresult);
        $page_link = $metadata->result->metadata_linkage;

        storenewdataset($jsonresult, $page_link, $api_link);
      }
      else {
        echo("This might be a forged API URL or your portal is not allowed in our application.");
      }
      

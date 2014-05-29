<?php
/*
 * This file generates the individual fisma/CCE-####-#.html pages
 * This script loops through ssg-rhel6-xccdf.xml and generates an html page for each rule.
 */
	
// Config
	define("FILE_SEP", "/"); // unix
	define("FILE_PATH", ".");
	define("PROFILE", "severity_high");

	$offset = 0;
	$limit = 30;
	$cnt = 0;

// Functions	
	// Echo an attribute using a function to make getting attribute easier
	function xml_attribute($object, $attribute)
	{
    	if(isset($object[$attribute]))
        	return (string) $object[$attribute];
	}

	function write_rule_file($file, $content) {
		file_put_contents($file, $content, LOCK_EX);
	}

// Load Result XML file into variable
	$context  = stream_context_create(array('http' => array('header' => 'Accept: application/xml')));
	$url = 'http://localhost:8080/govready/severity_high.xml';
	$xml = file_get_contents($url, false, $context);
	$xml = simplexml_load_string($xml);
	# print_r($xml);
	echo "File: $url\n";
	// Note: Always use namespace if names is defined
	$xml->registerXPathNamespace('myns', 'http://checklists.nist.gov/xccdf/1.1');
	$xml->registerXPathNamespace('xhtml', 'http://www.w3.org/1999/xhtml');

	$Profiles = $xml->xpath("//myns:Profile");
	echo "count Profiles ". count($Profiles)."\n";
	$xpath_path = "//myns:Profile[@id='".PROFILE."']";
	$profile_array = $xml->xpath($xpath_path);
	$profile = $profile_array[0];
	//print_r($profile);
	$title = $profile->title;
	$description = $profile->description;
	$selects = $profile->select;

	echo PROFILE."\n";
	echo "  "."title: $title\n";
	echo "  "."description: $description\n";
	echo "  "."count selects: ".count($selects);
	
// Load Adjustment XML file into variable
	$adjustment_file = "../ssg-rhel6-adjustments-centos6.xml";
	$adjustment_xml = file_get_contents($adjustment_file);
	$adjustment_xml = simplexml_load_string($adjustment_xml);
	//print_r($adjustment_xml);
	echo "File: $adjustment_xml\n";
	$adjustment_xml->registerXPathNamespace('adjustment', 'http://checklists.govready.org/adjustments/0.1');
	$Rules = $adjustment_xml->xpath("//adjustment:Rules");
	$adjustment = $adjustment_xml->xpath("//adjustment:Rules/adjustment:Rule[@id='ensure_redhat_gpgkey_installed']/adjustment:adjustments/adjustment:adjustment[@initial='fail']");

//	print_r( $adjustment_xml->xpath("//adjustment:Rules/adjustment:Rule[@id='ensure_redhat_gpgkey_installed']/adjustment:adjustments/adjustment:adjustment[@initial='fail']"));

	
	echo "\n";


	
// Sort through details

// Loop through selected rules
	foreach ($selects as $select_rule) {
		$cnt += 1;
		if ($cnt <= $offset) continue;
		if ($cnt > ($limit + $offset)) break;

		$rule_idref = xml_attribute($select_rule, "idref");
		echo "  rule_idref: $rule_idref \n";
		# <rule-result idref="disable_rexec" time="2014-05-25T12:51:50" severity="high" weight="1.000000">
		$xpath_path = "//myns:rule-result[@idref='".$rule_idref."']";
		echo "  xpath_path: $xpath_path\n";
		$rule_result = $xml->xpath($xpath_path);
		// print_r($rule_result[0]);
		
		// Apply adjustment
		$adjustment = $adjustment_xml->xpath("//adjustment:Rules/adjustment:Rule[@id='".$rule_idref."']/adjustment:adjustments/adjustment:adjustment[@initial='".$rule_result[0]->result."']");
		echo "  ident: ".$rule_result[0]->ident."\n";
		
		if (xml_attribute(@$adjustment[0],"initial")) {
			echo "  adjusment initial: ".xml_attribute($adjustment[0],"initial")."\n";
			echo "  adjusment revised: ".xml_attribute($adjustment[0],"revised")."\n";
			echo "  adjusment detail: ".$adjustment[0]."\n";
			$revised_result = xml_attribute($adjustment[0],"revised");
			echo "  result: ".$rule_result[0]->result."\n";
			echo "  revised_result: ".$revised_result."\n";
			echo "  based on: ".$adjustment[0]."\n";
		} else {
			$revised_result = $rule_result[0]->result;
			echo "  revised_result: ".$revised_result."\n";
		}


		echo "\n";



	}



	echo "\ndone";


	exit;



?>

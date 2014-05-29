<?php
/*
 * This file generates a separate <Profile> for each rule 
 * This script loops through ssg-rhel6-xccdf.xml and generates one <Profile> per rule
 *
 * usage: php -e unbundler2profiles.php
 */
	
// Config
	define("FILE_SEP", "/"); // unix
	define("FILE_PATH", ".");
	define("FILE_OUTPUT", "Profiles.xml");

	$offset = 0;
	$limit = 400;
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

	function append_rule_file($file, $content) {
		file_put_contents($file, $content, FILE_APPEND | LOCK_EX);
	}

// Load XML file into variable
	$src = './ssg-rhel6-xccdf-unbundled.xml';
	
	$xml = simplexml_load_file($src);
	echo "File: $src\n";

// Let's get an overall sense for what is in this xml file 
	// We'll use xpath queries
	// Note: Always use namespace if names is defined
	$xml->registerXPathNamespace('myns', 'http://checklists.nist.gov/xccdf/1.1');
	$xml->registerXPathNamespace('xhtml', 'http://www.w3.org/1999/xhtml');
	
	// Count Groups
	$result = $xml->xpath("//myns:Group");
	$count = count($result);
	echo "Groups: $count\n";
 
	// Count rules
	$result = $xml->xpath("//myns:Rule");
	$rule_count = count($result);
	echo "Rules: $rule_count\n";

	// Count titles (found in Group and rule nodes)
	$result = $xml->xpath("//myns:title");
	$count = count($result);
	echo "titles: $count\n";
 
 	echo "\n";

// Clear $content var and output file
 	$content = "";
 	write_rule_file(FILE_PATH.FILE_SEP.FILE_OUTPUT, "");
	
// Loop through rules and generate output files
	foreach ($xml->xpath("//myns:Rule") as $Rule) {
		$cnt += 1;
		if ($cnt <= $offset) continue;
		if ($cnt > ($limit + $offset)) break;
		echo "$cnt ".$Rule->title."\n";
		echo "    id: ".xml_attribute($Rule, "id")."\n";
		$severity = xml_attribute($Rule, "severity");
		echo "    ident: " .$Rule->ident . "\n";
		// get parent node, which is a Group
		$Group = $Rule->xpath("./..");
		$Group_id = xml_attribute($Group[0],"id");
		$Group_title = $Group[0]->title;
		$Group_title_lc = strtolower($Group_title);
		$Group_Rule_cnt = count($Group[0]->Rule);
		$Group_Rule_other_cnt = $Group_Rule_cnt - 1;
		$rule_id = xml_attribute($Rule, "id");
		$rule_title_lc = strtolower($Rule->title);
		$file = FILE_PATH.FILE_SEP.FILE_OUTPUT;

		// IMPORTANT: $Rule->description has inline tags with different name space so we need to strip tags or replace in xml string
		// $description = strip_tags($Rule->description->asXML());
		$description = $Rule->description->asXML();
		$rationale = $Rule->rationale->asXML();
		echo "    file: ".$file."\n";
		echo "\n";

		$text_warnings = array("low" => "info", "medium" => "warning", "high" => "danger");

		$scap_xml = $Rule->asXML();
		
		// Write each rule to a file. 
		$content = <<<FM
  <Profile id="$rule_id">
    <title xml:lang="en-US">$rule_id</title>
    <description xmlns:xhtml="http://www.w3.org/1999/xhtml" xml:lang="en-US">This is an unbundled profile for $rule_id</description>
    <select idref="$rule_id" selected="true"/>
  </Profile>
FM;

		append_rule_file($file, $content);

	}

	echo "\n";
	echo "\n";

?>

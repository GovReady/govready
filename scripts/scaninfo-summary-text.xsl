<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.1"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:cdf="http://checklists.nist.gov/xccdf/1.1"
    xmlns:exsl="http://exslt.org/common"
	xmlns:db="http://docbook.org/ns/docbook"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns="http://docbook.org/ns/docbook"
    xmlns:s="http://open-scap.org/"
    exclude-result-prefixes="xsl cdf db s exsl"
    xmlns:ovalres="http://oval.mitre.org/XMLSchema/oval-results-5"
    xmlns:sceres="http://open-scap.org/page/SCE_result_file"
    >

<!--
****************************************************************************************

Copyright: Greg Elin, 2014

This file provides a relitvely simple xslt transformation on openscap results.xml file
to show pass / fail numbers. 

usage: $> xsltproc scaninfo.xsl result-file-name.xml

-->

<!--xsl:output method="xml" encoding="UTF-8" indent="yes"/-->    
<xsl:strip-space elements="*"/>
<xsl:output method="text" encoding="utf-8" />

<xsl:template match="/">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match='cdf:TestResult'>
SCAN RESULTS ON PROFILE "<xsl:value-of select='cdf:profile/@idref'/>"

pass: <xsl:value-of select='count(cdf:rule-result[cdf:result="pass"])'/>
fail: <xsl:value-of select='count(cdf:rule-result[cdf:result="fail"])'/>
notselected: <xsl:value-of select='count(cdf:rule-result[cdf:result="notselected"])'/>
notapplicable: <xsl:value-of select='count(cdf:rule-result[cdf:result="notapplicable"])'/>
<xsl:text>
</xsl:text>
</xsl:template>

<!-- include to stop leakage from builtin tempaltes -->
<xsl:template match='node()' mode='engine-results'/>
<xsl:template match="text()"/>

</xsl:stylesheet>
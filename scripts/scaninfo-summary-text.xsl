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
OpenSCAP NIST Certified SCAP Scanner Results for Profile "<xsl:value-of select='cdf:profile/@idref'/>"

The "<xsl:value-of select='cdf:profile/@idref'/>" profile identifies <xsl:value-of select='count(cdf:rule-result[@severity="high"][cdf:result="pass"] | cdf:rule-result[@severity="high"][cdf:result="fail"] | cdf:rule-result[@severity="high"][cdf:result="error"])' /> high severity controls. OpenSCAP says <xsl:value-of select='count(cdf:rule-result[@severity="high"][cdf:result="pass"])' /> passing and <xsl:value-of select='count(cdf:rule-result[@severity="high"][cdf:result="fail"])' /> failing.
The "<xsl:value-of select='cdf:profile/@idref'/>" profile identifies <xsl:value-of select='count(cdf:rule-result[@severity="medium"][cdf:result="pass"] | cdf:rule-result[@severity="medium"][cdf:result="fail"] | cdf:rule-result[@severity="medium"][cdf:result="error"])' /> medium severity controls. OpenSCAP says <xsl:value-of select='count(cdf:rule-result[@severity="medium"][cdf:result="pass"])' /> passing and <xsl:value-of select='count(cdf:rule-result[@severity="medium"][cdf:result="fail"])' /> failing.
The "<xsl:value-of select='cdf:profile/@idref'/>" profile identifies <xsl:value-of select='count(cdf:rule-result[@severity="low"][cdf:result="pass"] | cdf:rule-result[@severity="low"][cdf:result="fail"] | cdf:rule-result[@severity="low"][cdf:result="error"])' /> low severity controls. OpenSCAP says <xsl:value-of select='count(cdf:rule-result[@severity="low"][cdf:result="pass"])' /> passing and <xsl:value-of select='count(cdf:rule-result[@severity="low"][cdf:result="fail"])' /> failing.
<xsl:text>
</xsl:text>
</xsl:template>

<!-- include to stop leakage from builtin tempaltes -->
<xsl:template match='node()' mode='engine-results'/>
<xsl:template match="text()"/>

</xsl:stylesheet>

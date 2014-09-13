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
to show information regarding a single rule.

usage: $> xsltproc - -stringparam paramname paramvalue ruleidresult.xsl result-file-name.xml

-->

<xsl:param name="ruleid">notdefined</xsl:param>
<xsl:param name="compare_result">notdefined</xsl:param>
<xsl:strip-space elements="*"/>
<xsl:output method="text" encoding="utf-8" />

<xsl:template match="/">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="cdf:rule-result">
<xsl:if test="@idref=$ruleid">
    <xsl:value-of select='cdf:result'/>
<xsl:text>
</xsl:text>
</xsl:if>
</xsl:template>

<!-- include to stop leakage from builtin tempaltes -->
<xsl:template match='node()' mode='engine-results'/>
<xsl:template match="text()"/>

</xsl:stylesheet>

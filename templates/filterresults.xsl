<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
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

This style sheet lists all failed rules

usage: $> xsltproc - -stringparam paramname paramvalue filterresults.xsl result-file-name.xml
examples
    Which rules pass in most recent scan?
       xsltproc - -stringparam result pass filterresults.xsl scans/results.xml

    Which rules fail in most recent scan?
       xsltproc - -stringparam result fail filterresults.xsl scans/results.xml


-->

<xsl:param name="result">notdefined</xsl:param>
<xsl:strip-space elements="*"/>
<xsl:output method="text" encoding="UTF-8" />

<xsl:template match="/">

<xsl:for-each select='cdf:Benchmark/cdf:TestResult/cdf:rule-result[cdf:result = $result]'>
<xsl:value-of select="@idref"/>
<xsl:text>
</xsl:text>
</xsl:for-each>

</xsl:template>

<!-- include to stop leakage from builtin tempaltes -->
<xsl:template match='node()' mode='engine-results'/>
<xsl:template match="text()"/>

</xsl:stylesheet>
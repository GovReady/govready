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

This style sheet diffs results of two results.xml files. Diffs most recent scan against target results-file-name.xml (which should be older).

usage: $> xsltproc diffinfo.xsl result-file-name.xml

-->

<!--xsl:output method="xml" encoding="UTF-8" indent="yes"/-->    
<xsl:strip-space elements="*"/>
<xsl:output methood="text" encoding="utf-8" />

<xsl:template match="/">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="/">
From older doc:
Benchmark @id: (<xsl:value-of select="cdf:Benchmark/@id" />)
status  @date: (<xsl:value-of select="cdf:Benchmark/cdf:status" />)
title: <xsl:value-of select="cdf:Benchmark/cdf:title" />
Result low pass count: <xsl:value-of select="count(cdf:Benchmark/cdf:TestResult/cdf:rule-result[@severity='low'][cdf:result='pass'])"/>

-----

From scans/results.xml (most recent) doc:
Benchmark @id: <xsl:value-of select="document('scans/results.xml')/cdf:Benchmark/@id" />
The <xsl:value-of select="document('scans/results.xml')/cdf:Benchmark/cdf:TestResult/cdf:profile/@idref"/> profile
Result low pass count: <xsl:value-of select="count(document('scans/results.xml')/cdf:Benchmark/cdf:TestResult/cdf:rule-result[@severity='low'][cdf:result='pass'])"/>

-------

</xsl:template>

<!-- include to stop leakage from builtin tempaltes -->
<xsl:template match='node()' mode='engine-results'/>
<xsl:template match="text()"/>

</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://purl.oclc.org/dsdl/schematron"
  xmlns:iso="http://purl.oclc.org/dsdl/schematron"
  exclude-result-prefixes="iso"
  version="2.0">
  <xsl:output indent="yes"/>
  
  <xsl:variable name="library" select="resolve-uri('rules/library.sch', base-uri(/))"/>
  <xsl:variable name="base" select="resolve-uri('.', base-uri(/))"/>  
    
  <xsl:template match="/">
    <xsl:result-document href="{$base}rules/rules.sch">
      <xsl:comment>
        Do not edit this file directly!
        This file is generated automatically by processing 
        <xsl:value-of select="substring-after(base-uri(/), $base)"/>
        If you want to change the rules, edit the corresponding sections 
        marked with audience="rules" in the corresponding topic files.
      </xsl:comment>
      <schema queryBinding="xslt2">
        <xsl:apply-templates select="document($library)" mode="generateIncludes"/>
        <xsl:apply-templates mode="rules"/>
      </schema>
    </xsl:result-document>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' map/topicref ')]" mode="rules">
    <xsl:apply-templates select="document(@href, .)" mode="rules"/>
    <xsl:apply-templates mode="rules"/>
  </xsl:template>
  <xsl:template match="section[@audience='rules']/dl" mode="rules">
    <xsl:apply-templates select="." mode="instantiate"/>
  </xsl:template>
  <xsl:template match="*" mode="rules">
    <xsl:apply-templates mode="rules"/>
  </xsl:template>
  <xsl:template match="text()" mode="rules"/>

  <xsl:template match="dl" mode="instantiate">
    <xsl:comment>Generated from <xsl:value-of select="substring-after(base-uri(.), $base)"/></xsl:comment>
    <pattern is-a="{dlhead/ddhd}">
      <xsl:apply-templates mode="instantiate"/>
    </pattern>
  </xsl:template>
  <xsl:template match="dlentry" mode="instantiate">
    <param name="{dt}" value="{dd}"/>
  </xsl:template>
  <xsl:template match="text()" mode="instantiate"/>


  <!-- generate include instuctions for all abstract patterns from the library -->
  <xsl:template match="text()" mode="generateIncludes"/>
  <xsl:template match="iso:pattern[@abstract='true']" mode="generateIncludes">
      <include href="library.sch#{@id}"/>
  </xsl:template>
  
</xsl:stylesheet>
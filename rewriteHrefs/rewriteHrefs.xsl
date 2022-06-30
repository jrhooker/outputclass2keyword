<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xrf="http://www.oxygenxml.com/ns/xmlRefactoring/functions"
    exclude-result-prefixes="xs math xd xrf xsi xr xra "
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xr="http://www.oxygenxml.com/ns/xmlRefactoring"
    xmlns:xra="http://www.oxygenxml.com/ns/xmlRefactoring/additional_attributes" version="3.0">
    
    <xsl:variable name="target-topic" select="name(/*)"/>
    <xsl:variable name="header" as="xs:string" select="xrf:get-content-before-root()"/>
    
    <xsl:output method="xml"/>
    
    <xsl:template match="/">       
        <xsl:apply-templates></xsl:apply-templates>
    </xsl:template>     
    
    <xsl:template match="title[parent::topic]">
        <xsl:element name="title"><xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>     
     </xsl:template>
 
    <xsl:template match="title[parent::concept]">
        <xsl:element name="title"><xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>     
    </xsl:template>
    
    <xsl:template match="title[parent::reference]">
        <xsl:element name="title"><xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>     
    </xsl:template>
    
    <xsl:template match="title[parent::task]">
        <xsl:element name="title"><xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>     
    </xsl:template>
    
    <xsl:template match="prolog"></xsl:template>
    
    <xsl:template match="@class"/>
    
    <xsl:template match="text() | comment() | processing-instruction()">
        <xsl:copy>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="xref">
        <xsl:copy>
            <xsl:copy-of select="@*"></xsl:copy-of>       
            <xsl:if test="not(contains(@scope, 'xternal'))">
                <xsl:attribute name="href"><xsl:value-of select="upper-case(@href)"/></xsl:attribute>
            </xsl:if>
            <xsl:apply-templates />
        </xsl:copy>       
    </xsl:template>    
    
    <xsl:template match="*">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates></xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>

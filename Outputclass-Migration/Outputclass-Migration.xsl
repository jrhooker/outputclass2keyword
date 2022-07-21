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
    
    <xsl:import href="rewrite-relrows.xsl"/> 
    
    <xsl:variable name="target-topic" select="name(/*)"/>
    <xsl:variable name="header" as="xs:string" select="xrf:get-content-before-root()"/>
    
    <xsl:output method="xml"/>
    
    <xsl:template match="/">       
        <xsl:apply-templates></xsl:apply-templates>
    </xsl:template>     
    
    <xsl:template match="topic">
        <xsl:element name="topic">
            <xsl:for-each select="@*">
                <xsl:if test="not(contains(., 'CHPLK_'))">
                    <xsl:variable name="att_name" select="self::node()/name()"/>
                    <xsl:attribute name="{$att_name}"><xsl:value-of select="."/></xsl:attribute>
                </xsl:if>
            </xsl:for-each>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="reference">
        <xsl:element name="reference">
            <xsl:for-each select="@*">
                <xsl:if test="not(contains(., 'CHPLK_'))">
                    <xsl:variable name="att_name" select="self::node()/name()"/>
                    <xsl:attribute name="{$att_name}"><xsl:value-of select="."/></xsl:attribute>
                </xsl:if>
            </xsl:for-each>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="task">
        <xsl:element name="task">
            <xsl:for-each select="@*">
                <xsl:if test="not(contains(., 'CHPLK_'))">
                    <xsl:variable name="att_name" select="self::node()/name()"/>
                    <xsl:attribute name="{$att_name}"><xsl:value-of select="."/></xsl:attribute>
                </xsl:if>
            </xsl:for-each>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="concept">
        <xsl:element name="concept">
            <xsl:for-each select="@*">
                <xsl:if test="not(contains(., 'CHPLK_'))">
                    <xsl:variable name="att_name" select="self::node()/name()"/>
                    <xsl:attribute name="{$att_name}"><xsl:value-of select="."/></xsl:attribute>
                </xsl:if>
            </xsl:for-each>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
   
    <xsl:template match="title[parent::topic]">
        <xsl:element name="title"><xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>     
        <xsl:if test="contains(parent::topic/@outputclass, 'CHPLK_')">                
            <xsl:choose>
                <xsl:when test="following-sibling::prolog">
                    <xsl:element name="prolog">
                        <xsl:copy-of select="following-sibling::prolog/@*"/>                                 
                        <xsl:call-template name="rewrite-metadata">
                            <xsl:with-param name="node" select="following-sibling::prolog/metadata"></xsl:with-param>
                            <xsl:with-param name="parent-id" select="parent::topic/@outputclass"></xsl:with-param>
                        </xsl:call-template>
                        <xsl:copy-of select="following-sibling::prolog[not(following-sibling::prolog/metadata)]/*"/>         
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="prolog">
                        <xsl:element name="metadata">
                            <xsl:element name="keywords">
                                <xsl:element name="keyword">
                                    <xsl:value-of select="parent::topic/@outputclass"/>
                                </xsl:element>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
 
    <xsl:template match="title[parent::concept]">
        <xsl:element name="title"><xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>     
        <xsl:if test="contains(parent::concept/@outputclass, 'CHPLK_')">                
            <xsl:choose>
                <xsl:when test="following-sibling::prolog">
                    <xsl:element name="prolog">
                        <xsl:copy-of select="following-sibling::prolog/@*"/>
                        <xsl:apply-templates select="following-sibling::prolog[not(following-sibling::prolog/metadata)]"></xsl:apply-templates>
                        <xsl:call-template name="rewrite-metadata">
                            <xsl:with-param name="node" select="following-sibling::prolog/metadata"></xsl:with-param>
                            <xsl:with-param name="parent-id" select="parent::concept/@outputclass"></xsl:with-param>
                        </xsl:call-template>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="prolog">
                        <xsl:element name="metadata">
                            <xsl:element name="keywords">
                                <xsl:element name="keyword">
                                    <xsl:value-of select="parent::concept/@outputclass"/>
                                </xsl:element>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="title[parent::reference]">
        <xsl:element name="title"><xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>     
        <xsl:if test="contains(parent::reference/@outputclass, 'CHPLK_')">                
            <xsl:choose>
                <xsl:when test="following-sibling::reference">
                    <xsl:element name="prolog">
                        <xsl:copy-of select="following-sibling::prolog/@*"/>
                        <xsl:apply-templates select="following-sibling::prolog[not(following-sibling::prolog/metadata)]"></xsl:apply-templates>
                        <xsl:call-template name="rewrite-metadata">
                            <xsl:with-param name="node" select="following-sibling::prolog/metadata"></xsl:with-param>
                            <xsl:with-param name="parent-id" select="parent::reference/@outputclass"></xsl:with-param>
                        </xsl:call-template>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="prolog">
                        <xsl:element name="metadata">
                            <xsl:element name="keywords">
                                <xsl:element name="keyword">
                                    <xsl:value-of select="parent::reference/@outputclass"/>
                                </xsl:element>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="title[parent::task]">
        <xsl:element name="title"><xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>     
        <xsl:if test="contains(parent::task/@outputclass, 'CHPLK_')">                
            <xsl:choose>
                <xsl:when test="following-sibling::task">
                    <xsl:element name="prolog">
                        <xsl:copy-of select="following-sibling::prolog/@*"/>
                        <xsl:apply-templates select="following-sibling::prolog[not(following-sibling::prolog/metadata)]"></xsl:apply-templates>
                        <xsl:call-template name="rewrite-metadata">
                            <xsl:with-param name="node" select="following-sibling::prolog/metadata"></xsl:with-param>
                            <xsl:with-param name="parent-id" select="parent::task/@outputclass"></xsl:with-param>
                        </xsl:call-template>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="prolog">
                        <xsl:element name="metadata">
                            <xsl:element name="keywords">
                                <xsl:element name="keyword">
                                    <xsl:value-of select="parent::task/@outputclass"/>
                                </xsl:element>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="rewrite-metadata">
        <xsl:param name="node"></xsl:param>
        <xsl:param name="parent-id"></xsl:param>
        <xsl:element name="metadata">
            <xsl:copy-of select="$node/@*"/>
            <xsl:copy-of select="$node[not(keywords)]"></xsl:copy-of>
            <xsl:element name="keywords">
                <xsl:for-each select="$node/keywords/keyword">
                    <xsl:element name="keyword">
                        <xsl:copy-of select="@*"/>
                        <xsl:value-of select="."/>
                    </xsl:element>
                </xsl:for-each>
                <xsl:element name="keyword">
                    <xsl:value-of select="$parent-id"/>
                </xsl:element>    
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="prolog"></xsl:template>
    
    <xsl:template match="@class"/>
    
    <xsl:template match="text() | comment() | processing-instruction()">
        <xsl:copy>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates></xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
    
    <!-- There is an established bug regarding the import process uppercasing ID values but not references to them. This template checks to make
    sure that the link is internal (or, at least, not external) and then uppercases them so they match the eventual ID values. -->
    <xsl:template match="xref">
        <xsl:copy>
            <xsl:copy-of select="@*"></xsl:copy-of>
            <xsl:if test="not(contains(@scope, 'external'))">
                <xsl:attribute name="href"><xsl:value-of select="upper-case(@href)"/></xsl:attribute>
            </xsl:if>           
            <xsl:apply-templates />
        </xsl:copy>       
    </xsl:template>
    
    <xsl:template match="relrow">
        <!-- The href elements with extensions will contain a period, those without extensions do not point to a file that is a part of the import,
        and therefore we check to make sure that every href attribute in the relrow has a period, which means it has an extension.-->
        <xsl:variable name="hrefs" select="count(descendant-or-self::*/@href)"/>
        <xsl:variable name="hrefs-with-extensions" select="count(descendant-or-self::*/@href[contains(., '.')])"/>       
        <xsl:choose>
            <xsl:when test="$hrefs = $hrefs-with-extensions">
                <xsl:element name="relrow">
                    <xsl:copy-of select="@*"/>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>

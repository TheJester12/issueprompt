<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" omit-xml-declaration="yes" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
	<xsl:comment><![CDATA[[if IE 6]> <html lang="en" class="no-js ie6 lte-ie9 lte-ie8 lte-ie7 lte-ie6 gte-ie6"> <![endif]]]></xsl:comment>
	<xsl:comment><![CDATA[[if IE 7]> <html lang="en" class="no-js ie7 lte-ie9 lte-ie8 lte-ie7 gte-ie7 gte-ie6"> <![endif]]]></xsl:comment>
	<xsl:comment><![CDATA[[if IE 8]> <html lang="en" class="no-js ie8 lte-ie9 lte-ie8 gte-ie8 gte-ie7 gte-ie6"> <![endif]]]></xsl:comment>
	<xsl:comment><![CDATA[[if IE 9]> <html lang="en" class="no-js ie9 lte-ie9 gte-ie9 gte-ie8 gte-ie7 gte-ie6"> <![endif]]]></xsl:comment>
	<xsl:comment><![CDATA[[if !(lte IE 9)]><!]]></xsl:comment> <html lang="en" class="no-js"> <xsl:comment><![CDATA[<![endif]]]></xsl:comment>
		<head>
		
			<title><xsl:call-template name="title"/></title>
			
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
			<link rel="shortcut icon" href="{$root}/favicon.ico" type="image/x-icon"/>
			<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
			<meta name="description" content=""/>
			<meta name="author" content=""/>
			
			<link href="{$workspace}/bootstrap/docs/assets/css/bootstrap.css" rel="stylesheet"/>
			<link href="{$workspace}/bootstrap/docs/assets/css/bootstrap-responsive.css" rel="stylesheet"/>
			<link href="{$workspace}/css/curi-screen.css" rel="stylesheet"/>
			
			<!--[if lt IE 9]>
			<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
			<![endif]-->

		</head>
		<body>
			<xsl:attribute name="class">
				<xsl:text>root-</xsl:text><xsl:value-of select="$root-page" />
				<xsl:text> page-</xsl:text><xsl:value-of select="$current-page" />
			</xsl:attribute>
			
			
			
			<div class="container">
			
				<xsl:apply-templates/>
								
			</div> <!-- /container -->
			
			<!-- Placed at the end of the document so the pages load faster -->
			<script src="{$workspace}/bootstrap/docs/assets/js/jquery.js"></script>
			<script src="{$workspace}/js/curi-scripts.js"></script>
			
		</body>
	</html>
</xsl:template>

<xsl:template name="title">
	<xsl:choose>
		<xsl:when test="$page-title = 'Home'">
			<xsl:value-of select="$website-name"/>
			<xsl:text> &#8211; curi</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$page-title"/>
			<xsl:text> &#8211; </xsl:text>
			<xsl:value-of select="$website-name"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
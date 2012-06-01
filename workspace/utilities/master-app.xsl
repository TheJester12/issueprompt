<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
<xsl:import href="date-time.xsl"/>
<xsl:import href="pagination.xsl"/>
	
<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" omit-xml-declaration="yes" encoding="UTF-8" indent="yes"/>

<xsl:variable name="member-is-logged-in" select="boolean(//events/member-login-info/@logged-in = 'yes')"/>
<xsl:variable name="member-role"/>

<xsl:template match="/">
	<xsl:comment><![CDATA[[if IE 6]> <html lang="en" class="no-js ie6 lte-ie9 lte-ie8 lte-ie7 lte-ie6 gte-ie6"> <![endif]]]></xsl:comment>
	<xsl:comment><![CDATA[[if IE 7]> <html lang="en" class="no-js ie7 lte-ie9 lte-ie8 lte-ie7 gte-ie7 gte-ie6"> <![endif]]]></xsl:comment>
	<xsl:comment><![CDATA[[if IE 8]> <html lang="en" class="no-js ie8 lte-ie9 lte-ie8 gte-ie8 gte-ie7 gte-ie6"> <![endif]]]></xsl:comment>
	<xsl:comment><![CDATA[[if IE 9]> <html lang="en" class="no-js ie9 lte-ie9 gte-ie9 gte-ie8 gte-ie7 gte-ie6"> <![endif]]]></xsl:comment>
	<xsl:comment><![CDATA[[if !(lte IE 9)]><!]]></xsl:comment> <html lang="en" class="no-js"> <xsl:comment><![CDATA[<![endif]]]></xsl:comment>
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
			
			<title><xsl:call-template name="title"/></title>
			
			<link rel="shortcut icon" href="{$root}/favicon.ico" type="image/x-icon"/>
			<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
			<meta name="description" content=""/>
			<meta name="author" content=""/>
			
			<link href="{$workspace}/bootstrap/docs/assets/css/bootstrap.css" rel="stylesheet"/>
			<link href="{$workspace}/bootstrap/docs/assets/css/bootstrap-responsive.css" rel="stylesheet"/>
			<link href="{$workspace}/js/chosen/chosen.css" rel="stylesheet" />
			<link href="{$workspace}/js/tags-input/jquery.tagsinput.css" rel="stylesheet" />
			<link href="{$workspace}/css/issuetracker-app-screen.css" rel="stylesheet"/>
			
			<!--[if lt IE 9]>
			<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
			<![endif]-->

		</head>
		<body>
			<xsl:attribute name="class">
				<xsl:text>root-</xsl:text><xsl:value-of select="$root-page" />
				<xsl:text> page-</xsl:text><xsl:value-of select="$current-page" />
			</xsl:attribute>
			
			<div class="navbar navbar-fixed-top">
				<div class="navbar-inner">
					<div class="container">
						<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						</a>
						<a class="brand" href="{$root}/dashboard/">Issue Prompt</a>
						<div class="nav-collapse">
							<ul class="nav pull-right">
								<li class="dropdown">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown"><xsl:value-of select="/data/logged-in-member/entry/organization/item"/><xsl:text> </xsl:text><b class="caret"></b></a>
									<ul class="dropdown-menu">
										<li><a href="{$root}/users/{/data/logged-in-member-organization/entry/organization-name/@handle}/">View All Users</a></li>
										<xsl:if test="$member-role = 'Administrator'">
											<li><a href="{$root}/users/new/{/data/logged-in-member-organization/entry/organization-name/@handle}/">Invite New Users</a></li>
											<li><a href="{$root}/organization/{/data/logged-in-member-organization/entry/organization-name/@handle}/">Edit Organization</a></li>
										</xsl:if>
									</ul>
								</li>
								<li class="dropdown">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown"><xsl:value-of select="/data/logged-in-member/entry/name"/><xsl:text> </xsl:text><b class="caret"></b></a>
									<ul class="dropdown-menu">
										<li><a href="{$root}/users/view/{/data/logged-in-member-organization/entry/organization-name/@handle}/{/data/logged-in-member/entry/name/@handle}/">Your Profile</a></li>
										<li><a href="{$root}/?member-action=logout&amp;redirect={$root}/">Log Out</a></li>
									</ul>
								</li>
							</ul>
						</div><!-- /.nav-collapse -->
					</div>
				</div><!-- /navbar-inner -->
			</div>
						
			<div class="container">
							
				<xsl:apply-templates/>
								
			</div> <!-- .container -->
			
			<!-- Placed at the end of the document so the pages load faster -->
			
			<script src="{$workspace}/bootstrap/docs/assets/js/jquery.js"></script>
			<script src="{$workspace}/bootstrap/docs/assets/js/bootstrap-collapse.js"></script>
			<script src="{$workspace}/bootstrap/docs/assets/js/bootstrap-dropdown.js"></script>
			<!--
			<script src="{$workspace}/bootstrap/docs/assets/js/bootstrap-transition.js"></script>
			<script src="{$workspace}/bootstrap/docs/assets/js/bootstrap-alert.js"></script>
			<script src="{$workspace}/bootstrap/docs/assets/js/bootstrap-modal.js"></script>
			<script src="{$workspace}/bootstrap/docs/assets/js/bootstrap-scrollspy.js"></script>
			<script src="{$workspace}/bootstrap/docs/assets/js/bootstrap-tab.js"></script>
			<script src="{$workspace}/bootstrap/docs/assets/js/bootstrap-tooltip.js"></script>
			<script src="{$workspace}/bootstrap/docs/assets/js/bootstrap-popover.js"></script>
			<script src="{$workspace}/bootstrap/docs/assets/js/bootstrap-button.js"></script>
			<script src="{$workspace}/bootstrap/docs/assets/js/bootstrap-carousel.js"></script>
			<script src="{$workspace}/bootstrap/docs/assets/js/bootstrap-typeahead.js"></script>
			-->
			<link rel="stylesheet" type="text/css" href="{$workspace}/js/wmd/wmd.css"/>
			<script src="{$workspace}/js/wmd/wmd.js"></script>
			<script src="{$workspace}/js/wmd/showdown.js"></script>
			<script src="{$workspace}/js/chosen/chosen.jquery.min.js"></script>
			<script src="{$workspace}/js/tags-input/jquery.tagsinput.min.js"></script>
			<script src="{$workspace}/js/issuetracker-app-scripts.js"></script>
			
		</body>
	</html>
</xsl:template>

<xsl:template name="title">
	<xsl:choose>
		<xsl:when test="$page-title = 'Home'">
			<xsl:value-of select="$website-name"/>
			<xsl:text> &#8211; Issuetracker</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$page-title"/>
			<xsl:text> &#8211; </xsl:text>
			<xsl:value-of select="$website-name"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
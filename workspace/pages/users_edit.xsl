<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exsl="http://exslt.org/common"
    xmlns:form="http://nick-dunn.co.uk/xslt/form-controls"
    extension-element-prefixes="exsl form">
	
<xsl:import href="../utilities/master-app.xsl"/>
<xsl:import href="../utilities/form-controls.xsl"/>
<xsl:import href="../utilities/string-replace.xsl"/>

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />
	
<xsl:variable name="form:event" select="/data/events/user-edit"/>

<xsl:template match="data">

	<div class="container">
	
		<ul class="breadcrumb">
			<li>
				<a href="{$root}/dashboard/">Dashboard</a> <span class="divider">/</span>
			</li>
			<li>
				<a href="{$root}/users/{logged-in-member-organization/entry/organization-name/@handle}/"><xsl:value-of select="logged-in-member-organization/entry/organization-name"/> Users</a> <span class="divider">/</span>
			</li>
			<li>
				<xsl:choose>
					<xsl:when test="/data/events/user-edit/@result = 'success'">
						<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
						<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
						
						<xsl:variable name="updated-user-handle1">
							<xsl:value-of select="translate(/data/events/user-edit/post-values/name, $uppercase, $smallcase)" />
						</xsl:variable>
						
						<xsl:variable name="updated-user-handle2">
							<xsl:call-template name="string-replace-all">
								<xsl:with-param name="text" select="$updated-user-handle1" />
								<xsl:with-param name="replace" select="' '" />
								<xsl:with-param name="by" select="'-'" />
							</xsl:call-template>
						</xsl:variable>
							
						<a href="{$root}/users/view/{logged-in-member-organization/entry/organization-name/@handle}/{$updated-user-handle2}/"><xsl:value-of select="/data/events/user-edit/post-values/name"/></a> <span class="divider">/</span>
					</xsl:when>
					<xsl:otherwise>
						<a href="{$root}/users/view/{logged-in-member-organization/entry/organization-name/@handle}/{user-view-individual/entry/name/@handle}/"><xsl:value-of select="user-view-individual/entry/name"/></a> <span class="divider">/</span>
					</xsl:otherwise>
				</xsl:choose>
			</li>
			<li class="active">Edit</li>
		</ul>
		
		<div class="row heading">
			<div class="span12">
				<h1>Edit <xsl:value-of select="user-view-individual/entry/name"/></h1>
			</div>
		</div>
		
		<div class="row">
		
			<div class="span9">
							
				<form action="" method="post">
		
					<xsl:call-template name="form:validation-summary"/>
					
					<div class="control-group">
						<label class="control-label" for="name">Name</label>
						<div class="controls">
							<xsl:call-template name="form:input">
								<xsl:with-param name="handle" select="'name'"/>
								<xsl:with-param name="value" select="user-view-individual/entry/name"/>
							</xsl:call-template>
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label" for="email">Email</label>
						<div class="controls">
							<xsl:call-template name="form:input">
								<xsl:with-param name="handle" select="'email'"/>
								<xsl:with-param name="value" select="user-view-individual/entry/email"/>
							</xsl:call-template>
						</div>
					</div>
					
					<div class="control-group">
						<a href="#" class="btn change-password">Change Password</a>
					</div>
						
										
					<input name="id" type="hidden" value="{user-view-individual/entry/@id}" />
					
					<div class="form-actions">
						<button type="submit" name="action[user-edit]" class="btn btn-primary">Edit User</button>
					</div>
					
				</form>
							
			</div><!-- .span9 -->
			
			<div class="span3">
			
				
			
			</div><!-- .span3 -->
		
		</div><!-- .row -->
		
	</div><!-- .container -->
	
</xsl:template>


</xsl:stylesheet>
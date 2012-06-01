<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exsl="http://exslt.org/common"
    xmlns:form="http://nick-dunn.co.uk/xslt/form-controls"
    extension-element-prefixes="exsl form">
	
<xsl:import href="../utilities/master-app.xsl"/>

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />
	
<xsl:template match="data">

	<div class="container">
	
		<ul class="breadcrumb">
			<li>
				<a href="{$root}/dashboard/">Dashboard</a> <span class="divider">/</span>
			</li>
			<li><xsl:value-of select="logged-in-member-organization/entry/organization-name"/> Users</li>
		</ul>
		
		<div class="row heading">
			<div class="span12">
				<h1><xsl:value-of select="logged-in-member-organization/entry/organization-name"/> Users</h1>
			</div>
		</div>
		
		<div class="row">
		
			<div class="span9">
														
				<table cellpadding="0" cellspacing="0" border="0" class="table table-striped  table-bordered">
					<tbody>
						<tr class="labels">
							<th>Name</th>
							<th>Role</th>
							<th>Projects</th>
							<th>Issues</th>
							<th width="15%">Comments</th>
						</tr>
						<xsl:apply-templates select="users-per-organization/entry"/>
						
					</tbody>
				</table>
														
			</div><!-- .span9 -->
			
			<div class="span3">
			
				<xsl:choose>
			
					<xsl:when test="$member-role = 'Administrator'">
									
						<div class="btn-area"><a href="{$root}/users/view/{logged-in-member-organization/entry/organization-name/@handle}/{user-view-individual/entry/name/@handle}/" class="btn btn-primary btn-large btn-block">Invite New Users</a></div>
							
					</xsl:when>
					
					<xsl:otherwise>
					
					
					</xsl:otherwise>
					
				</xsl:choose>
			
			</div><!-- .span3 -->
		
		</div><!-- .row -->
		
	</div><!-- .container -->
	
</xsl:template>

<xsl:template match="users-per-organization/entry">
						<tr>
							<td><a href="{$root}/users/view/{/data/logged-in-member-organization/entry/organization-name/@handle}/{name/@handle}/"><xsl:value-of select="name"/></a></td>
							<td><xsl:value-of select="role/name"/></td>
							<td><xsl:value-of select="@projects"/> Project<xsl:if test="@projects != '1'">s</xsl:if></td>
							<td><xsl:value-of select="@issues"/> Issue<xsl:if test="@issues != '1'">s</xsl:if></td>
							<td><xsl:value-of select="@comments"/> Comment<xsl:if test="@comments != '1'">s</xsl:if></td>

						</tr>
</xsl:template>

</xsl:stylesheet>
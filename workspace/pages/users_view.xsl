<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exsl="http://exslt.org/common"
    xmlns:form="http://nick-dunn.co.uk/xslt/form-controls"
    extension-element-prefixes="exsl form">
	
<xsl:import href="../utilities/master-app.xsl"/>
<xsl:import href="../utilities/time-ago.xsl"/>

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
			<li>
				<a href="{$root}/users/{logged-in-member-organization/entry/organization-name/@handle}/"><xsl:value-of select="logged-in-member-organization/entry/organization-name"/> Users</a> <span class="divider">/</span>
			</li>
			<li><xsl:value-of select="user-view-individual/entry/name"/></li>
		</ul>
		
		<div class="row heading">
			<div class="span12">
				<h1><xsl:value-of select="user-view-individual/entry/name"/></h1>
			</div>
		</div>
		
		<div class="row">
		
			<div class="span9">
							
				<h3>Recent Projects</h3>
							
				<table cellpadding="0" cellspacing="0" border="0" class="table table-striped  table-bordered">
					<tbody>
						<tr class="labels">
							<th>Project</th>
							<th>Client</th>
							<th>Issues</th>
							<th width="15%">Comments</th>
						</tr>
						<xsl:apply-templates select="user-projects/entry"/>
						
					</tbody>
				</table>
				
				<h3>Current Issues</h3>
				
				<table cellpadding="0" cellspacing="0" border="0" class="table table-striped  table-bordered">
					<tbody>
						<tr class="labels">
							<th width="5%">Priority</th>
							<th width="30%">Issue Name</th>
							<th width="20%">Date Modified</th>
							<th width="25%">Project</th>
							<th width="15%">Comments</th>
						</tr>
						<xsl:apply-templates select="user-issues/entry"/>
					</tbody>
				</table>
				
				<h3>Recent Comments</h3>
				
				<xsl:apply-templates select="user-recent-comments/entry"/>
											
			</div><!-- .span9 -->
			
			<div class="span3">
			
				<xsl:choose>
			
					<xsl:when test="$ds-user-view-individual = $member-id or $member-role = 'Administrator'">
									
						<div class="btn-area"><a href="{$root}/users/edit/{logged-in-member-organization/entry/organization-name/@handle}/{user-view-individual/entry/name/@handle}/" class="btn btn-primary btn-large btn-block">Edit User</a></div>
							
					</xsl:when>
					
					<xsl:otherwise>
					
						<div class="btn-area"><a href="mailto:{user-view-individual/entry/email}" class="btn btn-primary btn-large btn-block">Email User</a></div>
					
					</xsl:otherwise>
					
				</xsl:choose>
			
			</div><!-- .span3 -->
		
		</div><!-- .row -->
		
	</div><!-- .container -->
	
</xsl:template>

<xsl:template match="user-projects/entry">
						<tr>
							<td><a href="{$root}/projects/view/{organization-link/item/@handle}/{project-name/@handle}/"><xsl:value-of select="project-name"/></a></td>
							<td><xsl:value-of select="client/item"/></td>
							<td><xsl:value-of select="@issues"/> Issue<xsl:if test="@issues != '1'">s</xsl:if></td>
							<td><xsl:value-of select="@comments"/> Comment<xsl:if test="@comments != '1'">s</xsl:if></td>
						</tr>
</xsl:template>

<xsl:template match="user-issues/entry">
						<tr>
							<td><div><xsl:attribute name="class">priority priority-<xsl:value-of select="priority/item"/></xsl:attribute></div></td>
							<td><div><a href="{$root}/projects/issues/{organization-link/item/@handle}/{project-link/item/@handle}/{@id}/"><xsl:value-of select="issue-name"/></a></div><div><xsl:text>Tags: </xsl:text>
								<xsl:for-each select="tags/item">
									<a href=""><xsl:value-of select="."/></a><xsl:if test="position() != last()"
									><xsl:text>, </xsl:text></xsl:if>
								</xsl:for-each>
							</div></td>
							<td><xsl:call-template name="format-date"><xsl:with-param name="date" select="date-added"/><xsl:with-param name="format" select="'m. D, Y'"/></xsl:call-template></td>
							<td><a href="{$root}/projects/view/{organization-link/item/@handle}/{project-link/item/@handle}/"><xsl:value-of select="project-link/item"/></a></td>
							<td><xsl:value-of select="@comments"/> Comment<xsl:if test="@comments != '1'">s</xsl:if></td>
						</tr>
</xsl:template>

<xsl:template match="user-recent-comments/entry">
				<div class="well comment">
				
					<div class="row">
						
						<div class="span3">
						
							<a href="#" class="avatar"><xsl:variable name="added-by-member" select="/data/user-view-individual/entry/@id"/><img src="http://www.gravatar.com/avatar/{/data/user-view-individual/entry/email/@hash}?s=50&amp;d=mm" /><span><xsl:value-of select="/data/user-view-individual/entry/name"/></span></a>
												
						</div><!-- .span3 -->
						
						<div class="span5">
			
							<p><xsl:value-of select="comment"/></p>
							
							<p class="meta"><xsl:call-template name="time-ago"><xsl:with-param name="date-and-time"><xsl:value-of select="date-added"/><xsl:text>T</xsl:text><xsl:value-of select="date-added/@time"/><xsl:text>:00</xsl:text></xsl:with-param></xsl:call-template> | <a href="{$root}/projects/view/{organization-link/item/@handle}/{project-link/item/@handle}/"><xsl:value-of select="project-link/item"/></a> | <a href="{$root}/projects/issues/view/{organization-link/item/@handle}/{issue-link/item/@id}/"><xsl:value-of select="issue-link/item"/></a></p>
							
						</div><!-- .span5 -->
						
					</div><!-- .row -->
					
				</div><!-- .well -->
									
</xsl:template>

</xsl:stylesheet>
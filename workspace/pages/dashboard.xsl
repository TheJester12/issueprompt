<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
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
	
		<div class="row heading">
			<div class="span12">
				<h1><xsl:value-of select="logged-in-member/entry/name"/>'s Dashboard</h1>
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
						<xsl:apply-templates select="logged-in-member-projects/entry"/>
						
					</tbody>
				</table>
				
				<h3>Your Current Issues</h3>
				
				<table cellpadding="0" cellspacing="0" border="0" class="table table-striped  table-bordered">
					<tbody>
						<tr class="labels">
							<th width="5%">Priority</th>
							<th width="30%">Issue Name</th>
							<th width="20%">Date Modified</th>
							<th width="25%">Project</th>
							<th width="15%">Comments</th>
						</tr>
						<xsl:apply-templates select="logged-in-member-issues/entry"/>
					</tbody>
				</table>
				
				<h3>Your Recent Comments</h3>
				
				<xsl:apply-templates select="logged-in-member-recent-comments/entry"/>
			
			</div><!-- .span9 -->
			
			<div class="span3">
			
				<div class="btn-area"><a href="{$root}/projects/" class="btn btn-primary btn-large btn-block">View All Projects</a></div>
				
				<div class="btn-area"><a href="{$root}/projects/new/" class="btn  btn-large btn-block">Add New Project</a></div>
			
			</div><!-- .span3 -->
		
		</div><!-- .row -->
		
	</div><!-- .container -->
	
</xsl:template>

<xsl:template match="logged-in-member-projects/entry">
						<tr>
							<td><a href="{$root}/projects/view/{organization-link/item/@handle}/{project-name/@handle}/"><xsl:value-of select="project-name"/></a></td>
							<td><xsl:value-of select="client/item"/></td>
							<td><xsl:value-of select="@issues"/> Issue<xsl:if test="@issues != '1'">s</xsl:if></td>
							<td><xsl:value-of select="@comments"/> Comment<xsl:if test="@comments != '1'">s</xsl:if></td>
						</tr>
</xsl:template>

<xsl:template match="logged-in-member-issues/entry">
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

<xsl:template match="logged-in-member-recent-comments/entry">
				<div class="well comment">
				
					<div class="row">
						
						<div class="span3">
						
							<a href="#" class="avatar"><xsl:variable name="added-by-member" select="/data/logged-in-member/entry/@id"/><img src="http://www.gravatar.com/avatar/{/data/logged-in-member/entry/email/@hash}?s=50&amp;d=mm" /><span><xsl:value-of select="/data/logged-in-member/entry/name"/></span></a>
												
						</div><!-- .span3 -->
						
						<div class="span5">
			
							<p><xsl:value-of select="comment"/></p>
							
							<p class="meta"><xsl:call-template name="time-ago"><xsl:with-param name="date-and-time"><xsl:value-of select="date-added"/><xsl:text>T</xsl:text><xsl:value-of select="date-added/@time"/><xsl:text>:00</xsl:text></xsl:with-param></xsl:call-template> | <a href="{$root}/projects/view/{organization-link/item/@handle}/{project-link/item/@handle}/"><xsl:value-of select="project-link/item"/></a> | <a href="{$root}/projects/issues/view/{organization-link/item/@handle}/{issue-link/item/@id}/"><xsl:value-of select="issue-link/item"/></a></p>
							
						</div><!-- .span5 -->
						
					</div><!-- .row -->
					
				</div><!-- .well -->
									
</xsl:template>

</xsl:stylesheet>
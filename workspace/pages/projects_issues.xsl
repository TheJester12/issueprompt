<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exsl="http://exslt.org/common"
    xmlns:form="http://nick-dunn.co.uk/xslt/form-controls"
    extension-element-prefixes="exsl form">
	
<xsl:import href="../utilities/master-app.xsl"/>
<xsl:import href="../utilities/form-controls.xsl"/>
<xsl:import href="../utilities/time-ago.xsl"/>
	
<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />
	
<xsl:variable name="form:event" select="/data/events/comment-new"/>

<xsl:template match="data">

	<div class="container">
	
		<ul class="breadcrumb">
			<li>
				<a href="{$root}/dashboard/">Dashboard</a> <span class="divider">/</span>
			</li>
			<li>
				<a href="{$root}/projects/">Projects</a> <span class="divider">/</span>
			</li>
			<li>
				<a href="{$root}/projects/view/{issue-individual/entry/organization-link/item/@handle}/{issue-individual/entry/project-link/item/@handle}/"><xsl:value-of select="issue-individual/entry/project-link/item"/></a> <span class="divider">/</span>
			</li>
			<li class="active"><xsl:value-of select="issue-individual/entry/issue-name"/></li>
		</ul>
	
		<div class="row heading">
			<div class="span12">
				<h1><xsl:value-of select="issue-individual/entry/issue-name"/></h1>
			</div>
		</div>
		
		<div class="row">
		
			<div class="span9">
			
				<table cellpadding="0" cellspacing="0" border="0" class="table table-striped  table-bordered">
					<tbody>
						<tr class="labels">
							<th>ID</th>
							<th>Status</th>
							<th>Project</th>
							<th>Date Created</th>
							<th>Date Modified</th>
						</tr>
						<tr>
							<td><xsl:value-of select="issue-individual/entry/@id"/></td>
							<td><xsl:value-of select="issue-individual/entry/status/item"/></td>
							<td><xsl:value-of select="issue-individual/entry/project-link/item"/></td>
							<td><xsl:call-template name="format-date"><xsl:with-param name="date" select="issue-individual/entry/date-added"/><xsl:with-param name="format" select="'m. D, Y'"/></xsl:call-template></td>
							<td><xsl:call-template name="format-date"><xsl:with-param name="date" select="issue-individual/entry/date-modified"/><xsl:with-param name="format" select="'m. D, Y'"/></xsl:call-template></td>
						</tr>
					</tbody>
				</table>
				
				<h3>Description</h3>
				
				<div class="well comment">
				
					<div class="row">
					
						<div class="span3">
						
							<a href="#" class="avatar"><xsl:variable name="added-by-member" select="issue-individual/entry/added-by/item/@id"/><img src="http://www.gravatar.com/avatar/{/data/comments-per-issue-emails/entry[@id = $added-by-member]/email/@hash}?s=50&amp;d=mm" /><span><xsl:value-of select="issue-individual/entry/added-by/item"/></span></a>
												
						</div><!-- .span3 -->
						
						<div class="span5">
												
							<p><xsl:value-of select="issue-individual/entry/description" disable-output-escaping="yes"/></p>
						
						</div><!-- span6 -->
						
					</div><!-- .row -->
					
				</div><!-- .well -->
				
				<xsl:if test="comments-per-issue/pagination/@total-entries != 0">
					<h3>Comments</h3>
				</xsl:if>
				
				<xsl:apply-templates select="comments-per-issue/entry"/>
							
				<xsl:if test="project-view-individual/entry/participants/item/@id = $member-id">
			
					<h3>Add New Comment</h3>
					
					<div class="well comment">
					
						<div class="row">
						
							<div class="span3">
							
								<a href="#" class="avatar"><xsl:variable name="added-by-member" select="logged-in-member/entry/@id"/><img src="http://www.gravatar.com/avatar/{/data/comments-per-issue-emails/entry[@id = $added-by-member]/email/@hash}?s=50&amp;d=mm" /><span><xsl:value-of select="logged-in-member/entry/name"/></span></a>
													
							</div><!-- .span3 -->
							
							<div class="span5">
													
								<form action="" method="post">
				
									<xsl:call-template name="form:validation-summary"/>
									
									<div class="control-group">
										<div class="controls">
											<xsl:call-template name="form:textarea">
												<xsl:with-param name="handle" select="'comment'"/>
												<xsl:with-param name="class" select="'input-xlarge'"/>
												<xsl:with-param name="rows" select="'3'"/>
												<xsl:with-param name="cols" select="'40'"/>
											</xsl:call-template>
										</div>
									</div>
									
									<input name="fields[added-by]" type="hidden" value="{$member-id}" />
									<input name="fields[issue-link]" type="hidden" value="{issue-individual/entry/@id}" />
									<input name="fields[project-link]" type="hidden" value="{issue-individual/entry/project-link/item/@id}" />
									<input name="fields[organization-link]" type="hidden" value="{issue-individual/entry/organization-link/item/@id}" />
																
									<button type="submit" name="action[comment-new]" class="btn btn-primary">Add Comment</button>
									
								</form>
													
							</div><!-- span6 -->
							
						</div><!-- .row -->
						
					</div><!-- .well -->
					
				</xsl:if>
				
			</div><!-- .span9 -->
			
			<div class="span3">
			
				<xsl:choose>
				
					<xsl:when test="project-view-individual/entry/participants/item/@id = $member-id">
				
						<div class="btn-area"><a href="#" class="btn btn-primary btn-large btn-block">Issue Resolved</a></div>
						
						<div class="btn-area"><a href="{$root}/projects/issues/edit/{issue-individual/entry/organization-link/item/@handle}/{issue-individual/entry/project-link/item/@handle}/{issue-individual/entry/@id}/" class="btn btn-large btn-block">Edit Issue</a></div>
					
					</xsl:when>
					
					<xsl:otherwise>
					
						<p>You Don't Participate In This Project</p>
					
					</xsl:otherwise>
					
				</xsl:choose>
				
				<ul class="nav nav-list well">
					<li class="nav-header">
						Tags
					</li>
					<xsl:for-each select="issue-individual/entry/tags/item">
						<li>
							<a href="{$root}/projects/view/{/data/issue-individual/entry/organization-link/item/@handle}/{/data/issue-individual/entry/project-link/item/@handle}/?tags={@handle}"><xsl:value-of select="."/></a>
						</li>
					</xsl:for-each>
					<li class="nav-header">
						Assigned To
					</li>
					<xsl:for-each select="issue-individual/entry/assigned-to/item">
						<li>
							<a href="#"><xsl:value-of select="."/></a>
						</li>
					</xsl:for-each>
				</ul>
							
			</div><!-- .span3 -->
		
		</div><!-- .row -->
		
	</div><!-- .container -->
	
</xsl:template>

<xsl:template match="comments-per-issue/entry">
				<div class="well comment">
				
					<div class="row">
				
					<div class="span3">
												
						<a href="#" class="avatar"><xsl:variable name="added-by-member" select="added-by/item/@id"/><img src="http://www.gravatar.com/avatar/{/data/comments-per-issue-emails/entry[@id = $added-by-member]/email/@hash}?s=50&amp;d=mm" /><span><xsl:value-of select="added-by/item"/></span></a>
					
					</div><!-- .span3 -->
					
					<div class="span5">
											
						<p><xsl:value-of select="comment"/></p>
						
						<p class="meta"><xsl:call-template name="time-ago"><xsl:with-param name="date-and-time"><xsl:value-of select="date-added"/><xsl:text>T</xsl:text><xsl:value-of select="date-added/@time"/><xsl:text>:00</xsl:text></xsl:with-param></xsl:call-template></p>
					
					</div><!-- span6 -->
					
					</div>
					
				</div><!-- .row -->
</xsl:template>

</xsl:stylesheet>
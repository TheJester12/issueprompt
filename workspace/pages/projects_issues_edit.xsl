<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exsl="http://exslt.org/common"
    xmlns:form="http://nick-dunn.co.uk/xslt/form-controls"
    extension-element-prefixes="exsl form">
	
<xsl:import href="../utilities/master-app.xsl"/>
<xsl:import href="../utilities/form-controls.xsl"/>
	
<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />
	
<xsl:variable name="form:event" select="/data/events/issue-edit"/>

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
				<a href="{$root}/projects/view/{issue-individual/entry/organization-link/item/@handle}/{issue-individual/entry/project-link/item/@handle}/"><xsl:value-of select="issue-individual/entry/project-link"/></a> <span class="divider">/</span>
			</li>
			<li><a href="{$root}/projects/issues/{issue-individual/entry/organization-link/item/@handle}/{issue-individual/entry/project-link/item/@handle}/{issue-individual/entry/@id}/"><xsl:value-of select="issue-individual/entry/issue-name"/></a> <span class="divider">/</span>
			</li>
			<li class="active">Edit</li>
		</ul>
		
		<div class="row">
			<div class="span12">
				<h1>Edit: <xsl:value-of select="issue-individual/entry/issue-name"/></h1>
			</div>
		</div>
		
		<div class="row">
		
			<div class="span9">
		
				<form action="" method="post">
				
					<xsl:call-template name="form:validation-summary"/>
					
					<div class="control-group">
						<label class="control-label" for="issue-name">Issue Name</label>
						<div class="controls">
							<xsl:call-template name="form:input">
								<xsl:with-param name="handle" select="'issue-name'"/>
								<xsl:with-param name="value" select="issue-individual/entry/issue-name"/>
							</xsl:call-template>
						</div>
					</div>
		
				   <div class="control-group">
						<label class="control-label" for="field-description">Description</label>
						<div class="controls">
							<div id="wmd-button-bar"></div>
							<xsl:call-template name="form:textarea">
								<xsl:with-param name="handle" select="'description'"/>
								<xsl:with-param name="value" select="issue-individual/entry/description"/>
								<xsl:with-param name="class" select="'input-xlarge'"/>
								<xsl:with-param name="rows" select="'5'"/>
								<xsl:with-param name="cols" select="'40'"/>
							</xsl:call-template>
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label" for="assigned-to">Assigned To</label>
						<div class="controls">
							<xsl:call-template name="form:select">
								<xsl:with-param name="handle" select="'assigned-to'"/>
								<xsl:with-param name="options">
									<xsl:for-each select="project-view-individual/entry/participants/item">
										<option value="{@id}"><xsl:value-of select="."/></option>
									</xsl:for-each>
								</xsl:with-param>
								<xsl:with-param name="allow-multiple" select="'yes'"/>
								<xsl:with-param name="class" select="'chosen'"/>
								<xsl:with-param name="value">
									<xsl:for-each select="issue-individual/entry/assigned-to/item">
										<option><xsl:value-of select="@id"/></option>
									</xsl:for-each>
								</xsl:with-param>
							</xsl:call-template>
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label" for="tags">Tags</label>
						<div class="controls">
							<xsl:call-template name="form:input">
								<xsl:with-param name="handle" select="'tags'"/>
								<xsl:with-param name="value">
									<xsl:for-each select="issue-individual/entry/tags/item">
										<xsl:value-of select="."/><xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if>
									</xsl:for-each>
								</xsl:with-param>
								<xsl:with-param name="class" select="'tags-input'"/>
							</xsl:call-template>
						</div>
					</div>
					<ul class="tags-list">
						<xsl:for-each select="tags-per-project/tag">
							<li id="tag-{.}"><xsl:value-of select="."/></li>
						</xsl:for-each>
					</ul>
					
					<div class="control-group">
						<label class="control-label" for="priority">Priority Level</label>
						<div class="controls">
							<xsl:call-template name="form:select">
								<xsl:with-param name="handle" select="'priority'"/>
								<xsl:with-param name="options">
									<option value="4-No-Priority">No Priority</option>
									<option value="3-Low">Low</option>
									<option value="2-Medium">Medium</option>
									<option value="1-High">High</option>
								</xsl:with-param>
								<xsl:with-param name="value" select="issue-individual/entry/priority/item"/>
							</xsl:call-template>
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label" for="status">Status</label>
						<div class="controls">
							<xsl:call-template name="form:select">
								<xsl:with-param name="handle" select="'status'"/>
								<xsl:with-param name="options">
									<options>Active</options>
									<options>Inactive</options>
								</xsl:with-param>
								<xsl:with-param name="value" select="issue-individual/entry/status/item"/>
							</xsl:call-template>
						</div>
					</div>
					
					<input name="id" type="hidden" value="{issue-individual/entry/@id}" />
					<input name="fields[project-link]" type="hidden" value="{issue-individual/entry/project-link/item/@id}" />
					<input name="fields[added-by]" type="hidden" value="{issue-individual/entry/added-by/item/@id}" />
					<input name="fields[organization-link]" type="hidden" value="{issue-individual/entry/organization-link/item/@id}" />
					
					<!--<input name="redirect" type="hidden" value="{$root}/projects/view/{issue-individual/entry/organization-link/item/@handle}/{issue-individual/entry/@handle}/" />-->
					
					<div class="form-actions">
						<button type="submit" name="action[issue-edit]" class="btn btn-primary btn-large">Save Issue</button>
					</div>
					
				</form>
				
			</div><!-- .span9 -->
			
			<div class="span3">
			
				<div class="well">
				
					<p>These are some instructions</p>
				
				</div>
			
			</div><!-- .span3 -->
			
		</div><!-- .row -->
		
	</div><!-- .container -->
	
</xsl:template>

</xsl:stylesheet>
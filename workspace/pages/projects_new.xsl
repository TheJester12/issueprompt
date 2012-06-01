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
	
<xsl:variable name="form:event" select="/data/events/project-new"/>

<xsl:template match="data">

	<div class="container">
	
		<ul class="breadcrumb">
			<li>
				<a href="{$root}/dashboard/">Dashboard</a> <span class="divider">/</span>
			</li>
			<li>
				<a href="{$root}/projects/">Projects</a> <span class="divider">/</span>
			</li>
			<li class="active">New Project</li>
		</ul>
		
		<div class="row heading">
			<div class="span12">
				<h1>New Project</h1>
			</div>
		</div>
		
		<form action="" method="post">
		
			<xsl:call-template name="form:validation-summary"/>
			
			<div class="control-group">
				<label class="control-label" for="project-name">Project Name</label>
				<div class="controls">
					<xsl:call-template name="form:input">
						<xsl:with-param name="handle" select="'project-name'"/>
					</xsl:call-template>
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="client">Client</label>
				<div class="controls">
					<xsl:call-template name="form:input">
						<xsl:with-param name="handle" select="'client'"/>
					</xsl:call-template>
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="assigned-to">Participants</label>
				<div class="controls">
					<xsl:call-template name="form:select">
						<xsl:with-param name="handle" select="'participants'"/>
						<xsl:with-param name="options">
							<xsl:for-each select="users-per-organization/entry">
								<option value="{@id}"><xsl:value-of select="name"/></option>
							</xsl:for-each>
						</xsl:with-param>
						<xsl:with-param name="allow-multiple" select="'yes'"/>
						<xsl:with-param name="class" select="'chosen'"/>
					</xsl:call-template>
				</div>
			</div>
			
			<input name="fields[added-by]" type="hidden" value="{$member-id}" />
			<input name="fields[followed-by]" type="hidden" value="{$member-id}" />
			<input name="fields[status]" type="hidden" value="Active" />
			<input name="fields[organization-link]" type="hidden" value="{logged-in-member/entry/organization/item/@id}" />
			
			<div class="form-actions">
				<button type="submit" name="action[project-new]" class="btn btn-primary">Create New Project</button>
			</div>
			
		</form>
		
	</div><!-- .container -->
	
</xsl:template>

</xsl:stylesheet>
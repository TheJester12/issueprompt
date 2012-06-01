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
	
<xsl:variable name="form:event" select="/data/events/organization-edit"/>

<xsl:template match="data">

	<div class="container">
	
		<ul class="breadcrumb">
			<li>
				<a href="{$root}/dashboard/">Dashboard</a> <span class="divider">/</span>
			</li>
			<li class="active"><xsl:value-of select="logged-in-member-organization/entry/organization-name"/></li>
		</ul>
		
		<div class="row heading">
			<div class="span12">
				<h1>Edit <xsl:value-of select="logged-in-member-organization/entry/organization-name"/></h1>
			</div>
		</div>
		
		<div class="row">
		
			<div class="span9">
							
				<form action="" method="post">
		
					<xsl:call-template name="form:validation-summary"/>
					
					<div class="control-group">
						<label class="control-label" for="organization-name">Organization Name</label>
						<div class="controls">
							<xsl:call-template name="form:input">
								<xsl:with-param name="handle" select="'organization-name'"/>
								<xsl:with-param name="value" select="logged-in-member-organization/entry/organization-name"/>
							</xsl:call-template>
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label" for="website">Organization Website</label>
						<div class="controls">
							<xsl:call-template name="form:input">
								<xsl:with-param name="handle" select="'website'"/>
								<xsl:with-param name="value" select="logged-in-member-organization/entry/website"/>
							</xsl:call-template>
						</div>
					</div>
										
					<input name="id" type="hidden" value="{logged-in-member-organization/entry/@id}" />
					
					<div class="form-actions">
						<button type="submit" name="action[organization-edit]" class="btn btn-primary">Edit Organization</button>
					</div>
					
				</form>
							
			</div><!-- .span9 -->
			
			<div class="span3">
			
				
			
			</div><!-- .span3 -->
		
		</div><!-- .row -->
		
	</div><!-- .container -->
	
</xsl:template>

<xsl:template match="projects-all/entry">
						<tr>
							<td><a href="{$root}/projects/view/{organization-link/item/@handle}/{project-name/@handle}/"><xsl:value-of select="project-name"/></a></td>
							<td><xsl:value-of select="client/item"/></td>
							<td><xsl:value-of select="@issues"/> Issue<xsl:if test="@issues != '1'">s</xsl:if></td>
							<td><xsl:value-of select="@comments"/> Comment<xsl:if test="@comments != '1'">s</xsl:if></td>
						</tr>
</xsl:template>

</xsl:stylesheet>
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
	
<xsl:variable name="form:event" select="/data/events/user-invite"/>

<xsl:template match="data">

	<div class="container">
	
		<ul class="breadcrumb">
			<li>
				<a href="{$root}/dashboard/">Dashboard</a> <span class="divider">/</span>
			</li>
			<li>
				<a href="{$root}/users/{logged-in-member-organization/entry/organization-name/@handle}/"><xsl:value-of select="logged-in-member-organization/entry/organization-name"/> Users</a> <span class="divider">/</span>
			</li>
			<li class="active">Invite New User</li>
		</ul>
		
		<div class="row heading">
			<div class="span12">
				<h1>Invite A New User</h1>
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
					
					<input name="fields[role]" type="hidden" value="2" />
					<input name="fields[password][password]" type="hidden" value="temp135" />
					<input name="fields[password][confirm]" type="hidden" value="temp135" />
					<input name="fields[organization]" type="hidden" value="{logged-in-member-organization/entry/@id}" />
															
					<div class="form-actions">
						<button type="submit" name="action[user-invite]" class="btn btn-primary">Invite User</button>
					</div>
					
				</form>
							
			</div><!-- .span9 -->
			
			<div class="span3">
			
				
			
			</div><!-- .span3 -->
		
		</div><!-- .row -->
		
	</div><!-- .container -->
	
</xsl:template>

</xsl:stylesheet>
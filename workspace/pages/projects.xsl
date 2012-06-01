<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	xmlns:str="http://exslt.org/strings"
    extension-element-prefixes="str exsl">
	
<xsl:import href="../utilities/master-app.xsl"/>
<xsl:import href="../utilities/string-replace.xsl"/>

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />
	
<xsl:variable name="url-client"/>
<xsl:variable name="url-status"/>
<xsl:variable name="url-users"/>

<xsl:template match="data">

	<div class="container">
	
		<ul class="breadcrumb">
			<li>
				<a href="{$root}/dashboard/">Dashboard</a> <span class="divider">/</span>
			</li>
			<li class="active">Projects</li>
		</ul>
		
		<div class="row heading">
			<div class="span12">
				<h1><xsl:value-of select="logged-in-member-organization/entry/organization-name"/>'s Projects</h1>
			</div>
		</div>
		
		<div class="row">
		
			<div class="span9">
							
				<xsl:choose>
					<xsl:when test="projects-all/pagination/@total-entries = 0">
								
						<h2>Sorry, no projects found</h2>
						
					</xsl:when>
					<xsl:otherwise>
					<table cellpadding="0" cellspacing="0" border="0" class="table table-striped  table-bordered">
							<tbody>
								<tr class="labels">
									<th>Project</th>
									<th>Client</th>
									<th>Issues</th>
									<th>Comments</th>
								</tr>
								<xsl:apply-templates select="projects-all/entry"/>
							</tbody>
						</table>
					</xsl:otherwise>
				</xsl:choose>
				
				<xsl:call-template name="pagination">
					<xsl:with-param name="pagination" select="projects-all/pagination" />
					<xsl:with-param name="pagination-url">
						<xsl:value-of select="/data/params/root" />
						<xsl:value-of select="/data/params/parent-path" />
						<xsl:value-of select="/data/params/current-page" />
						<xsl:text>/?</xsl:text>
						<xsl:for-each select="/data/params/*[contains(name(), 'url-')]">
							<xsl:if test="not(name(.) = 'url-p')">
								<xsl:value-of select="concat(substring-after(name(), 'url-'), '=', text())" />
								<xsl:text disable-output-escaping="yes">&amp;</xsl:text>
							</xsl:if>
						</xsl:for-each>
						<xsl:text>p=$</xsl:text>
					</xsl:with-param>
					<xsl:with-param name="show-range" select="5" />
					<xsl:with-param name="label-next" select="'Next'" />
					<xsl:with-param name="label-previous" select="'Prev'" />
					<xsl:with-param name="class-selected" select="'active'" />
				</xsl:call-template>
			
			</div><!-- .span9 -->
			
			<div class="span3">
							
				<div class="btn-area"><a href="{$root}/projects/new/" class="btn btn-primary  btn-large btn-block">Add New Project</a></div>
				
				<ul class="nav nav-list well">
					<li class="nav-header">
						Filter by Client
					</li>
					<xsl:for-each select="clients-per-organization/client">
						<li class="select-one">
							<xsl:choose>
								<xsl:when test="$url-client = @handle">
									<xsl:attribute name="class">
										<xsl:text>active select-one</xsl:text>
									</xsl:attribute>
									<a>
									<xsl:attribute name="href">
										<xsl:value-of select="/data/params/root" />
										<xsl:value-of select="/data/params/parent-path" />
										<xsl:value-of select="/data/params/current-page" />
										<xsl:if test="count(/data/params/*[contains(name(), 'url-')]) &gt; 1">
											<xsl:text>/?</xsl:text>
										</xsl:if>
										<xsl:for-each select="/data/params/*[contains(name(), 'url-') and not(name(.) = 'url-client')]">
												<xsl:choose>
													<xsl:when test="contains(name(.), 'url-users')">
														<xsl:text>users=</xsl:text>
														<xsl:call-template name="string-replace-all">
															<xsl:with-param name="text" select="$url-users" />
															<xsl:with-param name="replace" select="'+'" />
															<xsl:with-param name="by" select="'%2B'" />
														</xsl:call-template>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="concat(substring-after(name(), 'url-'), '=', text())" />
													</xsl:otherwise>
												</xsl:choose>
												<xsl:if test="position() != last() and count(/data/params/*[contains(name(), 'url-')]) > 1">
													<xsl:text disable-output-escaping="yes">&amp;</xsl:text>
												</xsl:if>
										</xsl:for-each>
									</xsl:attribute>
									<xsl:value-of select="."/>
									</a>
								</xsl:when>
								<xsl:otherwise>
									<a>
										<xsl:attribute name="href">
											<xsl:value-of select="/data/params/root" />
											<xsl:value-of select="/data/params/parent-path" />
											<xsl:value-of select="/data/params/current-page" />
											<xsl:text>/?</xsl:text>
											<xsl:for-each select="/data/params/*[contains(name(), 'url-')]">
												<xsl:if test="not(name(.) = 'url-client') and not(name(.) = 'url-p')">
													<xsl:choose>
														<xsl:when test="contains(name(.), 'url-users')">
															<xsl:text>users=</xsl:text>
															<xsl:call-template name="string-replace-all">
																<xsl:with-param name="text" select="$url-users" />
																<xsl:with-param name="replace" select="'+'" />
																<xsl:with-param name="by" select="'%2B'" />
															</xsl:call-template>
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="concat(substring-after(name(), 'url-'), '=', text())" />
														</xsl:otherwise>
													</xsl:choose>
													<xsl:text disable-output-escaping="yes">&amp;</xsl:text>
												</xsl:if>
											</xsl:for-each>
											<xsl:text>client=</xsl:text>
											<xsl:value-of select="@handle"/>
										</xsl:attribute>
										<xsl:value-of select="."/>
									</a>
								</xsl:otherwise>
							</xsl:choose>
						</li>
					</xsl:for-each>
					<li class="nav-header">
						Filter by Participant
					</li>
					<xsl:for-each select="users-per-organization/entry">
						<xsl:variable name="currentUser" select="name/@handle"/>
						<li class="select-multiple">
							<xsl:choose>
								<xsl:when test="contains($url-users, name/@handle)">
									<xsl:attribute name="class">
										<xsl:text>active select-multiple</xsl:text>
									</xsl:attribute>
									<a>
										<xsl:attribute name="href">
											<xsl:value-of select="/data/params/root" />
											<xsl:value-of select="/data/params/parent-path" />
											<xsl:value-of select="/data/params/current-page" />
											<xsl:if test="count(/data/params/*[contains(name(), 'url-')]) &gt; 1">
												<xsl:text>/?</xsl:text>
											</xsl:if>
											<xsl:if test="count(/data/params/*[contains(name(), 'url-')]) = 1">
												<xsl:choose>
													<xsl:when test="count(str:tokenize($url-users, '+')) &gt; 1">
														<xsl:text>/?</xsl:text>
													</xsl:when>
													<xsl:otherwise>
														<xsl:text>/</xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:if>
											<xsl:for-each select="/data/params/*[contains(name(), 'url-')]">
												<xsl:choose>
													<xsl:when test="contains(name(.), 'url-users')">
														<xsl:if test="count(str:tokenize($url-users, '+')) &gt; 1">
															<xsl:text>users=</xsl:text>
														</xsl:if>
														<xsl:for-each select="str:tokenize($url-users, '+')[. != $currentUser]">
															<xsl:if test=". != $currentUser">
																<xsl:value-of select="."/>
																<xsl:if test="position() != last()">
																	<xsl:text>%2B</xsl:text>
																</xsl:if>
															</xsl:if>
														</xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="concat(substring-after(name(), 'url-'), '=', text())" />
													</xsl:otherwise>
												</xsl:choose>
												<xsl:if test="position() != last() and count(/data/params/*[contains(name(), 'url-')]) > 1">
													<xsl:text disable-output-escaping="yes">&amp;</xsl:text>
												</xsl:if>
											</xsl:for-each>
										</xsl:attribute>
										<xsl:value-of select="name"/>
									</a>
								</xsl:when>
								<xsl:otherwise>
								<a>
									<xsl:attribute name="href">
										<xsl:value-of select="/data/params/root" />
										<xsl:value-of select="/data/params/parent-path" />
										<xsl:value-of select="/data/params/current-page" />
										<xsl:text>/?</xsl:text>
										<xsl:for-each select="/data/params/*[contains(name(), 'url-')]">
											<xsl:if test="not(name(.) = 'url-users') and not(name(.) = 'url-p')">
												<xsl:value-of select="concat(substring-after(name(), 'url-'), '=', text())" />
												<xsl:text disable-output-escaping="yes">&amp;</xsl:text>
											</xsl:if>
										</xsl:for-each>
										<xsl:text>users=</xsl:text>
										<xsl:if test="$url-users != ''">
											<xsl:call-template name="string-replace-all">
												<xsl:with-param name="text" select="$url-users" />
												<xsl:with-param name="replace" select="'+'" />
												<xsl:with-param name="by" select="'%2B'" />
											</xsl:call-template>
											<xsl:text>%2B</xsl:text>
										</xsl:if>
										<xsl:value-of select="name/@handle"/>
									</xsl:attribute>
									<xsl:value-of select="name"/>
									</a>
								</xsl:otherwise>
							</xsl:choose>
						</li>
					</xsl:for-each>
					<li class="nav-header">
						Filter by Status
					</li>
					<li>
						<xsl:if test="$url-status = 'active' or $url-status = ''">
							<xsl:attribute name="class">
								<xsl:text>active</xsl:text>
							</xsl:attribute>
						</xsl:if>
						<a>
							<xsl:attribute name="href">
								<xsl:value-of select="/data/params/root" />
								<xsl:value-of select="/data/params/parent-path" />
								<xsl:value-of select="/data/params/current-page" />
								<xsl:text>/?</xsl:text>
								<xsl:for-each select="/data/params/*[contains(name(), 'url-') and not(name(.) = 'url-status') and not(name(.) = 'url-p')]">
									<xsl:choose>
										<xsl:when test="contains(name(.), 'url-users')">
											<xsl:text>users=</xsl:text>
											<xsl:call-template name="string-replace-all">
												<xsl:with-param name="text" select="$url-users" />
												<xsl:with-param name="replace" select="'+'" />
												<xsl:with-param name="by" select="'%2B'" />
											</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="concat(substring-after(name(), 'url-'), '=', text())" />
										</xsl:otherwise>
									</xsl:choose>
									<xsl:if test="position() != last() and count(/data/params/*[contains(name(), 'url-')]) > 1">
										<xsl:text disable-output-escaping="yes">&amp;</xsl:text>
									</xsl:if>
								</xsl:for-each>
							</xsl:attribute>
							<xsl:text>Active</xsl:text>
						</a>
					</li>
					<li>
						<xsl:if test="$url-status = 'inactive'">
							<xsl:attribute name="class">
								<xsl:text>active</xsl:text>
							</xsl:attribute>
						</xsl:if>
						<a>
							<xsl:attribute name="href">
								<xsl:value-of select="/data/params/root" />
								<xsl:value-of select="/data/params/parent-path" />
								<xsl:value-of select="/data/params/current-page" />
								<xsl:text>/?</xsl:text>
								<xsl:for-each select="/data/params/*[contains(name(), 'url-')]">
									<xsl:if test="not(name(.) = 'url-status') and not(name(.) = 'url-p')">
										<xsl:choose>
											<xsl:when test="contains(name(.), 'url-users')">
												<xsl:text>users=</xsl:text>
												<xsl:call-template name="string-replace-all">
													<xsl:with-param name="text" select="$url-users" />
													<xsl:with-param name="replace" select="'+'" />
													<xsl:with-param name="by" select="'%2B'" />
												</xsl:call-template>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="concat(substring-after(name(), 'url-'), '=', text())" />
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text disable-output-escaping="yes">&amp;</xsl:text>
									</xsl:if>
								</xsl:for-each>
								<xsl:text>status=inactive</xsl:text>
							</xsl:attribute>
							<xsl:text>Inactive</xsl:text>
						</a>
					</li>
				</ul>
			
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
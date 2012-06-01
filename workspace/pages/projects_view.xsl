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
	
<xsl:variable name="url-tags"/>
<xsl:variable name="url-users"/>
<xsl:variable name="url-creator"/>
<xsl:variable name="url-sort"/>
<xsl:variable name="url-order"/>
<xsl:variable name="url-status"/>
<xsl:variable name="currentUser"/>
<xsl:variable name="currentTag"/>

<xsl:template match="data">

	<div class="container">
	
		<ul class="breadcrumb">
			<li>
				<a href="{$root}/dashboard/">Dashboard</a> <span class="divider">/</span>
			</li>
			<li>
				<a href="{$root}/projects/">Projects</a> <span class="divider">/</span>
			</li>
			<li class="active"><xsl:value-of select="project-view-individual/entry/project-name"/></li>
		</ul>
		
		<div class="row heading">
			<div class="span12">
				<h1><xsl:value-of select="project-view-individual/entry/project-name"/> Issues</h1>
			</div>
		</div>
		
		<div class="row">
		
			<div class="span9">
				
				<xsl:choose>
					<xsl:when test="issues-per-project/pagination/@total-entries = 0">
								
						<h2>Sorry, no issues found</h2>
						
					</xsl:when>
					<xsl:otherwise>
						<table cellpadding="0" cellspacing="0" border="0" class="table table-striped  table-bordered">
							<tbody>
								<tr class="labels">
									<th width="5%">Priority</th>
									<th width="30%">Issue Name</th>
									<th width="20%">Date Modified</th>
									<th width="25%">Assigned To</th>
									<th width="15%">Comments</th>
								</tr>
								<xsl:apply-templates select="issues-per-project/entry"/>
							</tbody>
						</table>
					</xsl:otherwise>
				</xsl:choose>
				
				<xsl:call-template name="pagination">
					<xsl:with-param name="pagination" select="issues-per-project/pagination" />
					<xsl:with-param name="pagination-url">
						<xsl:value-of select="/data/params/root" />
						<xsl:value-of select="/data/params/parent-path" />
						<xsl:text>/</xsl:text>
						<xsl:value-of select="/data/params/current-page" />
						<xsl:text>/</xsl:text>
						<xsl:value-of select="/data/params/organization" />
						<xsl:text>/</xsl:text>
						<xsl:value-of select="/data/params/projectname" />
						<xsl:text>/?</xsl:text>
						<xsl:for-each select="/data/params/*[contains(name(), 'url-')]">
							<xsl:if test="not(name(.) = 'url-p')">
								<xsl:choose>
									<xsl:when test="contains(name(.), 'url-users')">
										<xsl:text>users=</xsl:text>
										<xsl:call-template name="string-replace-all">
											<xsl:with-param name="text" select="$url-users" />
											<xsl:with-param name="replace" select="'+'" />
											<xsl:with-param name="by" select="'%2B'" />
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="contains(name(.), 'url-tags')">
										<xsl:text>tags=</xsl:text>
										<xsl:call-template name="string-replace-all">
											<xsl:with-param name="text" select="$url-tags" />
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
						<xsl:text>p=$</xsl:text>
					</xsl:with-param>
					<xsl:with-param name="show-range" select="5" />
					<xsl:with-param name="label-next" select="'Next'" />
					<xsl:with-param name="label-previous" select="'Prev'" />
					<xsl:with-param name="class-selected" select="'active'" />
				</xsl:call-template>
			
			</div><!-- .span9 -->
			
			<div class="span3">
			
				<xsl:choose>
			
					<xsl:when test="project-view-individual/entry/participants/item/@id = $member-id">
								
						<div class="btn-area"><a href="{$root}/projects/issues/new/{project-view-individual/entry/organization-link/item/@handle}/{project-view-individual/entry/project-name/@handle}/" class="btn btn-primary btn-large btn-block">Add New Issue</a></div>
						
						<div class="btn-area"><a href="{$root}/projects/edit/{project-view-individual/entry/organization-link/item/@handle}/{project-view-individual/entry/project-name/@handle}/" class="btn btn-primary btn-large btn-block">Edit Project</a></div>
					
					</xsl:when>
					
					<xsl:otherwise>
					
						<div class="btn-area"><a href="{$root}/projects/edit/{project-view-individual/entry/organization-link/item/@handle}/{project-view-individual/entry/project-name/@handle}/" class="btn btn-large btn-block">Participate In Project</a></div>
						
					</xsl:otherwise>
					
				</xsl:choose>
				
				<ul class="nav nav-list well">
					<li class="nav-header">
						Filter by Tag
					</li>
					<xsl:for-each select="tags-per-project/tag">
						<xsl:variable name="currentTag" select="@handle"/>
						<li class="select-multiple">
							<xsl:choose>
								<xsl:when test="contains($url-tags, @handle)">
									<xsl:attribute name="class">
										<xsl:text>active select-multiple</xsl:text>
									</xsl:attribute>
									<a>
										<xsl:attribute name="href">
											<xsl:value-of select="/data/params/root" />
											<xsl:value-of select="/data/params/parent-path" />
											<xsl:text>/</xsl:text>
											<xsl:value-of select="/data/params/current-page" />
											<xsl:text>/</xsl:text>
											<xsl:value-of select="/data/params/organization" />
											<xsl:text>/</xsl:text>
											<xsl:value-of select="/data/params/projectname" />
											<xsl:if test="count(/data/params/*[contains(name(), 'url-')]) &gt; 1">
												<xsl:text>/?</xsl:text>
											</xsl:if>
											<xsl:if test="count(/data/params/*[contains(name(), 'url-')]) = 1">
												<xsl:choose>
													<xsl:when test="count(str:tokenize($url-tags, '+')) &gt; 1">
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
														<xsl:text>users=</xsl:text>
														<xsl:call-template name="string-replace-all">
															<xsl:with-param name="text" select="$url-users" />
															<xsl:with-param name="replace" select="'+'" />
															<xsl:with-param name="by" select="'%2B'" />
														</xsl:call-template>
													</xsl:when>
													<xsl:when test="not(name(.) = 'url-users') and not(name(.) = 'url-tags')">
														<xsl:value-of select="concat(substring-after(name(), 'url-'), '=', text())" />
													</xsl:when>
												</xsl:choose>
												<xsl:if test="count(/data/params/*[contains(name(), 'url-')]) &gt; 1 and name(.) != 'url-tags'">
													<xsl:choose>
														<xsl:when test="position() = last()-1 and count(str:tokenize($url-tags, '+')) = 1">
														</xsl:when>
														<xsl:otherwise>
															<xsl:text disable-output-escaping="yes">&amp;</xsl:text>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:if>
											</xsl:for-each>
											<xsl:if test="count(str:tokenize($url-tags, '+')) &gt; 1">
												<xsl:text>tags=</xsl:text>
											</xsl:if>
											<xsl:for-each select="str:tokenize($url-tags, '+')[. != $currentTag]">
												<xsl:if test=". != $currentTag">
													<xsl:value-of select="."/>
													<xsl:if test="position() != last()">
														<xsl:text>%2B</xsl:text>
													</xsl:if>
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
											<xsl:text>/</xsl:text>
											<xsl:value-of select="/data/params/current-page" />
											<xsl:text>/</xsl:text>
											<xsl:value-of select="/data/params/organization" />
											<xsl:text>/</xsl:text>
											<xsl:value-of select="/data/params/projectname" />
											<xsl:text>/?</xsl:text>
											<xsl:for-each select="/data/params/*[contains(name(), 'url-')]">
												<xsl:if test="not(name(.) = 'url-tags') and not(name(.) = 'url-p')">
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
											<xsl:text>tags=</xsl:text>
											<xsl:if test="$url-tags != ''">
												<xsl:call-template name="string-replace-all">
													<xsl:with-param name="text" select="$url-tags" />
													<xsl:with-param name="replace" select="'+'" />
													<xsl:with-param name="by" select="'%2B'" />
												</xsl:call-template>
												<xsl:text>%2B</xsl:text>
											</xsl:if>
											<xsl:value-of select="@handle"/>
										</xsl:attribute>
										<xsl:value-of select="."/>
									</a>
								</xsl:otherwise>
							</xsl:choose>
						</li>
					</xsl:for-each>
					<li class="nav-header">
						Filter by Assigned User
					</li>
					<xsl:for-each select="project-view-individual/entry/participants/item">
						<xsl:variable name="currentUser" select="@handle"/>
						<li class="select-multiple">
							<xsl:choose>
								<xsl:when test="contains($url-users, @handle)">
									<xsl:attribute name="class">
										<xsl:text>active select-multiple</xsl:text>
									</xsl:attribute>
									<a>
										<xsl:attribute name="href">
											<xsl:value-of select="/data/params/root" />
											<xsl:value-of select="/data/params/parent-path" />
											<xsl:text>/</xsl:text>
											<xsl:value-of select="/data/params/current-page" />
											<xsl:text>/</xsl:text>
											<xsl:value-of select="/data/params/organization" />
											<xsl:text>/</xsl:text>
											<xsl:value-of select="/data/params/projectname" />
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
													<xsl:when test="contains(name(.), 'url-tags')">
														<xsl:text>tags=</xsl:text>
														<xsl:call-template name="string-replace-all">
															<xsl:with-param name="text" select="$url-tags" />
															<xsl:with-param name="replace" select="'+'" />
															<xsl:with-param name="by" select="'%2B'" />
														</xsl:call-template>
													</xsl:when>
													<xsl:when test="not(name(.) = 'url-users') and not(name(.) = 'url-tags')">
														<xsl:value-of select="concat(substring-after(name(), 'url-'), '=', text())" />
													</xsl:when>
												</xsl:choose>
												<xsl:if test="count(/data/params/*[contains(name(), 'url-')]) &gt; 1 and name(.) != 'url-users'">
													<xsl:choose>
														<xsl:when test="position() = last()-1 and count(str:tokenize($url-users, '+')) = 1">
														</xsl:when>
														
														<xsl:otherwise>
															<xsl:text disable-output-escaping="yes">&amp;</xsl:text>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:if>
											</xsl:for-each>
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
										</xsl:attribute>
										<xsl:value-of select="."/>
									</a>
								</xsl:when>
								<xsl:otherwise>
								<a>
									<xsl:attribute name="href">
										<xsl:value-of select="/data/params/root" />
										<xsl:value-of select="/data/params/parent-path" />
										<xsl:text>/</xsl:text>
										<xsl:value-of select="/data/params/current-page" />
										<xsl:text>/</xsl:text>
										<xsl:value-of select="/data/params/organization" />
										<xsl:text>/</xsl:text>
										<xsl:value-of select="/data/params/projectname" />
										<xsl:text>/?</xsl:text>
										<xsl:for-each select="/data/params/*[contains(name(), 'url-')]">
											<xsl:if test="not(name(.) = 'url-users') and not(name(.) = 'url-p')">
												<xsl:choose>
													<xsl:when test="contains(name(.), 'url-tags')">
														<xsl:text>tags=</xsl:text>
														<xsl:call-template name="string-replace-all">
															<xsl:with-param name="text" select="$url-tags" />
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
										<xsl:text>users=</xsl:text>
										<xsl:if test="$url-users != ''">
											<xsl:call-template name="string-replace-all">
												<xsl:with-param name="text" select="$url-users" />
												<xsl:with-param name="replace" select="'+'" />
												<xsl:with-param name="by" select="'%2B'" />
											</xsl:call-template>
											<xsl:text>%2B</xsl:text>
										</xsl:if>
										<xsl:value-of select="@handle"/>
									</xsl:attribute>
									<xsl:value-of select="."/>
									</a>
								</xsl:otherwise>
							</xsl:choose>
						</li>
					</xsl:for-each>
					<!--
					<li class="nav-header">
						Filter by Creator
					</li>
					<li class="active">
						<a href="#">Jesse</a>
					</li>
					<li>
						<a href="#">Joe</a>
					</li>
					<li>
						<a href="#">Justin</a>
					</li>
					-->
					<li class="nav-header">
						Order By
					</li>
					<li>
						<xsl:if test="$url-sort = 'priority' or $url-sort = ''">
							<xsl:attribute name="class">
								<xsl:text>active</xsl:text>
							</xsl:attribute>
						</xsl:if>
						<a>
							<xsl:attribute name="href">
								<xsl:value-of select="/data/params/root" />
								<xsl:value-of select="/data/params/parent-path" />
								<xsl:text>/</xsl:text>
								<xsl:value-of select="/data/params/current-page" />
								<xsl:text>/</xsl:text>
								<xsl:value-of select="/data/params/organization" />
								<xsl:text>/</xsl:text>
								<xsl:value-of select="/data/params/projectname" />
								<xsl:text>/?</xsl:text>
								<xsl:for-each select="/data/params/*[contains(name(), 'url-') and not(name(.) = 'url-sort') and not(name(.) = 'url-order')]">
									<xsl:choose>
										<xsl:when test="contains(name(.), 'url-tags')">
											<xsl:text>tags=</xsl:text>
											<xsl:call-template name="string-replace-all">
												<xsl:with-param name="text" select="$url-tags" />
												<xsl:with-param name="replace" select="'+'" />
												<xsl:with-param name="by" select="'%2B'" />
											</xsl:call-template>
										</xsl:when>
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
									<xsl:if test="count(/data/params/*[contains(name(), 'url-')]) &gt; 1">
										<xsl:text disable-output-escaping="yes">&amp;</xsl:text>
									</xsl:if>
								</xsl:for-each>
								<xsl:text>sort=priority&amp;order=asc</xsl:text>
							</xsl:attribute>
							<xsl:text>Priority</xsl:text>
						</a>
					</li>
					<li>
						<xsl:if test="$url-sort = 'date-added'">
							<xsl:attribute name="class">
								<xsl:text>active</xsl:text>
							</xsl:attribute>
						</xsl:if>
						<a>
							<xsl:attribute name="href">
								<xsl:value-of select="/data/params/root" />
								<xsl:value-of select="/data/params/parent-path" />
								<xsl:text>/</xsl:text>
								<xsl:value-of select="/data/params/current-page" />
								<xsl:text>/</xsl:text>
								<xsl:value-of select="/data/params/organization" />
								<xsl:text>/</xsl:text>
								<xsl:value-of select="/data/params/projectname" />
								<xsl:text>/?</xsl:text>
								<xsl:for-each select="/data/params/*[contains(name(), 'url-') and not(name(.) = 'url-sort') and not(name(.) = 'url-order')]">
									<xsl:choose>
										<xsl:when test="contains(name(.), 'url-tags')">
											<xsl:text>tags=</xsl:text>
											<xsl:call-template name="string-replace-all">
												<xsl:with-param name="text" select="$url-tags" />
												<xsl:with-param name="replace" select="'+'" />
												<xsl:with-param name="by" select="'%2B'" />
											</xsl:call-template>
										</xsl:when>
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
									<xsl:if test="count(/data/params/*[contains(name(), 'url-')]) &gt; 1">
										<xsl:text disable-output-escaping="yes">&amp;</xsl:text>
									</xsl:if>
								</xsl:for-each>
								<xsl:text>sort=date-added&amp;order=desc</xsl:text>
							</xsl:attribute>
							<xsl:text>Date Added</xsl:text>
						</a>
					</li>
					<li>
						<xsl:if test="$url-sort = 'date-modified'">
							<xsl:attribute name="class">
								<xsl:text>active</xsl:text>
							</xsl:attribute>
						</xsl:if>
						<a>
							<xsl:attribute name="href">
								<xsl:value-of select="/data/params/root" />
								<xsl:value-of select="/data/params/parent-path" />
								<xsl:text>/</xsl:text>
								<xsl:value-of select="/data/params/current-page" />
								<xsl:text>/</xsl:text>
								<xsl:value-of select="/data/params/organization" />
								<xsl:text>/</xsl:text>
								<xsl:value-of select="/data/params/projectname" />
								<xsl:text>/?</xsl:text>
								<xsl:for-each select="/data/params/*[contains(name(), 'url-') and not(name(.) = 'url-sort') and not(name(.) = 'url-order')]">
									<xsl:choose>
										<xsl:when test="contains(name(.), 'url-tags')">
											<xsl:text>tags=</xsl:text>
											<xsl:call-template name="string-replace-all">
												<xsl:with-param name="text" select="$url-tags" />
												<xsl:with-param name="replace" select="'+'" />
												<xsl:with-param name="by" select="'%2B'" />
											</xsl:call-template>
										</xsl:when>
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
									<xsl:if test="count(/data/params/*[contains(name(), 'url-')]) &gt; 1">
										<xsl:text disable-output-escaping="yes">&amp;</xsl:text>
									</xsl:if>
								</xsl:for-each>
								<xsl:text>sort=date-modified&amp;order=desc</xsl:text>
							</xsl:attribute>
							<xsl:text>Date Modified</xsl:text>
						</a>
					</li>
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
								<xsl:text>/</xsl:text>
								<xsl:value-of select="/data/params/current-page" />
								<xsl:text>/</xsl:text>
								<xsl:value-of select="/data/params/organization" />
								<xsl:text>/</xsl:text>
								<xsl:value-of select="/data/params/projectname" />
								<xsl:if test="count(/data/params/*[contains(name(), 'url-')]) &gt; 1">
									<xsl:text>/?</xsl:text>
								</xsl:if>
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
										<xsl:when test="contains(name(.), 'url-tags')">
											<xsl:text>tags=</xsl:text>
											<xsl:call-template name="string-replace-all">
												<xsl:with-param name="text" select="$url-tags" />
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
								<xsl:text>/</xsl:text>
								<xsl:value-of select="/data/params/current-page" />
								<xsl:text>/</xsl:text>
								<xsl:value-of select="/data/params/organization" />
								<xsl:text>/</xsl:text>
								<xsl:value-of select="/data/params/projectname" />
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
											<xsl:when test="contains(name(.), 'url-tags')">
												<xsl:text>tags=</xsl:text>
												<xsl:call-template name="string-replace-all">
													<xsl:with-param name="text" select="$url-tags" />
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

<xsl:template match="issues-per-project/entry">
						<tr>
							<td><div><xsl:attribute name="class">priority priority-<xsl:value-of select="priority/item"/></xsl:attribute></div></td>
							<td><div><a href="{$root}/projects/issues/{organization-link/item/@handle}/{project-link/item/@handle}/{@id}/"><xsl:value-of select="issue-name"/></a></div><div><xsl:text>Tags: </xsl:text>
								<xsl:for-each select="tags/item">
									<a href=""><xsl:value-of select="."/></a><xsl:if test="position() != last()"
									><xsl:text>, </xsl:text></xsl:if>
								</xsl:for-each>
							</div></td>
							<td><xsl:call-template name="format-date"><xsl:with-param name="date" select="date-added"/><xsl:with-param name="format" select="'m. D, Y'"/></xsl:call-template></td>
							<td>
								<xsl:for-each select="assigned-to/item">
									<xsl:value-of select="."/>
									<xsl:if test="position() != last()">
										<xsl:text>, </xsl:text>
									</xsl:if>
								</xsl:for-each>
							</td>
							<td><xsl:value-of select="@comments"/> Comment<xsl:if test="@comments != '1'">s</xsl:if></td>
						</tr>
</xsl:template>

</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master-app.xsl"/>
<xsl:import href="../utilities/members.form-login.xsl"/>

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />
	
<xsl:variable name="member-is-logged-in" select="boolean(//events/member-login-info/@logged-in = 'yes')"/>

<xsl:template match="data">
    <h1>Login</h1>
    
	<p>Your district will need to sign up in order for you to create a new account here, <a href="#">more information</a>.</p>

    <xsl:choose>
        <xsl:when test="$member-is-logged-in">
            <p>You are logged in. (<a href="?member-action=logout&amp;redirect={$current-url}">Logout</a>)</p>
        </xsl:when>
        <xsl:otherwise>
            <xsl:call-template name="members-form-login"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

</xsl:stylesheet>
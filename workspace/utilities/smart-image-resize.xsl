<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="smart-resize-image">

  <xsl:param name="xml" /> <!-- Incoming XML node -->
  <xsl:param name="max-w" select="300"/> <!-- Max Width (default = 300) -->
  <xsl:param name="max-h" select="400"/> <!-- Max Height (default = 400) -->
  <xsl:param name="alt" select="'image'"/> <!-- Alt value (optional, default = 'image') -->
  <xsl:param name="class" /> <!-- class (optional) -->

  <!-- Calculating biggest size of an image -->
  <xsl:variable name="b-side">
    <xsl:choose>
      <xsl:when test="$xml/meta/@width &gt;= $xml/meta/@height">w</xsl:when>
      <xsl:otherwise>h</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  
  <!-- Image Result -->  
  <xsl:element name="img">
    <!-- Src value depending on biggest size and limits -->
    <xsl:attribute name="src">
      <xsl:choose>
        <xsl:when test="($b-side = 'w') and ($xml/meta/@width &gt; $max-w)">
          <xsl:value-of select="concat('/image/1/', $max-w,'/0/0/', $xml/@path, '/', $xml/filename)"/>
        </xsl:when>
        <xsl:when test="($b-side = 'h') and ($xml/meta/@height &gt; $max-h)">
          <xsl:value-of select="concat('/image/1/0/', $max-h,'/0/', $xml/@path, '/', $xml/filename)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat('/workspace', $xml/@path, '/', $xml/filename)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    
    <xsl:attribute name="alt"><xsl:value-of select="$alt"/></xsl:attribute>
    
    <xsl:if test="$class">
      <xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute>  
    </xsl:if>
  </xsl:element>
  
</xsl:template>

</xsl:stylesheet>
﻿<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output omit-xml-declaration="yes" indent="no" method="text" encoding="UTF-8"/>
	<xsl:template match="/">
		<xsl:text>using System;

namespace </xsl:text>
		<xsl:value-of select="entity/@namespaceModel"/>
		<xsl:text>
{</xsl:text>
		<xsl:apply-templates select="entity"/>
		<xsl:text>
}
</xsl:text>
	</xsl:template>
	<xsl:template match="entity">
	/// &lt;summary&gt;
	/// Entity Class <xsl:value-of select="@name"/>
	/// &lt;/summary&gt;
	[Serializable]
	public class <xsl:value-of select="@name"/>
	{
		#region declaration
		private string _TableName = "<xsl:value-of select="@tableName"/>";
        private string _PrimaryKey = "<xsl:for-each select="./primaryKey/column">
            <xsl:value-of select="@columnName"/></xsl:for-each>";<xsl:for-each select="./columns/property">
		private <xsl:value-of select="@csharptype"/><xsl:text> </xsl:text>
		<xsl:value-of select="@field"/>;</xsl:for-each>
		#endregion

		#region constructors
		/// &lt;summary&gt;
        /// Default constructor
        /// &lt;/summary&gt;
		public <xsl:value-of select="@name"/>() { }
		
		/// &lt;summary&gt;
        /// Full constructor
        /// &lt;/summary&gt;
		public <xsl:value-of select="@name"/>(<xsl:for-each select="./columns/property">
			<xsl:value-of select="@csharptype"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="@lowerName"/>			
			<xsl:if test="position()!=last()">
				<xsl:text>, </xsl:text>
			</xsl:if>
		</xsl:for-each>)
        {<xsl:for-each select="./columns/property">
			this.<xsl:value-of select="@field"/> = <xsl:value-of select="@lowerName"/>
			<xsl:text>;</xsl:text>
		</xsl:for-each>
        }        
		#endregion

		#region property
		/// &lt;summary&gt;
        /// TableName
        /// &lt;/summary&gt;
        public string TableName
        {
            get { return _TableName; }
        }
        /// &lt;summary&gt;
        /// PrimaryKey
        /// &lt;/summary&gt;
        public string PrimaryKey
        {
            get { return _PrimaryKey; }
        }<xsl:for-each select="./columns/property">
		/// &lt;summary&gt;
		/// <xsl:value-of select="@columnDescription"/>
		/// &lt;/summary&gt;
		public <xsl:value-of select="@csharptype"/><xsl:text> </xsl:text>
			<xsl:value-of select="@columnName"/>
		{
			get	{ return <xsl:value-of select="@field"/>; }
			set	{ <xsl:value-of select="@field"/> = value; }
		}</xsl:for-each>
		#endregion
		
		&lt;table class=table_field cellSpacing=1 cellPadding=2 align=center&gt;        
			&lt;tr class=tr_title&gt;
				&lt;td colSpan=3&gt;网站参数配置&lt;/td&gt;
			&lt;/tr&gt;
			&lt;tr class=tr_field&gt;
				&lt;td class="td_field_label"&gt;&lt;span class="input_mandatory"&gt;*&lt;/span&gt;网站名称：&lt;/td&gt;
				&lt;td class="td_field_input"&gt;&lt;input id="txtWebsiteName" type="text" value="猎头网" class="long_input" pattern="required max-length-40" tip="网站的名称" /&gt;&lt;/td&gt;
				&lt;td class="td_field_info"&gt;&lt;div id="txtWebsiteNameTip"&gt;&lt;/div&gt;&lt;/td&gt;
			&lt;/tr&gt;
			
		
	}</xsl:template>
</xsl:stylesheet>
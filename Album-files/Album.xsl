<?xml version="1.0"?>
<xsl:stylesheet 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0"
>

<!-- Stylesheet for Photo Album in XSL language -->

<!-- Made by Stefano Cotta Ramusino with XML-Spy and Notepad -->

	<xsl:template name="photo">
		<xsl:param name="var1" select="position()"/>
		<xsl:param name="var2" select="0"/>
		<xsl:param name="var3" select="0"/>
		<SCRIPT LANGUAGE="JavaScript">load(<xsl:value-of select="$var3"/>+<xsl:value-of select="$var2"/>+<xsl:value-of select="$var1"/>-1,'photo');</SCRIPT>
		<IMG CLASS="thumbs" ID="photo">
			<xsl:attribute name="SRC">Floppy/<xsl:value-of select="@floppy"/>/<xsl:value-of select="PHOTOINFO/text()"/></xsl:attribute>
			<xsl:if test="not(@comment)">
				<xsl:attribute name="ALT">No comment</xsl:attribute>
			</xsl:if>
			<xsl:if test="@comment">
				<xsl:attribute name="ALT"><xsl:value-of select="@comment"/></xsl:attribute>
			</xsl:if>
			<xsl:attribute name="ONCLICK">FullScreen('Floppy/<xsl:value-of select="@floppy"/>/<xsl:value-of select="PHOTOINFO/text()"/>');</xsl:attribute>
			<xsl:attribute name="ONMOUSEOVER">window.status = 'Enlarge the photo \'<xsl:value-of select="text()"/>\' that is in Floppy <xsl:value-of select="@floppy"/>  (<xsl:value-of select="PHOTOINFO/text()"/>)';return true;</xsl:attribute>
			<xsl:attribute name="ONMOUSEOUT">window.status = '';</xsl:attribute>
		</IMG>
		<BR/>
		<DIV CLASS="photoname">
			<xsl:attribute name="ONCLICK">FullScreen('Floppy/<xsl:value-of select="@floppy"/>/<xsl:value-of select="PHOTOINFO/text()"/>')</xsl:attribute>
			<xsl:attribute name="ONMOUSEOVER">window.status = 'Enlarge the photo \'<xsl:value-of select="text()"/>\' that is in Floppy <xsl:value-of select="@floppy"/>  (<xsl:value-of select="PHOTOINFO/text()"/>)';return true;</xsl:attribute>
			<xsl:attribute name="ONMOUSEOUT">window.status = '';</xsl:attribute>
			<xsl:value-of select="text()"/>
		</DIV>
		<TABLE CLASS="small">
			<TR>
				<TD CLASS="attribute">Location</TD>
				<TD CLASS="value1">
					<xsl:value-of select="LOCATION"/>
				</TD>
			</TR>
			<xsl:if test="LOCATION/@place">
				<TR>
					<TD CLASS="attribute">Place</TD>
					<TD CLASS="value1">
						<xsl:value-of select="LOCATION/@place"/>
					</TD>
				</TR>
			</xsl:if>
			<TR>
				<TD CLASS="attribute">Date</TD>
				<TD CLASS="value1">
					<SCRIPT LANGUAGE="JavaScript">document.write(date('Floppy/<xsl:value-of select="@floppy"/>/<xsl:value-of select="PHOTOINFO/text()"/>'));</SCRIPT>
				</TD>
			</TR>
		</TABLE>
		<TABLE CLASS="abn">
			<TR>
				<TD CLASS="titabn"><xsl:attribute name="ONCLICK">showInfo(<xsl:value-of select="$var3"/>+<xsl:value-of select="$var2"/>+<xsl:value-of select="$var1"/>-1);</xsl:attribute>Info about the photo</TD>
			</TR>
			<TR>
				<TD ID="hidden">
					<TABLE CLASS="PhotoInfo">
						<TR>
							<TD CLASS="info">File name</TD>
							<TD CLASS="value">
								<A name="fileName">
									<xsl:attribute name="href">Floppy/<xsl:value-of select="@floppy"/>/<xsl:value-of select="PHOTOINFO/text()"/></xsl:attribute>
									<NOBR CLASS="nounder">
										<xsl:value-of select="PHOTOINFO"/>
									</NOBR>
								</A>
							</TD>
						</TR>
						<TR>
							<TD CLASS="info">Size</TD>
							<TD CLASS="value">
								<xsl:value-of select="PHOTOINFO/@size"/>
							</TD>
						</TR>
						<TR>
							<TD CLASS="info">File size</TD>
							<TD CLASS="value">
								<SCRIPT LANGUAGE="JavaScript">document.write(file_size_Format('Floppy/<xsl:value-of select="@floppy"/>/<xsl:value-of select="PHOTOINFO/text()"/>'));</SCRIPT>
							</TD>
						</TR>

						<TR>
							<TD CLASS="info">Quality</TD>
							<TD CLASS="value">
								<xsl:value-of select="PHOTOINFO/@quality"/>
							</TD>
						</TR>
						<TR>
							<TD CLASS="info">Color model</TD>
							<TD CLASS="value">
								<xsl:value-of select="PHOTOINFO/@color"/>
							</TD>
						</TR>
						<TR>
							<TD CLASS="info">Resolution</TD>
							<TD CLASS="value">
								<xsl:value-of select="PHOTOINFO/@resolution"/>
							</TD>
						</TR>
						<xsl:if test="PHOTOINFO/@filter">
							<TR>
								<TD CLASS="info">Filtro</TD>
								<TD CLASS="value">
									<xsl:value-of select="PHOTOINFO/@filter"/>
								</TD>
							</TR>
						</xsl:if>
						<xsl:if test="PHOTOINFO/@effect">
							<TR>
								<TD CLASS="info">Effect</TD>
								<TD CLASS="value">
									<xsl:if test="PHOTOINFO/@effect[. = 'negative']">
										<DIV CLASS="noNormal">
											<xsl:attribute name="ONCLICK">positive(<xsl:value-of select="$var3"/>+<xsl:value-of select="$var2"/>+<xsl:value-of select="$var1"/>-1);</xsl:attribute>
											<xsl:attribute name="ONMOUSEOVER">window.status='Click if you want to see the photo \'<xsl:value-of select="text()"/>\' in positive';return true;</xsl:attribute>
											<xsl:attribute name="ONMOUSEOUT">window.status='';</xsl:attribute>
											<xsl:value-of select="PHOTOINFO/@effect"/>
										</DIV>
									</xsl:if>
									<xsl:if test="PHOTOINFO/@effect[not(. = 'negative')]">
										<xsl:value-of select="PHOTOINFO/@effect"/>
									</xsl:if>
								</TD>
							</TR>
						</xsl:if>
						<TR>
							<TD CLASS="info">Type</TD>
							<TD CLASS="value">
								<xsl:if test="PHOTOINFO/@type[. = 'NORMAL']">
									<xsl:value-of select="PHOTOINFO/@type"/>
								</xsl:if>
								<xsl:if test="PHOTOINFO/@file">
									<A CLASS="noNormal">
										<xsl:attribute name="ONMOUSEOVER">window.status='View the related <xsl:value-of select="PHOTOINFO/@type"/> (<xsl:value-of select="PHOTOINFO/@file"/>)';return true;</xsl:attribute>
										<xsl:attribute name="ONMOUSEOUT">window.status='';</xsl:attribute>
										<xsl:attribute name="ONCLICK">FullScreen('Floppy/<xsl:value-of select="@floppy"/>/<xsl:value-of select="PHOTOINFO/@file"/>',<xsl:if test="PHOTOINFO/@type[. = 'VOICE']">'voice'</xsl:if><xsl:if test="PHOTOINFO/@type[not(. = 'VOICE')]">1</xsl:if>);</xsl:attribute>
										<xsl:value-of select="PHOTOINFO/@type"/>
									</A>
								</xsl:if>
							</TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
		</TABLE>
	</xsl:template>

	<xsl:template name="movie">
		<xsl:param name="var1" select="position()"/>
		<xsl:param name="var2" select="0"/>
		<xsl:param name="var3" select="0"/>
		<xsl:param name="var4" select="0"/>
		<SCRIPT LANGUAGE="JavaScript">load(<xsl:value-of select="$var4"/>+<xsl:value-of select="$var3"/>+<xsl:value-of select="$var2"/>+<xsl:value-of select="$var1"/>-1,'movie');</SCRIPT>
		<DIV CLASS="moviename">
			<A name="movieName">
				<xsl:attribute name="href">Floppy/<xsl:value-of select="@floppy"/>/<xsl:value-of select="MOVIEINFO/text()"/></xsl:attribute>
				<xsl:attribute name="ONMOUSEOVER">window.status = 'Show the movie \'<xsl:value-of select="text()"/>\' that is in Floppy <xsl:value-of select="@floppy"/>  (<xsl:value-of select="MOVIEINFO/text()"/>)';return true;</xsl:attribute>
				<xsl:attribute name="ONMOUSEOUT">window.status = '';</xsl:attribute>
				<xsl:value-of select="text()"/></A>
		</DIV>
		<TABLE CLASS="small">
			<xsl:if test="@comment">
				<TR>
					<TD CLASS="attribute">Comment</TD>
					<TD CLASS="value1">
						<xsl:value-of select="@comment"/>
					</TD>
				</TR>
			</xsl:if>
			<TR>
				<TD CLASS="attribute">Location</TD>
				<TD CLASS="value1">
					<xsl:value-of select="LOCATION"/>
				</TD>
			</TR>
			<xsl:if test="LOCATION/@place">
				<TR>
					<TD CLASS="attribute">Place</TD>
					<TD CLASS="value1">
						<xsl:value-of select="LOCATION/@place"/>
					</TD>
				</TR>
			</xsl:if>
			<TR>
				<TD CLASS="attribute">Date</TD>
				<TD CLASS="value1">
					<SCRIPT LANGUAGE="JavaScript">document.write(date('Floppy/<xsl:value-of select="@floppy"/>/<xsl:value-of select="MOVIEINFO/text()"/>'));</SCRIPT>
				</TD>
			</TR>
		</TABLE>
		<TABLE CLASS="abn">
			<TR>
				<TD CLASS="titabn"><xsl:attribute name="ONCLICK">showInfo(<xsl:value-of select="$var4"/>+<xsl:value-of select="$var3"/>+<xsl:value-of select="$var2"/>+<xsl:value-of select="$var1"/>-1);</xsl:attribute>Info about the movie</TD>
			</TR>
			<TR>
				<TD ID="hidden">
					<TABLE CLASS="MovieInfo">
						<TR>
							<TD CLASS="info">File name</TD>
							<TD CLASS="value">
								<A>
									<xsl:attribute name="href">Floppy/<xsl:value-of select="@floppy"/>/<xsl:value-of select="MOVIEINFO/text()"/></xsl:attribute>
									<NOBR CLASS="nounder">
										<xsl:value-of select="MOVIEINFO"/>
									</NOBR>
								</A>
							</TD>
						</TR>
						<TR>
							<TD CLASS="info">Size</TD>
							<TD CLASS="value">
								<xsl:value-of select="MOVIEINFO/@size"/>
							</TD>
						</TR>
						<TR>
							<TD CLASS="info">File size</TD>
							<TD CLASS="value">
								<SCRIPT LANGUAGE="JavaScript">document.write(file_size_Format('Floppy/<xsl:value-of select="@floppy"/>/<xsl:value-of select="MOVIEINFO/text()"/>'));</SCRIPT></TD>
						</TR>
						<TR>
							<TD CLASS="info">Duration</TD>
							<TD CLASS="value">
								<xsl:value-of select="MOVIEINFO/@duration"/>
							</TD>
						</TR>
						<TR>
							<TD CLASS="info">Images</TD>
							<TD CLASS="value">
								<SCRIPT LANGUAGE="JavaScript">document.write(fps('<xsl:value-of select="MOVIEINFO/@duration"/>'));</SCRIPT>
							</TD>
						</TR>
						<xsl:if test="MOVIEINFO/@filter">
							<TR>
								<TD CLASS="info">Filter</TD>
								<TD CLASS="value">
									<xsl:value-of select="MOVIEINFO/@filter"/>
								</TD>
							</TR>
						</xsl:if>
						<xsl:if test="MOVIEINFO/@effects">
							<TR>
								<TD CLASS="info">Effects</TD>
								<TD CLASS="value">
									<xsl:value-of select="MOVIEINFO/@effects"/>
								</TD>
							</TR>
						</xsl:if>
					</TABLE>
				</TD>
			</TR>
		</TABLE>
	</xsl:template>

	<!-- Tag root -->
	<xsl:template match="/">
		<HTML>
			<!-- xmlns:HTML="http://www.w3.org/Profiles/XHTML-transitional" -->
			<!-- Head of file -->
			<HEAD>
				<!-- Title of window -->
				<TITLE>Album of the <xsl:value-of select="ALBUM/@camera"/></TITLE>

				<!-- Stylesheet CSS for graphical effects -->
				<LINK REL="STYLESHEET" TYPE="text/css" HREF="Album-files/Style.css"/>

				<!-- (( ================ ATTENTION !! ================ )) -->
				<!-- ((			        ==============                 )) -->
				<!-- (( The closing tag of the script must be alwaws   )) -->
				<!-- (( present otherwise the entire document will be  )) -->
				<!-- (( exchanged by a script and not interpreted !!   )) -->
				<!-- (( ============================================== )) -->

				<!-- External script file for various tasks -->
				<SCRIPT LANGUAGE="JavaScript" SRC="Album-files/Script.js"></SCRIPT>
				<SCRIPT LANGUAGE="JavaScript" SRC="Floppy.js"></SCRIPT>

			</HEAD>

			<!-- End of head, start of body -->

			<BODY onload="hide()">
				<NOBR>
					<H1 ID="title">Album of <xsl:value-of select="ALBUM/@camera"/></H1>
				</NOBR>
				<DIV ID="loaded_photos" CLASS="loading"></DIV>
				<DIV ID="loaded_movies" CLASS="loading"></DIV>
				<DIV ID="divLoadCont" ALIGN="center" VALIGN="middle">
					<BR/><h3>Loading...</h3>
				</DIV>
				<TABLE CLASS="big" PADDING="4">
					<TR>
						<TH>GOOD PHOTOS</TH>
						<TH>GOOD MOVIES</TH>
						<TH>BAD PHOTOS</TH>
						<TH>BAD MOVIES</TH>
					</TR>
					<TR>
						<TD>
							<xsl:for-each select="ALBUM/GOOD/PHOTO">
								<xsl:call-template name="photo"/>
							</xsl:for-each>
						</TD>
						<TD>
							<xsl:for-each select="ALBUM/GOOD/MOVIE">
								<xsl:call-template name="movie">
									<xsl:with-param name="var2" select="count(/ALBUM/GOOD/PHOTO)"/>
								</xsl:call-template>
							</xsl:for-each>
						</TD>
						<TD>
							<xsl:for-each select="ALBUM/BAD/PHOTO">
								<xsl:call-template name="photo">
									<xsl:with-param name="var2" select="count(/ALBUM/GOOD/PHOTO)"/>
									<xsl:with-param name="var3" select="count(/ALBUM/GOOD/MOVIE)"/>
								</xsl:call-template>
							</xsl:for-each>
						</TD>
						<TD>
							<xsl:for-each select="ALBUM/BAD/MOVIE">
								<xsl:call-template name="movie">
									<xsl:with-param name="var2" select="count(/ALBUM/GOOD/PHOTO)"/>
									<xsl:with-param name="var3" select="count(/ALBUM/GOOD/MOVIE)"/>
									<xsl:with-param name="var4" select="count(/ALBUM/BAD/PHOTO)"/>
								</xsl:call-template>
							</xsl:for-each>
						</TD>
					</TR>
				</TABLE>
				<SCRIPT LANGUAGE="JavaScript">disappear();</SCRIPT>
			</BODY>
		</HTML>
	</xsl:template>
</xsl:stylesheet>

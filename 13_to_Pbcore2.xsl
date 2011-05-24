<?xml version="1.0"?>
<!--
	written by Dave Rice, AudioVisual Preservation Solutions for Dance Heritage Coalition's Secure Media Network managed by Bay Area Video Coalition
	2011-02-11
	updated 2011-05-24
	converts valid PBCore 1.3 records into PBCore 2.0
	may not work properly for PBCore versions prior to 1.3
	issues are commented below
-->
<!--     comments on mapping: According to pbcore.org, source and version refer to data value, not another attribute.  
	 Therefore, lossy/inaccurate mapping (@source may refer to another attribute rather than element value from 1.3 to 2.0 for the following elements: 
	 pbcoreTitle (titleType now an attribute).
	 pbcoreSubject (subjectAuthorityUsed now = @source) 
	 pbcoreDescription (descriptionType now an attribute)
	 pbcoreGenre (genreAuthorityUsed now = @source)
	
	-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xsi:schemaLocation="http://www.pbcore.org/PBCore/PBCoreNamespace.html http://www.pbcore.org/PBCore/PBCoreXSD_Ver_1-2-1.xsd" xmlns:p13="http://www.pbcore.org/PBCore/PBCoreNamespace.html" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.pbcore.org/PBCore/PBCoreNamespace.html">
	<xsl:output encoding="UTF-8" method="xml" version="1.0" indent="yes"/>
	<xsl:template match="p13:PBCoreDescriptionDocument">
		<pbcoreDescriptionDocument>
			<xsl:apply-templates select="p13:pbcoreIdentifier|p13:pbcoreTitle|p13:pbcoreSubject|p13:pbcoreDescription|p13:pbcoreGenre|p13:pbcoreRelation|p13:pbcoreCoverage|p13:pbcoreAudienceLevel|p13:pbcoreAudienceRating"/>
			<xsl:apply-templates select="p13:pbcoreCreator|p13:pbcoreContributor|p13:pbcorePublisher|p13:pbcoreRightsSummary"/>
			<xsl:apply-templates select="p13:pbcoreInstantiation"/>
			<xsl:apply-templates select="p13:pbcoreExtension"/>
		</pbcoreDescriptionDocument>
	</xsl:template>
	<xsl:template match="p13:pbcoreIdentifier">
		<!-- KVM: pbcoreAssetType? -->
		<pbcoreIdentifier>
			<xsl:attribute name="source">
				<xsl:value-of select="p13:identifierSource"/>
			</xsl:attribute>
			<xsl:if test="string(p13:identifierSource/@source)">
				<xsl:attribute name="annotation">
					<xsl:text>pbcore13:source=</xsl:text>
					<xsl:value-of select="p13:identifierSource/@source"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="string(p13:identifierSource/@version)">
				<xsl:attribute name="version">
					<xsl:value-of select="p13:identifierSource/@version"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="p13:identifier"/>
		</pbcoreIdentifier>
	</xsl:template>
	<xsl:template match="p13:pbcoreTitle">
		<pbcoreTitle>		
			<xsl:if test="string(p13:titleType)">
				<xsl:attribute name="titleType">
					<xsl:value-of select="p13:titleType"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="string(p13:titleType/@source)">
				<xsl:attribute name="source">
					<xsl:value-of select="p13:titleType/@source"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="string(p13:titleType/@version)">
				<xsl:attribute name="version">
					<xsl:value-of select="p13:titleType/@version"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="p13:title"/>
		</pbcoreTitle>
	</xsl:template>
	<xsl:template match="p13:pbcoreSubject">
		<pbcoreSubject>
			<xsl:if test="string(p13:subjectAuthorityUsed)">
				<xsl:attribute name="source">
					<xsl:value-of select="p13:subjectAuthorityUsed"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="string(p13:subjectAuthorityUsed/@source)">
				<xsl:attribute name="annotation">
					<xsl:text>pbcore13:source=</xsl:text>
					<xsl:value-of select="p13:subjectAuthorityUsed/@source"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="string(p13:subjectAuthorityUsed/@version)">
				<xsl:attribute name="version">
					<xsl:value-of select="p13:subjectAuthorityUsed/@version"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="p13:subject"/>
		</pbcoreSubject>
	</xsl:template>
	<xsl:template match="p13:pbcoreDescription">
		<pbcoreDescription>
			<xsl:if test="string(p13:descriptionType)">
				<xsl:attribute name="descriptionType">
					<xsl:value-of select="p13:descriptionType"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="string(p13:descriptionType/@source)">
				<xsl:attribute name="source">
					<xsl:value-of select="p13:descriptionType/@source"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="string(p13:descriptionType/@version)">
				<xsl:attribute name="version">
					<xsl:value-of select="p13:descriptionType/@version"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="p13:description"/>
		</pbcoreDescription>
	</xsl:template>
	<xsl:template match="p13:pbcoreGenre">
		<pbcoreGenre>
			<xsl:if test="string(p13:genreAuthorityUsed)">
				<xsl:attribute name="source">
					<xsl:value-of select="p13:genreAuthorityUsed"/>
				</xsl:attribute>
			</xsl:if>
			<!-- need to clarify -->
			<!-- KVM: what if both are present in 1.3 document? -->
			<xsl:if test="string(p13:genreAuthorityUsed/@source) or string(p13:genre/@source)">
				<xsl:attribute name="annotation">
					<xsl:text>pbcore13:source=</xsl:text>
					<xsl:value-of select="p13:genre/@source"/>
					<xsl:value-of select="p13:genreAuthorityUsed/@source"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="string(p13:genreAuthorityUsed/@version)">
				<xsl:attribute name="version">
					<xsl:value-of select="p13:genreAuthorityUsed/@version"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="p13:genre"/>
		</pbcoreGenre>
	</xsl:template>
	<xsl:template match="p13:pbcoreRelation">
	<!-- need to add check of p13:pbcoreRelation without one of necessary sub-elements -->
		<pbcoreRelation>
			<pbcoreRelationType>
				<xsl:if test="string(p13:relationType/@source)">
					<xsl:attribute name="source">
						<xsl:value-of select="p13:relationType/@source"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="string(p13:relationType/@version)">
					<xsl:attribute name="version">
						<xsl:value-of select="p13:relationType/@version"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="p13:relationType"/>
			</pbcoreRelationType>
			<pbcoreRelationIdentifier>
				<xsl:value-of select="p13:relationIdentifier"/>
			</pbcoreRelationIdentifier>
		</pbcoreRelation>
	</xsl:template>
	<xsl:template match="p13:pbcoreCoverage">
	<!-- need to add check of p13:pbcoreCoverage without one of necessary sub-elements -->
		<pbcoreCoverage>
			<coverage>
				<xsl:if test="string(p13:coverage/@source)">
					<xsl:attribute name="source">
						<xsl:value-of select="p13:coverage/@source"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="string(p13:coverage/@version)">
					<xsl:attribute name="version">
						<xsl:value-of select="p13:coverage/@version"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="p13:coverage"/>
			</coverage>
			<xsl:if test="string(p13:coverageType)">
				<coverageType>
					<xsl:value-of select="p13:coverageType"/>
				</coverageType>
			</xsl:if>
		</pbcoreCoverage>
	</xsl:template>
	<xsl:template match="p13:pbcoreAudienceLevel">
		<pbcoreAudienceLevel>
			<xsl:if test="string(p13:audienceLevel/@source)">
				<xsl:attribute name="source">
					<xsl:value-of select="p13:audienceLevel/@source"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="string(p13:audienceLevel/@version)">
				<xsl:attribute name="version">
					<xsl:value-of select="p13:audienceLevel/@version"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="p13:audienceLevel"/>
		</pbcoreAudienceLevel>
	</xsl:template>
	<xsl:template match="p13:pbcoreAudienceRating">
		<pbcoreAudienceRating>
			<xsl:if test="string(p13:audienceRating/@source)">
				<xsl:attribute name="source">
					<xsl:value-of select="p13:audienceRating/@source"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="string(p13:audienceRating/@version)">
				<xsl:attribute name="version">
					<xsl:value-of select="p13:audienceRating/@version"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="p13:audienceRating"/>
		</pbcoreAudienceRating>
	</xsl:template>
	<xsl:template match="p13:pbcoreCreator">
		<pbcoreCreator>
			<creator>
				<xsl:value-of select="p13:creator"/>
			</creator>
			<xsl:if test="string(p13:creatorRole)">
				<creatorRole>
					<xsl:if test="string(p13:creatorRole/@source)">
						<xsl:attribute name="source">
							<xsl:value-of select="p13:creatorRole/@source"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:if test="string(p13:creatorRole/@version)">
						<xsl:attribute name="version">
							<xsl:value-of select="p13:creatorRole/@version"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="p13:creatorRole"/>
				</creatorRole>
			</xsl:if>
		</pbcoreCreator>
	</xsl:template>
	<xsl:template match="p13:pbcoreContributor">
		<pbcoreContributor>
			<contributor>
				<xsl:value-of select="p13:contributor"/>
			</contributor>
			<xsl:if test="string(p13:contributorRole)">
				<contributorRole>
					<xsl:if test="string(p13:contributorRole/@source)">
						<xsl:attribute name="source">
							<xsl:value-of select="p13:contributorRole/@source"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:if test="string(p13:contributorRole/@version)">
						<xsl:attribute name="version">
							<xsl:value-of select="p13:contributorRole/@version"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="p13:contributorRole"/>
				</contributorRole>
			</xsl:if>
		</pbcoreContributor>
	</xsl:template>
	<xsl:template match="p13:pbcorePublisher">
		<pbcorePublisher>
			<publisher>
				<xsl:value-of select="p13:publisher"/>
			</publisher>
			<xsl:if test="string(p13:publisherRole)">
				<publisherRole>
					<xsl:if test="string(p13:publisherRole/@source)">
						<xsl:attribute name="source">
							<xsl:value-of select="p13:publisherRole/@source"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:if test="string(p13:publisherRole/@version)">
						<xsl:attribute name="version">
							<xsl:value-of select="p13:publisherRole/@version"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="p13:publisherRole"/>
				</publisherRole>
			</xsl:if>
		</pbcorePublisher>
	</xsl:template>
	<xsl:template match="p13:pbcoreRightsSummary">
		<rightsSummary>
			<xsl:value-of select="p13:rightsSummary"/>
		</rightsSummary>
	</xsl:template>
	<xsl:template match="p13:pbcoreInstantiation">
		<pbcoreInstantiation>
			<xsl:apply-templates select="p13:pbcoreFormatID"/>
			<xsl:if test="string(p13:dateCreated)">
				<instantiationDate>
					<xsl:attribute name="dateType">created</xsl:attribute>
					<xsl:value-of select="p13:dateCreated"/>
				</instantiationDate>
			</xsl:if>
			<xsl:if test="string(p13:dateIssued)">
				<instantiationDate>
					<xsl:attribute name="dateType">issued</xsl:attribute>
					<xsl:value-of select="p13:dateIssued"/>
				</instantiationDate>
			</xsl:if>
			<xsl:apply-templates select="p13:pbcoreDateAvailable"/>
			<xsl:if test="string(p13:formatPhysical)">
				<instantiationPhysical>
					<xsl:if test="string(p13:formatPhysical/@source)">
						<xsl:attribute name="source">
							<xsl:value-of select="p13:formatPhysical/@source"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:if test="string(p13:formatPhysical/@version)">
						<xsl:attribute name="version">
							<xsl:value-of select="p13:formatPhysical/@version"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="p13:formatPhysical"/>
				</instantiationPhysical>
			</xsl:if>
			<xsl:if test="string(p13:formatDigital)">
				<instantiationDigital>
					<xsl:if test="string(p13:formatDigital/@source)">
						<xsl:attribute name="source">
							<xsl:value-of select="p13:formatDigital/@source"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:if test="string(p13:formatDigital/@version)">
						<xsl:attribute name="version">
							<xsl:value-of select="p13:formatDigital/@version"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="p13:formatDigital"/>
				</instantiationDigital>
			</xsl:if>
			<instantiationLocation>
				<xsl:value-of select="p13:formatLocation"/>
			</instantiationLocation>
			<xsl:if test="string(p13:formatMediaType)">
				<instantiationMediaType>
					<xsl:if test="string(p13:formatMediaType/@source)">
						<xsl:attribute name="source">
							<xsl:value-of select="p13:formatMediaType/@source"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:if test="string(p13:formatMediaType/@version)">
						<xsl:attribute name="version">
							<xsl:value-of select="p13:formatMediaType/@version"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="p13:formatMediaType"/>
				</instantiationMediaType>
			</xsl:if>
			<xsl:if test="string(p13:formatGenerations)">
				<instantiationGenerations>
					<xsl:if test="string(p13:formatGenerations/@source)">
						<xsl:attribute name="source">
							<xsl:value-of select="p13:formatGenerations/@source"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:if test="string(p13:formatGenerations/@version)">
						<xsl:attribute name="version">
							<xsl:value-of select="p13:formatGenerations/@version"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="p13:formatGenerations"/>
				</instantiationGenerations>
			</xsl:if>
			<xsl:if test="string(p13:formatFileSize)">
				<instantiationFileSize>
					<xsl:value-of select="p13:formatFileSize"/>
				</instantiationFileSize>
			</xsl:if>
			<xsl:if test="string(p13:formatTimeStart)">
				<instantiationTimeStart>
					<xsl:value-of select="p13:formatTimeStart"/>
				</instantiationTimeStart>
			</xsl:if>
			<xsl:if test="string(p13:formatDuration)">
				<instantiationDuration>
					<xsl:value-of select="p13:formatDuration"/>
				</instantiationDuration>
			</xsl:if>
			<xsl:if test="string(p13:formatDataRate)">
				<instantiationDataRate>
					<xsl:value-of select="p13:formatDataRate"/>
				</instantiationDataRate>
			</xsl:if>
			<xsl:if test="string(p13:formatColors)">
				<instantiationColors>
					<xsl:if test="string(p13:formatColors/@source)">
						<xsl:attribute name="source">
							<xsl:value-of select="p13:formatColors/@source"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:if test="string(p13:formatColors/@version)">
						<xsl:attribute name="version">
							<xsl:value-of select="p13:formatColors/@version"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="p13:formatColors"/>
				</instantiationColors>
			</xsl:if>
			<xsl:if test="string(p13:formatTracks)">
				<instantiationTracks>
					<xsl:value-of select="p13:formatTracks"/>
				</instantiationTracks>
			</xsl:if>
			<xsl:if test="string(p13:formatChannelConfiguration)">
				<instantiationChannelConfiguration>
					<xsl:value-of select="p13:formatChannelConfiguration"/>
				</instantiationChannelConfiguration>
			</xsl:if>
			<xsl:if test="string(p13:language)">
				<instantiationLanguage>
					<xsl:if test="string(p13:language/@source)">
						<xsl:attribute name="source">
							<xsl:value-of select="p13:language/@source"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:if test="string(p13:language/@version)">
						<xsl:attribute name="version">
							<xsl:value-of select="p13:language/@version"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="p13:language"/>
				</instantiationLanguage>
			</xsl:if>
			<xsl:if test="string(p13:formatAlternativeModes)">
				<instantiationAlternativeModes>
					<xsl:value-of select="p13:formatAlternativeModes"/>
				</instantiationAlternativeModes>
			</xsl:if>
			<xsl:apply-templates select="p13:pbcoreEssenceTrack"/>
			<xsl:apply-templates select="p13:pbcoreAnnotation"/>
		</pbcoreInstantiation>
	</xsl:template>
	<xsl:template match="p13:pbcoreFormatID">
		<instantiationIdentifier>
			<xsl:attribute name="source">
				<xsl:value-of select="p13:formatIdentifierSource"/>
			</xsl:attribute>
			<xsl:if test="string(p13:formatIdentifierSource/@source)">
				<xsl:attribute name="annotation">
					<xsl:text>pbcore13:source=</xsl:text>
					<xsl:value-of select="p13:formatIdentifierSource/@source"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="string(p13:formatIdentifierSource/@version)">
				<xsl:attribute name="version">
					<xsl:value-of select="p13:formatIdentifierSource/@version"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="p13:formatIdentifier"/>
		</instantiationIdentifier>
	</xsl:template>
	<xsl:template match="p13:pbcoreEssenceTrack">
		<pbcoreEssenceTrack>
			<xsl:if test="string(p13:essenceTrackType)">
				<essenceTrackType>
					<xsl:value-of select="p13:essenceTrackType"/>
				</essenceTrackType>
			</xsl:if>
			<xsl:if test="string(p13:essenceTrackIdentifier)">
				<essenceTrackIdentifier>
					<!-- what about if 1.3 has essenceTrackIdentifierSource but no essenceTrackIdentifier -->
					<xsl:if test="string(p13:essenceTrackIdentifierSource)">
						<xsl:attribute name="source">
							<xsl:value-of select="p13:essenceTrackIdentifierSource"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="p13:essenceTrackIdentifier"/>
				</essenceTrackIdentifier>
			</xsl:if>
			<xsl:if test="string(p13:essenceTrackStandard)">
				<essenceTrackStandard>
					<xsl:if test="string(p13:essenceTrackStandard/@source)">
						<xsl:attribute name="source">
							<xsl:value-of select="p13:essenceTrackStandard/@source"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:if test="string(p13:essenceTrackStandard/@version)">
						<xsl:attribute name="version">
							<xsl:value-of select="p13:essenceTrackStandard/@version"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="p13:essenceTrackStandard"/>
				</essenceTrackStandard>
			</xsl:if>
			<xsl:if test="string(p13:essenceTrackEncoding)">
				<essenceTrackEncoding>
					<xsl:value-of select="p13:essenceTrackEncoding"/>
				</essenceTrackEncoding>
			</xsl:if>
			<xsl:if test="string(p13:essenceTrackDataRate)">
				<essenceTrackDataRate>
					<xsl:value-of select="p13:essenceTrackDataRate"/>
				</essenceTrackDataRate>
			</xsl:if>
			<xsl:if test="string(p13:essenceTrackTimeStart)">
				<essenceTrackTimeStart>
					<xsl:value-of select="p13:essenceTrackTimeStart"/>
				</essenceTrackTimeStart>
			</xsl:if>
			<xsl:if test="string(p13:essenceTrackDuration)">
				<essenceTrackDuration>
					<xsl:value-of select="p13:essenceTrackDuration"/>
				</essenceTrackDuration>
			</xsl:if>
			<xsl:if test="string(p13:essenceTrackBitDepth)">
				<essenceTrackBitDepth>
					<xsl:if test="string(p13:essenceTrackBitDepth/@source)">
						<xsl:attribute name="source">
							<xsl:value-of select="p13:essenceTrackBitDepth/@source"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:if test="string(p13:essenceTrackBitDepth/@version)">
						<xsl:attribute name="version">
							<xsl:value-of select="p13:essenceTrackBitDepth/@version"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="p13:essenceTrackBitDepth"/>
				</essenceTrackBitDepth>
			</xsl:if>
			<xsl:if test="string(p13:essenceTrackSamplingRate)">
				<essenceTrackSamplingRate>
					<xsl:if test="string(p13:essenceTrackSamplingRate/@source)">
						<xsl:attribute name="source">
							<xsl:value-of select="p13:essenceTrackSamplingRate/@source"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:if test="string(p13:essenceTrackSamplingRate/@version)">
						<xsl:attribute name="version">
							<xsl:value-of select="p13:essenceTrackSamplingRate/@version"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="p13:essenceTrackSamplingRate"/>
				</essenceTrackSamplingRate>
			</xsl:if>
			<xsl:if test="string(p13:essenceTrackFrameSize)">
				<essenceTrackFrameSize>
					<xsl:if test="string(p13:essenceTrackFrameSize/@source)">
						<xsl:attribute name="source">
							<xsl:value-of select="p13:essenceTrackFrameSize/@source"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:if test="string(p13:essenceTrackFrameSize/@version)">
						<xsl:attribute name="version">
							<xsl:value-of select="p13:essenceTrackFrameSize/@version"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="p13:essenceTrackFrameSize"/>
				</essenceTrackFrameSize>
			</xsl:if>
			<xsl:if test="string(p13:essenceTrackAspectRatio)">
				<essenceTrackAspectRatio>
					<xsl:if test="string(p13:essenceTrackAspectRatio/@source)">
						<xsl:attribute name="source">
							<xsl:value-of select="p13:essenceTrackAspectRatio/@source"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:if test="string(p13:essenceTrackAspectRatio/@version)">
						<xsl:attribute name="version">
							<xsl:value-of select="p13:essenceTrackAspectRatio/@version"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="p13:essenceTrackAspectRatio"/>
				</essenceTrackAspectRatio>
			</xsl:if>
			<xsl:if test="string(p13:essenceTrackFrameRate)">
				<essenceTrackFrameRate>
					<xsl:if test="string(p13:essenceTrackFrameRate/@source)">
						<xsl:attribute name="source">
							<xsl:value-of select="p13:essenceTrackFrameRate/@source"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:if test="string(p13:essenceTrackFrameRate/@version)">
						<xsl:attribute name="version">
							<xsl:value-of select="p13:essenceTrackFrameRate/@version"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="p13:essenceTrackFrameRate"/>
				</essenceTrackFrameRate>
			</xsl:if>
			<xsl:if test="string(p13:essenceTrackLanguage)">
				<essenceTrackLanguage>
					<xsl:if test="string(p13:essenceTrackLanguage/@source)">
						<xsl:attribute name="source">
							<xsl:value-of select="p13:essenceTrackLanguage/@source"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:if test="string(p13:essenceTrackLanguage/@version)">
						<xsl:attribute name="version">
							<xsl:value-of select="p13:essenceTrackLanguage/@version"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="p13:essenceTrackLanguage"/>
				</essenceTrackLanguage>
			</xsl:if>
			<xsl:if test="string(p13:essenceTrackAnnotation)">
				<essenceTrackAnnotation>
					<!-- split by delimiter? -->
					<xsl:value-of select="p13:essenceTrackAnnotation"/>
				</essenceTrackAnnotation>
			</xsl:if>
		</pbcoreEssenceTrack>
	</xsl:template>
	<xsl:template match="p13:pbcoreDateAvailable">
		<xsl:choose>
			<xsl:when test="string(p13:dateAvailableStart) and string(p13:dateAvailableEnd)">
				<instantiationDate>
				<!-- not sure -->
					<xsl:attribute name="dateType">available</xsl:attribute>
					<!-- should test for ISO8601 before using this separator -->
					<xsl:value-of select="p13:dateAvailableStart"/>
					<xsl:text>/</xsl:text>
					<xsl:value-of select="p13:dateAvailableEnd"/>
				</instantiationDate>
			</xsl:when>
			<xsl:when test="string(p13:dateAvailableStart)">
				<instantiationDate>
				<!-- not sure -->
					<xsl:attribute name="dateType">available start</xsl:attribute>
					<xsl:value-of select="p13:dateAvailableStart"/>
				</instantiationDate>
			</xsl:when>
			<xsl:when test="string(p13:dateAvailableEnd)">
				<instantiationDate>
				<!-- not sure -->
					<xsl:attribute name="dateType">available end</xsl:attribute>
					<xsl:value-of select="p13:dateAvailableEnd"/>
				</instantiationDate>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="p13:pbcoreAnnotation">
		<xsl:if test="string(p13:annotation)">
			<instantiationAnnotation>
				<!-- need to add substring-after on colon delimiter -->
				<xsl:value-of select="p13:annotation"/>
			</instantiationAnnotation>
		</xsl:if>
	</xsl:template>
	<xsl:template match="p13:pbcoreExtension">
		<xsl:if test="string(p13:extension)">
			<pbcoreExtension>
				<extensionWrap>
					<extensionElement>
						<xsl:text>um</xsl:text><!-- parse out of extension -->
					</extensionElement>
					<!-- need to add substring-after on colon delimiter -->
					<extensionValue>
						<xsl:value-of select="p13:extension"/>
					</extensionValue>
					<extensionAuthorityUsed>
						<xsl:value-of select="p13:extensionAuthorityUsed"/><!-- add source, version -->
						<!-- KVM: source and version map to extensionWrap @annotation. -->
					</extensionAuthorityUsed>
				</extensionWrap>
			</pbcoreExtension>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
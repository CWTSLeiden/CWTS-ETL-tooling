# Release notes JsonParser

## Implemented data sources:

|Name|Versions|
|---|---|
|altmetric|2019oct, 2021jun, 2022may, 2024nov|
|dimensionspublications|2020apr, 2020apr_update, 2021jan, format_7, format_8, format_9, 2024jul|
|dimensionscategories|2020apr_update, 2021jan|
|dimensionsfundergroups|format_1|
|dimensionsgrants|format_6, 2024jul|
|dimensionsresearchgroups|format_1|
|dimensionsorganisations|2023_jul, 2024jul|
|grid|2020jun, 2020dec|
|overton|2020jul, 2021may, 2023may|
|unpaywall|2020apr, 2020oct|
|datacitedois|2020aug, 2021aug|
|dataciteclients|2021nov|
|dataciteproviders|2021nov|
|ror|2020oct, version8, 2024apr|
|crossrefjournals|2021jan|
|crossrefmembers|2021jan|
|crossrefeventdata|2021aug|
|openalexworks|2022jul, 2023feb, 2023jul, 2023nov, 2024mar, 2024may, 2024jun, 2024jul|
|openalexauthors|2022jul, 2023feb, 2023jul, 2023nov, 2024mar|
|openalexinstitutions|2022jul, 2023feb, 2023jul, 2023nov, 2024may|
|openalexvenues|2022jul|
|openalexconcepts|2022jul, 2023feb, 2023jul|
|openalexsources|2023feb, 2023jul, 2024jun|
|openalexpublishers|2023feb, 2023jul|
|openalexfunders|2023jul|
|openalextopics|2024mar|
|openalexdomains|2024mar|
|openalexfields|2024mar|
|openalexsubfields|2024mar|
|twitter|2022jul|
|bso|2023sep|
|openaireorganization|2024aug|
|openairerelation|2024aug|
|openaireproject|2024aug|
|openairedatasource|2024aug|
|openairecommunity_infrastructure|2024aug|
|openairedataset|2024aug|
|openaireother_research_product|2024aug|
|openairepublication|2024aug|
|openairesoftware|2024aug|
|leidenrepository|2024aug|

OpenAlex documentatie: https://docs.openalex.org/


## Releases

### 1.40.0.0

- Nieuwe velden Altmetric
    - citation.dimensions_publication_id
    - counts.guideline.posts_count
    - counts.guideline.unique_users[seq]
    - counts.guideline.unique_users_count
    - posts.guideline[seq].author.image
    - posts.guideline[seq].citation_ids[seq]
    - posts.guideline[seq].license
    - posts.guideline[seq].page_url
    - posts.guideline[seq].posted_on
    - posts.guideline[seq].source.description
    - posts.guideline[seq].source.geo.country
    - posts.guideline[seq].source.name
    - posts.guideline[seq].title
    - posts.guideline[seq].url
    - posts.twitter[seq].author.geo.geocoded_at
    - posts.twitter[seq].author.geo.provider   

- Verwijderde velden Altmetric
    - altmetric_score.context_for_score.this_journal
    - demographics.users.mendeley.by_discipline.Law
    - demographics.users.mendeley.by_discipline.Sports and Recreation
    - posts.policy[seq].collections[seq].name
    - posts.policy[seq].collections[seq].url

### 1.39.0.0

- Nieuwe velden OpenAIRE
    - organization.alternativenames[seq]
    - organization.country.code
    - organization.country.label
    - organization.id
    - organization.legalname
    - organization.legalshortname
    - organization.pid[seq].scheme
    - organization.pid[seq].value
    - organization.websiteurl
    - relation.provenance.provenance
    - relation.provenance.trust
    - relation.reltype.name
    - relation.reltype.type
    - relation.source
    - relation.sourceType
    - relation.target
    - relation.targetType
    - relation.validated
    - relation.validationDate
    - project.acronym
    - project.callidentifier
    - project.code
    - project.enddate
    - project.funding[seq].funding_stream.description
    - project.funding[seq].funding_stream.id
    - project.funding[seq].jurisdiction
    - project.funding[seq].name
    - project.funding[seq].shortName
    - project.granted.currency
    - project.granted.fundedamount
    - project.granted.totalcost
    - project.h2020programme[seq].code
    - project.h2020programme[seq].description
    - project.id
    - project.keywords
    - project.openaccessmandatefordataset
    - project.openaccessmandateforpublications
    - project.startdate
    - project.subject[seq]
    - project.summary
    - project.title
    - project.websiteurl
    - datasource.accessrights
    - datasource.certificates
    - datasource.citationguidelineurl
    - datasource.databaseaccessrestriction
    - datasource.datasourcetype.scheme
    - datasource.datasourcetype.value
    - datasource.datauploadrestriction
    - datasource.dateofvalidation
    - datasource.description
    - datasource.englishname
    - datasource.id
    - datasource.journal.issnLinking
    - datasource.journal.issnOnline
    - datasource.journal.issnPrinted
    - datasource.journal.name
    - datasource.languages[seq]
    - datasource.logourl
    - datasource.missionstatementurl
    - datasource.officialname
    - datasource.openairecompatibility
    - datasource.originalId[seq]
    - datasource.pid[seq].scheme
    - datasource.pid[seq].value
    - datasource.pidsystems
    - datasource.releaseenddate
    - datasource.releasestartdate
    - datasource.subjects[seq]
    - datasource.uploadrights
    - datasource.versioning
    - datasource.websiteurl
    - community_infrastructure.acronym
    - community_infrastructure.description
    - community_infrastructure.id
    - community_infrastructure.name
    - community_infrastructure.subject[seq]
    - community_infrastructure.type
    - community_infrastructure.zenodo_community
    - dataset.author[seq].fullname
    - dataset.author[seq].name
    - dataset.author[seq].pid
    - dataset.author[seq].pid.id.scheme
    - dataset.author[seq].pid.id.value
    - dataset.author[seq].pid.provenance.provenance
    - dataset.author[seq].pid.provenance.trust
    - dataset.author[seq].rank
    - dataset.author[seq].surname
    - dataset.bestaccessright.code
    - dataset.bestaccessright.label
    - dataset.bestaccessright.scheme
    - dataset.contributor[seq]
    - dataset.country[seq].code
    - dataset.country[seq].label
    - dataset.country[seq].provenance.provenance
    - dataset.country[seq].provenance.trust
    - dataset.dateofcollection
    - dataset.description[seq]
    - dataset.embargoenddate
    - dataset.format[seq]
    - dataset.geolocation[seq].box
    - dataset.geolocation[seq].place
    - dataset.geolocation[seq].point
    - dataset.green
    - dataset.id
    - dataset.inDiamondJournal
    - dataset.indicators.bipIndicators[seq].class
    - dataset.indicators.bipIndicators[seq].indicator
    - dataset.indicators.bipIndicators[seq].score
    - dataset.indicators.usageCounts.downloads
    - dataset.indicators.usageCounts.views
    - dataset.instance[seq].accessright.code
    - dataset.instance[seq].accessright.label
    - dataset.instance[seq].accessright.openAccessRoute
    - dataset.instance[seq].accessright.scheme
    - dataset.instance[seq].alternateIdentifier[seq].scheme
    - dataset.instance[seq].alternateIdentifier[seq].value
    - dataset.instance[seq].license
    - dataset.instance[seq].pid[seq].scheme
    - dataset.instance[seq].pid[seq].value
    - dataset.instance[seq].publicationdate
    - dataset.instance[seq].refereed
    - dataset.instance[seq].type
    - dataset.instance[seq].url[seq]
    - dataset.isGreen
    - dataset.isInDiamondJournal
    - dataset.language.code
    - dataset.language.label
    - dataset.lastupdatetimestamp
    - dataset.maintitle
    - dataset.openAccessColor
    - dataset.originalId[seq]
    - dataset.pid[seq].scheme
    - dataset.pid[seq].value
    - dataset.publicationdate
    - dataset.publiclyFunded
    - dataset.publisher
    - dataset.size
    - dataset.source[seq]
    - dataset.subjects[seq].provenance
    - dataset.subjects[seq].provenance.provenance
    - dataset.subjects[seq].provenance.trust
    - dataset.subjects[seq].subject.scheme
    - dataset.subjects[seq].subject.value
    - dataset.subtitle
    - dataset.type
    - dataset.version
    - other_research_product.author[seq].fullname
    - other_research_product.author[seq].name
    - other_research_product.author[seq].pid
    - other_research_product.author[seq].pid.id.scheme
    - other_research_product.author[seq].pid.id.value
    - other_research_product.author[seq].pid.provenance.provenance
    - other_research_product.author[seq].pid.provenance.trust
    - other_research_product.author[seq].rank
    - other_research_product.author[seq].surname
    - other_research_product.bestaccessright.code
    - other_research_product.bestaccessright.label
    - other_research_product.bestaccessright.scheme
    - other_research_product.contactperson[seq]
    - other_research_product.contributor[seq]
    - other_research_product.country[seq].code
    - other_research_product.country[seq].label
    - other_research_product.country[seq].provenance.provenance
    - other_research_product.country[seq].provenance.trust
    - other_research_product.dateofcollection
    - other_research_product.description[seq]
    - other_research_product.embargoenddate
    - other_research_product.format[seq]
    - other_research_product.green
    - other_research_product.id
    - other_research_product.inDiamondJournal
    - other_research_product.indicators.bipIndicators[seq].class
    - other_research_product.indicators.bipIndicators[seq].indicator
    - other_research_product.indicators.bipIndicators[seq].score
    - other_research_product.indicators.usageCounts.downloads
    - other_research_product.indicators.usageCounts.views
    - other_research_product.instance[seq].accessright.code
    - other_research_product.instance[seq].accessright.label
    - other_research_product.instance[seq].accessright.openAccessRoute
    - other_research_product.instance[seq].accessright.scheme
    - other_research_product.instance[seq].alternateIdentifier[seq].scheme
    - other_research_product.instance[seq].alternateIdentifier[seq].value
    - other_research_product.instance[seq].license
    - other_research_product.instance[seq].pid[seq].scheme
    - other_research_product.instance[seq].pid[seq].value
    - other_research_product.instance[seq].publicationdate
    - other_research_product.instance[seq].refereed
    - other_research_product.instance[seq].type
    - other_research_product.instance[seq].url[seq]
    - other_research_product.isGreen
    - other_research_product.isInDiamondJournal
    - other_research_product.language.code
    - other_research_product.language.label
    - other_research_product.lastupdatetimestamp
    - other_research_product.maintitle
    - other_research_product.openAccessColor
    - other_research_product.originalId[seq]
    - other_research_product.pid[seq].scheme
    - other_research_product.pid[seq].value
    - other_research_product.publicationdate
    - other_research_product.publiclyFunded
    - other_research_product.publisher
    - other_research_product.source[seq]
    - other_research_product.subjects[seq].provenance.provenance
    - other_research_product.subjects[seq].provenance.trust
    - other_research_product.subjects[seq].subject.scheme
    - other_research_product.subjects[seq].subject.value
    - other_research_product.subtitle
    - other_research_product.type
    - publication.author[seq].fullname
    - publication.author[seq].name
    - publication.author[seq].pid
    - publication.author[seq].pid.id.scheme
    - publication.author[seq].pid.id.value
    - publication.author[seq].pid.provenance.provenance
    - publication.author[seq].pid.provenance.trust
    - publication.author[seq].rank
    - publication.author[seq].surname
    - publication.bestaccessright.code
    - publication.bestaccessright.label
    - publication.bestaccessright.scheme
    - publication.container.conferencedate
    - publication.container.conferenceplace
    - publication.container.edition
    - publication.container.ep
    - publication.container.iss
    - publication.container.issnLinking
    - publication.container.issnOnline
    - publication.container.issnPrinted
    - publication.container.name
    - publication.container.sp
    - publication.container.vol
    - publication.contributor[seq]
    - publication.country[seq].code
    - publication.country[seq].label
    - publication.country[seq].provenance
    - publication.country[seq].provenance.provenance
    - publication.country[seq].provenance.trust
    - publication.dateofcollection
    - publication.description[seq]
    - publication.embargoenddate
    - publication.format[seq]
    - publication.green
    - publication.id
    - publication.inDiamondJournal
    - publication.indicators.bipIndicators[seq].class
    - publication.indicators.bipIndicators[seq].indicator
    - publication.indicators.bipIndicators[seq].score
    - publication.indicators.usageCounts.downloads
    - publication.indicators.usageCounts.views
    - publication.instance[seq].accessright.code
    - publication.instance[seq].accessright.label
    - publication.instance[seq].accessright.openAccessRoute
    - publication.instance[seq].accessright.scheme
    - publication.instance[seq].alternateIdentifier[seq].scheme
    - publication.instance[seq].alternateIdentifier[seq].value
    - publication.instance[seq].articleprocessingcharge.amount
    - publication.instance[seq].articleprocessingcharge.currency
    - publication.instance[seq].license
    - publication.instance[seq].pid[seq].scheme
    - publication.instance[seq].pid[seq].value
    - publication.instance[seq].publicationdate
    - publication.instance[seq].refereed
    - publication.instance[seq].type
    - publication.instance[seq].url[seq]
    - publication.isGreen
    - publication.isInDiamondJournal
    - publication.language.code
    - publication.language.label
    - publication.lastupdatetimestamp
    - publication.maintitle
    - publication.openAccessColor
    - publication.originalId[seq]
    - publication.pid[seq].scheme
    - publication.pid[seq].value
    - publication.publicationdate
    - publication.publiclyFunded
    - publication.publisher
    - publication.source[seq]
    - publication.subjects[seq].provenance
    - publication.subjects[seq].provenance.provenance
    - publication.subjects[seq].provenance.trust
    - publication.subjects[seq].subject.scheme
    - publication.subjects[seq].subject.value
    - publication.subtitle
    - publication.type
    - software.author[seq].fullname
    - software.author[seq].name
    - software.author[seq].pid
    - software.author[seq].pid.id.scheme
    - software.author[seq].pid.id.value
    - software.author[seq].pid.provenance.provenance
    - software.author[seq].pid.provenance.trust
    - software.author[seq].rank
    - software.author[seq].surname
    - software.bestaccessright.code
    - software.bestaccessright.label
    - software.bestaccessright.scheme
    - software.codeRepositoryUrl
    - software.contributor[seq]
    - software.country[seq].code
    - software.country[seq].label
    - software.country[seq].provenance.provenance
    - software.country[seq].provenance.trust
    - software.dateofcollection
    - software.description[seq]
    - software.documentationUrl[seq]
    - software.embargoenddate
    - software.format[seq]
    - software.green
    - software.id
    - software.inDiamondJournal
    - software.indicators.bipIndicators[seq].class
    - software.indicators.bipIndicators[seq].indicator
    - software.indicators.bipIndicators[seq].score
    - software.indicators.usageCounts.downloads
    - software.indicators.usageCounts.views
    - software.instance[seq].accessright.code
    - software.instance[seq].accessright.label
    - software.instance[seq].accessright.openAccessRoute
    - software.instance[seq].accessright.scheme
    - software.instance[seq].alternateIdentifier[seq].scheme
    - software.instance[seq].alternateIdentifier[seq].value
    - software.instance[seq].license
    - software.instance[seq].pid[seq].scheme
    - software.instance[seq].pid[seq].value
    - software.instance[seq].publicationdate
    - software.instance[seq].refereed
    - software.instance[seq].type
    - software.instance[seq].url[seq]
    - software.isGreen
    - software.isInDiamondJournal
    - software.language.code
    - software.language.label
    - software.lastupdatetimestamp
    - software.maintitle
    - software.openAccessColor
    - software.originalId[seq]
    - software.pid[seq].scheme
    - software.pid[seq].value
    - software.programmingLanguage
    - software.publicationdate
    - software.publiclyFunded
    - software.publisher
    - software.source[seq]
    - software.subjects[seq].provenance
    - software.subjects[seq].provenance.provenance
    - software.subjects[seq].provenance.trust
    - software.subjects[seq].subject.scheme
    - software.subjects[seq].subject.value
    - software.subtitle
    - software.type

- Nieuwe velden LeidenRepository
    - record.header.datestamp
    - record.header.identifier
    - record.header.setSpec
    - record.header.setSpec[seq]
    - record.metadata.oai_dc:dc.dc:contributor[seq]
    - record.metadata.oai_dc:dc.dc:creator[seq]
    - record.metadata.oai_dc:dc.dc:date[seq]
    - record.metadata.oai_dc:dc.dc:description[seq]
    - record.metadata.oai_dc:dc.dc:format[seq]
    - record.metadata.oai_dc:dc.dc:identifier[seq]
    - record.metadata.oai_dc:dc.dc:language[seq]
    - record.metadata.oai_dc:dc.dc:publisher
    - record.metadata.oai_dc:dc.dc:relation
    - record.metadata.oai_dc:dc.dc:source
    - record.metadata.oai_dc:dc.dc:subject[seq]
    - record.metadata.oai_dc:dc.dc:title
    - record.metadata.oai_dc:dc.dc:type[seq]
    - record.metadata.oai_dc:dc.dcterms:alternative[seq]
    - record.metadata.oai_dc:dc.dcterms:license[seq]

### 1.38.0.0

- Verwijderde velden
    - works.authorships[seq].author.display_name
    - works.authorships[seq].institutions[seq].display_name
    - works.authorships[seq].raw_affiliation_string


### 1.36.0.0

- Nieuwe velden
    - source.is_core
    - works.authorships[seq].affiliations[seq].institution_ids[seq]
    - works.authorships[seq].affiliations[seq].raw_affiliation_string

- Verwijderde velden
    - works.keywords[seq].keyword

### 1.35.0.0

- Nieuwe velden
    - organisation.external_ids.UEI.all[seq]
    - organisation.external_ids.UEI.preferred
    - grants.concepts_scores_v6[seq].concept
    - grants.concepts_scores_v6[seq].relevance
    - publication.concepts_scores_v6[seq].concept
    - publication.concepts_scores_v6[seq].concept
    - publication.created_in_dimensions
    - publication.doctype_classification_v1
    - publication.doctype_is_citable_v1
    - publication.mesh.headings[seq]
    - publication.mesh.terms[seq]
    - publication.mesh.ui[seq]
    - publication.pubmed_publication_types[seq]
    - publication.source.eissn
    - publication.source.issn

- Verwijderde velden
    - publication.doctype_classification_v0
    - publication.doctype_is_citable_v0

### 1.34.0.0

- Nieuwe velden
    - institutions.is_super_system
    - works.best_oa_location.license_id
    - works.keywords[seq].display_name
    - works.keywords[seq].id
    - works.locations[seq].license_id
    - works.primary_location.license_id

### 1.33.0.0

- Nieuwe velden
    - admin.created.date
    - admin.created.schema_version
    - admin.last_modified.date
    - admin.last_modified.schema_version
    - domains[seq]
    - external_ids[seq].all[seq]
    - external_ids[seq].preferred
    - external_ids[seq].type
    - links[seq].type
    - links[seq].value
	- [seq].locations[seq].geonames_details.country_code
    - locations[seq].geonames_details.country_name
    - locations[seq].geonames_details.lat
    - locations[seq].geonames_details.lng
    - locations[seq].geonames_details.name
    - locations[seq].geonames_id
    - names[seq].lang
    - names[seq].types[seq]
    - names[seq].value

- Verwijderde velden
    - acronyms[seq]
    - addresses[seq].city
    - addresses[seq].country_geonames_id
    - addresses[seq].geonames_city.city
    - addresses[seq].geonames_city.geonames_admin1.ascii_name
    - addresses[seq].geonames_city.geonames_admin1.code
    - addresses[seq].geonames_city.geonames_admin1.id
    - addresses[seq].geonames_city.geonames_admin1.name
    - addresses[seq].geonames_city.geonames_admin2.ascii_name
    - addresses[seq].geonames_city.geonames_admin2.code
    - addresses[seq].geonames_city.geonames_admin2.id
    - addresses[seq].geonames_city.geonames_admin2.name
    - addresses[seq].geonames_city.id
    - addresses[seq].geonames_city.license.attribution
    - addresses[seq].geonames_city.license.license
    - addresses[seq].geonames_city.nuts_level1.code
    - addresses[seq].geonames_city.nuts_level1.name
    - addresses[seq].geonames_city.nuts_level2.code
    - addresses[seq].geonames_city.nuts_level2.name
    - addresses[seq].geonames_city.nuts_level3.code
    - addresses[seq].geonames_city.nuts_level3.name
    - addresses[seq].lat
    - addresses[seq].line
    - addresses[seq].lng
    - addresses[seq].postcode
    - addresses[seq].primary
    - addresses[seq].state
    - addresses[seq].state_code
    - aliases[seq]
    - country.country_code
    - country.country_name
    - email_address
    - external_ids.CNRS.all[seq]
    - external_ids.CNRS.preferred
    - external_ids.FundRef.all[seq]
    - external_ids.FundRef.preferred
    - external_ids.GRID.all
    - external_ids.GRID.preferred
    - external_ids.HESA.all[seq]
    - external_ids.HESA.preferred
    - external_ids.ISNI.all[seq]
    - external_ids.ISNI.preferred
    - external_ids.OrgRef.all[seq]
    - external_ids.OrgRef.preferred
    - external_ids.UCAS.all[seq]
    - external_ids.UCAS.preferred
    - external_ids.UKPRN.all[seq]
    - external_ids.UKPRN.preferred
    - external_ids.Wikidata.all[seq]
    - external_ids.Wikidata.preferred
    - labels[seq].iso639
    - labels[seq].label
    - links[seq]
    - name
    - wikipedia_url

### 1.32.0.0

- Nieuwe velden
    - authors.affiliations[seq].institution.id
    - authors.affiliations[seq].years[seq]
    - authors.last_known_institutions[seq].id
    - domains.cited_by_count
    - domains.created_date
    - domains.description
    - domains.display_name
    - domains.display_name_alternatives[seq]
    - domains.fields[seq].id
    - domains.id
    - domains.ids.wikidata
    - domains.ids.wikipedia
    - domains.siblings[seq].id
    - domains.updated_date
    - domains.works_count
	- fields.cited_by_count
	- fields.created_date
	- fields.description
	- fields.display_name
	- fields.display_name_alternatives[seq]
	- fields.domain.id
	- fields.id
	- fields.ids.wikidata
	- fields.ids.wikipedia
	- fields.siblings[seq].id
	- fields.subfields[seq].id
	- fields.updated_date
	- fields.works_count
	- subfields.cited_by_count
	- subfields.created_date
	- subfields.description
	- subfields.display_name
	- subfields.display_name_alternatives[seq]
	- subfields.domain.id
	- subfields.id
	- subfields.ids.wikidata
	- subfields.ids.wikipedia
	- subfields.siblings[seq].id
	- subfields.topics[seq].id
	- subfields.updated_date
	- subfields.works_count
	- topics.cited_by_count
	- topics.created_date
	- topics.description
	- topics.display_name
	- topics.domain.id
	- topics.field.id
	- topics.id
	- topics.ids.wikipedia
	- topics.keywords[seq]
	- topics.siblings[seq].id
	- topics.subfield.id
	- topics.updated_date
	- topics.works_count
    - works.domains[seq].id
    - works.fields[seq].id
    - works.indexed_in[seq]
    - works.primary_topic.id
	- works.primary_topic.score
    - works.subfields[seq].id
    - works.topics[seq].id
    - works.topics[seq].score
    - works.topics_count

### 1.31.0.0

- Nieuwe velden
    - institutions.lineage
    - works.authorships[seq].raw_author_name
    - works.countries_distinct_count
    - works.fulltext_origin
    - works.has_fulltext
	- works.keywords[seq].keyword
    - works.keywords[seq].score

- Verwijderde velden
    - works.is_oa
	- works.host_venue.display_name
    - authors.ids.mag

### 1.30.0.0

- implemetatie bso 2023sep model (French Open Science Monitor)

### 1.29.0.0

- Aanpassen OpenAlex model (works) n.a.v. data download 2023aug.

### 1.28.0.0

- Bug fixing OpenAlex model
    - Initiele table prefix funder toegevoegd
	- Naamgeving aangepast.

### 1.27.0.0

- Implementatie van Dimensions organisations model (2023_jul)

### 1.26.0.0

- OpenAlex modellen onder regie van Nees aangepast. Zie ook de documentatie in Teams.

### 1.25.0.0

#### Models

- implementatie 2023jul voor OpenAlex authors (update)
- implementatie 2023jul voor OpenAlex concepts (update)
- implementatie 2023jul voor OpenAlex funders (nieuw)
- implementatie 2023jul voor OpenAlex institutions (update)
- implementatie 2023jul voor OpenAlex publishers (update)
- implementatie 2023jul voor OpenAlex sources (update)
- implementatie 2023jul voor OpenAlex works (update)

### 1.24.0.0

#### Models

- implementatie format_9 voor Dimensions publicaties
- implementatie format_1 voor Dimensions fundergroups
- implementatie format_6 voor Dimensions grants
- implementatie format_1 voor Dimensions researchgroups

### 1.23.0.0

- Implementatie model Overton 2023may

### 1.22.0.0

#### Implementatie van OpenAlex modellen versie 2023feb. In deze release zijn de volgende release notes van OpenAlex meegenomen:

RELEASE 2023-02-21
- renamed venues to sources
- add publishers entity

RELEASE 2022-12-21
- the values in host_venue have been added to alternate_host_venues in works, which paves way for the new locations list that will contain all possible venues for a work

RELEASE 2022-11-14
- new fields in venues: type, apc_usd, alternate_titles, abbreviated_title, fatcat_id, and wikidata_id

OpenAlex relase notes: https://openalex.s3.amazonaws.com/RELEASE_NOTES.txt

### 1.21.0.0

- Paden verwijderd uit het OpenAlex model onder regie van Bram en Nees

### 1.20.0.0

- Versiedatum van de OpenAlex modellen van 2022jan in 2022jul gewijzigd en de structuur van de modellen is in overeenstemming met de actuele documentatie/analyse gebracht.
- Model voor parsen van twitter data is toegevoegd.

### 1.19.0.0

- Extra parameter toegevoegd om de extensie van de source bestanden aan te geven. De parameter is optioneel en indien gebruikt worden alleen die bestanden in de source folder geselecteerd die de gewenste extensie hebben. Default worden alle bestanden geselecteerd.

	Example: SourceFileExtension=json


### 1.18.0.0

 - Implementatie model altmetric_2022may
 - Implementatie model dimensionspublications format_8

### 1.17.0.0

 - Implementatie van de modellen voor OpenAlex data (works, authors, institutions, venues en concepts).

### 1.16.0.1

- Bugfix in datamodel voor DataCite dois n.a.v. melding Bram

### 1.16.0.0

- De databron datacite is datacitedois geworden om onderscheid te maken met andere entiteiten binnen Datacite.
- Databron DataCite clients is toegevoegd -> dataciteclients - 2021nov
- Databron DataCite providers is toegevoegd -> dataciteproviders - 2021nov
- Objecten met alleen maar lege velden worden niet meer naar de uitvoer doorgeschreven.
- Implementatie van FastMember library om applicatie sneller te maken.
- Code refactoring van CsvBase.cs om applicatie sneller te maken.

Updates externe libraries:

|library|oude versie|nieuwe versie|
|---|---|---|
|Newtonsoft.Json|12.0.3|13.0.1|
|Costura.Fody|4.1.0|5.7.0|
|Fody|6.2.1|6.6.0|


### 1.15.0.0 - 20210909

- Databron crossrefeventdata toegevoegd. Model versie is 2021aug.
- Datum velden die waardes hebben die een T bevatten worden vanaf nu niet meer als DateTime 
aangemerkt maar als VarChar.

### 1.14.0.0 - 20210909

- Bug voor het bepalen van een floatwaarde opgelost.

		-.8014 werd niet als float herkend.


### 1.13.0.0 - 20210819

- Error melding wordt gegenereerd voor char(1) kolommen (lege kolommen) in de database definitie.
- Alle parse errors worden nu gemeld ipv alleen wanneer het parsen geen object oplevert. Dit is 
aangepast omdat bij aanpassen van het DataCite model bleek dat de GeoLocationPolygonPoint 
objecten soms in een enkele en soms in een dubbele array staan. De dubbele array werd niet in de 
uitvoer	meegenomen maar genereerde ook geen fout.
- Nieuw model voor DataCite toegevoegd: 2021aug

- Verwijderde velden: 
		
		data.attributes.prefix
		data.attributes.suffix

### 1.12.0.0 - 20210802

- Nieuw model voor altmetric toegevoegd: 2021jun

		Toegevoegde velden:

			citation.book.cover_image_url
			citation.book.editors[seq]
			citation.book.epubdate
			citation.epubdate

		Verwijderde velden:

			counts.reviews
			posts.twitter[seq].author alle velden behalve tweeter_id
			posts.twitter[seq].posted_on
			posts.twitter[seq].rt
			posts.twitter[seq].title
			posts.twitter[seq].url

### 1.11.0.0 - 20210622

- Nieuw model voor ROR toegevoegd: version8

### 1.10.0.0 - 20210531

- Nieuw model voor Overton data toegevoegd.

		Velden toegevoegd:

			source_tags
			sdgcategories
			open_mentioned_institution_authors_with_country
			mentions_people
				aff
				name
				country

		Velden gewijzigd

			policy_source_region van string naar array[string]

### 1.9.0.0	 - 20210519

- Naamgeving conventie voor data versie van dimensions publications is aangepast zodat deze
met de naamgeving van de leverancier overeenkomt. De meest recente versie is format_7.
- In deze versie is het veld book_series_title uit het model verwijderd omdat deze kolom
geen data bevatte.

### 1.8.0.0  - 20210323

- In de logfile is bij de verstreken tijd nu ook het aantal dagen opgenomen om langlopende
processen te meten.

### 1.7.0.0  - 20210204

- Model implemented for GRID - 2020dec
- Model implemented for dimensionscategories - 2021jan

### 1.6.0.0	 - 20210203

- Dimensions is divided into dimensionspublications and dimensionscategories.
	- For dimensionscategories the model 2020apr_update is implemented
	- For dimensionspublications the model 2021_jan is implemented.

### 1.5.0.0	 - 20210127

- implemented new datasources: crossrefjournals & crossrefmembers
- added model for dimensions: 2020apr_update
- added fields in the 2020apr_update model:

		pub
			abstract
			source [source]
			authors [author]
			categories [category]
		
		source
			id
			title
			original_title
		
		category
			id
			category_type
			version
		
		author
			first_name
			last_name
			researcher_id
			affiliations [affiliation] -> tabel: raw_affiliation 
			corresponding
		
		affiliation
			affiliation
			grid_ids
			cities
			states
			countries_territories
			corresponding


### 1.4.0.0	 - 20201125

- Implemented new datasource ror 
- Created model for ror - 2020oct
- BugFix for BigInt columns that were wrongly typed in de SQL.

### 1.3.0.0	 - 20201014

- Added 2020oct model voor Unpaywall.
	
		Added publication fields:
		
			has_repository_copy
			first_oa_location
		
		Added location fields
	
			oa_date
			repository_institution

### 1.2.0.0	 - 20201013

- Model voor DataCite data geimplementeerd

### 1.1.0.0  - 20200903

- Opmaak van de log in lijn gebracht met die van andere applicaties.

### 1.0.0.0  - 20200730

- Eerste oplevering


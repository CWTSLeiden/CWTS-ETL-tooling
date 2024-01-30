# Release notes JsonParser

## Implemented data sources:

|Name|Versions|
|---|---|
|altmetric|2019oct, 2021jun, 2022may|
|dimensionspublications|2020apr, 2020apr_update, 2021jan, format_7, format_8, format_9|
|dimensionscategories|2020apr_update, 2021jan|
|dimensionsfundergroups|format_1|
|dimensionsgrants|format_6|
|dimensionsresearchgroups|format_1|
|grid|2020jun, 2020dec|
|overton|2020jul, 2021may, 2023may|
|unpaywall|2020apr, 2020oct|
|datacitedois|2020aug, 2021aug|
|dataciteclients|2021nov|
|dataciteproviders|2021nov|
|ror|2020oct, version8|
|crossrefjournals|2021jan|
|crossrefmembers|2021jan|
|crossrefeventdata|2021aug|
|openalexworks|2022jul, 2023feb
|openalexauthors|2022jul, 2023feb|
|openalexinstitutions|2022jul, 2023feb|
|openalexvenues|2022jul|
|openalexconcepts|2022jul, 2023feb|
|openalexsources|2023feb|
|openalexpublishers|2023feb|
|twitter|2022jul|

OpenAlex documentatie: https://docs.openalex.org/


## Releases

### 1.24.0.0

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


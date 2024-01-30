Deze repository gebruikt semantische versienummers om updates bij te houden.
Het doel van de semantische versienummers is tijdens het updaten van de data pipelines een snel overzicht te hebben van de tussentijdse veranderingen aan de etl-tooling repository.

# Semantic versioning: v(Major.Minor.Patch)
Een versienummer bestaat uit 3 delen:

## Major versie
- Het Major versienummer geeft een significante verandering aan van een functie. 
- Bij deze verandering moet de aanroep binnen een data pipeline veranderd worden, of verandert de output van de functie met dezelfde aanroep.

## Minor versie
- Het Minor versienummer geeft een niet-significante verandering aan van een functie. 
- Bij deze verandering worden er extra functionaliteiten toegevoegd aan een functie zonder dat de aanroep van de functie wordt veranderd.
- Een voorbeeld van een minor versie update is een extra optie voor een specifieke parameter.

## Patch versie
- Het Patch versienummer geeft een bugfix aan.

# Releases

## Versie van functies
In de [README.md](https://github.com/cwts-ict/etl-tooling/blob/master/README.md) van de repository etl-tooling staan de laatste versies van alle functies.

- Een versienummer vanaf v0.0.1 geeft aan dat de functie nog in ontwikkeling is.
- Een versienummer vanaf v0.1.0 geeft aan dat de functie ontwikkeld is, maar nog niet (volledig) is getest in een productieomgeving.
- Een versienummer vanaf v1.0.0 geeft aan dat de functie geschikt is voor productie.

## Versie van de repository etl-tooling
Bij het ontwikkelen van een data pipeline kunnen er veranderingen gemaakt worden aan de etl-tooling repository.
Om in de toekomst makkelijk terug te gaan naar een versie van de etl-tooling repository worden er releases gemaakt van de etl-tooling repository op GitHub.
De release wordt tegelijkertijd gemaakt met de release van de data pipeline. Er wordt alleen een nieuwe release gemaakt van de etl-tooling repository als er functies zijn veranderd. Het versienummer van de etl-tooling release wordt opgehoogt met de maximale versieophoging van een van de veranderde functies, e.g. als de laatste etl-tooling release v2.1.3 was en 1 functie een Minor update heeft gehad en 2 functies een Patch update, dan is de volgende versie van de etl-tooling repository v2.2.0.

# Changelogs
In de [README.md](https://github.com/cwts-ict/etl-tooling/blob/master/README.md) wordt er per functie een changelog bijgehouden.
Bij het updaten van een data pipeline kan er gekeken worden welke aanpassingen er hebben plaats gevonden aan een specifieke functie.

            
This program splits an XML file in multiple XML files.
            
The size of the resulting XML files is determined bij the number of records in
a block. A record starts and ends with a split tag.

Before execution of the program it needs to be configured. This is done by:

1.  Configuration file.

    The name of the configuration file must be XmlFileSplitter.exe.config and it must be in the same folder as the program.

    Example:

    <?xml version="1.0" encoding="utf-8" ?>
    <configuration>
        <appSettings>
            <add key="XmlFile" value="D:\development\projects\github\TestData\XmlFileSplitter\ListRecords_J_10.1001_224806.xml" />
            <add key="SplitTag" value="record" />
            <add key="CleanTags" value="citedTitle,abstracts" />
            <add key="BlockSize" value="100" />
            <add key="LogFolder" value="D:\development\projects\github\TestData\XmlFileSplitter\log" />
            <add key="clean_cdata" value="true"/>
            <add key="remove_namespaces" value="true" />
            <add key="fix_crossref_namespaces" value="true" />   *** only for crossref data ***
            <add key="OrderMixedValues" value="fr:assertion"/>
            <add key="include_xml_prolog" value="false"/>
            <add key="remove_original_files" value="false"/>
        </appSettings>
    </configuration>

or by
            
2. Command line

    XmlFileSplitter.exe XmlFile="ListRecords_J_10.1001_224806.xml" splittag=record BlockSize=10000 logfolder=".\splitlog" cleantags="title, subtitle, original_language_title, unstructured_citation, assertion, description, abstract, jats:abstract, ja:abstract" clean_cdata="true" remove_namespaces="true" fix_crossref_namespaces="true" OrderMixedValues="fr:assertion"

    e.g for Scopus:

    XmlFileSplitter.exe xmlfolder="c:\files" findfilesrecursive=true CleanTags="name" LogFolder="c:\files\log"
            
Parameters:
            
    XmlFile                 - Location of the XML file to split.
    XmlFolder               - Folder with the XML files. Only files with .xml extension are processed. 

                              You have to supply XmlFile or XmlFolder but not both.

    FindfilesRecursive      - If XmlFolder is provided: when true files in all subfolders are processed. If false only files in the given folder are processed.
                              This parameter is not used when XmlFile is used.
    SplitTag                - Tag used to split the file without < and >.
    CleanTags (optional)    - Comma seperated list of tags the need to be cleaned (remove html tags, carriage return and new line characters)
    BlockSize (optional)    - Number of records in each result file. When omitted the block size is 10000. The blocksize is not used when splittag is not defined.
    LogFolder               - Location of the folder where the log file is saved. If an error occurs during execution of the program an error file is generated in this folder.
                              The folder is created if it doesn't exist.
    clean_cdata             - If true then all cdata fields are cleaned (default = false).
    remove_namespaces       - If true then all namespaces will be removed from the resulting XML. If omitted or other value
                              the namespaces will not be removed.
                              (remove all namespaces in tags, e.g. xmlns="http://www.openarchives.org/OAI/2.0/", in tags that contain : the : is replaced by _)
    fix_crossref_namespaces - If true all the namespaces that start with ns (e.g.ns4:) according to the following table for the namespave url:
                    
                              http://www.crossref.org/clinicaltrials.xsd    ct
                              http://www.crossref.org/relations.xsd         rel
                              http://www.crossref.org/AccessIndicators.xsd  ai
                              http://www.crossref.org/fundref.xsd           fr
                              http://www.ncbi.nlm.nih.gov/JATS1             jats

                              *** this option is only implemented for Crossref data, set to false or omit it for other data sources ***

    OrderMixedValues        - This parameter is a list of tags that have mixed content (data & elements).
                              If the list has tags the XmlFileSplitter program will reorder mixed content in those tags. It make sure that the data is before the xml elements
                              because ReadData cannot handle it properly if the elements come first. In that case the data would be omitted.
                              If the OrderMixedValues parameter is false or not provided the elements will not be swapped.
                              If the parameter remove_namespaces is true then in all tags of the OrderMixedValues property the : is replaced by _

                              e.g.

                              <fr:assertion name="funder_name">
                                <fr:assertion name="funder_identifier" provider="crossref">https://doi.org/10.13039/501100001700</fr:assertion>
                                Ministry of Education, Culture, Sports, Science and Technology
                              </fr:assertion>

                              is converted to:

                              <fr:assertion name="funder_name">
                                Ministry of Education, Culture, Sports, Science and Technology
                                <fr:assertion name="funder_identifier" provider="crossref">https://doi.org/10.13039/501100001700</fr:assertion>
                              </fr:assertion>

    Include_xml_prolog      - if true the XML prolog ill be added to the resulting file. It is not added if false but if the original file
                              contains the XML prolog, the resulting file has it too.
    
    Remove_original_files   - if true the original file is deleted. If false the original file is renamend to .split.
                              Default value is false (rename)
    
    showoutput (optional). If this parameter is omitted, no output is shown in the console. This can only be set as a commandline parameter.

If a parameter value is found in the config file and as a commandline parameter, the commandline parameter is used.

When only commandline parameters are used the configuration file doesn't have to exist.

Cleansing of the data:

From                To
/t (tab)            space
&#13; (linefeed)    space

All lines are trimmed.

            
    
            
            

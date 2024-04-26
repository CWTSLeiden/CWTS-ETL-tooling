# =======================================================================================
# Main
## Generate a BigQuery json schema from the data types output of the export_table function
#
# input variables
## 1. InputFile:  Tsv file containing the data types
## 2. OutputFile: The file to store the json schema in
## 3. LogFile:    Log file for this function
# =======================================================================================

param (
    [Parameter(Mandatory=$true)] [System.IO.FileInfo] $InputFile,
    [Parameter(Mandatory=$true)] [System.IO.FileInfo] $OutputFile,
    [System.IO.FileInfo] $LogFile
)

function ConvertTypeBQ {
    param($Type)
    $Type = $Type -replace "\([0-9]+\)",""
    Switch -Exact ($Type) {
        "char"           { return "STRING" }
        "varchar"        { return "STRING" }
        "text"           { return "STRING" }
        "nchar"          { return "STRING" }
        "nvarchar"       { return "STRING" }
        "ntext"          { return "STRING" }
        "bigint"         { return "INT64" }
        "int"            { return "INT64" }
        "smallint"       { return "INT64" }
        "tinyint"        { return "INT64" }
        "bit"            { return "BOOL" }
        "numeric"        { return "NUMERIC" }
        "decimal"        { return "NUMERIC" }
        "float"          { return "NUMERIC" }
        "real"           { return "FLOAT64" }
        Default          { return "STRING" }
    }
}

function ConvertNullableBQ {
    param($Nullable)
    Switch -Exact ($Nullable) {
        "YES"   { return "NULLABLE" }
        1       { return "NULLABLE" }
        "True"  { return "NULLABLE" }
        "NO"    { return "REQUIRED" }
        0       { return "REQUIRED" }
        "False" { return "REQUIRED" }
        Default { return "NULLABLE" }
    }
}

function Log {
    param([string]$LogString)
    Write-Verbose $LogString
    if ($LogFile) {
        Add-Content -Path $LogFile -Value $LogString
    }
}

$table = Import-Csv -Path $InputFile -Delimiter `t

$schema = @()

foreach ($row in $table) {
    $bq_data_type = ConvertTypeBQ -Type $row.data_type
    $bq_is_nullable = ConvertNullableBQ -Nullable $row.is_nullable

    Log "$($row.table_name).$($row.column_name): $($row.data_type) -> ${bq_data_type}"

    $schema += [PSCustomObject]@{
        name = $row.column_name;
        type = $bq_data_type;
        mode = $bq_is_nullable;
        description = $row.description;
    }
}

$schema | ConvertTo-Json | Out-File -FilePath $OutputFile -Encoding ascii

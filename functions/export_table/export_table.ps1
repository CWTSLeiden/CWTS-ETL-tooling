param(
    [Parameter(Mandatory=$true)] [string] $server,
    [Parameter(Mandatory=$true)] [string] $db_name,
    [Parameter(Mandatory=$true)] [string] $table_name,
    [Parameter(Mandatory=$true)] [System.IO.FileInfo] $input_file,
    [Parameter(Mandatory=$true)] [System.IO.FileInfo] $output_file,
    [string] $log_folder = ".\log",
    [switch]$NoHeader = $false,
    [string]$Separator = "`t",
    [int]$limit = 1000000000
)

function get_row_count {
    param(
        [Parameter(Mandatory=$true)] [string] $table_name
    )
    $query = "select top 1 [row_count] from sys.tables a join sys.dm_db_partition_stats b on a.object_id = b.object_id where a.[name] = '${table_name}'"
    try{
        $result = Invoke-SqlCmd -TrustServerCertificate -Server $server -Database $db_name -Query $query
    }
    catch {
        Out-File -FilePath "${log_folder}\export_${table_name}.error" -Append -InputObject $_.Exception.Message
    }
    $row_count = if ($null -eq $result.row_count) { -1 } else { $result.row_count }
    return $row_count
}

# Requires Powershell 7
function export_table {
    param(
        [Parameter(Mandatory=$true)] [System.IO.FileInfo] $output_file,
        [int]$offset = 0,  # Offset is a multiple of $limit
        [int]$iterations = 0
    )
    # If the table is split, the first iteration has not postfix
    # subsequent iterations get the #offset postfix
    if ($iterations -gt 0) {
        Write-Verbose "Export table:        ${table_name} [$($offset + 1)/$($iterations + 1)]"
    } else {
        Write-Verbose "Export table:        ${table_name}"
    }
    Write-Verbose "Using export script: ${input_file}"
    Write-Verbose "To file:             ${output_file}"
    if ($offset -gt 0) {
        $base = Split-Path -Path $output_file -Parent
        $name = Split-Path -Path $output_file -LeafBase
        $ext  = Split-Path -Path $output_file -Extension
        $output_file = "${base}\${name}_#${offset}${ext}"
    }
    try{
        Invoke-SqlCmd `
          -TrustServerCertificate `
          -Server $server `
          -Database $db_name `
          -InputFile $input_file `
          -Variable @("table_name=${table_name}", "limit=${limit}", "offset=$($offset * $limit)") `
          | Export-Csv `
          -Path $output_file `
          -Encoding UTF8 `
          -NoTypeInformation `
          -UseQuotes "AsNeeded" `
          -Delimiter $Separator `
          -NoHeader:$NoHeader
    } catch {
        Out-File -FilePath "${log_folder}\export_${table_name}.error" -Append -InputObject $_.Exception.Message
    }
}

if ($input_file -match "export_table\\export_table\.sql$") {
    # Standard export script is used
    $row_count = get_row_count -table_name $table_name
    $iterations = [int]($row_count / 1000000000)
    # Split the table into sections of 1B rows
    foreach ($i in 0..$iterations) {
        export_table -output_file $output_file -offset $i -iterations $iterations
    }
} else {
    export_table -output_file $output_file
}
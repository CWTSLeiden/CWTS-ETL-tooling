param(
    [Parameter(Mandatory=$true)] [string] $server,
    [Parameter(Mandatory=$true)] [string] $db_name,
    [Parameter(Mandatory=$true)] [string] $table_name,
    [Parameter(Mandatory=$true)] [System.IO.FileInfo] $input_file,
    [Parameter(Mandatory=$true)] [System.IO.FileInfo] $output_file,
    [string] $log_folder = ".\log",
    [switch]$NoHeader = $false,
    [string]$Separator = "`t"
)

# Requires Powershell 7
Write-Verbose "Export table: ${table_name}"
Write-Verbose "Using export script: ${input_file}"
try{
    Invoke-SqlCmd `
      -TrustServerCertificate `
      -Server $server `
      -Database $db_name `
      -InputFile $input_file `
      -Variable @("table_name=${table_name}") `
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

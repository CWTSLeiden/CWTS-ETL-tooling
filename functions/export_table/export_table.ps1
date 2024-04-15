param(
    [Parameter(Mandatory=$true)] [string] $server,
    [Parameter(Mandatory=$true)] [string] $db_name,
    [Parameter(Mandatory=$true)] [string] $table_name,
    [Parameter(Mandatory=$true)] [System.IO.FileInfo] $input_file,
    [Parameter(Mandatory=$true)] [System.IO.FileInfo] $output_file,
    [string]$Encoding = "UTF8",
    [switch]$NoHeader = $false,
    [string]$Separator = "`t",
    [string]$NullValue = ""
)

function ParseByType {
    param(
        [Parameter(Mandatory=$true)]$Item
    )
    $Type = $Item.GetType()
    switch ($Type) {
        System.DBNull { return $NullValue }
        string { return "`"${Item}`"" }
        DateTime { return $Item.ToString("yyyy-MM-dd HH:mm") }
        Default { return $Item }
    }
}

function Export-Tsv {
    # TODO: Much too slow
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)] [PSCustomObject[]]$Table,
        [Parameter(Mandatory=$true)] [System.IO.FileInfo]$Path
    )
    begin {
        $rownumber = 0
        Write-Output "" | Out-File -FilePath $Path -Encoding $Encoding -NoNewLine
    }
    process {
        $rownumber += 1
        if ((-not $NoHeader) -and ($rownumber -eq 1)) {
            $header = ($Table | ConvertTo-Csv -NoTypeInformation -Delimiter "`t")[0]
            $header  -replace "`"","" | Out-File -FilePath $Path -Encoding $Encoding -Append
        }
        foreach ($row in $Table) {
            $parsed = $row.ItemArray | Foreach-Object { ParseByType -Item $_ -NullValue $NullValue }
            $parsed -join $Separator | Out-File -FilePath $Path -Encoding $Encoding -Append
        }
    }
    end {
        Write-Verbose "Number of rows exported: $rownumber"
    }
}

# TODO: Needs Powershell 7+
Invoke-SqlCmd `
    -TrustServerCertificate `
    -Server $server `
    -Database $db_name `
    -InputFile $input_file `
    -Variable @("table_name=${table_name}") `
    | Export-Csv -Path $output_file -Encoding $Encoding -NoTypeInformation -UseQuotes "AsNeeded" -Delimiter $Separator -NoHeader:$NoHeader
#    | Export-Tsv -Path $output_file

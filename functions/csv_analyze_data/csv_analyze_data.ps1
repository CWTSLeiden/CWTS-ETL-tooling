param (
    [Parameter(Mandatory=$true)][System.IO.Path] $File,
    [string] $Delimiter = '`t',
    [swich] $NoHeader
)

$TypeOrder = @{
    Boolean = 0
    Int32   = 1
    Long    = 2
    Float   = 3
    Double  = 4
    Decimal = 5
    Char    = 6
    String  = 7
}

$row_number = 0
$Header = (Get-Content -Head 1 -Path $File) -split '|', 0, "SimpleMatch"
if ($NoHeader) {
    $n = 0
    $Header = $Header | ForEach-Object { $n += 1; "column${n}" }
    $row_number = 1
}

$Detection = [pscustomobject]@{}
$InitType = [pscustomobject]@{
    Type = $none
    Length = $none
    Null = $false
}
foreach ($Column in $Header) {
    $Detection | Add-Member -MemberType NoteProperty -Name $Column -Value @{}
}

function UpdateDetection {
    param(
        [Parameter(Mandatory=$true)][pscustomobject] $Current,
        [Parameter(Mandatory=$true)][pscustomobject] $Value
    )
    if ($null -eq $Value) {
        $Current.Null = $true
        return $Current
    }
    if ('' -eq $Value) {
        $Current.Null = $true
    }
    if (($null -eq $Current.Type) -or ($TypeOrder[$Value.getType().Name] -lt $TypeOrder[$Current.Type.Name])) {
        $Current.Type = $Value.getType()
    }
    if ($Value.Length -gt $Current.Length) {
        $Current.Length = $Value.Length
    }
    return $Current
}

Get-Content -Path $File | ForEach-Object {
    $Row = $_ | ConvertFrom-Csv -Delimiter $Delimiter -Header $Header
    if ($row_number -gt 0) {
        foreach ($Column in $Header) {
            $Detection.$Column = UpdateDetection -Current $Detetction.$Column -Value $Row.$Column
        }
    }
    $row_number += 1
}

Write-Output "Number of rows: ${row_number}"
Write-Output ($Detection | Format-Table)

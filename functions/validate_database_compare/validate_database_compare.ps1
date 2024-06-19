# =======================================================================================
# Main
## Compare the row counts of two validation files
#
# parameters
#
# input variables
## 1. old:            The previous validation file, a tsv file.
## 2. new:            The previous validation file, a tsv file.
## 3. (optional) out: A file to output the results to
##                    or 'view' to open the results in a window
# =======================================================================================

param (
    [System.IO.FileInfo] $old,
    [System.IO.FileInfo] $new,
    [System.IO.FileInfo] $out
)

function filepicker {
    param (
        [string] $title = "Pick file"
    )
    Add-Type -AssemblyName System.Windows.Forms
    $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
        InitialDirectory = [Environment]::GetFolderPath('Desktop')
        Filter = 'tsv files (*.tsv)|*.tsv|csv files (*.csv)|*.csv|All files (*.*)|*.*'
        Title = $title
    }
    $FileBrowser.ShowDialog() | Out-Null
    return $FileBrowser.FileName
}

if (!(Test-Path -Path $old)) {
    $old = filepicker -title "Pick file from previous update"
}
if (!(Test-Path -Path $new)) {
    $new = filepicker -title "Pick file from current update"
}
if (!(Test-Path -Path $old)) {
    Write-Error "Validation files from previous update missing"
    exit 1
}
if (!(Test-Path -Path $new)) {
    Write-Error "Validation files from current update missing"
    exit 1
}

# Get the validation files and convert them into hash tables
# The hash table has the table name as key and count as value
$oldfile = Get-Item $old
$oldtable = @{}
Import-Csv $oldfile.FullName -Delimiter `t -Header "table", "count" | ForEach-Object { $oldtable[$_.table] = $_.count }

$newfile = Get-Item $new
$newtable = @{}
Import-Csv $newfile.FullName -Delimiter `t -Header "table", "count" | ForEach-Object { $newtable[$_.table] = $_.count }

# Get all the tables from both validation files
$tables = ($newtable.Keys + $newtable.Keys) | Sort-Object | Get-Unique

# Loop over the hash tables and construct a table with the comparison data
$comparison= @()
foreach ($table in $tables) {
    $oldcount = [int64]$oldtable[$table]
    $newcount = [int64]$newtable[$table]
    $difference = [int64]($newcount - $oldcount)
    $difference_p = if ($newcount -gt 0) { [decimal]($difference / $newcount) }
    $comparison += [pscustomobject]@{Table=$table;OldCount=$oldcount; NewCount=$newcount; Difference=$difference; DifferenceP=$difference_p}
}

# Return
if ("view" -eq $out) {
    # Show the comparison in a new window and pause
    $comparison | Out-GridView -Wait
} elseif (-not ($null -eq $out)) {
    # Write the comparison as a tsv file
    $comparison | Export-Csv -Delimiter `t -NoTypeInformation -Path $out
} else {
    # Return the comparison for use in a powershell script
    return $comparison
}

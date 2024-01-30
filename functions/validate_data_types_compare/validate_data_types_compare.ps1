# =======================================================================================
# Main
## Compare the data types of two validation files
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
    [Parameter(Mandatory=$true)] [System.IO.FileInfo] $old,
    [Parameter(Mandatory=$true)] [System.IO.FileInfo] $new,
    [System.IO.FileInfo] $out
)

# Get the validation files and convert them into hash tables
# The hash table has the table.column name as key and [datatype,length] as value
$oldfile = Get-Item $old
$oldtable = @{}
Import-Csv $oldfile.FullName -Delimiter `t -Header "table", "column", "datatype", "length" | ForEach-Object { $oldtable["$($_.table).$($_.column)"] = @($_.datatype, $_.length) }

$newfile = Get-Item $new
$newtable = @{}
Import-Csv $newfile.FullName -Delimiter `t -Header "table", "column", "datatype", "length" | ForEach-Object { $newtable["$($_.table).$($_.column)"] = @($_.datatype, $_.length) }

# Get all the columns from both validation files
$tables = ($newtable.Keys + $oldtable.Keys) | Sort-Object | Get-Unique

# Loop over the hash tables and construct a table with the comparison data
$comparison= @()
foreach ($table in $tables) {
    $oldtype = if ($null -eq $oldtable[$table]) { $null } else { $oldtable[$table][0] }
    $newtype= if ($null -eq $newtable[$table]) { $null } else { $newtable[$table][0] }
    $oldlength = if ($null -eq $oldtable[$table]) { $null } else { [int]$oldtable[$table][1] }
    $newlength = if ($null -eq $newtable[$table]) { $null } else { [int]$newtable[$table][1] }
    if (-not (($oldtype -eq $newtype) -and ($oldlength -eq $newlength))) {
        $comparison += [pscustomobject]@{Table=$table;OldType=$oldtype; NewType=$oldtype; OldLength=$oldlength; NewLength=$newlength}
    }
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

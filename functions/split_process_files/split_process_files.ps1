# =======================================================================================
# Main
## Recursively collect all files of a specific type within the data_folder and
## distribute them equally over a number of folders in the process_folder. 

# parameters

# input variables
## 1. data_folder:                  source folder containing raw datafiles
## 2. process_folder:               target folder for numbered directories
## 3. number_of_processes:          number of process folders
## 4. file_type:                    type of file that should be splitted (without leading dot)
## 5. include_parent_directory:     if argument is include_parent_directory, then the folder structure is inherited in the numbered directory.
##                                  if argument is "" the files will be placed in the numbered directory.
## 6. order:                        if size, order by size before splitting (accurate)
##                                  if preserve, preserve order of files across process folders (slow)
##                                  else, do not order (fast)
# =======================================================================================

param (
    [Parameter(Mandatory=$true)]
    [string] $data_folder,
    [Parameter(Mandatory=$true)]
    [string] $process_folder,
    [Parameter(Mandatory=$true)]
    [string] $number_of_processes,
    [Parameter(Mandatory=$true)]
    [string] $file_type,
    [Parameter(Mandatory=$true)]
    [string] $include_parent_directory,
    $order
)
$number_of_files = 0

function split_files {
<#
Do not order files before moving to subfolders. This will ensure the best performance
and a low memory footprint but will result in a less even split.
(Piping the file list into ForEach-Object without processing ensures that the loop only
 processes one file at a time without taking the entire file-list into memory.)
#>
    Get-ChildItem -Path $data_folder -Recurse -File -Filter *.$file_type | ForEach-Object {
        $target_process = $number_of_files % $number_of_processes + 1
        move_file $_.FullName
        $number_of_files += 1
        output_status $number_of_files
    }
}

function split_files_order_by_size {
<#
Order files by size before moving to subfolders. This will ensure a more even split,
but the sorting will take a lot of time and memory for very large amounts of files.
#>
    Get-ChildItem -Path $data_folder -Recurse -File -Filter *.$file_type | 
    Sort-Object -Descending -Property Length | ForEach-Object {
        $target_process = $number_of_files % $number_of_processes + 1
        move_file $_.FullName
        $number_of_files += 1
        output_status $number_of_files
    }
}

function split_files_order_preserve {
<#
Split the files in the order they are presented by the file_system, which is alphabetical.
This method provides the worst split and performance.
#>
    $total_number_of_files = (Get-ChildItem -Path $data_folder -Recurse -File -Filter *.$file_type | Measure-Object).Count
    $files_per_process = [math]::Floor($total_number_of_files / $number_of_processes)
    $surplus_files = $total_number_of_files % $number_of_processes

    $target_process = 1
    $process_number_of_files = 0
    Get-ChildItem -Path $data_folder -Recurse -File -Filter *.$file_type | ForEach-Object {
        move_file $_.FullName
        $process_number_of_files += 1
        $number_of_files += 1
        if (
            $process_number_of_files -ge $files_per_process + ($target_process -le $surplus_files) -and
            $target_process -gt $number_of_processes
        ) {
            $target_process += 1
            $process_number_of_files = 0
        }
        if ($target_process -gt $number_of_processes) { $target_process = $number_of_processes }
        output_status $number_of_files
    }
}

function output_status {
    param ($n)
    if ($n % 10000 -eq 0) { Write-Verbose "$n files processed" }
}

function move_file {
    param($location)
    if ($include_parent_directory -eq "include_parent_directory") {
        $destination_directory = "$process_folder\$target_process\" + (Split-Path (Split-Path $location -Parent) -Leaf) + "\"

        if(-not(Test-Path -path $destination_directory)) {
            New-Item $destination_directory\ -Type Directory | Out-Null
        }      
        Move-Item -Path $location -Destination $destination_directory
    } else {
        Move-Item -Path $location -Destination $process_folder\$target_process\
    }
}

# Create folder structure if it does not exist
ForEach ($process in 1..$number_of_processes) {
    if (-not(Test-Path -Path $process_folder\$process)) {
        Write-Verbose "Create folder $process_folder\$process"
        New-Item -Path $process_folder -Name $process -Type Directory | Out-Null
    }
}

if ($order -eq "size") {
    split_files_order_by_size
} elseif ($order -eq "preserve") {
    split_files_order_preserve
} else {
    split_files
}

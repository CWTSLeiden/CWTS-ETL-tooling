# Call script from batch file as following
# %powershell_exe% ". '%path_to_this_script%' -db '%db_name%' -user '%db_owner% -process %~n0 -body 'Process finished'"

param (
    [string]$db,
    [string]$user,
    [string]$process,
    [string]$body,
    [string]$teams_channel_email,
    [switch]$only_on_error
)

$name = ($user -split '\\')[-1]
$email = "$name@vuw.leidenuniv.nl"
$date = Get-Date -Format "dddd dd-MM-yyyy 'at' HH:mm"

$subject = "[Pipeline Notifier] $db - $process finished"
$body = @"
DATABASE: $db<br>
PROCESS: $process<br>
DATE: $date<br><br>
$body
"@

$errors = & "$PSScriptRoot\..\check_errors.bat" skip_pause | out-string
$errors = $errors -replace "\x1b\[[0-9;]*m"  # strip color tags from string

if ($LastExitCode -eq 0) {
    $priority = "normal"
    $body = "$body<br><br>NO ERRORS"
} else {
    $priority = "high"
    $body = "$body<br><br><pre>$errors</pre>"
}
if (($priority -ne "high") -and $only_on_error) {
    Write-Verbose "No errors, not sending notification"
    return $False
}

$smtp = "smtp.leidenuniv.nl"
$from = "pipeline.notifier@cwts.leidenuniv.nl"

send-MailMessage -SmtpServer $smtp -Port 25 -UseSsl -To $email -From $from -Subject $subject -Body $body -BodyAsHtml -Priority $priority

if ($teams_channel_email) {
    send-MailMessage -SmtpServer $smtp -Port 25 -UseSsl -To $teams_channel_email -From $from -Subject $subject -Body $body -BodyAsHtml -Priority $priority
}

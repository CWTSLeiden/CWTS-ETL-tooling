# Call script from batch file as following
# %powershell_exe% ". '%path_to_this_script%' -db '%db_name%' -user '%db_owner% -process %~n0 -body 'Process finished'"

param (
    $db,
    $user,
    $process,
    $body,
    $teams_channel_email
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
if ($LastExitCode -eq 0) {
    $priority = "normal"
    $body = "$body<br><br>NO ERRORS"
} else {
    $priority = "high"
    $body = "$body<br><br><pre>$errors</pre>"
}

$smtp = "smtp.leidenuniv.nl"
$from = "pipeline.notifier@smtp.leidenuniv.nl"

send-MailMessage -SmtpServer $smtp -Port 25 -UseSsl -To $email -From $from -Subject $subject -Body $body -BodyAsHtml -Priority $priority

if ($teams_channel_email) {
    send-MailMessage -SmtpServer $smtp -Port 25 -UseSsl -To $teams_channel_email -From $from -Subject $subject -Body $body -BodyAsHtml -Priority $priority
}

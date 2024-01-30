param (
	[Parameter(Mandatory=$true)]
	[string] $settings_file
)

foreach ($line in Get-Content $settings_file) {
	if ($line -match '^[ \t]*set ([^=]+)=(.*)') {
		$var = $Matches[1]
		$val = $Matches[2]
		if ($val -match '%([^%]+)%') {
			$val = $val -replace "%[^%]+%", (Get-Variable -ValueOnly $Matches[1])
		}
		$val = $val -replace '"'
		New-Variable -Name $var -Value $val.trim() -Scope "Global" -Force
	}
} 
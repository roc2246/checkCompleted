# ENABLES TRY CATCH FUNCTIONALITY
$ErrorActionPreference = "Stop"

# SET PATHS
if ($env:COMPUTERNAME -eq "RILEYS-COMPUTER") {
    Import-Module "..\modules\ENV.psm1" -Force
    Import-Module "..\modules\error.psm1" -Force

    $rootDirectory = Join-Path (Get-Location) "CompletedFiles"
}
else {
    Import-Module ".\PowershellScripts\modules\ENV.psm1" -Force
    Import-Module ".\PowershellScripts\modules\error.psm1" -Force

    $rootDirectory = "C:\CompletedFiles"
}


try {
    $timespan = 3
    $recentCompletedFiles = Get-ChildItem -Path $rootDirectory -File | Where-Object { $_.CreationTime -ge (Get-Date).AddHours(-$timespan) }
    $lastCompletedDateAndTime = ((Get-ChildItem -Path $rootDirectory -File| Sort-Object CreationTime -Descending | Select-Object -First 1).CreationTime).ToString("yyyy-MM-dd HH:mm:ss tt")

    if ($recentCompletedFiles.Count -eq 0) {
        Find-Recent -Timespan "$($timespan) hours" -DateAndTime $lastCompletedDateAndTime
    } 
}
catch {
    Send-Error -ScriptName $MyInvocation.MyCommand.Name -ErrorParam "$($Error[0].Exception.Message)"
}


# ENABLES TRY CATCH FUNCTIONALITY
$ErrorActionPreference = "Stop"

# SET PATHS
if ($env:COMPUTERNAME -eq "RILEYS-COMPUTER") {
    Import-Module "..\modules\ENV.psm1" -Force
    Import-Module "..\modules\error.psm1" -Force
}
else {
    Import-Module ".\PowershellScripts\modules\ENV.psm1" -Force
    Import-Module ".\PowershellScripts\modules\error.psm1" -Force
}

try{
    $recentCompletedFiles = "C:\CompletedFiles" | Get-ChildItem -File | Where-Object { $_.CreationTime -lt (Get-Date).AddMinutes(-10) }
    Write-Output $recentCompletedFiles.Length

}catch{
    Send-Error -ScriptName $MyInvocation.MyCommand.Name -ErrorParam "$($Error[0].Exception.Message)"
}
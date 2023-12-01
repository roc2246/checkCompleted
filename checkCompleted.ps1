# ENABLES TRY CATCH FUNCTIONALITY
$ErrorActionPreference = "Stop"

# SET PATHS
if ($env:COMPUTERNAME -eq "RILEYS-COMPUTER") {
    Import-Module "..\modules\ENV.psm1" -Force
    Import-Module "..\modules\error.psm1" -Force
    $rootDirectory = Get-Location
}
else {
    Import-Module ".\PowershellScripts\modules\ENV.psm1" -Force
    Import-Module ".\PowershellScripts\modules\error.psm1" -Force
    $rootDirectory = "C:\CompletedFiles"
}

try{
    $timespan = 10
    $recentCompletedFiles = $rootDirectory | Get-ChildItem -File | Where-Object { $_.CreationTime -ge (Get-Date).AddMinutes(-$timespan) }
    if($recentCompletedFiles.Length -eq 0){
        Find-Recent -Time $timespan
    }

}catch{
    Send-Error -ScriptName $MyInvocation.MyCommand.Name -ErrorParam "$($Error[0].Exception.Message)"
}
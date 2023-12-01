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

$rootDirectory = "C:\CompletedFiles"



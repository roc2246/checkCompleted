# ENABLES TRY CATCH FUNCTIONALITY
$ErrorActionPreference = "Stop"

# SET PATHS
if ($env:COMPUTERNAME -eq "RILEYS-COMPUTER") {
    Import-Module "..\modules\ENV.psm1" -Force
    Import-Module "..\modules\error.psm1" -Force

    $rootDirectory = "$(Get-Location)\CompletedFiles"
    $LoopCountFile = "$(Get-Location)\checkCompleted-skippedRuns.txt"
}
else {
    Import-Module ".\PowershellScripts\modules\ENV.psm1" -Force
    Import-Module ".\PowershellScripts\modules\error.psm1" -Force

    $rootDirectory = "C:\CompletedFiles"
    $LoopCountFile = "C:\PowershellScripts\checkCompleted-skippedRuns.txt"
}

Function New-LoopFileIfNotExists {
    if (-not (Test-Path $LoopCountFile)) {
        New-Item -ItemType File -Path $LoopCountFile
    }
}

Function Set-Loop-Process {
    param(
        [string]$Mode
    )

    if ($Mode -eq "reset") {
        $LoopNo = 0
        $LoopNo | Out-File -FilePath $LoopCountFile
    }
    elseif ($Mode -eq "set") {
        $LoopNo = [int](Get-Content -Path $LoopCountFile)
        $LoopNo++
        $LoopNo | Out-File -FilePath $LoopCountFile

        if ($LoopNo % 4 -eq 0) {
            Find-Recent -Time $timespan
        }
    }
}

try{
    $timespan = 10
    $recentCompletedFiles = $rootDirectory | Get-ChildItem -File | Where-Object { $_.CreationTime -ge (Get-Date).AddMinutes(-$timespan) }
   
    New-LoopFileIfNotExists

    if($recentCompletedFiles.Length -eq 0){
        Set-Loop-Process -Mode "set"
    } else {
        Set-Loop-Process -Mode "reset"
    }

}catch{
    Send-Error -ScriptName $MyInvocation.MyCommand.Name -ErrorParam "$($Error[0].Exception.Message)"
}
# DatabasePatch.ps1

$ServerName = "SQLSERVER01"
$DatabaseName = "MyDatabase"
$PatchFile = "C:\DBPatches\Patch_001.sql"
$LogFile = "C:\Logs\DBPatch.log"

try {

    Write-Host "Starting Database Patch..."

    Invoke-Sqlcmd `
        -ServerInstance $ServerName `
        -Database $DatabaseName `
        -InputFile $PatchFile `
        -Verbose 4>> $LogFile

    Write-Host "Patch Applied Successfully"

    Add-Content $LogFile "$(Get-Date) : Patch completed successfully"

}
catch {

    Write-Host "Patch Failed"

    Add-Content $LogFile "$(Get-Date) : Patch failed - $_"

}
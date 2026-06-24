# List of servers
$Servers = @(
    "Server01",
    "Server02",
    "Server03"
)

# Output file
$OutputFile = "C:\Reports\CPU_Utilization_Report.csv"

# Create results array
$Results = @()

foreach ($Server in $Servers) {
    try {
        $CPU = Get-CimInstance -ComputerName $Server `
            -ClassName Win32_Processor |
            Measure-Object -Property LoadPercentage -Average

        $Results += [PSCustomObject]@{
            ServerName    = $Server
            CPUUtilization = [math]::Round($CPU.Average,2)
            CollectionTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        }
    }
    catch {
        $Results += [PSCustomObject]@{
            ServerName    = $Server
            CPUUtilization = "Connection Failed"
            CollectionTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        }
    }
}

# Export to CSV
$Results | Export-Csv -Path $OutputFile -NoTypeInformation

Write-Host "Report generated: $OutputFile"
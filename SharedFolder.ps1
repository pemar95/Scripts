# Discover open network shares on the localhost
$openShares = Get-WmiObject -Class Win32_Share | Where-Object { $_.Type -eq 0 }

# Display information about open network shares
if ($openShares.Count -eq 0) {
    Write-Host "No open network shares found on the localhost."
} else {
    Write-Host "Open network shares on the localhost:"
    $openShares | ForEach-Object {
        Write-Host "Share Name: $($_.Name)"
        Write-Host "Path: $($_.Path)"
        Write-Host "Description: $($_.Description)"
        Write-Host "---------------------------------"
    }
}


$source = Join-Path $PSScriptRoot "Projects"
$backup = Join-Path $PSScriptRoot "Backup"

$dateLimit = (Get-Date).AddDays(-7)

Write-Host "=== MY FILE AUTOMATION ==="

$oldFiles = Get-ChildItem -Path $source -File |
    Where-Object {
        $_.LastWriteTime -lt $dateLimit
    }

if ($oldFiles.Count -gt 0) {
    foreach ($file in $oldFiles) {
        Write-Host "Checking file:" $file.Name

        Copy-Item -Path $file.FullName `
            -Destination $backup `
            -WhatIf
    }
}
else {
    Write-Host "No old files found."
}

Write-Host "Automation test completed."
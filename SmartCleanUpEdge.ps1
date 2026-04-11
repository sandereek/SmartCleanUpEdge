$edgeUserDataPath = Join-Path $env:LOCALAPPDATA "Microsoft\Edge\User Data"
$foldersToDelete = @("Cache", "Code Cache", "GPUCache")

if (-not (Test-Path $edgeUserDataPath)) {
    Write-Host "Pad niet gevonden: $edgeUserDataPath" -ForegroundColor Red
    exit 1
}

Write-Host "Zoeken naar Edge-cachemappen in: $edgeUserDataPath" -ForegroundColor Cyan

$totalFiles = 0
$totalBytes = 0

Get-ChildItem -Path $edgeUserDataPath -Directory -Recurse -Force -ErrorAction SilentlyContinue |
    Where-Object { $foldersToDelete -contains $_.Name } |
    ForEach-Object {
        try {
            $files = Get-ChildItem -Path $_.FullName -File -Recurse -Force -ErrorAction SilentlyContinue
            $folderFileCount = ($files | Measure-Object).Count
            $folderByteSize = ($files | Measure-Object -Property Length -Sum).Sum
            if (-not $folderByteSize) { $folderByteSize = 0 }

            Write-Host "Verwijderen: $($_.FullName)" -ForegroundColor Yellow
            Remove-Item -Path $_.FullName -Recurse -Force -ErrorAction Stop

            $totalFiles += $folderFileCount
            $totalBytes += $folderByteSize
        }
        catch {
            Write-Host "Kon niet verwijderen: $($_.FullName)" -ForegroundColor Red
            Write-Host $_.Exception.Message -ForegroundColor DarkRed
        }
    }

$totalGB = [math]::Round($totalBytes / 1GB, 2)
Write-Host "Klaar. Verwijderd: $totalFiles bestanden ($totalGB GB)." -ForegroundColor Green
# SmartCleanUpEdge.ps1
# Verwijdert Edge-cachemappen voor de huidige gebruiker (in alle profielen) en rapporteert de vrijgemaakte ruimte.
# Uitbreiding 2026-09-08:
#   - "CacheStorage" (onder <profiel>\Service Worker): offline-cache van PWA's zoals Teams, Outlook web en M365.
#     In de praktijk verreweg de grootste veelvraat.
#   - "Snapshots" (direct onder User Data): profielkopieen van oude Edge-versies, bewaard voor rollback.
#   - Controle vooraf of Edge nog draait; anders zijn veel bestanden vergrendeld en blijft de cache half achter.

$edgeUserDataPath = Join-Path $env:LOCALAPPDATA "Microsoft\Edge\User Data"
$foldersToDelete = @("Cache", "Code Cache", "GPUCache", "CacheStorage")
$rootFoldersToDelete = @("Snapshots")

if (-not (Test-Path $edgeUserDataPath)) {
    Write-Host "Pad niet gevonden: $edgeUserDataPath" -ForegroundColor Red
    exit 1
}

if (Get-Process msedge -ErrorAction SilentlyContinue) {
    Write-Host "Microsoft Edge draait nog. Sluit Edge volledig (ook de achtergrondprocessen) en start het script opnieuw." -ForegroundColor Red
    exit 1
}

Write-Host "Zoeken naar Edge-cachemappen in: $edgeUserDataPath" -ForegroundColor Cyan

$totalFiles = 0
$totalBytes = 0

function Remove-CacheFolder($folder) {
    try {
        $files = Get-ChildItem -Path $folder.FullName -File -Recurse -Force -ErrorAction SilentlyContinue
        $folderFileCount = ($files | Measure-Object).Count
        $folderByteSize = ($files | Measure-Object -Property Length -Sum).Sum
        if (-not $folderByteSize) { $folderByteSize = 0 }

        Write-Host "Verwijderen: $($folder.FullName)" -ForegroundColor Yellow
        Remove-Item -Path $folder.FullName -Recurse -Force -ErrorAction Stop

        $script:totalFiles += $folderFileCount
        $script:totalBytes += $folderByteSize
    }
    catch {
        Write-Host "Kon niet verwijderen: $($folder.FullName)" -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor DarkRed
    }
}

# Cachemappen in alle profielen (recursief op naam)
Get-ChildItem -Path $edgeUserDataPath -Directory -Recurse -Force -ErrorAction SilentlyContinue |
    Where-Object { $foldersToDelete -contains $_.Name } |
    ForEach-Object { Remove-CacheFolder $_ }

# Mappen direct onder User Data (bijv. Snapshots van oude Edge-versies)
Get-ChildItem -Path $edgeUserDataPath -Directory -Force -ErrorAction SilentlyContinue |
    Where-Object { $rootFoldersToDelete -contains $_.Name } |
    ForEach-Object { Remove-CacheFolder $_ }

$totalGB = [math]::Round($totalBytes / 1GB, 2)
Write-Host "Klaar. Verwijderd: $totalFiles bestanden ($totalGB GB)." -ForegroundColor Green

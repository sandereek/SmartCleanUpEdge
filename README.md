# SmartCleanUpEdge

A small PowerShell script that clears Microsoft Edge cache folders for the current user and reports how much was removed.

## What it does

The script scans the current user's Edge `User Data` directory and deletes the following folders wherever they appear (including inside every profile):

- `Cache`
- `Code Cache`
- `GPUCache`
- `CacheStorage` (under `Service Worker`; the offline cache of PWAs such as Teams, Outlook web and M365 — in practice by far the largest consumer)

Directly under `User Data` it also removes:

- `Snapshots` (profile copies kept by old Edge versions for rollback)

Profiles themselves, logins, bookmarks, history and extensions are not touched.

When it finishes, it prints the total number of files deleted and the total size in GB.

## Requirements

- Windows with Microsoft Edge installed
- PowerShell 5.1 or newer
- Microsoft Edge must be closed. The script checks for running `msedge` processes and exits if it finds any, because locked files would otherwise leave the cache half-cleaned. Note that Edge may keep background processes alive after the last window is closed (startup boost / background extensions); end those first.

## Usage

From a PowerShell prompt:

```powershell
.\SmartCleanUpEdge.ps1
```

If script execution is blocked by your execution policy, you can run it for the current session only:

```powershell
powershell -ExecutionPolicy Bypass -File .\SmartCleanUpEdge.ps1
```

The script uses the `%LOCALAPPDATA%` environment variable, so it works for any user without modification.

## Example output

```
Zoeken naar Edge-cachemappen in: C:\Users\<user>\AppData\Local\Microsoft\Edge\User Data
Verwijderen: C:\Users\<user>\AppData\Local\Microsoft\Edge\User Data\Default\Cache
Verwijderen: C:\Users\<user>\AppData\Local\Microsoft\Edge\User Data\Default\Code Cache
Verwijderen: C:\Users\<user>\AppData\Local\Microsoft\Edge\User Data\Default\Service Worker\CacheStorage
...
Klaar. Verwijderd: 1234 bestanden (2.47 GB).
```

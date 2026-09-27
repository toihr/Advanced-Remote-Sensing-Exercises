<#
.SYNOPSIS
  Download the large input data of one or more exercises from the GitHub release.

.EXAMPLE
  .\tools\download_data.ps1                                   # all exercises
  .\tools\download_data.ps1 exercises\09-lidar-dtm-chm-forest-stands
#>
param([Parameter(ValueFromRemainingArguments)][string[]]$Exercise)

$ErrorActionPreference = 'Stop'
$ProgressPreference    = 'SilentlyContinue'   # makes Invoke-WebRequest much faster
$Repo    = 'toihr/Advanced-Remote-Sensing-Exercises'
$Release = 'data-v1.0'
$BaseUrl = "https://github.com/$Repo/releases/download/$Release"
$Root    = Split-Path $PSScriptRoot -Parent

function Get-Md5([string]$Path) { (Get-FileHash $Path -Algorithm MD5).Hash.ToLower() }

function Get-ExerciseData([string]$Dir) {
    $manifest = Join-Path $Dir 'data-manifest.csv'
    if (-not (Test-Path $manifest)) { Write-Host "No manifest in $Dir - skipping"; return }
    Write-Host "== $(Split-Path $Dir -Leaf)"

    foreach ($row in Import-Csv $manifest) {
        $target = Join-Path $Dir $row.path
        if ($row.asset -like '*.zip') {
            $marker = Join-Path $target ".$($row.asset).extracted"
            if (Test-Path $marker) { Write-Host "[skip] $($row.path)/$($row.asset) (already extracted)"; continue }
            $tmp = Join-Path ([IO.Path]::GetTempPath()) $row.asset
            Write-Host "[get ] $($row.asset) -> $($row.path)/"
            Invoke-WebRequest "$BaseUrl/$($row.asset)" -OutFile $tmp
            if ((Get-Md5 $tmp) -ne $row.md5) { throw "Checksum mismatch: $($row.asset)" }
            New-Item -ItemType Directory -Force $target | Out-Null
            Expand-Archive $tmp -DestinationPath $target -Force
            Remove-Item $tmp
            New-Item -ItemType File $marker | Out-Null
        } else {
            if ((Test-Path $target) -and ((Get-Md5 $target) -eq $row.md5)) {
                Write-Host "[skip] $($row.path) (already present)"; continue
            }
            New-Item -ItemType Directory -Force (Split-Path $target -Parent) | Out-Null
            Write-Host "[get ] $($row.asset) -> $($row.path)"
            Invoke-WebRequest "$BaseUrl/$($row.asset)" -OutFile $target
            if ((Get-Md5 $target) -ne $row.md5) { throw "Checksum mismatch: $($row.asset)" }
        }
    }
}

if (-not $Exercise) { $Exercise = Get-ChildItem (Join-Path $Root 'exercises') -Directory | ForEach-Object FullName }
foreach ($d in $Exercise) { Get-ExerciseData (Resolve-Path $d).Path }

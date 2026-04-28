param(
    [Parameter(Mandatory=$true)]
    [string]$AosBrainPath,

    [string]$RepoBrainPath = (Join-Path (Get-Location) "aos_brain"),

    [switch]$NoCommit
)

$ErrorActionPreference = "Stop"

if (!(Test-Path $AosBrainPath)) {
    throw "AOS brain path not found: $AosBrainPath"
}

if (!(Test-Path $RepoBrainPath)) {
    New-Item -ItemType Directory -Path $RepoBrainPath | Out-Null
}

$includeFolders = @(
    "00_decisions",
    "02_agent_configs",
    "03_seed_memories",
    "04_exports",
    "06_tests"
)

$excludePatterns = @(
    "*.db",
    "*.sqlite",
    "*.sqlite3",
    "*.log",
    "*.tmp",
    ".env",
    "*.key",
    "*.pem",
    "*.pfx",
    "*.zip",
    "node_modules",
    ".venv",
    "__pycache__",
    ".git"
)

Write-Host "Syncing AOS Brain from OneDrive to GitHub mirror"
Write-Host "Source: $AosBrainPath"
Write-Host "Target: $RepoBrainPath"

foreach ($folder in $includeFolders) {
    $src = Join-Path $AosBrainPath $folder
    $dst = Join-Path $RepoBrainPath $folder

    if (Test-Path $src) {
        if (!(Test-Path $dst)) {
            New-Item -ItemType Directory -Path $dst | Out-Null
        }

        robocopy $src $dst /E /NFL /NDL /NJH /NJS /NP /XD node_modules .venv __pycache__ .git /XF *.db *.sqlite *.sqlite3 *.log *.tmp .env *.key *.pem *.pfx *.zip | Out-Null
        if ($LASTEXITCODE -le 7) {
            $global:LASTEXITCODE = 0
        } else {
            throw "Robocopy failed for $folder with exit code $LASTEXITCODE"
        }
    } else {
        Write-Host "Skipping missing folder: $src"
    }
}

$readmeSrc = Join-Path $AosBrainPath "README.md"
if (Test-Path $readmeSrc) {
    Copy-Item $readmeSrc (Join-Path $RepoBrainPath "README.onedrive.md") -Force
}

Write-Host "Sync complete. Review changes with: git status"

if (!$NoCommit) {
    git status --short
    Write-Host "To commit: git add aos_brain; git commit -m 'Sync AOS brain from OneDrive'; git push"
}

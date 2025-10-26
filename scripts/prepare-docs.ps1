param(
    [switch]$Clean
)

$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Resolve-Path (Join-Path $root '..')
$docsDir = Join-Path $repoRoot 'docs'

if (Test-Path $docsDir) {
    if ($Clean) {
        Write-Host "Cleaning docs directory: $docsDir"
        Remove-Item -Recurse -Force $docsDir
    }
}

if (!(Test-Path $docsDir)) {
    New-Item -ItemType Directory -Path $docsDir | Out-Null
}

# Copy top-level pages referenced by nav
Copy-Item -Path (Join-Path $repoRoot 'README.md') -Destination (Join-Path $docsDir 'README.md') -Force
Copy-Item -Path (Join-Path $repoRoot 'CHANGELOG.md') -Destination (Join-Path $docsDir 'CHANGELOG.md') -Force

# Copy content directories used by nav
$includeDirs = @('learning', 'prompts', 'styles')
foreach ($dir in $includeDirs) {
    $src = Join-Path $repoRoot $dir
    if (Test-Path $src) {
        $dst = Join-Path $docsDir $dir
        if (Test-Path $dst) {
            Write-Host "Removing existing directory: $dst"
            Remove-Item -Recurse -Force $dst
        }
        Write-Host "Copying $src -> $dst"
        Copy-Item -Path $src -Destination $dst -Recurse -Force
    }
}

Write-Host "Prepared docs in: $docsDir"

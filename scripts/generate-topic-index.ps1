param(
    [string]$Root = (Join-Path (Get-Location).Path 'docs'),
    [string[]]$ScanDirs = @('learning','prompts'),
    # Path to output file relative to $Root
    [string]$OutFile = 'learning/topics.md'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Unquote {
    param([string]$s)
    if ([string]::IsNullOrEmpty($s)) { return $s }
    $t = $s
    if ($t.StartsWith('"') -and $t.EndsWith('"')) { $t = $t.Substring(1, $t.Length-2) }
    if ($t.StartsWith("'") -and $t.EndsWith("'")) { $t = $t.Substring(1, $t.Length-2) }
    return $t
}

function Parse-FrontMatter {
    param([string]$Content)
    # Match YAML front matter at the top of file
    $m = [regex]::Match($Content, '^---\s*(.*?)\s*---',
        [System.Text.RegularExpressions.RegexOptions]::Singleline)
    if (-not $m.Success) { return @{} }

    $yaml = $m.Groups[1].Value
    $fm = @{}
    $lines = $yaml -split "`n"
    foreach ($raw in $lines) {
        $line = $raw.Trim()
        if ($line -eq '' -or $line.StartsWith('#')) { continue }
        $kv = [regex]::Match($line, '^(?<k>[A-Za-z0-9_-]+)\s*:\s*(?<v>.*)$')
        if (-not $kv.Success) { continue }
        $k = $kv.Groups['k'].Value
        $v = $kv.Groups['v'].Value.Trim()

        if ($k -eq 'topics') {
            if ($v.StartsWith('[') -and $v.EndsWith(']')) {
                $items = $v.Trim('[',']') -split ',' | ForEach-Object { Unquote ($_.Trim()) } | Where-Object { $_ -ne '' }
                $fm['topics'] = @($items)
            }
            continue
        }
        if ($k -in @('title','summary','type','level','updated')) {
            $fm[$k] = Unquote $v
        }
    }
    return $fm
}

function Get-RelativePathUnix {
    param([string]$FullPath, [string]$BasePath)
    $uriFile = New-Object System.Uri($FullPath)
    $uriBase = New-Object System.Uri((Resolve-Path $BasePath).Path + [IO.Path]::DirectorySeparatorChar)
    $rel = $uriBase.MakeRelativeUri($uriFile).ToString()
    # Convert backslashes to forward slashes for markdown links
    return ($rel -replace '%20',' ')
}

# Collect markdown files
$rootPath = Resolve-Path $Root
${outDir} = Join-Path $rootPath (Split-Path -Parent $OutFile)
$files = @()
foreach ($d in $ScanDirs) {
    $p = Join-Path $rootPath $d
    if (Test-Path $p) {
        $files += Get-ChildItem -Path $p -Recurse -File -Filter '*.md'
    }
}

$topicsMap = @{}
foreach ($f in $files) {
    $content = Get-Content -Raw -Path $f.FullName
    $fm = Parse-FrontMatter -Content $content
    if (-not $fm.ContainsKey('topics')) { continue }
    $title = if ($fm.ContainsKey('title')) { $fm['title'] } else { [IO.Path]::GetFileNameWithoutExtension($f.Name) }
    $summary = if ($fm.ContainsKey('summary')) { $fm['summary'] } else { '' }
    $type = if ($fm.ContainsKey('type')) { $fm['type'] } else { '' }
    $level = if ($fm.ContainsKey('level')) { $fm['level'] } else { '' }
    # Build links relative to the directory of the output file to avoid duplicated path segments
    $rel = Get-RelativePathUnix -FullPath $f.FullName -BasePath ${outDir}

    foreach ($t in $fm['topics']) {
        if (-not $topicsMap.ContainsKey($t)) { $topicsMap[$t] = @() }
        $topicsMap[$t] += [pscustomobject]@{
            Title = $title
            Summary = $summary
            Type = $type
            Level = $level
            Path = $rel
        }
    }
}

if ($topicsMap.Keys.Count -eq 0) {
    Write-Warning 'No topics found in scanned files.'
}

# Sort helper for type priority
$typeOrder = @('roadmap','reading-list','cheatsheet','note','paper-notes','course-notes')
function Get-TypeRank([string]$t) {
    $idx = [array]::IndexOf($typeOrder, $t)
    if ($idx -ge 0) { return $idx }
    return 999
}

$generatedOn = (Get-Date).ToString('yyyy-MM-dd HH:mm K')
$lines = @()
$lines += '# Topics Index (auto-generated)'
$lines += ''
$lines += "Generated: $generatedOn"
$lines += ''
$lines += 'Do not edit by hand; run ./scripts/generate-topic-index.ps1.'

foreach ($topic in ($topicsMap.Keys | Sort-Object)) {
    $lines += ''
    $lines += "## $topic"
    $lines += ''
    $items = $topicsMap[$topic] | Sort-Object @{Expression={ Get-TypeRank $_.Type }}, @{Expression={$_.Title}}, @{Expression={$_.Path}}
    foreach ($it in $items) {
        $meta = @()
        if ($it.Type) { $meta += $it.Type }
        if ($it.Level) { $meta += $it.Level }
        $metaStr = if ($meta.Count) { ' - ' + ($meta -join ', ') } else { '' }
        $summaryStr = if ($it.Summary) { ' - ' + $it.Summary } else { '' }
        $lines += "- [$($it.Title)]($($it.Path))$metaStr$summaryStr"
    }
}

$outPath = Join-Path $rootPath $OutFile
New-Item -ItemType Directory -Force -Path (Split-Path $outPath) | Out-Null
Set-Content -Path $outPath -Value ($lines -join [Environment]::NewLine)
Write-Host "Wrote topic index -> $OutFile"

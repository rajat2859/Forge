param(
    [switch]$Force
)

$ErrorActionPreference = "Stop"

$forgeRepositoryArchive = "https://github.com/rajat2859/Forge/archive/refs/heads/main.zip"
$temporaryRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("forge-" + [guid]::NewGuid().ToString("N"))
$archivePath = Join-Path $temporaryRoot "forge.zip"
$extractPath = Join-Path $temporaryRoot "source"
$userHome = [Environment]::GetFolderPath("UserProfile")

function Test-CommandAvailable {
    param([string]$CommandName)

    return $null -ne (Get-Command $CommandName -ErrorAction SilentlyContinue)
}

function Add-AgentTarget {
    param(
        [System.Collections.ArrayList]$Targets,
        [string]$Name,
        [string]$Path,
        [string]$Invocation
    )

    [void]$Targets.Add([pscustomobject]@{
        Name = $Name
        Path = $Path
        Invocation = $Invocation
    })
}

function Install-ForgeSkill {
    param(
        [string]$SourceRoot,
        [string]$TargetPath
    )

    $targetParent = Split-Path -Parent $TargetPath
    $stagingPath = "$TargetPath.staging-$([guid]::NewGuid().ToString("N"))"
    $backupPath = $null

    New-Item -ItemType Directory -Path $targetParent -Force | Out-Null
    New-Item -ItemType Directory -Path $stagingPath -Force | Out-Null

    Copy-Item -Path (Join-Path $SourceRoot "SKILL.md") -Destination (Join-Path $stagingPath "SKILL.md")
    Copy-Item -Path (Join-Path $SourceRoot "rules") -Destination (Join-Path $stagingPath "rules") -Recurse
    Copy-Item -Path (Join-Path $SourceRoot "VERSION") -Destination (Join-Path $stagingPath "VERSION")

    if (Test-Path $TargetPath) {
        $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
        $backupPath = "$TargetPath.backup-$timestamp"
        Move-Item -Path $TargetPath -Destination $backupPath
    }

    try {
        Move-Item -Path $stagingPath -Destination $TargetPath
    }
    catch {
        if ($backupPath -and (Test-Path $backupPath) -and -not (Test-Path $TargetPath)) {
            Move-Item -Path $backupPath -Destination $TargetPath
        }

        throw
    }

    return $backupPath
}

$targets = [System.Collections.ArrayList]::new()

if (Test-CommandAvailable "claude") {
    Add-AgentTarget -Targets $targets -Name "Claude Code" -Path (Join-Path $userHome ".claude\skills\forge") -Invocation "/forge"
}

if (Test-CommandAvailable "agy") {
    Add-AgentTarget -Targets $targets -Name "Antigravity CLI" -Path (Join-Path $userHome ".gemini\antigravity-cli\skills\forge") -Invocation "/forge"
}

if (Test-CommandAvailable "codex") {
    $codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $userHome ".codex" }
    Add-AgentTarget -Targets $targets -Name "Codex" -Path (Join-Path $codexHome "skills\forge") -Invocation '$forge'
}

if (Test-CommandAvailable "opencode") {
    Add-AgentTarget -Targets $targets -Name "OpenCode" -Path (Join-Path $userHome ".config\opencode\skills\forge") -Invocation "/forge"
}

if ($targets.Count -eq 0) {
    Write-Host ""
    Write-Host "Forge did not detect a supported coding-agent CLI in PATH."
    Write-Host "Supported targets: claude, agy, codex, opencode."
    Write-Host "Install or expose the desired CLI in PATH, then run this installer again."
    exit 1
}

Write-Host ""
Write-Host "Forge installer"
Write-Host ""
Write-Host "Detected:"
foreach ($target in $targets) {
    Write-Host "  - $($target.Name)"
}

try {
    New-Item -ItemType Directory -Path $temporaryRoot -Force | Out-Null
    New-Item -ItemType Directory -Path $extractPath -Force | Out-Null

    Invoke-WebRequest -Uri $forgeRepositoryArchive -OutFile $archivePath
    Expand-Archive -Path $archivePath -DestinationPath $extractPath -Force

    $sourceRoot = Join-Path $extractPath "Forge-main"

    if (-not (Test-Path (Join-Path $sourceRoot "SKILL.md"))) {
        throw "Downloaded Forge package does not contain SKILL.md."
    }

    $forgeVersion = (Get-Content (Join-Path $sourceRoot "VERSION") -Raw).Trim()

    Write-Host ""
    Write-Host "Installing Forge $forgeVersion..."

    foreach ($target in $targets) {
        $backupPath = Install-ForgeSkill -SourceRoot $sourceRoot -TargetPath $target.Path
        Write-Host "  [OK] $($target.Name) -> $($target.Path)"

        if ($backupPath) {
            Write-Host "       Previous Forge installation backed up to $backupPath"
        }
    }

    Write-Host ""
    Write-Host "Forge $forgeVersion installed."
    Write-Host "Restart any open coding-agent sessions so they rediscover the skill."
    Write-Host ""
    Write-Host "Invoke Forge with:"

    foreach ($target in $targets) {
        Write-Host "  $($target.Name): $($target.Invocation)"
    }
}
finally {
    if (Test-Path $temporaryRoot) {
        Remove-Item -Path $temporaryRoot -Recurse -Force -ErrorAction SilentlyContinue
    }
}

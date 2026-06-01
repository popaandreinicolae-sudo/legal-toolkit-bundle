# Install script PowerShell pentru Legal Toolkit Bundle
# Autor: Andrei Nicolae Popa, jurist constitutionalist
# Versiune: 1.0.0
# Compatibil: Windows 10/11 cu Claude Desktop si optional Claude Code

param(
    [switch]$SkipClaudeCode,
    [switch]$SkipClaudeDesktop,
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$BundleRoot = $PSScriptRoot

Write-Host "Legal Toolkit Bundle Installer" -ForegroundColor Cyan
Write-Host "Sursa: $BundleRoot" -ForegroundColor Gray
Write-Host ""

# Detectare instalari Claude
$claudeCodeDir = "$env:USERPROFILE\.claude"
$claudeDesktopConfig = "$env:APPDATA\Claude\claude_desktop_config.json"
$hasClaudeCode = Test-Path $claudeCodeDir
$hasClaudeDesktop = Test-Path $claudeDesktopConfig

Write-Host "Claude Code detectat: $hasClaudeCode ($claudeCodeDir)" -ForegroundColor Yellow
Write-Host "Claude Desktop detectat: $hasClaudeDesktop ($claudeDesktopConfig)" -ForegroundColor Yellow
Write-Host ""

if (-not $hasClaudeCode -and -not $hasClaudeDesktop) {
    Write-Host "ERROR: Nu am detectat nici Claude Code nici Claude Desktop. Verifica instalarile." -ForegroundColor Red
    exit 1
}

# Verificare Python
try {
    $pythonVersion = & python --version 2>&1
    Write-Host "Python detectat: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Python nu este instalat. Instaleaza Python 3.10+ inainte." -ForegroundColor Red
    exit 1
}

# Verificare python-docx
try {
    & python -c "import docx" 2>&1 | Out-Null
    Write-Host "python-docx detectat: OK" -ForegroundColor Green
} catch {
    Write-Host "Instalez python-docx..." -ForegroundColor Yellow
    & pip install python-docx --quiet
}

Write-Host ""

if (-not $SkipClaudeCode -and $hasClaudeCode) {
    Write-Host "=== Instalare in Claude Code ($claudeCodeDir) ===" -ForegroundColor Cyan

    $targets = @{
        "$BundleRoot\skills" = "$claudeCodeDir\skills"
        "$BundleRoot\agents" = "$claudeCodeDir\agents"
        "$BundleRoot\scripts" = "$claudeCodeDir\scripts"
        "$BundleRoot\cowork-templates" = "$claudeCodeDir\cowork-templates"
    }

    foreach ($src in $targets.Keys) {
        $dst = $targets[$src]
        if (-not (Test-Path $dst)) {
            New-Item -ItemType Directory -Path $dst -Force | Out-Null
        }
        Write-Host "  $src" -ForegroundColor Gray
        Write-Host "    -> $dst" -ForegroundColor Gray
        if (-not $DryRun) {
            Copy-Item -Path "$src\*" -Destination $dst -Recurse -Force
        }
    }

    Write-Host ""
    Write-Host "ATENTIE Claude Code: pentru hook-uri active, adauga in settings.json sectiunea:" -ForegroundColor Yellow
    Write-Host @'
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit|MultiEdit",
        "hooks": [
          { "type": "command", "command": "python \"%USERPROFILE%\\.claude\\scripts\\ai_tone_hook.py\"", "timeout": 25 },
          { "type": "command", "command": "python \"%USERPROFILE%\\.claude\\scripts\\fact_check_hook.py\"", "timeout": 25 }
        ]
      }
    ],
    "UserPromptSubmit": [
      {
        "matcher": ".*",
        "hooks": [
          { "type": "command", "command": "python \"%USERPROFILE%\\.claude\\scripts\\prompt_injection_hook.py\"", "timeout": 5 }
        ]
      }
    ]
  }
'@ -ForegroundColor Gray

    Write-Host ""
}

if (-not $SkipClaudeDesktop -and $hasClaudeDesktop) {
    Write-Host "=== Instalare MCP anti-ai-tone in Claude Desktop ===" -ForegroundColor Cyan

    $mcpFile = "$BundleRoot\mcp-servers\anti-ai-tone-v1.1.0.mcpb"
    if (Test-Path $mcpFile) {
        Write-Host "Fisier MCPB gasit: $mcpFile" -ForegroundColor Green
        Write-Host ""
        Write-Host "INSTALARE MANUALA Claude Desktop:" -ForegroundColor Yellow
        Write-Host "1. Deschide Claude Desktop"
        Write-Host "2. Settings -> Extensions -> Browse"
        Write-Host "3. Sau dublu-click pe: $mcpFile"
        Write-Host "4. Claude Desktop te ghideaza la confirmare install"
        Write-Host ""

        if (-not $DryRun) {
            $copyTarget = "$env:USERPROFILE\Downloads\anti-ai-tone-v1.1.0.mcpb"
            Copy-Item -Path $mcpFile -Destination $copyTarget -Force
            Write-Host "Fisier MCPB copiat la: $copyTarget" -ForegroundColor Green
            Write-Host "Dublu-click pe el ca sa-l instalezi in Claude Desktop." -ForegroundColor Green
        }
    } else {
        Write-Host "WARNING: Fisier MCPB nu exista la $mcpFile" -ForegroundColor Yellow
    }

    Write-Host ""
}

Write-Host "=== Pasi manuali in Claude Cowork ===" -ForegroundColor Cyan
Write-Host "1. Deschide Claude.ai -> Settings -> Profile"
Write-Host "2. Copy-paste continutul: $BundleRoot\cowork-templates\PROJECT_INSTRUCTIONS_UNIVERSAL.md"
Write-Host "3. Pentru fiecare Project juridic sau energetic, aplica template-ul specific."
Write-Host "4. Activeaza Citations API in Beta features."
Write-Host ""

Write-Host "=== Instalare completa ===" -ForegroundColor Green
Write-Host "Componente instalate:"
Write-Host "  - 10 skill-uri (anti-ai-tone, anti-hallucination, juridice)"
Write-Host "  - 4 subagenti (reviewer plus fact-checker)"
Write-Host "  - 5 scripts Python (detection, hooks)"
Write-Host "  - 1 MCP server anti-ai-tone (pentru Desktop si Code)"
Write-Host "  - 4 templates Cowork (universal, energetic, juridic, README)"
Write-Host ""
Write-Host "Pentru intrebari sau bug-uri, contact: popa.andrei.nicolae@gmail.com" -ForegroundColor Gray

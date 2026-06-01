# Legal Toolkit Bundle, Andrei Nicolae Popa

Setup complet anti-AI tone plus anti-halucinare pentru juristi, doctoranzi, consilieri juridici care lucreaza cu Claude AI Desktop, Claude Cowork si Claude Code.

Construit pe baza analizei halucinatiilor reale documentate in rapoarte profesionale generate prin LLM. Versiune 1.0.0, iunie 2026.

## Ce contine bundle-ul

10 skill-uri (anti-AI tone v2.1, anti-hallucination universal plus energetic, juridice doctorale), 4 subagenti specializati (reviewer plus fact-checker), 5 scripts Python (detection, hooks, comparare versiuni), 1 MCP server cu 7 tools (instalabil single-click in Claude Desktop), 4 templates Project Instructions pentru Cowork.

## Cerinte sistem

- Sistem de operare: Windows 10/11, macOS 12 plus, sau Linux modern
- Python 3.10 plus (sau 3.12 plus recomandat)
- Claude Desktop instalat (pentru MCP single-click)
- Claude Code instalat optional (pentru skill-uri auto-aplicate)
- Microsoft Office cu Word (optional, pentru integrare Claude for Word)
- Abonament Claude Pro, Max, Team sau Enterprise

## Instalare rapida pe Windows

Deschide PowerShell ca utilizator (NU administrator), navigheaza in folderul bundle, ruleaza:

```powershell
cd "calea\catre\legal-toolkit-bundle"
.\INSTALL.ps1
```

Scriptul detecteaza Claude Code si Claude Desktop, copiaza componentele in locatiile corecte, raporteaza ce mai trebuie configurat manual.

## Instalare rapida pe macOS sau Linux

```bash
cd /calea/catre/legal-toolkit-bundle
chmod +x INSTALL.sh
./INSTALL.sh
```

## Structura bundle

```
legal-toolkit-bundle/
├── INSTALL.ps1                  Script instalare Windows
├── INSTALL.sh                   Script instalare macOS/Linux
├── README.md                    Acest fisier
├── LICENSE                      MIT
├── skills/                      10 skill-uri auto-aplicate
├── agents/                      4 subagenti read-only
├── scripts/                     5 scripts Python (hooks, detection)
├── mcp-servers/                 MCP server anti-ai-tone plus pachet MCPB
└── cowork-templates/            Templates Project Instructions Cowork
```

## Componente principale

### Skill-uri (in skills/)

- anti-ai-tone.md, v2.1, 25 reguli, lista neagra 200 plus termeni RO si EN
- anti-hallucination-document, 12 reguli pozitive pentru orice document factual
- anti-hallucination-energetic, 10 reguli sectoriale energie cu cifre baseline
- analiza-juridica-critica, analiza doctorala constitutional
- zero-hallucination-citations, citarea bibliografica corecta
- zero-legal-hallucination, protocol verificare prin MCP juridice
- anti-hallucination-factuala, date, cifre, denumiri institutionale
- verificare-legislatie, validare acte normative in vigoare
- format-bibliografie-doctorat-ub, format citare UB Drept
- mcp-fallback-strategy, decision tree cand MCP-urile esueaza

### Subagenti (in agents/)

- anti-ai-tone-reviewer, audit stilistic read-only
- juridic-style-reviewer, audit terminologie plus format UB Drept
- fact-checker-document, fact-check universal cu raport structurat
- fact-checker-energetic, fact-check sectorial cu cifre baseline plus coduri SIDU

### Scripts (in scripts/)

- detect_ai_tone.py, detection 25 plus pattern-uri AI tone in text
- ai_tone_hook.py, PostToolUse hook care ruleaza detect automat la Write
- fact_check_hook.py, PostToolUse hook pentru detectie halucinari documente
- prompt_injection_hook.py, UserPromptSubmit injectare reminder anti-AI tone
- session_end_hook.py, Stop hook pentru audit final sesiune

### MCP Server (in mcp-servers/)

- anti-ai-tone-server.py, server Python care expune 7 tools
- anti-ai-tone-v1.1.0.mcpb, pachet single-click pentru Claude Desktop

### Templates Cowork (in cowork-templates/)

- PROJECT_INSTRUCTIONS_UNIVERSAL.md, pentru orice document factual
- PROJECT_INSTRUCTIONS_ENERGETIC.md, sector energetic specific
- PROJECT_INSTRUCTIONS_JURIDIC_DOCTORAT.md, cercetare doctorala UB Drept
- README_UTILIZARE.md, ghid utilizare cu scenarii concrete

## Configurare suplimentara

### Pentru Claude Code, configurare hooks

Dupa instalare, editeaza `~/.claude/settings.json` si adauga:

```json
{
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
    ],
    "Stop": [
      {
        "matcher": ".*",
        "hooks": [
          { "type": "command", "command": "python \"%USERPROFILE%\\.claude\\scripts\\session_end_hook.py\"", "timeout": 60 }
        ]
      }
    ]
  }
}
```

### Pentru Claude Desktop, MCP install

Dublu-click pe `mcp-servers/anti-ai-tone-v1.1.0.mcpb` deschide Claude Desktop si te ghideaza prin instalare. Single-click confirma. Restart Desktop.

### Pentru Claude Cowork, Project Instructions

1. Deschide Claude.ai, Cowork, Projects, sau creeaza Project nou
2. Settings, Custom Instructions
3. Copy-paste continutul template-ului relevant din cowork-templates/
4. Activeaza Citations API in Beta features
5. Upload PDF-urile primare in Project Knowledge

## Verificare ca totul functioneaza

In Claude Code, ruleaza:

```bash
python "%USERPROFILE%\.claude\scripts\detect_ai_tone.py" "calea_catre_fisier.md" --json
```

Rezultat asteptat: JSON cu scor naturalete plus lista probleme.

In Claude Desktop, in chat nou:

```
Foloseste tool-ul mcp__anti-ai-tone__check_ai_tone pe acest text:
"In contextul actual al transformarii digitale, securitatea cibernetica
reprezinta un pilon fundamental al statului de drept."
```

Rezultat asteptat: scor sub 70 plus lista probleme (em-dash apozitional, copula avoidance, truism deschidere).

## Suport plus contact

Pentru intrebari, bug-uri, sugestii:

- Email: popa.andrei.nicolae@gmail.com
- Profil academic: https://unibuc.academia.edu/PopaAndreiNicolae
- LinkedIn: https://www.linkedin.com/in/andrei-nicolae-popa-623aa8128

## Surse care au informat acest sistem

Construit pe baza sintezei a 15 surse internationale 2024-2026 privind detectia textului AI plus halucinatii LLM, plus normele lingvistice oficiale ale limbii romane (DOOM 3, Gramatica Academiei Romane), plus standardele Scolii Doctorale Facultatea de Drept Universitatea din Bucuresti pentru format citare juridica.

Lista completa surse in: skills/anti-ai-tone.md (sectiunea SURSE SINTETIZATE).

## Licenta

MIT, copiere libera cu pastrare atribuire.

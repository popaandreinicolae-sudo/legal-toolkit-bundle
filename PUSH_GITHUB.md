# Instructiuni Push GitHub pentru legal-toolkit-bundle

Repo-ul este pregatit local cu 3 commits curatе. Pentru a-l publica pe GitHub, ai 2 optiuni.

## Optiunea 1, recomandata, gh CLI

Pasul 1, autentificare gh CLI (o singura data):

```bash
gh auth login
```

Selectezi GitHub.com, HTTPS, autentifici prin browser. Dureaza 1-2 minute.

Pasul 2, creare repo plus push:

```bash
cd "C:/Users/Adrian Vasilescu/legal-toolkit-bundle"

gh repo create popa-andrei-nicolae/legal-toolkit-bundle \
  --public \
  --description "Anti-AI tone plus anti-halucinare pentru juristi si doctoranzi. Sistem complet Claude Desktop plus Code plus Cowork." \
  --source . \
  --remote origin \
  --push
```

Ultima linie `--push` ataseaza repo-ul local plus face push primul.

Pasul 3, verificare:

```bash
gh repo view popa-andrei-nicolae/legal-toolkit-bundle --web
```

Deschide browser-ul cu repo-ul publicat.

## Optiunea 2, manual prin GitHub Web Interface

Pasul 1, mergi la https://github.com/new

Pasul 2, completezi:
- Repository name: legal-toolkit-bundle
- Description: Anti-AI tone plus anti-halucinare pentru juristi si doctoranzi
- Public sau Private (recomandare Public pentru contribuții comunitate)
- NU bifa "Add README", "Add .gitignore", "Add license" (le avem deja)

Pasul 3, Create Repository.

Pasul 4, in terminal:

```bash
cd "C:/Users/Adrian Vasilescu/legal-toolkit-bundle"
git remote add origin https://github.com/popa-andrei-nicolae/legal-toolkit-bundle.git
git push -u origin main
```

GitHub iti cere user plus token (foloseste Personal Access Token din Settings, Developer, Tokens).

## Optiunea 3, gh CLI dar repo deja existent

Daca ai creat repo manual la pasul 2, apoi:

```bash
gh auth login
gh repo set-default popa-andrei-nicolae/legal-toolkit-bundle
git remote add origin https://github.com/popa-andrei-nicolae/legal-toolkit-bundle.git
git push -u origin main
```

## Activare GitHub Actions

Dupa push, mergi la repo, Settings, Actions, General. Selecteaza "Allow all actions and reusable workflows".

Workflows existente:
- `.github/workflows/ccr-watcher.yml` (zilnic 8 AM UTC)
- `.github/workflows/mof-watcher.yml` (zilnic 9 AM UTC)
- `.github/workflows/hudoc-watcher.yml` (saptamanal luni 10 AM UTC)

## Adaugare secrets pentru Managed Agents

In repo, Settings, Secrets and variables, Actions, New repository secret:

- Nume: ANTHROPIC_API_KEY
- Valoare: cheia ta Anthropic API (din https://console.anthropic.com/settings/keys)

Cu acest secret, workflows incep sa ruleze automat conform schedule cron.

## Publicare release v1.1.0

```bash
gh release create v1.1.0 \
  --title "v1.1.0, Skills custom romanesti plus GitHub Actions" \
  --notes-file CHANGELOG.md \
  "C:/Users/Adrian Vasilescu/Downloads/legal-toolkit-bundle-v1.1.0.zip" \
  "C:/Users/Adrian Vasilescu/Downloads/anti-ai-tone-v1.1.0.mcpb"
```

Release-ul include ZIP-ul complet plus pachetul MCPB single-click pentru distributie.

## Backup repo

Inainte de push, fa backup local al folderului:

```bash
cp -r "C:/Users/Adrian Vasilescu/legal-toolkit-bundle" "C:/Users/Adrian Vasilescu/Downloads/legal-toolkit-bundle-backup-$(date +%Y%m%d)"
```

## Verificare post-push

1. Vezi repo-ul la https://github.com/popa-andrei-nicolae/legal-toolkit-bundle
2. Verifica ca toate cele 50 fisiere sunt prezente
3. Verifica ca workflows apar la tab Actions
4. Trimite link colegilor doctoranzi pentru a-l clona si testa

## Distributie colegi prin repo public

Colegii instaleaza cu:

```bash
git clone https://github.com/popa-andrei-nicolae/legal-toolkit-bundle
cd legal-toolkit-bundle
./INSTALL.sh    # macOS sau Linux
# sau
.\INSTALL.ps1   # Windows PowerShell
```

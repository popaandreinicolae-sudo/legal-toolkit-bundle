# Email draft pentru Constantin-Alexandru Manda

Subiect propus: Sistem anti-AI tone plus anti-halucinare, pachet pentru test

```
Catre: [adresa email Constantin-Alexandru Manda]
De la: popa.andrei.nicolae@gmail.com
Subiect: Sistem anti-AI tone plus anti-halucinare, pachet single-click pentru Claude Desktop

Salut Alex,

Iti trimit atasat un pachet pe care l-am construit pentru a preveni
halucinatiile plus tonul AI in documentele generate prin Claude AI
Cowork. L-am calibrat dupa analiza halucinatiilor reale din raportul
nostru Bucuresti-Ilfov v11, unde am detectat cifre fabricate (44
angajati PIU, 3 milioane EUR Trust Fund, BCR 3,5), capitole goale
(cap. XI cadrul juridic), scenarii cu indicatori inventati (BAU,
Strategy, Ambitious), plus denumiri institutionale depasite (RADET
in loc de CMTEB).

Atasamentul anti-ai-tone-v1.1.0.mcpb este un pachet single-click
pentru Claude Desktop. Dublu-click pe el, Claude te ghideaza prin
instalare. Expune 7 tools direct in chat:

- check_ai_tone, audit stilistic complet cu scor 0-100
- quick_score, scor rapid de naturalete
- suggest_fixes, lista corectii prioritizate
- check_file, audit pe fisier .md sau .docx
- fact_check_document, detectie halucinari cu raport structurat
- compare_versions, comparativa intre versiuni .docx
- get_skill_rules, returneaza regulile complete v2.1

Cum il testezi rapid:

1. Salveaza atasamentul local.
2. Dublu-click pe fisier in Windows Explorer.
3. Claude Desktop deschide dialog instalare, confirma.
4. Restart Claude Desktop.
5. In chat nou, scrie:
   "Foloseste tool-ul anti-ai-tone fact_check_document pe acest text:
   [paste un paragraf din raportul nostru]"
6. Claude te raporteaza problemele detectate.

Daca esti interesat de tot setup-ul, am facut un bundle complet cu
skill-uri, subagenti, hook-uri plus templates Project Instructions
pentru Cowork. Il pot trimite ca ZIP de 122 kB cu install script
automat pentru Windows.

Sistemul este construit pe baza skill-ului anti-ai-tone v2.1 (sinteza
din 15 surse internationale 2024-2026 plus DOOM 3 pentru limba romana)
plus protocolul anti-halucinare construit pe pattern-urile concrete
din raportul nostru.

Pentru raportul Bucuresti-Ilfov v12 plus rapoarte viitoare la Banca
Mondiala, asta inseamna mai putin timp pierdut pe corectii manuale
post-generare.

Daca testezi si descoperi pattern-uri de halucinare pe care le-am
ratat, da-mi feedback la popa.andrei.nicolae@gmail.com. Il integrez
in versiunea v1.1.0.

Pachetul este open-source MIT. Cand termin de testat, il public pe
GitHub plus l-as putea propune Facultatii de Drept UB pentru a fi
adoptat in cercetarea doctorala juridica.

Cu prietenie,
Andrei Nicolae Popa
Jurist constitutionalist, doctorand Drept Constitutional UB
Consilier juridic Transgaz SA
Membru CA E.ON Romania
```

## Atasamente recomandate

1. `C:\Users\Adrian Vasilescu\Downloads\anti-ai-tone-v1.1.0.mcpb` (8 kB),
   pachet single-click MCP
2. Optional: `C:\Users\Adrian Vasilescu\Downloads\legal-toolkit-bundle-v1.0.0.zip`
   (122 kB), bundle complet

## Cum trimit emailul

Variantă rapidă: deschide Outlook (sau Gmail web), creează email nou,
copy-paste textul de mai sus, atașează fișierul .mcpb din Downloads,
trimite.

Variantă programatică (dacă vrei automatizare):
- Foloseste MCP Gmail dacă este conectat la Cowork
- Sau invoca prin scriptul Python local cu smtplib (necesită config SMTP)

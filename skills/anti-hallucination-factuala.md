---
name: anti-hallucination-factuala
description: >
  Prevents factual hallucinations: dates, numbers, institutional names, statistics.
  Triggers: any factual claim, date, number, percentage, institutional name.
---

# Anti-Hallucination Factuala

## REGULI

1. **Date**: Nu scrie nicio data fara verificare. "Publicata in M.Of. nr. X din data Y" — verifica numarul si data.
2. **Denumiri institutionale**: Foloseste denumirea oficiala completa. Nu prescurta si nu inventa.
   - CORECT: "Directia Nationala de Securitate Cibernetica (DNSC)"
   - GRESIT: "Directoratul de Securitate Cibernetica"
3. **Cifre si statistici**: Orice cifra trebuie sa aiba sursa verificabila.
4. **Prenume autori**: NICIODATA nu ghici prenumele. Verifica prin `scholar_search` sau `WebSearch`.
   - Daca gasesti doar initiala: scrie initiala, nu inventezi prenumele.
5. **Edituri si ani**: Verifica prin `zotero_search_items` sau `WebSearch`.
6. **Numere de pagina**: Daca nu poti confirma pagina, scrie `[pagina neverificata]`.

## CAND NU STII

Scrie explicit `[DE VERIFICAT: ...]` — e preferabil fata de a inventa.

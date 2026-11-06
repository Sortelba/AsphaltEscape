# Asphalt Flucht online stellen

Damit läuft das Spiel auf einer eigenen Website, und alle, die den Link haben, landen in derselben Bestenliste. Beides ist kostenlos.

- **Supabase** speichert die Highscores.
- **GitHub Pages** zeigt die Website an.

## 1. Supabase einrichten (ca. 5 Minuten)

1. Auf <https://supabase.com> mit „Start your project“ anmelden (z. B. mit deinem GitHub-Konto).
2. **New project** anlegen. Name z. B. `asphalt-flucht`, ein Datenbank-Passwort vergeben (gut aufheben, wird für das Spiel nicht gebraucht), Region **Frankfurt (eu-central-1)**.
3. Warten, bis das Projekt bereit ist (1–2 Minuten).
4. Links **SQL Editor** öffnen, den kompletten Inhalt von `supabase-setup.sql` einfügen und auf **Run** klicken. Es sollte „Success“ erscheinen.
5. Oben auf **Connect** klicken (oder links **Project Settings → API Keys**) und diese zwei Werte kopieren:
   - die **Project URL**, z. B. `https://abcdefgh.supabase.co`
   - den **anon public** Key (oder **Publishable key**, beginnt mit `sb_publishable_`)

   Wichtig: **Nicht** den `service_role`- oder `secret`-Key nehmen. Der darf niemals auf eine Website.

6. Die beiden Werte in `index.html` oben im Script eintragen:

   ```js
   const ONLINE = {
     url: "https://abcdefgh.supabase.co",
     key: "dein-anon-oder-publishable-key",
   };
   ```

   Oder schick sie Claude, dann trägt Claude sie ein. Der anon/publishable Key ist dafür gedacht, öffentlich in einer Website zu stehen. Die Tabelle erlaubt damit nur Lesen und neue Einträge.

## 2. Auf GitHub Pages veröffentlichen

1. Auf <https://github.com/new> ein neues Repository anlegen:
   - Name: `AsphaltEscape`
   - **Public**
   - **Kein** README, keine .gitignore, keine Lizenz (ganz leer lassen)
2. Claude lädt die Dateien hoch (oder selbst im Ordner `asphalt-flucht`):

   ```bash
   git init
   git add index.html supabase-setup.sql ANLEITUNG.md
   git commit -m "Asphalt Flucht"
   git branch -M main
   git remote add origin https://github.com/Sortelba/AsphaltEscape.git
   git push -u origin main
   ```

3. Im Repository auf **Settings → Pages**: bei „Source“ **Deploy from a branch** wählen, Branch **main** und Ordner **/(root)**, dann **Save**.
4. Nach 1–2 Minuten ist das Spiel erreichbar unter:
   **<https://sortelba.github.io/AsphaltEscape/>**

Diesen Link kannst du an deine Freunde schicken. Niemand braucht ein Konto.

## Bestenliste verwalten

- Alle Einträge siehst du in Supabase unter **Table Editor → scores**.
- Unpassende Namen oder offensichtlich geschummelte Ergebnisse kannst du dort einfach löschen (Zeile markieren → Delete).
- Die Liste ist nicht schummelsicher: Wer sich auskennt, kann sich einen Fantasie-Highscore eintragen. Für eine Runde unter Freunden reicht das, und du kannst solche Einträge löschen.
- Supabase pausiert kostenlose Projekte, wenn eine Woche lang niemand spielt. Dann im Supabase-Dashboard auf „Restore project“ klicken. Solange die Bestenliste offline ist, zeigt das Spiel die Ergebnisse auf dem jeweiligen Gerät an.

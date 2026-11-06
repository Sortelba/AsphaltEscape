-- Asphalt Flucht: Tabelle für die Online-Bestenliste
-- In Supabase: links "SQL Editor" öffnen, alles hier einfügen und auf "Run" klicken.

create table if not exists public.scores (
  id         bigint generated always as identity primary key,
  name       text        not null check (char_length(name) between 1 and 16),
  score      integer     not null check (score between 0 and 10000000),
  dist       integer     not null default 0 check (dist between 0 and 1000000),
  created_at timestamptz not null default now(),
  -- grobe Plausibilitätsprüfung: viele Punkte ohne Strecke gehen nicht
  constraint score_passt_zur_strecke check (score <= dist * 25 + 5000)
);

create index if not exists scores_score_idx on public.scores (score desc);

-- Zugriff: jeder darf die Liste lesen und neue Ergebnisse eintragen,
-- aber niemand darf fremde Einträge ändern oder löschen.
alter table public.scores enable row level security;

drop policy if exists "Alle duerfen lesen" on public.scores;
create policy "Alle duerfen lesen" on public.scores
  for select to anon, authenticated using (true);

drop policy if exists "Alle duerfen eintragen" on public.scores;
create policy "Alle duerfen eintragen" on public.scores
  for insert to anon, authenticated
  with check (char_length(name) between 1 and 16 and score between 0 and 10000000);

grant select, insert on public.scores to anon, authenticated;

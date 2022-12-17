create type game_status as enum ('pending', 'started', 'complete');

create table games (
  id bigint generated by default as identity primary key,
  channel uuid default uuid_generate_v4() not null,
  status game_status default 'pending' not null,
  host_id uuid references auth.users (id) default auth.uid() not null
);

-- To listen to status updates and start game for all players.
alter publication supabase_realtime add table public.games;

create table players (
  id bigint generated by default as identity primary key,
  player_name text not null,
  score int default 0 not null,
  game_id bigint references games (id) not null,
  user_id uuid references auth.users (id) default auth.uid() not null,
  unique(game_id, user_id)
);

-- To see players joining a game in real-time.
alter publication supabase_realtime add table public.players;

create table questions (
  id bigint generated by default as identity primary key,
  game_id bigint references games (id) not null,
  question text not null,
  correct_answer text not null,
  wrong_answer_1 text not null,
  wrong_answer_2 text not null,
  wrong_answer_3 text not null
);

create table answers (
  id bigint generated by default as identity primary key,
  game_id bigint references games (id) not null,
  question_id bigint references questions (id) not null,
  user_id uuid references auth.users (id) default auth.uid() not null,
  answer text not null,
  answer_time timestamptz default now()
);

-- TODO RLS
-- TODO Delete game/players/questions/answers on completed game
-- TODO Player stats
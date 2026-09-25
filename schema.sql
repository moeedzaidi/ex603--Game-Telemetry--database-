
-- EX 603 Assignment 2 — schema.sql
-- Theme: <Game-Telemetry-Database>
-- Author: <Moeed Zaidi>
-- Target: PostgreSQL 14+
-- Reset. Reverse creation order, so no dependency blocks a drop.



DROP TABLE IF EXISTS match_modes CASCADE;
DROP TABLE IF EXISTS match_participants CASCADE;
DROP TABLE IF EXISTS game_modes CASCADE;
DROP TABLE IF EXISTS matches CASCADE;
DROP TABLE IF EXISTS players CASCADE;

-- 1 of 5: players is created first because other tables reference players as the main player entity.
CREATE TABLE players (
player_id INTEGER GENERATED ALWAYS AS IDENTITY,
display_name VARCHAR(100) NOT NULL,
referred_by INTEGER,

CONSTRAINT pk_players
    PRIMARY KEY (player_id),

CONSTRAINT fk_players_referred_by
    FOREIGN KEY (referred_by)
    REFERENCES players(player_id)
    ON DELETE SET NULL,

CONSTRAINT chk_players_no_self_referral
    CHECK (referred_by IS DISTINCT FROM player_id)

);

-- 2 of 5: matches is created next because participant and mode records depend on individual matches.
CREATE TABLE matches (
match_id INTEGER GENERATED ALWAYS AS IDENTITY,
match_name VARCHAR(100) NOT NULL,
is_active BOOLEAN NOT NULL DEFAULT TRUE,
player_capacity INTEGER NOT NULL,
start_time TIMESTAMP NOT NULL,
end_time TIMESTAMP,

duration_min INTEGER GENERATED ALWAYS AS (
    CASE
        WHEN end_time IS NULL THEN NULL
        ELSE EXTRACT(EPOCH FROM (end_time - start_time))::INTEGER / 60
    END
) STORED,

CONSTRAINT pk_matches
    PRIMARY KEY (match_id),

CONSTRAINT chk_matches_player_capacity
    CHECK (player_capacity > 0),

CONSTRAINT chk_matches_end_after_start
    CHECK (end_time IS NULL OR end_time >= start_time)

);
-- 3 of 5: game_modes is created before match_modes because match_modes references each game mode.
CREATE TABLE game_modes (
game_mode_id INTEGER GENERATED ALWAYS AS IDENTITY,
name VARCHAR(100) NOT NULL,

CONSTRAINT pk_game_modes
    PRIMARY KEY (game_mode_id),

CONSTRAINT uq_game_modes_name
    UNIQUE (name)

);

-- 4 of 5: match_participants is created after players and matches because it links players to their matches.
CREATE TABLE match_participants (
player_id INTEGER NOT NULL,
match_id INTEGER NOT NULL,
participated_at TIMESTAMP NOT NULL,
score INTEGER NOT NULL,

CONSTRAINT pk_match_participants
    PRIMARY KEY (player_id, match_id),

CONSTRAINT fk_match_participants_player
    FOREIGN KEY (player_id)
    REFERENCES players(player_id)
    ON DELETE CASCADE,

CONSTRAINT fk_match_participants_match
    FOREIGN KEY (match_id)
    REFERENCES matches(match_id)
    ON DELETE CASCADE,

CONSTRAINT chk_match_participants_score
    CHECK (score >= 0)

);

-- 5 of 5: match_modes is created last because it connects matches and game modes through foreign keys.
CREATE TABLE match_modes (
match_id INTEGER NOT NULL,
game_mode_id INTEGER NOT NULL,

CONSTRAINT pk_match_modes
    PRIMARY KEY (match_id, game_mode_id),

CONSTRAINT fk_match_modes_match
    FOREIGN KEY (match_id)
    REFERENCES matches(match_id)
    ON DELETE CASCADE,

CONSTRAINT fk_match_modes_game_mode
    FOREIGN KEY (game_mode_id)
    REFERENCES game_modes(game_mode_id)
    ON DELETE RESTRICT

);

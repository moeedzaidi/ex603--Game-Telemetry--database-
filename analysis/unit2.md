# Unit 2 — Schema Design Reasoning

## Constraints and ON DELETE Decisions

The database uses foreign keys to maintain referential integrity between related tables. The `players.referred_by` foreign key is recursive because a player can refer another player. It uses `ON DELETE SET NULL` because deleting the referenced player should not delete the player who made the referral.

The `match_participants` table references both `players` and `matches`. Both foreign keys use `ON DELETE CASCADE` because a participation record is dependent on both a player and a match. If either parent is removed, the participation record no longer represents a valid relationship.

The `match_modes` junction table also uses two foreign keys. The reference to `matches` uses `ON DELETE CASCADE` because a match's mode associations should disappear when the match is deleted. The reference to `game_modes` uses `ON DELETE RESTRICT` because a game mode may be used by many matches. Restricting deletion protects those existing relationships from being removed accidentally.

## CHECK Constraints

The schema uses CHECK constraints to prevent invalid states at the database level. `player_capacity > 0` prevents matches from having zero or negative capacity. The end-time constraint prevents a match from ending before it starts. The score constraint prevents negative scores under the assumed scoring rules. The self-referral constraint prevents a player from referring to themselves.

These rules are enforced in the database rather than only in application code because data may enter through different applications, scripts, or administrative tools. Database-level constraints provide consistent protection regardless of which client writes the data.

## Other Schema Decisions

The `match_participants` table uses a composite primary key consisting of `player_id` and `match_id`. This prevents the same player from having duplicate participation records for the same match and makes the relationship itself part of the row's identity.

The `match_modes` table also uses a composite primary key, `(match_id, game_mode_id)`, because the same match-mode association should not occur more than once.

The `match_participants` relation is dependent on its parent records and can be treated as a weak/dependent entity because its identity is derived from the combination of the player and match identifiers.

The many-to-many relationship between matches and game modes is resolved through `match_modes`. Instead of storing multiple game modes in one field, each match-mode relationship receives its own row.

The `duration_min` attribute is derived from `start_time` and `end_time`. It is implemented as a generated column so the database calculates it rather than requiring application code to keep a manually stored duration synchronized.

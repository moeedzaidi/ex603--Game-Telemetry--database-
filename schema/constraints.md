Integrity Constraints — Game Telemetry
Primary Key Constraints

Each relation has a primary key that uniquely identifies its records.

players.player_id is the primary key of players.
matches.match_id is the primary key of matches.
game_modes.game_mode_id is the primary key of game_modes.
(player_id, match_id) is the composite primary key of match_participants.
(match_id, game_mode_id) is the composite primary key of match_modes.

Primary key values must be unique and cannot be NULL.

Foreign Key Constraints
1. match_participants.player_id

match_participants.player_id references players.player_id.

ON DELETE CASCADE

If a player is deleted, their participation records are also deleted because those records no longer have a valid player associated with them.

2. match_participants.match_id

match_participants.match_id references matches.match_id.

ON DELETE CASCADE

If a match is deleted, its participant records should also be removed because they describe participation in that specific match.

3. match_modes.match_id

match_modes.match_id references matches.match_id.

ON DELETE CASCADE

If a match is deleted, its associated game-mode records in the junction table should also be removed. This prevents orphaned junction records.

4. match_modes.game_mode_id

match_modes.game_mode_id references game_modes.game_mode_id.

ON DELETE RESTRICT

A game mode should not be deleted while matches are still associated with it. Restricting the deletion protects existing match-mode relationships from being removed accidentally.

Additional Integrity Constraints
display_name in players should not be NULL.
match_name in matches should not be NULL.
name in game_modes should not be NULL.
player_capacity should be greater than zero.
score should be non-negative if the game does not support negative scores.
Composite primary keys prevent duplicate player participation records for the same match and duplicate match-mode associations.
Foreign keys prevent records from referencing players, matches, or game modes that do not exist.

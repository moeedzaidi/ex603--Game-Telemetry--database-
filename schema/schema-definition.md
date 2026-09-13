Task 1.1: Define the relation schema


Relation Schema — Game Telemetry
1. Players

Relation: players

Attributes and domains:

Attribute	Domain
player_id	INTEGER
display_name	VARCHAR

Primary Key: player_id


2. Matches

Relation: matches

Attributes and domains:

Attribute	Domain
match_id	INTEGER
match_name	VARCHAR
is_active	BOOLEAN
player_capacity	INTEGER

Primary Key: match_id

player_capacity is the numeric attribute used for filtering.


3. Match Participants

Relation: match_participants

Attributes and domains:

Attribute	Domain
player_id	INTEGER
match_id	INTEGER
participated_at	TIMESTAMP
score	INTEGER

Primary Key: (player_id, match_id)

Foreign Keys:

player_id references players(player_id)
match_id references matches(match_id)

The score attribute is the numeric metric that will be aggregated in later analysis.



4. Game Modes

Relation: game_modes

Attributes and domains:

Attribute	Domain
game_mode_id	INTEGER
name	VARCHAR

Primary Key: game_mode_id



4. Game Modes

Relation: game_modes

Attributes and domains:

Attribute	Domain
game_mode_id	INTEGER
name	VARCHAR

Primary Key: game_mode_id

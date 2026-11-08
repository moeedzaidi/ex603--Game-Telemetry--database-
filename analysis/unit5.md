### Task 5.1 Write-up

**1. What feature or report could use the three-table join?**

A Match Activity Report could use this three-table join.
It would display the player who participated in each match,
the match associated with the participation, and the date
and time when the player joined. This would help platform
administrators investigate player activity and understand
which players were involved in specific matches.

**2. Why is the junction table important?**

The match_modes junction table connects matches with game
modes. A match can have multiple game modes, and a game
mode can be associated with multiple matches. The junction
table stores these relationships using match_id and mode_id.
Without it, connecting matches directly to game_modes would
be difficult because there would be no reliable way to
represent their many-to-many relationship.




### Task 5.2 Write-up

**1. Which producers were excluded by the INNER JOIN?**

The producers excluded by the INNER JOIN are the matches
that do not have any corresponding records in the
match_participants table.

Their match IDs are: 14,15.

The total number of excluded producers is: 75.

**2. What does it mean when a producer has no events?**

It means that a match has no corresponding participation
records in the event table. Possible explanations include
that the match was never started, was scheduled but not
used, or that its event data was not recorded. The data
alone does not tell us the exact reason.

**3. How could an INNER JOIN report give leadership an
incomplete picture?**

An INNER JOIN only displays matches that have matching
event records. It hides matches with no events, so
leadership might incorrectly assume that every producer
has activity.

**4. Why might leadership want to identify producers that
have never been active?**

Leadership may want to investigate whether these matches
were unused, incorrectly configured, or affected by data
collection problems. Identifying them can help improve
platform utilization and data quality.

**5. What action could leadership take?**

Leadership could investigate matches with no events
separately from matches with high failure rates. They
could check scheduling records, configuration, and
event collection before deciding whether to reactivate,
correct, or retire those matches.




### Task 5.3 Write-up

**1. Give an example of when a Cartesian product could be useful.**

A Cartesian product could be useful for creating a
testing matrix that combines every game mode with every
match. This would help administrators review possible
combinations. However, it should only be used when all
combinations are needed because it can generate many
unnecessary rows.

**2. Which join algorithms did PostgreSQL choose?**

[ADD THE JOIN ALGORITHMS FROM YOUR EXECUTION PLAN.]

**3. What information in the execution plan helps explain
those choices?**

The execution plan provides information about estimated
rows, estimated costs, table scans, indexes, and join
operations. These details help explain why PostgreSQL
selected particular join algorithms.

**4. Why is it useful to understand the selected join
algorithms?**

Understanding join algorithms helps developers identify
potential performance problems and make better decisions
about indexes, query structure, and database optimization.

**5. What changes might make another join algorithm more
appropriate?**

Changes in table size, available indexes, data distribution,
and the number of matching records may influence the
optimizer's decision. For example, larger tables or useful
indexes may make a different join strategy more efficient.






### Task 5.4 Reflection: Changes That Could Affect PostgreSQL Join Algorithms

PostgreSQL may choose a different join algorithm when the size of tables, available indexes, or number of matching records changes. For example, our Game Telemetry dataset has relatively small tables, including 30 players, 15 matches, and 200 participation records. With a small dataset, PostgreSQL may find that scanning tables and using a Hash Join or another simple strategy is efficient.

If the `match_participants` table grows from hundreds to millions of records, the cost of scanning and comparing rows could increase. Adding indexes on frequently joined foreign-key columns, such as `player_id` and `match_id`, may make an Index Scan and Nested Loop Join more attractive, particularly when one side of the join returns only a small number of rows.

The number of matching records also matters. If most records match, a Hash Join may be more efficient because PostgreSQL can build a hash table and compare rows. If the data is already sorted on the join columns, a Merge Join may become a better option.

Ultimately, PostgreSQL uses estimated costs to select an algorithm. Updated table statistics, appropriate indexes, and changes in data volume or distribution can therefore change its decision. Understanding these choices helps developers improve query performance as a database grows.

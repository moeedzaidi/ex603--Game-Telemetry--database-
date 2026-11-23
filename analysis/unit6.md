
# Unit 6 – Analysis

## Task 6.1: Compute Across a Window Without Collapsing

### Part 1: Comparing Events with the Producer Average

**Business question:**

For each player participation event, is its score higher or lower than the average score of its match?

I used AVG() OVER (PARTITION BY match_id) to calculate the average score for each match while keeping every participation event in the output.

The GROUP BY version returns one summary row per match. It shows the average score but loses individual participation details, such as the player ID and individual score. Therefore, it cannot show which specific events are above or below their match average.

### Part 2: Ranking Producers

**Platform feature:**

A match activity leaderboard could use the ranking functions to show which matches have the highest participation counts.

I would use RANK() because matches with the same event count should receive the same position. This makes the leaderboard treat equal counts fairly. ROW_NUMBER() would be useful if exactly one unique position were required, while DENSE_RANK() would be useful if ranking positions should not have gaps after ties.

### Part 3: Four Producer Bands

[After running the NTILE(4) query, explain how the matches were distributed across the four bands and whether any tied event counts appeared in different bands.]


## Task 6.2: Compare Each Row to Its Neighbors

### Part A: Row to Row

A large positive or negative score delta indicates a significant change between consecutive events. The team should investigate whether the change reflects genuine platform activity, unusual gameplay, or a possible data-quality issue.

### Part B: Cumulative and Smoothed

A plain SUM returns one overall total. A running total shows how that total accumulates over time, allowing the team to see when progress increases and how close the platform is to its target.

I selected a 7-row moving average because it smooths short-term variation while still showing recent changes. A smaller window reacts more quickly to individual events, while a larger window produces a smoother trend.

ROWS counts physical rows, while RANGE includes rows based on the ORDER BY values and treats matching values as peers.

### Part C: Where the Series Stops













## Reflection

In my Game Telemetry database, one useful reporting question is: How does each player's score compare with the average score of the match they participated in?

A window function makes this question easier because it calculates the match average while keeping every individual participation event in the result. For example, `AVG(score) OVER (PARTITION BY match_id)` displays the average score for a match alongside each player's individual score, player ID, and participation timestamp.

Using only `GROUP BY match_id` would calculate the average score for each match, but it would collapse all participation events into one summary row per match. I would lose the individual event details needed to identify which players scored above or below the match average.

Window functions also make other reporting tasks possible, such as comparing an event's score with the previous event using `LAG()`, calculating running totals, and ranking the highest-scoring events within each match.

This unit helped me understand that window functions are useful when a report needs both individual records and calculations across related records. GROUP BY is useful for summaries, while window functions preserve the detail needed for deeper analysis.

A gap longer than seven days indicates that no recorded participation event appeared during that interval for the selected producer.

A gap alone cannot prove that the producer stopped activity. It could represent a real break in activity or missing/incomplete event records. Further investigation is needed to distinguish these possibilities.

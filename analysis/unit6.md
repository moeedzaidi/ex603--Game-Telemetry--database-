
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


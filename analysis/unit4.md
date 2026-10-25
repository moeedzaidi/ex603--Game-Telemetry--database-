# Unit 4 — Task 4.1: Measuring the Platform

## 1. Platform-wide statistics

The first query summarizes the event table by calculating the total number of event records, total score, average score, minimum score, maximum score, and number of distinct players. The results show [insert actual results]. The minimum and maximum scores help identify the range of recorded scores, while the distinct-player count indicates how many different players appear in the event data.

## 2. Per-producer breakdown

The second query compares producers using event counts and average scores. The results show [describe the highest-volume producers and any notable differences]. The per-producer breakdown can help the game operations or platform reliability team decide where further investigation is needed.

## 3. Minimum-volume threshold

The third query includes only producers with at least 10 event records. This threshold reduces the risk of overinterpreting results from producers with very few events. However, it does not guarantee statistical reliability, so the event counts should still be considered when comparing producers.

## 4. Producer and region breakdown

The fourth query groups events by producer identifier and server region. This helps reveal whether score patterns and event volume differ across regions. The results show [insert observed regional patterns].

## What the aggregates hide

An average conceals the distribution of individual scores: two producers can have the same average but very different patterns. A count conceals which events and players are included. A platform operations or reliability lead could use the producer breakdown to prioritize further investigation. Next, I would examine the actual failure rate by producer, the distribution of event outcomes, the number of network-timeout events, and whether the observed differences persist across regions and larger event samples.

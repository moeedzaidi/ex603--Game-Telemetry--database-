-- Overall failure rate across the platform.
-- Assumes network_timeout is the confirmed failure value.

SELECT
    COUNT(*) AS total_events,
    SUM(
        CASE
            WHEN disconnect_reason = 'network_timeout' THEN 1
            ELSE 0
        END
    ) AS failure_events,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN disconnect_reason = 'network_timeout' THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS failure_rate_percent
FROM match_participants;

-- Producer-level failure rates.
-- Assumes network_timeout is the confirmed failure value.

SELECT
    match_id AS producer_id,
    COUNT(*) AS total_events,
    SUM(
        CASE
            WHEN disconnect_reason = 'network_timeout' THEN 1
            ELSE 0
        END
    ) AS failure_events,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN disconnect_reason = 'network_timeout' THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS failure_rate_percent
FROM match_participants
GROUP BY match_id
HAVING COUNT(*) >= 10
ORDER BY failure_rate_percent DESC, total_events DESC;


# Unit 4.3 — Leadership Finding

The platform's overall failure rate was 0%, based on 0% failures out of 200 events**. This is the platform-wide result, but it does not mean every producer has the same level of reliability.

The producer breakdown showed variation in failure rates. Producer **[ID 6]** had a failure rate of 0% across 21 events**. Producer **[ID 8]** had a rate of **0%** across **20% events**, while producer **[ID 12]** had a rate of **0%** across **17% events**. These producers merit investigation because their observed failure rates were low relative to the other producers with sufficient event volume.

I would investigate these producer IDs first, review their network-timeout records, and compare their server regions and event patterns. The figures identify where to look, but they do not by themselves prove the cause of the failures. The operations team should confirm whether the differences persist with additional data before making major platform or payout decisions.



**Reflection **

Conditional aggregation allows multiple related measurements to be calculated in a single query. For example, one query can count all events for each producer and count how many of those events are classified as failures. A `CASE` expression assigns a value to each event, and an aggregate function such as `SUM` adds those values. Both results appear side by side, making it easier to compare total activity with failures.

An alternative is to run two separate filtered queries: one to count all events and another to count only failure events. This approach can work, but it requires separate queries and then requires their results to be compared or combined. It can also create consistency problems if the queries use different filters or are run against data that changes between executions.

At a million rows, avoiding unnecessary repeated scans can reduce database work, especially when both measurements use the same underlying table and grouping. Conditional aggregation may allow the database to calculate both counts during one scan instead of processing the table separately for each query. The actual performance improvement depends on the database engine, indexes, query plan, and storage system, so one pass does not guarantee a specific speedup.

For this analysis, conditional aggregation is useful because leadership can compare event volume and failure volume for each producer in one result set. It also makes the query easier to maintain because both measurements share the same grouping and failure definition.

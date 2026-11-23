# Unit 6 – Closing Finding

## Is the Failure Problem Getting Better or Worse?

The available Game Telemetry data was analyzed using monthly participation trends, active-player counts, active-match counts, and event gaps.

The monthly analysis provides information about participation volume, active players, active matches, and total scores over time. However, these measurements show platform activity rather than directly measuring platform failures. An increase or decrease in participation does not automatically mean that the platform is becoming more or less reliable.

The gap analysis identifies periods longer than seven days between consecutive participation events within a match. These gaps indicate interruptions in recorded activity, but they do not independently prove that the platform failed, that a player left, or that event records were lost.

Based on the available data, the failure problem is **inconclusive**. The current dataset does not provide a direct failure indicator or enough evidence to establish whether failures are improving or worsening. More information about errors, failed matches, service interruptions, and event collection is needed to reach a reliable conclusion.

## What Should the Team Do Next Quarter?

1. **Monitor platform activity:** Track monthly participation events, active players, and active matches to identify significant changes in platform usage.
2. **Investigate activity gaps:** Review unusually long gaps between participation events to determine whether they represent genuine inactivity or missing event records.
3. **Monitor score changes:** Compare monthly total scores with participation volume and active-player counts. Investigate significant changes instead of assuming that higher scores automatically indicate better platform performance.
4. **Improve failure monitoring:** Record platform errors, failed matches, service interruptions, and event-collection problems. This will help the team distinguish actual platform failures from normal changes in player activity.
5. **Review progress quarterly:** Compare the next quarter's results with the current baseline to determine whether reliability and platform activity are improving.

## Supporting SQL Evidence

- **Task 6.2 Part C – Activity Gap Analysis:** Uses `LAG()` to compare consecutive participation timestamps and identify gaps longer than seven days.
- **Task 6.3 Part B – Monthly Comparison:** Uses `DATE_TRUNC()`, `LAG()`, and percentage change to compare monthly total scores. It also generates a monthly calendar to identify months with no recorded events.
- **Task 6.4 – Monthly Participation Analysis:** Uses `COUNT(*)`, `COUNT(DISTINCT player_id)`, and `COUNT(DISTINCT match_id)` to compare participation events, active players, and active matches over time.

## Final Recommendation

The team should prioritize better failure and event-monitoring data next quarter. The current Game Telemetry dataset is useful for understanding player activity and participation trends, but it is not sufficient on its own to measure platform reliability. Adding direct failure indicators will allow leadership to make a more confident decision about whether the failure problem is improving or worsening.

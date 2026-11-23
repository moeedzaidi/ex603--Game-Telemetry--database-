# Game Telemetry Database — EX603

**A PostgreSQL-based data analytics project exploring game matches, player participation, network failures, and platform activity.**

**Author:** Moeed Raza Zaidi  
**Course:** EX603 — Data and Algorithms for Scalable Systems  
**Database:** PostgreSQL (`ex603_data`)  
**Project Theme:** Game Telemetry

---

## 1. Project Overview

This project explores a Game Telemetry Database developed as part of the EX603 course. It focuses on analyzing game matches and player participation to understand platform activity, investigate reported network failures, and support better operational decisions.

The project follows a data investigation process. It begins with understanding the available data, then examines SQL query correctness, missing records, relationships between tables, and analytical patterns. Later units use more advanced SQL techniques to compare match activity, identify unusual patterns, rank matches, and study changes over time.

The central business question is whether the reported network failure problem reflects the actual platform data and what actions the team should take to improve platform reliability.

## 2. Domain and Business Context

The selected project domain is **Game Telemetry**. In this platform, players participate in matches, and each participation record captures information about an individual player's activity. Matches are the producers of these participation events.

The platform needs reliable reporting to understand player activity, compare match performance, identify matches with unusually high or low participation, and investigate network timeout failures. These insights can help the platform team understand whether a problem is isolated to particular matches or represents a wider issue.

An important business scenario in this project involves a dashboard that reported that approximately half of the events ended in a failure state. This result raised concerns because the reported failure rate did not match the experience of a ranked player. The investigation examines the underlying data and SQL logic rather than accepting the dashboard result without verification.

The analysis is intended to help the team produce more trustworthy reports, identify records that might otherwise be excluded, and make evidence-based recommendations about platform reliability and ranked-mode rewards.

## 3. Database Overview

The project uses the provided Game Telemetry dataset loaded into a PostgreSQL database named `ex603_data`.

The database follows five main data roles:

| Role | Table | Purpose |
|---|---|---|
| Actor | `players` | Stores player information |
| Producer | `matches` | Stores game match information |
| Event | `match_participants` | Records player participation in matches |
| Catalog | `game_modes` | Stores available game modes |
| Junction | `match_modes` | Connects matches with game modes |

### Main tables

**players**

Contains player records and identifies the players participating in the platform.

**matches**

Represents game matches. Each match is treated as a producer of participation events. Match attributes include information such as whether the match is ranked and its player count.

**match_participants**

Records individual player participation in matches. It connects players to matches and includes event-related information such as `joined_at` and `score`.

**game_modes**

Stores descriptive information about game modes.

**match_modes**

Acts as a junction table connecting matches and game modes.

### Database relationships

- One player can participate in multiple matches.
- One match can contain multiple participation records.
- Each participation record connects a player with a match.
- A match can be associated with multiple game modes through the junction table.

The database structure and supplied DDL/ERD are based on the course-provided Unit 3 dataset. The analysis uses the same `ex603_data` database throughout the later units.

**ERD:** https://github.com/moeedzaidi/ex603--Game-Telemetry--database-/blob/main/schema/Game-Telemetry-ERD.drawio.png

## 4. Project Structure

The repository organizes SQL queries, analysis documents, and screenshots by course unit.

```text
ex603--Game-Telemetry--database/
│
├── README.md
│
├── queries/
│   ├── unit3/
│   │   ├── q3_1.sql
│   │   ├── q3_2.sql
│   │   └── q3_3.sql
│   │
│   ├── unit4/
│   │   └── [Unit 4 SQL files]
│   │
│   ├── unit5/
│   │   └── [Unit 5 SQL files]
│   │
│   └── unit6/
│       ├── q6_1.sql
│       ├── q6_2.sql
│       └── q6_3.sql
│
├── analysis/
│   ├── unit3-finding.md
│   ├── unit5.md
│   ├── unit5-finding.md
│   ├── unit6.md
│   └── unit6-finding.md
│
└── screenshots/
    ├── unit3/
    ├── unit5/
    └── unit6/
```

*The structure above is a documentation guide. Keep only folders and files that actually exist in the repository, and add any other files you created during earlier units.*

## 5. Query Catalogue

The SQL work is organized by course unit. Each query is intended to answer a specific question about the Game Telemetry platform.

### Unit 1 — Project Selection

Selected the Game Telemetry domain and established the project direction.

### Unit 2 — Database Foundations

Worked with database concepts and an initial database design exercise. The separate Unit 2 database is not the source of the later analytical dataset; the project analysis uses the provided Unit 3 database.

### Unit 3 — SQL Foundations: Retrieval and Filtering

| File | Purpose |
|---|---|
| [q3_1.sql](queries/unit3/q3_1.sql) | Explore the dataset, inspect statuses, filter records, handle NULL values, and create useful calculated columns. |
| [q3_2.sql](queries/unit3/q3_2.sql) | Reproduce and repair SQL problems involving NULL handling and SELECT aliases. |
| [q3_3.sql](queries/unit3/q3_3.sql) | Answer the same analytical question using three different SQL approaches and compare their results. |

**Main focus:** Understanding the dataset, identifying SQL logic problems, and producing reliable query results.

### Unit 4 — Aggregate Functions, Grouping, and Advanced Summarization

This unit focuses on transforming raw event data into meaningful analytical insights using aggregate functions, grouping logic, and advanced summarization patterns.

The Unit 4 SQL queries answer questions such as:

- How can aggregate functions summarize event data using calculations such as `COUNT()`, `SUM()`, `AVG()`, `MIN()`, and `MAX()`?
- How does grouping data by different dimensions reveal activity patterns?
- How can advanced grouping and summarization techniques analyze data across multiple dimensions and hierarchies?
- How can multi-step SQL pipelines transform raw records into useful analytical summaries?

**SQL files:** Add the Unit 4 query files from the `/queries/unit4/` directory.

### Unit 5 — Joins and Query Performance

| Task | Analytical purpose |
|---|---|
| Task 5.1 | Explore relationships using multi-table joins. |
| Task 5.2 | Compare INNER, LEFT, RIGHT, and FULL OUTER JOIN results and identify producers without events using NOT EXISTS and EXCEPT. |
| Task 5.3 | Explore CROSS JOIN and examine query execution plans using EXPLAIN. |
| Task 5.4 | Prepare recommendations for producers with frequent failures and producers with no events. |

**Main focus:** Understanding how join types affect the records included in reports and how PostgreSQL plans query execution.

### Unit 6 — Analytics and Window Functions

| File | Purpose |
|---|---|
| [q6_1.sql](queries/unit6/q6_1.sql) | Compare individual events with producer averages, rank producers, and divide producers into four groups. |
| [q6_2.sql](queries/unit6/q6_2.sql) | Analyze running totals, moving averages, changes, and gaps in the event timeline. |
| [q6_3.sql](queries/unit6/q6_3.sql) | Build top-three events per producer and compare monthly activity using period-over-period analysis. |

**Main focus:** Using window functions to analyze records without losing individual event details, build reporting patterns, and understand changes over time.

## 6. Technical Highlights

### 1. Filtering and Aggregation

Used `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`, `DISTINCT`, and aggregate functions to explore the dataset and summarize platform activity.

### 2. NULL Handling and Query Correctness

Investigated SQL's three-valued logic and how comparisons involving NULL can silently exclude records. Used explicit NULL handling and alternative query structures to correct reporting logic.

### 3. Joins and Relationships

Used INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL OUTER JOIN, and CROSS JOIN to understand relationships between players, matches, and participation records. Compared matched and unmatched records to avoid incomplete reporting.

### 4. CTEs and Subqueries

Used Common Table Expressions and subqueries to organize multi-step analytical queries and express the same business question in different SQL forms.

### 5. Window Functions and Ranking

Used `AVG() OVER`, `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`, `NTILE()`, `LAG()`, and other window functions to calculate analytical values while retaining individual records.

These techniques support leaderboards, event comparisons, top-N reporting, running totals, and month-over-month analysis.

## 7. Findings and Recommendations

The project investigates whether the reported network failure rate accurately represents the underlying Game Telemetry data.

### Key Findings

1. **Dashboard reliability:** The original dashboard reported that approximately half of all events ended in a failure state. The Unit 3 investigation examined SQL problems involving NULL handling and query structure that can affect which records are included in a report. The original percentage should therefore not be treated as reliable without checking the corrected query result. The exact corrected failure percentage is not included here because it has not been verified from the final query output.

2. **Producer activity:** The dataset contains 15 matches and 200 player participation records. Thirteen matches have participation records, while `Match_14` and `Match_15` have no participation events. An INNER JOIN between matches and participation records can exclude these two matches, producing an incomplete view of platform activity.

3. **Activity patterns:** Participation is not evenly represented across all matches: some matches have multiple player participation records, while two have none. This demonstrates why match-level reporting should include both active and zero-event matches. Window functions and ranking queries can help compare match activity without losing individual participation details.

### Recommendations

- Validate SQL logic before using query results for business decisions.
- Recalculate the network failure rate using the corrected query before making decisions about ranked-mode rewards.
- Include unmatched producers when building platform-wide reports.
- Investigate matches with no participation events instead of automatically assuming they are inactive.
- Monitor matches with unusually high failure activity and investigate possible network or platform issues.
- Use time-based reporting to monitor whether platform reliability is improving or deteriorating.

See the analysis documents and SQL query files for detailed explanations and supporting evidence.

## 8. Limitations and Future Improvements

### Limitations

- The analysis is based on the provided dataset and its available records.
- The results represent the data available for the period covered by the dataset.
- A missing participation record does not explain why a match has no events.
- SQL results can identify patterns, but additional investigation may be required to establish the actual cause of a network failure.
- Query performance observations from a limited dataset may differ when the database grows significantly.

### Future Improvements

- Include additional telemetry fields to provide more detail about network errors.
- Analyze failure patterns across different game modes and match conditions.
- Monitor platform activity with regularly updated reports.
- Expand the dataset to support longer-term trend analysis.
- Improve reporting through dashboards and visualizations.
- Revisit indexes and query execution plans as the dataset grows.

## 9. Project Video Presentation

The final presentation demonstrates selected SQL queries, explains analytical decisions, and summarizes the important findings and recommendations.

**Video:** [Add your public video link here.]

## 10. How to Run the Project

### Requirements

- PostgreSQL 14 or later.
- A PostgreSQL client such as pgAdmin or `psql`.
- The provided Game Telemetry SQL dataset.

### Setup

1. Install PostgreSQL.
2. Create a database named `ex603_data`.
3. Load the provided Game Telemetry dataset into the database.
4. Confirm that the five project tables are available.
5. Open the SQL files in the `queries/` directory.
6. Execute the required query files using pgAdmin or `psql`.
7. Review the corresponding analysis documents in the `analysis/` directory.

### Example PostgreSQL commands

Create the database:

```sql
CREATE DATABASE ex603_data;
```

Connect using `psql`:

```bash
psql -d ex603_data
```

Run a query file:

```bash
psql -d ex603_data -f queries/unit3/q3_1.sql
```

For other units, replace the query filename with the appropriate SQL file.

**Note:** The database must already contain the supplied tables and data before running the analytical queries. Do not include database passwords, connection strings, or personal credentials in this repository.

---

## 11. Author

**Moeed Raza Zaidi**

EX603 — Data and Algorithms for Scalable Systems

Project: Game Telemetry Database


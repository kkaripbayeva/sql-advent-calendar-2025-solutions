-- SQL Advent Calendar - Day 18
-- Title: 12 Days of Data - Progress Tracking
-- Difficulty: hard
--
-- Question:
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--

-- Table Schema:
-- Table: daily_quiz_scores
--   subject: VARCHAR
--   quiz_date: DATE
--   score: INTEGER
--

-- My Solution:

SELECT subject,
       MAX(CASE WHEN quiz_date = min_date THEN score END) AS first_record,
       MAX(CASE WHEN quiz_date = max_date THEN score END) AS last_record
FROM (
    SELECT d.*,
           MIN(quiz_date) OVER (PARTITION BY subject) AS min_date,
           MAX(quiz_date) OVER (PARTITION BY subject) AS max_date
    FROM daily_quiz_scores d
) t
GROUP BY subject;

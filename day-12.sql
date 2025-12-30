-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

with users as (select user_id,
count(message_id) as count_msg,
sent_at::date as sent
from npn_users u 
join npn_messages m on u.user_id = m.sender_id
group by user_id, sent_at::date),
ranking as (select user_id,
count_msg,
sent, 
rank() over (partition by sent order by count_msg desc) as ranking_u
from users)
select user_id,
count_msg,
sent 
from ranking
where ranking_u = 1

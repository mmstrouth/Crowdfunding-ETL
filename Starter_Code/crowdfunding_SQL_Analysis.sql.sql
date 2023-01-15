-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT backers_count, SUM(cf_id) as "cf_id sum" 
FROM campaign
WHERE outcome = 'live'
GROUP BY backers_count
ORDER BY backers_count DESC;


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT COUNT(cf_id)
FROM backers;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT 
	b.first_name, 
	b.last_name, 
	b.email,
	c.goal - c.pledged AS "Remaining Goal Amount"
INTO email_contacts_remaining_goal_amount
FROM backers AS b
JOIN campaign AS c ON
b.cf_id = c.cf_id
ORDER BY "Remaining Goal Amount" DESC
;

-- Check the table
SELECT * FROM email_contacts_remaining_goal_amount

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
SELECT 
	b.email,
	b.first_name, 
	b.last_name, 
	b.cf_id,
	c.company_name,
	c.description,
	c.end_date,
	e."Remaining Goal Amount" AS "Left of Goal"
INTO email_backers_remaining_goal_amount
FROM backers AS b
JOIN campaign AS c ON b.cf_id = c.cf_id
JOIN email_contacts_remaining_goal_amount AS e ON e.email = b.email 
ORDER BY last_name
;

-- Check the table
SELECT * FROM email_backers_remaining_goal_amount


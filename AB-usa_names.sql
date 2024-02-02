SELECT *
FROM names
LIMIT 5;

-- 1. How many rows are in the names table?
SELECT COUNT(*)
FROM names;
-- There are 1,957,046 rows in the names table

-- 2. How many total registered people appear in the dataset?
SELECT SUM(num_registered)
FROM names;
-- There are 351,653,025 registered people in the dataset

-- 3. Which name had the most appearances in a single year in the dataset?
SELECT name, year, SUM(num_registered) AS name_count
FROM names
GROUP BY year, name
ORDER BY name_count DESC
LIMIT 10;
-- The name Linda appears the most in a single year - 99,905 in 1947

-- 4. What range of years are included?
SELECT MAX(year), MIN(year)
FROM names;
-- The years range from 1880 through 2018

-- 5. What year has the largest number of registrations?
SELECT SUM(num_registered), year
FROM names
GROUP BY year
ORDER BY SUM(num_registered) DESC
LIMIT 10;
-- 1957 had the most registrations with 4,200,022 registrations.

-- 6. How many different (distinct) names are contained in the dataset?
SELECT COUNT(DISTINCT(name))
FROM names;
-- There are 98,400 distinct names in the dataset

-- 7. Are there more males or more females registered?
SELECT gender, SUM(num_registered)
FROM names
GROUP BY gender;
-- There are 174,079,232 female registrations and 177,573,793 male registrations.
-- This means there are 3,494,561 more male registrations than female registrations.

-- 8. What are the most popular male and female names overall (i.e., the most total registrations)?
SELECT name, gender, SUM(num_registered)
FROM names
GROUP BY gender, name
ORDER BY SUM(num_registered) DESC;
-- James is the most popular male name with 5,164,280 registrations.
-- Mary is the most popular female name with 4,125,674 registrations.

-- 9. What are the most popular boy and girl names of the first decade of the 2000s (2000 - 2009)?
SELECT name, gender, year/10 AS decade, SUM(num_registered)
FROM names
GROUP BY gender, name, decade
HAVING year/10 = 200
ORDER BY SUM(num_registered) DESC;
-- Jacob is the most popular male name of the 2000s.
-- Emily is the most popular female name of the 2000s.

-- 10. Which year had the most variety in names (i.e. had the most distinct names)?
SELECT COUNT(DISTINCT(name)), year
FROM names
GROUP BY year
ORDER BY COUNT(DISTINCT(name)) DESC;
-- 2008 had the most variety of names with 32,518 distinct names

-- 11. What is the most popular name for a girl that starts with the letter X?
SELECT name, gender, SUM(num_registered)
FROM names
GROUP BY name, gender
HAVING gender = 'F'
	AND name LIKE 'X%'
ORDER BY SUM(num_registered) DESC;
-- "Ximena" is the most popular girl name starting with the letter X.
-- The name Ximena has 26,145 total registrations.

-- 12. How many distinct names appear that start with a 'Q', but whose second letter is not 'u'?
SELECT COUNT(DISTINCT(name))
FROM names
WHERE name LIKE 'Q%'
	AND name NOT LIKE '_u%';
-- There are 46 distinct names that start with 'Q' but dont have a second letter of 'u'.

-- 13. Which is the more popular spelling between "Stephen" and "Steven"? Use a single query to answer this question.
SELECT name, SUM(num_registered)
FROM names
GROUP BY name
HAVING name = 'Stephen' OR name = 'Steven';
-- The name "Steven" is more popular than the name "Stephen".
-- There were 1,286,951 registrations for "Steven" and 860,972 registrations for "Stephen".

-- 14. What percentage of names are "unisex" - that is what percentage of names have been used both for boys and for girls?
SELECT COUNT(name_gender_count)
FROM
(
SELECT DISTINCT(name), COUNT(DISTINCT(gender)) AS name_gender_count
FROM names
GROUP BY DISTINCT(name)
ORDER BY name_gender_count DESC
) AS SUBQUERY
GROUP BY name_gender_count;
-- There are 10,773 unisex names and 87,627 names that only appear for one gender.
-- This means that ~10.95% of the names are unisex.

-- 15. How many names have made an appearance in every single year since 1880?
SELECT COUNT(num_years_appeared)
FROM
(
SELECT name, COUNT(DISTINCT(year)) AS num_years_appeared
FROM names
GROUP BY name
ORDER BY num_years_appeared DESC
) AS SUBQUERY
WHERE num_years_appeared = 139;
-- 921 names appeared in every single year since 1880

-- 16. How many names have only appeared in one year?
SELECT COUNT(num_years_appeared)
FROM
(
SELECT name, COUNT(DISTINCT(year)) AS num_years_appeared
FROM names
GROUP BY name
ORDER BY num_years_appeared DESC
) AS SUBQUERY
WHERE num_years_appeared = 1;
-- 21,123 names appeared in only one year.

-- 17. How many names only appeared in the 1950s?
SELECT name, COUNT(DISTINCT(name))
FROM names
GROUP BY name
HAVING MAX(year)=1959 AND MIN(year) = 1950;
-- Just 2 names only appeared in the 1950s: Leartis and Stevphen.

-- 18. How many names made their first appearance in the 2010s?
SELECT COUNT(name)
FROM
(
SELECT name, COUNT(DISTINCT(name)) AS name_count_2010s
FROM names
GROUP BY name
HAVING MIN(year) = 2010
) AS SUBQUERY;
--1,504 names made their first appearance in the 2010s.

-- 19. Find the names that have not be used in the longest.
SELECT name, MAX(year)
FROM names
GROUP BY name
ORDER BY MAX(year);
-- The names "Zilpah" and "Roll" both have not been used since 1881.

-- 20. Come up with a question that you would like to answer using this dataset. Then write a query to answer this question.

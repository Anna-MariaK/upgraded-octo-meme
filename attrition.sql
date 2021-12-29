-- Employee Attrition Data Exploration 
-- Skills used: Joins, CTE's, Aggregate Functions

-- Avarage age of employee
SELECT AVG(age) AS AvgAge 
 FROM new_schema.hr_attrition
 
 -- Attrition VS TotalWorkingYears
SELECT Attrition, AVG(TotalWorkingYears) AS AvgTotalWorkingYears
FROM new_schema.hr_attrition
WHERE Attrition = 'No'
UNION
SELECT Attrition,AVG(TotalWorkingYears) AS AvgTotalWorkingYears
FROM new_schema.hr_attrition
WHERE Attrition = 'YES'
 
-- Attrition VS NumCompaniesWorked
SELECT Attrition, AVG(NumCompaniesWorked) AS AvgNumCompaniesWorked
FROM new_schema.hr_attrition
WHERE Attrition = 'No'
UNION
SELECT Attrition,AVG(NumCompaniesWorked) AS AvgNumCompaniesWorked
FROM new_schema.hr_attrition
WHERE Attrition = 'YES'


-- Converting text values from Attrition column into numeric values and saving as separate table 
SELECT EmployeeNumber,
Case
when attrition = 'Yes' then 1
when attrition = 'No' then 0
ELSE 'Maybe'
END
AS Atr
FROM new_schema.hr_attrition
 
 -- Joining two tables
 SELECT hr.EmployeeNumber, Atr, hr.EmployeeCount
 FROM new_schema.hr_attrition hr
 JOIN new_schema.atr_table atr
 ON hr.EmployeeNumber= atr.EmployeeNumber
 
 
 -- Calcucate AttritionLevel
 SELECT hr.EmployeeCount, TRUNCATE((Sum(Atr)/ Sum(hr.EmployeeCount)) * 100, 2) as AttritionLevel
 FROM new_schema.hr_attrition hr
 JOIN new_schema.atr_table atr
 ON hr.EmployeeNumber= atr.EmployeeNumber
 Group by hr.EmployeeCount
 
-- Checking the ratio of men to women
 SELECT Gender, Sum(EmployeeCount) AS TotalEmployee
 FROM new_schema.hr_attrition
 WHERE gender= 'female' or gender='male'
 GROUP BY Gender WITH ROLLUP
 
 -- Looking at level of burnout of men and women
 SELECT Gender, Sum(EmployeeCount)/588*100 AS TotalEmployee
 FROM new_schema.hr_attrition
 WHERE gender= 'female' AND Attrition = 'Yes'
 UNION
 SELECT Gender, Sum(EmployeeCount)/882*100 AS TotalEmployee
 FROM new_schema.hr_attrition
 WHERE gender= 'male' and Attrition= 'Yes'
 
 -- Exploring correlation between WorkLifeBalance and Attrition
-- WorkLifeBalance (1-'Bad', 2-'Good', 3-'Better', 4-'Best')
-- Calcucating % OF Attrition of each group

SELECT WorkLifeBalance, SUM(EmployeeCount)/1470*100 AS EmployeeAttritionPerc
 FROM new_schema.hr_attrition
 WHERE WorkLifeBalance IN(1) AND Attrition = 'Yes'
 UNION
 SELECT WorkLifeBalance, SUM(EmployeeCount)/1470*100 AS EmployeeAttritionPerc
 FROM new_schema.hr_attrition
  WHERE WorkLifeBalance IN(2) AND Attrition = 'Yes'
  UNION
 SELECT WorkLifeBalance, SUM(EmployeeCount)/1470*100 AS EmployeeAttritionPerc
 FROM new_schema.hr_attrition
  WHERE WorkLifeBalance IN(3) AND Attrition = 'Yes'
  UNION
 SELECT WorkLifeBalance, SUM(EmployeeCount)/1470*100 AS EmployeeAttritionPerc
 FROM new_schema.hr_attrition
  WHERE WorkLifeBalance IN(4) AND Attrition = 'Yes'
  
-- BusinessTravel and Burnout
SELECT BusinessTravel, SUM(EmployeeCount)/1470*100 AS EmployeeAttritionPerc
 FROM new_schema.hr_attrition
 WHERE BusinessTravel='Travel_Rarely' AND Attrition = 'Yes'
 UNION
 SELECT BusinessTravel, SUM(EmployeeCount)/1470*100 AS EmployeeAttritionPerc
 FROM new_schema.hr_attrition
 WHERE BusinessTravel='Travel_Frequently' AND Attrition = 'Yes'
 
-- Monthly income and Attrition
SELECT MAX(Monthlyincome), MIN(Monthlyincome),AVG(Monthlyincome)
 FROM new_schema.hr_attrition
WHERE Attrition = 'NO'

SELECT MAX(Monthlyincome), MIN(Monthlyincome),AVG(Monthlyincome)
 FROM new_schema.hr_attrition
WHERE Attrition = 'YES'
 

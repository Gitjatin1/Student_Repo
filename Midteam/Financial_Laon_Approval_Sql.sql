-- SQL
    
/* Creating Data base Jatin_Financial_Loan_Approval and Create Table Loan_approval*/

CREATE TABLE Loan_approval (
    Application_date           DATE    NOT NULL,
    Age                        INTEGER NOT NULL,
    Annual_Income              REAL    NOT NULL,
    Credit_Score               INTEGER NOT NULL,
    Employment_Status          TEXT    NOT NULL,
    Loan_Amount                REAL    NOT NULL,
    Loan_Duration              INTEGER NOT NULL,
    Marital_Status             TEXT    NOT NULL,
    Home_Ownership_Status      TEXT    NOT NULL,
    Bankruptcy_History         BLOB    NOT NULL,
    Loan_Purpose               TEXT    NOT NULL,
    Monthly_Income             REAL    NOT NULL,
    Interest_Rate              REAL    NOT NULL,
    Monthly_Loan_Payment       REAL    NOT NULL,
    Total_Debt_to_Income_Ratio REAL    NOT NULL,
    Loan_Approved              BLOB    NOT NULL,
    Risk_Score                 INTEGER NOT NULL
);

-- 5. Data Import
--  Import data from Financial_Loan_Approval.cvs
-- 1. Data Import: Import your cleaned data into your database tables. Verify data integrity after import.

Select * from Loan_approval;

/*2. Data Verification: Write queries to verify row counts match your original dataset. 
    Check for any data type issues or constraints that need addressing.*/


Select count(*) as total_no_row from Loan_approval;

Select Application_date,
    Age,
    Annual_Income,
    Loan_Approved
from Loan_approval
where Loan_Approved is not null;


/* 6. Exploratory Query Analysis
    1. Exploratory Queries: Develop at least 3 basic queries specifically designed to explore potential routes for analysis in your data.
    2. Count of records meeting specific criteria.
    3. Sum or average of numeric fields with grouping.
    4. Identification of minimum/maximum values.
    5. Date-based filtering and analysis.
    6. Text pattern matching using LIKE.
    7. Example Queries.
*/

-- Calculate Average of Loan Amount

Select Round(Avg(Loan_Amount))
from Loan_approval;

-- Count Loan Approved > 25000 (Average Loan Amount)

Select
    count(case when Loan_Amount > 25000 then 1 end) As Loan_Amount_is_morethan_Avg
from Loan_approval
;

-- Calculate and show toatl amount in different laon
Select
    Loan_Purpose,
    sum(Loan_Amount) as Total_Amount
from Loan_approval
group by Loan_Purpose;

-- Calculate and show toatl number loan in different laon

Select
    Loan_Purpose,
    sum(Loan_Approved) as Total_Amount
from Loan_approval
group by Loan_Purpose;

-- find Minimum Amount and Maximum Amount of apporved loan in different Employment status 
Select 
    Employment_Status,
    Loan_Approved,
    Min(Loan_Amount) As Min_Loan_Amount,
    Max(Loan_Amount) As Max_Loan_Amount
from Loan_approval
where Loan_Approved = "1"
group by Employment_Status;

--- Find by LIKE Applicants those loan was approved who had Mortgage and Employed. 
Select 
    Home_Ownership_Status,
    Employment_Status,
    Loan_Approved
from Loan_approval
where Loan_Approved ="1" 
    And Home_Ownership_Status like "%Mortgage"
    And Employment_Status like "Emp%";

/*
7. Business Query Analysis 
    1. Business Insight Queries: Develop at least 3 advanced queries specifically designed to answer key business questions related to your dataset.
    2. Time-series analysis (trends over time).
    3. Cohort analysis (grouping related records).
    4. Ranking and percentiles.
    5. Running totals or moving averages.
    6. Complex filtering with multiple conditions.
    7.Example Queries:
*/

-- find Loan approved status yes and total annual income in order of Marital state and grouped in employment and ownership state 

Select
    Marital_status,
    Employment_status,
    Home_ownership_status,
    sum(Annual_Income) as total_Aount,
    Loan_approved
from Loan_approval
Where Loan_Approved = "1"
Group by Home_Ownership_Status, Employment_Status
Having Sum(Annual_Income) > Avg(Annual_Income)
order by Marital_Status Asc
;

-- Find count of loan approved for different purpose and in age between 40 to 50.

Select 
    Loan_Approved,
    Employment_Status,
    Age,
    Round(Count(case when Loan_Purpose='Auto' then 1 end),2)as Total_Auto,
    Round(Count(case when Loan_Purpose='Debt Consolidation' then 1 end),2)as Total_Debt_Consolidation,
    Round(Count(case when Loan_Purpose='Education' then 1 end),2)as Total_Education,
    Round(Count(case when Loan_Purpose='Home' then 1 end),2)as Total_Home,
    Round(Count(case when Loan_Purpose='Other' then 1 end),2)as Total_Other
from Loan_approval
group by Loan_Approved, Employment_Status
Having Age between 30 And 50
order by Loan_Approved Asc;


-- find out loan approved, marital, employment, ownship having credit score > 600 and order by marital asc. 
Select
    Marital_status,
    Employment_status,
    Home_ownership_status,
    Credit_Score,
    Loan_approved
from Loan_approval
Where Loan_Approved = "1" or Loan_Approved = "0"
Group by Home_Ownership_Status, Employment_Status
Having Credit_Score > 600
order by Marital_Status Asc
;




    5. Query Documentation: Document your queries in preparation for the SQL Analysis Report described below.
    6. Describe your queries and Include sample result screenshots for each query.
    7. Summary of the types of analysis performed.
    8. Top significant insights discovered.
    9. Paragraph explanation of how these insights could inform business decisions
9. Data Analysis Report
    1. Comprehensive analysis report that demonstrates both your technical Excel & SQL skills and business analysis capabilities.

Dataset Introduction:
    1. Source of the data.
    2. Size (number of tables and approximate records).
    3. General subject matter (e.g., "retail sales data," "healthcare patient records")
Analysis Objectives:
    1. Business questions being investigated.
    2. Patterns or trends the analysis hopes to uncover.
    3. Specific hypotheses being tested with the data
Analytical Approach and Findings:
    1. Brief overview of methods used.
    2. Query explanations and insights
Business Recommendations:
    1. Strategic suggestions based on your complete analysis.
    2. Actionable insights for stakeholders derived from your findings.
*/
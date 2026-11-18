
--Describe all the details in the Bank Loan DB
SELECT * FROM bank_loan_data


-- Count total loan applications
SELECT COUNT(*) AS Total_Loan_Applications FROM bank_loan_data

-- Display the first 10 records
SELECT TOP 10 * FROM bank_loan_data 

--How many loan applications were recorded in December
SELECT COUNT(*) AS MTD_Total_Applications
FROM bank_loan_data
WHERE MONTH(issue_date) = 12

--How many loan applications were recorded in November
SELECT COUNT(*) AS PMTD_Total_Applications
FROM bank_loan_data
WHERE MONTH(issue_date) = 11

--What is the total amount of money lent to borrowers
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM bank_loan_data

--What is the total amount of loans funded in December
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan_data 
WHERE MONTH(issue_date) = 12

--What is the total amount of loans funded in November
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount
FROM bank_loan_data 
WHERE MONTH(issue_date) = 11

--What is the total amount received from loan repayments
SELECT SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data

--What is the total amount received from loan payments in December
SELECT SUM(total_payment) AS MTD_Total_Amount_Received
FROM bank_loan_data
WHERE MONTH(issue_date) = 12

-- What is the total amount received for November loan records
SELECT SUM(total_payment) AS PMTD_Total_Amount_Received
FROM bank_loan_data
WHERE MONTH(issue_date) = 11

--What is the average interest rate across all loans
SELECT ROUND(AVG(int_rate),4) * 100 AS Avg_Int_Rate
FROM bank_loan_data

--What is the average interest rate for December loan records
SELECT ROUND(AVG(int_rate),4) * 100 AS MTD_Avg_Int_Rate
FROM bank_loan_data
WHERE MONTH(issue_date) = 12

--What is the average interest rate for November loan records
SELECT ROUND(AVG(int_rate),4) * 100 AS MTD_Avg_Int_Rate
FROM bank_loan_data
WHERE MONTH(issue_date) = 11


--What is the average DTI across all loan applications
SELECT ROUND(AVG(dti),4) * 100 AS Avg_DTI
FROM bank_loan_data

--What is the average DTI for December loan records
SELECT ROUND(AVG(dti),4) *100 AS MTD_Avg_DTI
FROM bank_Loan_data
WHERE MONTH(issue_date) = 12

--What is the average DTI for November loan records
SELECT ROUND(AVG(dti),4) *100 AS MTD_Avg_DTI
FROM bank_Loan_data
WHERE MONTH(issue_date) = 11

--What percentage of loan applications are classified as good loans
SELECT
COUNT(CASE
WHEN loan_status = 'fully paid'
OR loan_status = 'current'
THEN id
END) * 100/COUNT(id) AS Total_Percentage
FROM bank_loan_data

--How many loan applications are classified as good loans
SELECT COUNT(*) AS Good_Loan_Applications
FROM bank_loan_data WHERE loan_status IN ('fully paid','current')

--What is the total funded amount for good loans
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount
FROM bank_loan_data
WHERE loan_status IN ('fully paid','current')

--How much money has been received from good loans
SELECT SUM(total_payment) AS Good_Loan_Amount_Received
FROM bank_loan_data
WHERE loan_status IN ('Fully Paid', 'Current')

--What percentage of loan applications are classified as bad loans
SELECT (COUNT(CASE 
WHEN loan_status = 'charged off'
THEN id END) * 100)/COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data

--How many loan applications are classified as bad loans
SELECT COUNT(id) AS Bad_Loan_Applications
FROM bank_loan_data WHERE loan_status ='charged off'

--What is the total funded amount for bad loans
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount
FROM bank_loan_data
WHERE loan_status = 'Charged Off'

--How much money has been received from bad loan
SELECT SUM(total_payment) AS Bad_loan_Amount_Received
FROM bank_Loan_data
WHERE loan_status = 'charged off'

--Loan Status Breakdown
--How many loans are there under each loan status, and what are their total funded amount, amount received, average interest rate, and average DTI
SELECT 
loan_status,
COUNT(id) AS Loan_Count,
SUM(total_payment) AS Total_Amount_Received,
SUM(loan_amount) AS Total_Funded_Amount,
AVG(int_rate) * 100 AS Average_Interest_Rate,
AVG(dti) * 100 AS Average_DTI
FROM bank_loan_data
GROUP BY loan_status
ORDER BY loan_status

--For December, how many loans are there under each loan status, and what are the total funded amount and amount received
SELECT 
loan_status,
SUM(total_payment) AS Total_Amount_Received,
SUM(loan_amount) AS Total_Funded_Amount
FROM bank_loan_data
GROUP BY loan_status
ORDER BY loan_status

--How do loan applications, total funded amount, and total amount received change from month to month
SELECT
MONTH(issue_date) AS Month_Number,
DATENAME(MONTH, issue_date) AS Month_Name,
COUNT(id) AS Total_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY
MONTH(issue_date),
DATENAME(MONTH, issue_date)
ORDER BY
MONTH(issue_date)

--How many loan applications are there in each state, and what are the total funded amount and amount received for each state
SELECT
address_state,
COUNT(id) AS Total_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state

--How many loan applications are there for each loan term, and what are the total funded amount and amount received for each term
SELECT
term,
COUNT(id) AS Total_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term

--How do loan applications, funded amounts, and payments received vary by employee length
SELECT
emp_length,
COUNT(id) AS Total_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length

--How do loan applications, funded amounts, and payments received vary by loan purpose
SELECT
purpose,
COUNT(id) AS Total_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose

--How do loan applications, funded amounts, and payments received vary by home ownership
SELECT
home_ownership,
COUNT(id) AS Total_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership

--How do loan applications, funded amounts, and payments received vary by purpose for Grade A loans
SELECT
purpose,
COUNT(id) AS Total_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose
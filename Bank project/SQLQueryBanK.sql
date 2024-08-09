select *
from bank_loan_data;


-- Total Loan Applications
SELECT COUNT(id) AS Total_Loan_Applications
FROM bank_loan_data;

-- Month to Date Applications
SELECT COUNT(id) AS Month_to_Date_Applications
FROM bank_loan_data
WHERE MONTH(issue_date)=12 and YEAR(issue_date)=2021

--Previous Month to Date 
SELECT COUNT(id) AS Previous_Month_to_Date_Applications
FROM bank_loan_data
WHERE MONTH(issue_date)=11 and YEAR(issue_date)=2021;

--Total Funded Amount
SELECT SUM(loan_amount) AS Total_Amount_Funded
From bank_loan_data

--Month To Date Funded Amount
SELECT SUM(loan_amount) AS Total_Amount_Funded
From bank_loan_data
Where MONTH(issue_date)=12 and YEAR(issue_date) = 2021


-- Previous Month To Date Fnded Amount
SELECT SUM(loan_amount) AS Total_Amount_Funded
From bank_loan_data
Where MONTH(issue_date)=11 and YEAR(issue_date) = 2021

--Total Amount Received
SELECT SUM(total_payment) as Total_Collected
FROM bank_loan_data


--Month To Date Amount Received
SELECT SUM(total_acc) AS Total_Collected
From bank_loan_data
Where MONTH(issue_date)=12 and YEAR(issue_date) = 2021


--Previous Month To Date Amount Received
SELECT SUM(total_acc) AS Total_Collected
From bank_loan_data
Where MONTH(issue_date)=11 and YEAR(issue_date) = 2021


--Average Interest Rate
SELECT ROUND(AVG(int_rate)*100,2) AS Average_Interest_Rate
FROM bank_loan_data

--Month to Date Average Interest Rate 
SELECT ROUND(AVG(int_rate)*100,2) AS MTD_Average_Interest_Rate
FROM bank_loan_data
WHERE MONTH(issue_date)=12 and YEAR(issue_date)=2021

--Previous Month to Date Average Interest Rate 
SELECT ROUND(AVG(int_rate)*100,2) AS MTD_Average_Interest_Rate
FROM bank_loan_data
WHERE MONTH(issue_date)=11 and YEAR(issue_date)=2021

--Average Debt to Income Ratio (DTI)
SELECT ROUND(AVG(dti)*100,2) AS DTI_AVG
FROM bank_loan_data

--Month to Date Debt to Income Ratio (DTI)
SELECT ROUND(AVG(dti)*100,2) AS MTD_DTI
FROM bank_loan_data
WHERE MONTH(issue_date)=12 and YEAR(issue_date)=2021


--Previous Month to Date Debt to Income Ratio (DTI)
SELECT ROUND(AVG(dti)*100,2) AS MTD_DTI
FROM bank_loan_data
WHERE MONTH(issue_date)=11 and YEAR(issue_date)=2021


--Good Loan Application Percentage 
SELECT (COUNT(CASE WHEN loan_status = 'Fully Paid' or Loan_status ='Current' THEN id END)*100)
	/ COUNT(id) as Good_loan_Percentage
FROM bank_loan_data

--Good Loan Applicants
SELECT (COUNT(CASE WHEN loan_status = 'Fully Paid' or Loan_status ='Current' THEN id END)) AS Good_Loan_Applicants
FROM bank_loan_data

SELECT COUNT(id) AS Good_Loan_Applicants
From bank_loan_data
WHERE loan_status = 'Fully Paid' or loan_status = 'Current' 

--Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded
From bank_loan_data
WHERE loan_status = 'Fully Paid' or loan_status = 'Current'

--Good Loan Received Amount
SELECT SUM(total_payment) AS Good_Loan_Received
From bank_loan_data
WHERE loan_status = 'Fully Paid' or loan_status = 'Current'




--Bad Loan Application Percentage 
SELECT (COUNT(CASE WHEN loan_status = 'Charged OFF' THEN id END)*100)
	/ COUNT(id) as Bad_loan_Percentage
FROM bank_loan_data

--Bad Loan Applicants
SELECT (COUNT(CASE WHEN loan_status = 'Charged OFF'THEN id END)) AS Bad_Loan_Applicants
FROM bank_loan_data

SELECT COUNT(id) AS Bad_Loan_Applicants
From bank_loan_data
WHERE loan_status = 'Charged OFF' 

--Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded
From bank_loan_data
WHERE loan_status = 'Charged Off'

--Bad Loan Received Amount
SELECT SUM(total_payment) AS Bad_Loan_Received
From bank_loan_data
WHERE loan_status = 'Charged Off'


-- Loan Status Overview
SELECT loan_status, COUNT(id) AS Loan_Applications, SUM(loan_amount) AS Total_Funded_Amount, SUM(total_payment) AS Total_Amount_Received ,
ROUND(AVG(int_rate *100),2) AS Interest_Rate_Percentage, ROUND(AVG(dti *100),2) AS DTI_Percentage
FROM bank_loan_data
GROUP BY loan_status 
--Adding the MTD overview
SELECT loan_status, SUM(total_payment) AS MTD_Total_Amount_Received, SUM(loan_amount) AS MTD_Total_Funded
FROM bank_loan_data
WHERE MONTH(issue_date) = 12
GROUP BY loan_status

--MOM Trend Overview
Select 
MONTH(issue_date) AS Month_Number,
DATENAME(MONTH, issue_date) AS Months, ---this date name is used to convert the date to month in the issue date comlumn
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_funded_amount,
SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date),  DATENAME(MONTH, issue_date)
ORDER BY MONTH (issue_date) 


-- Loan Status Geo Overview
SELECT address_state AS State, COUNT(id) AS Loan_Applications, SUM(loan_amount) AS Total_Funded_Amount, SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state 
ORDER BY SUM(loan_amount) DESC


-- Loan Terms Overview
SELECT term AS Loan_Termh, COUNT(id) AS Loan_Applications, SUM(loan_amount) AS Total_Funded_Amount, SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term 
ORDER BY term DESC


-- Employee Length Overview
SELECT emp_length AS EMP_Length, COUNT(id) AS Loan_Applications, SUM(loan_amount) AS Total_Funded_Amount, SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length 
ORDER BY emp_length


-- Purpose of Loan Overview
SELECT purpose AS Reasons, COUNT(id) AS Loan_Applications, SUM(loan_amount) AS Total_Funded_Amount, SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose 
ORDER BY COUNT(id) DESC 


-- Home Ownership Overview
SELECT home_ownership AS Reasons, COUNT(id) AS Loan_Applications, SUM(loan_amount) AS Total_Funded_Amount, SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership 
ORDER BY COUNT(id) DESC 



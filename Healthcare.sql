-- creating table patients

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100),
    dob DATE
);

insert into patients (patient_id, name, dob) values
(1, 'Alice Smith','1985-03-12'),
(2, 'Ronan Teezewr','1995-12-3'),
(3, 'Sunila Maharjan','1965-07-22');

-- creating table Claims
create table Claims(
	claim_id int primary key,
	patient_id int,
	service_date date,
	claim_amount decimal(10, 2),
	diagnosis varchar(10),
	foreign key (patient_id) references patients(patient_id)
);

-- insert values in claims 
INSERT INTO Claims (claim_id, patient_id, service_date, claim_amount, diagnosis) VALUES
(101, 1, '2023-07-10', 500.00, 'A01'),
(102, 2, '2023-07-12', 750.00, 'B02'),
(103, 1, '2023-07-13', NULL, 'A01'),
(104, 3, '2023-08-01', 300.00, NULL),
(105, 2, '2025-12-01', 400.00, 'B02');



select *
from Claims;

select *
from Patients;

-- finding any duplicates claims for same patient on the same date 
select patient_id, service_date, count(*)
from Claims
group by patient_id, service_date
having count(*) > 1;

--Find records with NULLs in important fields
select *
from Claims
where claim_amount is Null or diagnosis is null;

-- Find completely duplicate rows in a table
select claim_id, patient_id, service_date, claim_amount, diagnosis, count(*)
from Claims
group by claim_id, patient_id, service_date, claim_amount, diagnosis
having count(*) > 1;


-- patience with more than one claims 

select patient_id, count(*) as total_claim
from Claims
group by patient_id
having count(*) > 1;

-- claims with null amount
select *
from Claims 
where claim_amount is null;

--finding all claims with a service date in the future 

select *
from Claims
where service_date > CURRENT_DATE;

-- List all diagnosis codes and how often they appear (excluding NULLs).
select diagnosis, count(*) diagnosis
from Claims
where diagnosis is not null
group by diagnosis;

-- Calculate the average claim amount per patient.
select*
from Claims;

select patient_id, AVG(claim_amount) as avgclaim 
from Claims
where claim_amount is not null 
group by patient_id;


-- Get the full name and DOB of each patient along with their claim date and amount.

select *
from Patients;

select p.name, p.dob, c.service_date as claim_date, claim_amount
from Patients as p
join Claims as c on p.patient_id = c.patient_id;

--Detect invalid foreign key entries (claims with non-existent patients).

--Find the number of claims submitted per month.

select extract(year from service_date) as year,
	   extract(month from service_date) as month,
	   COUNT(*) as total_claims
from Claims
GROUP BY year, month
ORDER BY year, month;


-- finding patient with more than 2 claims in a month 
select patient_id, FORMAT(service_date, '%Y-%m') as claim_month, count(*) as claim_count
from Claims
group by patient_id, FORMAT(service_date, '%Y-%m')
having count(*) > 2;

-- how would you find gaps in a patient's claim history (e.g., no claims for >30 days)?

-- Find the claim(s) with the highest amount per patient.
select*
from Claims c

claim_id, patient_id, max(claim_amount) as claim_amount

group by 


select *
from Claims;

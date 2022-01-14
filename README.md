# Pewlett-Hackard-Analysis

## Overview of the Analysis

In the modules this week, we created a SQL database to manage data for employees of Pewlett-Hackard. In the past, they managed their employee data through Excel and VBA.  We have already analyzed the counts of employees who are likely to retire soon by department, and determined how many of these are managers. Now, we  have produced two new analyses: the number of prospective employees by job title, and the number of employees eligible for a proposed mentorship program.  Both of these should help Pewlett-Hackard start preparing for the oncoming "silver tsunami".

## Results

#### Who is retiring?
There are a huge number of employees who will be ready to retire soon.  More than 72,000 active employees will reach retirement age soon. They represent around 30% of the active work force at Pewlett Hackard.  Firstly, let's look at who is retiring.

#### Prospective retirees by job title

![retiring_titles.csv screenshot](https://github.com/mgsrichard/Pewlett-Hackard-Analysis/blob/main/retiring_titles.png)
  - The bulk of the retirements are coming in two positions, Senior Engineer and Senior Staff. This makes sense since these are the older and more experienced employees.  
  - In light of this, the mentorship program seems like a really great idea, to bring the next generation of employees into the ranks of senior positions.
  
#### Prospective employees by department
![retiring by dept](https://github.com/mgsrichard/Pewlett-Hackard-Analysis/blob/main/er_elig_depts.png)
  - The employees who will be retiring soon are distributed across all departments in the company, so any mentorship program needs to be for all departments.

#### Do we have enough people and the right people to be mentors?
We created a list of all the employees born during 1965 as a proposed list of mentors.  Let's look at how many there are and if they are spread evenly through departments and titles/positions.

![mentorship departments](https://github.com/mgsrichard/Pewlett-Hackard-Analysis/blob/main/mentorship_counts_dept.png)
  - 1,549 employees are in the proposed mentor group.  That is approximately 0.7% of all employees and breaks down to roughly one mentor per 150 employees.  (Even though some of the employees included in these count retire soon, for our analysis, we are assuming that those positions will be replaced by younger employees and the company will continue to have the same number of  employees it has today). 
  - We calculated the percentage of mentors and active employees in each department, and the good news is that the proposed mentors are spread evenly through the departments. The average number of employees per mentor is fairly close to the company-wide average of 150 for most departments.

![mentorship titles](https://github.com/mgsrichard/Pewlett-Hackard-Analysis/blob/main/mentorship_counts_title.png)
  - We completed a similar breakdown and analysis by job title, and the results are very similar. Proposed mentors still have around 150 employees on average across job titles and again, they are distributed evenly among the job titles. 
 
## Summary
A big demographic wave is coming for Pewlett-Hackard, with 72,458 employees coming eligible for retirement soon. Luckily, the employees who we have identified for the mentorship program are spread out evenly through the company, proportionally representing departments and job titles within the company.

As a final note, if you should decide to widen the eligibility window for the mentorship program, and include those born in 1964 and 1963 as well, it would create a much larger pool of employees who could participate.  Here are tables showing the numbers of employees born in those years by job title.

#### Employees born in 1964 by job title
![mentorship 64](https://github.com/mgsrichard/Pewlett-Hackard-Analysis/blob/main/mentorship_counts_64.png)

#### Employees born in 1963 by job title
![mentorship 63](https://github.com/mgsrichard/Pewlett-Hackard-Analysis/blob/main/mentorship_counts_63.png)

The addition of this group to the mentorship program could greatly increase the number particpating, which could be very helpful given the sheer number of employees who are about to start retiring.


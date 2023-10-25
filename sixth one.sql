

-- 8.1 Obtain the names of all physicians that have performed a medical procedure they have never been certified to perform:

select distinct p.name from physician p where p.employeeid in (select distinct u.physician from undergoes u left join trained_in t on 
u.physician = t.physician and u.treatment = t.treatment where u.dateundergoes < t.certificationdate or t.certificationdate is null);


-- 8.2 Same as the previous query, but include additional information:

select distinct p.name as physician_name, pr.name as procedure_name, u.dateundergoes, pt.name as patient_name from physician p inner join
 undergoes u on p.employeeid = u.physician inner join procedures pr on u.treatment = pr.code inner join patient pt on u.patient = pt.ssn 
 where p.employeeid in (select distinct u.physician from undergoes u left join trained_in t on u.physician = t.physician and u.treatment = 
 t.treatment where u.dateundergoes < t.certificationdate or t.certificationdate is null);
 
 
-- 8.3 Obtain the names of physicians who performed a certified procedure after their certification expired:

select distinct p.name from physician p inner join undergoes u on p.employeeid = u.physician inner join trained_in t on
 u.physician = t.physician and u.treatment = t.treatment where u.dateundergoes > t.certificationexpires;
 
-- 8.4 Same as the previous query, but include additional information:

select distinct p.name as physician_name, pr.name as procedure_name, u.dateundergoes, pt.name as patient_name, t.certificationexpires 
from physician p inner join undergoes u on p.employeeid = u.physician inner join trained_in t on u.physician = t.physician and u.treatment = 
t.treatment inner join procedures pr on u.treatment = pr.code inner join patient pt on u.patient = pt.ssn where u.dateundergoes > 
t.certificationexpires;

-- 8.5 Obtain information for appointments where a patient met with a physician other than their primary care physician:

select pt.name as patient_name, p.name as physician_name, n.name as nurse_name, a.start, a.end, a.examinationroom, pcp.name as 
primary_care_physician from appointment a inner join patient pt on a.patient = pt.ssn inner join physician p on a.physician = p.employeeid 
left join nurse n on a.prepnurse = n.employeeid left join physician pcp on pt.pcp = pcp.employeeid where a.physician <> pt.pcp;

-- 8.6 Select rows from Undergoes that exhibit inconsistencies with the Stay table:

select u.* from undergoes u left join stay s on u.stay = s.stayid where u.patient <> s.patient;

-- 8.7 Obtain the names of all nurses who have ever been on call for room 123:

select distinct n.name from on_call oc inner join nurse n on oc.nurse = n.employeeid where oc.blockfloor = 1 and oc.blockcode = 1;

-- 8.8 Count the number of appointments in each examination room:

select examinationroom, count(*) as appointmentcount from appointment group by examinationroom;

-- 8.9 Obtain the names of patients meeting specific criteria:

select pt.name as patient_name, pcp.name as primary_care_physician from patient pt inner join physician pcp on pt.pcp = 
pcp.employeeid where pt.ssn in (select distinct pr.patient from prescribes pr where pr.physician = pt.pcp and pr.medication in 
(select distinct pr2.medication from prescribes pr2 where pr2.physician = pt.pcp) and pt.ssn in (select distinct pt2.ssn from appointment a 
inner join nurse n on a.prepnurse = n.employeeid where n.registered = 1 group by pt2.ssn having count(distinct a.appointmentid) >= 2) 
and pt.pcp not in (select distinct d.head from department d));

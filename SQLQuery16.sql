

select count(*) from clinicaldata

select * into new_table1 from clinicaldata

select top 5 * from new_table1

select max(year(admissiondate)) maximum from new_table1

select min(year(admissiondate)) minimum from new_table1

update new_table1 
set AdmissionDate=
		case when year(AdmissionDate)>2030
		then dateadd(day,(abs(checksum(newid())))%(DATEDIFF(day,'2024-01-01','2030-12-31')+1),'2024-01-01')
		else admissiondate
		end
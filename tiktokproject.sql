use patients_appointment;
select * from studentperformancefactors;
# adding an id column to distinguish each row
alter table studentperformancefactors
add column id  int auto_increment primary key;

# checking if there exists any duplicate
with cte as(
select *,row_number() over (partition by Hours_Studied,Attendance,Access_to_Resources,Sleep_Hours,
Family_Income order by id) as row_num from studentperformancefactors order by id)
select * from cte where row_num > 1;

# EDA
select min(Hours_Studied),max(Hours_Studied) from studentperformancefactors;
select count(distinct(Hours_Studied)) from studentperformancefactors;
# categorizing column Hours_Studied
select (case 
			when Hours_Studied between 8 and 12 then '8-12 hrs'
			when Hours_Studied between 12 and 16 then '13-16 hrs'
			when Hours_Studied between 16 and 20 then '17-20 hrs'
			else '20 and above' end) as Hours_Studied
            from studentperformancefactors;
alter table studentperformancefactors
add column Hours_StudiedCat nvarchar(225);

update studentperformancefactors
set Hours_StudiedCat = case 
			when Hours_Studied between 8 and 12 then '8-12 hrs'
			when Hours_Studied between 12 and 16 then '13-16 hrs'
			when Hours_Studied between 16 and 20 then '17-20 hrs'
			else '20 and above' end;
            
select Attendance from studentperformancefactors;
select (case 
			when Attendance between 90 and 100 then '90-99'
			when Attendance between 80 and 89 then '80-89'
			when Attendance between 70 and 79 then '70-79'
            when Attendance between 60 and 69 then '60-69'
			else Attendance end) as Attendance
            from studentperformancefactors;
alter table studentperformancefactors
add column AttendanceCat nvarchar(225);

update studentperformancefactors
set AttendanceCat = case 
			when Attendance between 90 and 100 then '90-99'
			when Attendance between 80 and 89 then '80-89'
			when Attendance between 70 and 79 then '70-79'
            when Attendance between 60 and 69 then '60-69'
			else Attendance end;

# between male and female, who dropped much compared to previous exam
select Gender,sum(Previous_Scores) as previous_score,sum(Exam_Score) as present_score
,sum(Previous_Scores-Exam_Score) as Dropped_Marks from 
studentperformancefactors where Previous_Scores>Exam_Score
group by Gender;

select * from studentperformancefactors;
# Comparing exam score with various features
select Parental_Involvement, sum(Exam_Score) as Exam_Score,sum(Previous_Scores) as previous_score
from studentperformancefactors
group by Parental_Involvement order by Exam_Score desc;

select Access_to_Resources, sum(Exam_Score) as Exam_Score,sum(Previous_Scores) as previous_score
from studentperformancefactors
group by Access_to_Resources order by Exam_Score desc;

select Extracurricular_Activities, sum(Exam_Score) as Exam_Score,sum(Previous_Scores) as previous_score
from studentperformancefactors
group by Extracurricular_Activities order by Exam_Score desc;

select Sleep_Hours, sum(Exam_Score) as Exam_Score,sum(Previous_Scores) as previous_score
from studentperformancefactors
group by Sleep_Hours order by Exam_Score desc;

select Motivation_Level, sum(Exam_Score) as Exam_Score,sum(Previous_Scores) as previous_score
from studentperformancefactors
group by Motivation_Level order by Exam_Score desc;

select Internet_Access, sum(Exam_Score) as Exam_Score,sum(Previous_Scores) as previous_score
from studentperformancefactors
group by Internet_Access order by Exam_Score desc;

select Family_Income, sum(Exam_Score) as Exam_Score,sum(Previous_Scores) as previous_score
 from studentperformancefactors
group by Family_Income order by Exam_Score desc;

select Peer_Influence, sum(Exam_Score) as Exam_Score,sum(Previous_Scores) as previous_score
 from studentperformancefactors
group by Peer_Influence order by Exam_Score desc;

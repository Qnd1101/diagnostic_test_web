drop table tbl_patient_202004;
create table tbl_patient_202004(
            p_no char(4) primary key,
            p_name varchar2(20),
            p_birth char(8),
            p_gender char(1),
            p_tel1 char(3),
            p_tel2 char(4),
            p_tel3 char(4),
            p_city char(2)
);

insert into tbl_patient_202004 values('1001', '김환자', '19850301', 'M', '010', '2222', '0001', '10');
insert into tbl_patient_202004 values('1002', '이환자', '19900301', 'M', '010', '2222', '0002', '20');
insert into tbl_patient_202004 values('1003', '박환자', '19770301', 'F', '010', '2222', '0003', '30');
insert into tbl_patient_202004 values('1004', '조환자', '19650301', 'F', '010', '2222', '0004', '10');
insert into tbl_patient_202004 values('1005', '황환자', '19400301', 'M', '010', '2222', '0005', '40');
insert into tbl_patient_202004 values('1006', '양환자', '19440301', 'F', '010', '2222', '0006', '40');
insert into tbl_patient_202004 values('1007', '허환자', '19760301', 'F', '010', '2222', '0007', '10');

drop table tbl_lab_test_202004;
create table tbl_lab_test_202004(
	t_code char(4) primary key,
	t_name varchar2(20)
);

insert into tbl_lab_test_202004 values('T001', '결핵');
insert into tbl_lab_test_202004 values('T002', '장티푸스');
insert into tbl_lab_test_202004 values('T003', '수두');
insert into tbl_lab_test_202004 values('T004', '홍역');
insert into tbl_lab_test_202004 values('T005', '콜레라');

select * from tbl_lab_test_202004;

drop table tbl_result_202004;
create table tbl_result_202004(
	p_no char(4) ,
	t_code char(4),
	t_sdate date,
	t_status char(1),
	t_ldate date,
	t_result char(1),
	primary key(p_no, t_code, t_sdate)
);

insert into tbl_result_202004 values('1001', 'T001', '2020-01-01', '1','2020-01-02','X');
insert into tbl_result_202004 values('1002', 'T002', '2020-01-01', '2','2020-01-02','P');
insert into tbl_result_202004 values('1003', 'T003', '2020-01-01', '2','2020-01-02','N');
insert into tbl_result_202004 values('1004', 'T004', '2020-01-01', '2','2020-01-02','P');
insert into tbl_result_202004 values('1005', 'T005', '2020-01-01', '2','2020-01-02','P');
insert into tbl_result_202004 values('1006', 'T001', '2020-01-01', '2','2020-01-02','N');
insert into tbl_result_202004 values('1007', 'T002', '2020-01-01', '2','2020-01-02','P');
insert into tbl_result_202004 values('1005', 'T003', '2020-01-01', '2','2020-01-02','P');
insert into tbl_result_202004 values('1006', 'T004', '2020-01-01', '2','2020-01-02','N');
insert into tbl_result_202004 values('1007', 'T005', '2020-01-01', '2','2020-01-02','N');

--- 환자조회 ---
환자번호, 환자성명, 생년월일(년, 월, 일 넣기), 성별, 전화번호(연결 후 사이에 하이픈), 지역
select p_no as 환자번호, p_name as 환자성명,
	substr(p_birth, 1, 4) || '년' || substr(p_birth, 5, 2) || '월' || substr(p_birth, 7, 2) || '일' as 생년월일,
	case when p_gender = 'M' then '남' else '여' end as 성별,
	p_tel1 || '-' || p_tel2 || '-' || p_tel3 as 전화번호,
	case p_city when '10' then '서울' when '20' then '경기' when '30' then '강원' else '대구' end as 지역 
from tbl_patient_202004;

--- 검사결과조회 ---
환자번호(pa), 환자명(pa), 검사명(la), 검사시작일(re), 검사상태(re), 검사완료일(re), 검사결과(re)
select pa.p_no as 환자번호, pa.p_name as 환자명, la.t_name as 검사명,
		to_char(re.t_sdate, 'yyyy-mm-dd') as 검사시작일, 
		case re.t_status when '1' then '검사중' else '검사완료' end as 검사상태,
		to_char(re.t_ldate, 'yyyy-mm-dd') as 검사완료일, 
		case re.t_result when 'X' then '미입력' when 'P' then '양성' else '음성' end as 검사결과
from tbl_patient_202004 pa, tbl_lab_test_202004 la, tbl_result_202004 re
where pa.p_no = re.p_no and re.t_code = la.t_code
order by 환자번호 asc, 검사결과 asc, 검사명 desc;

--- 지역별검사건수 ---
지역코드, 지역명, 검사건수
select p_city as 지역코드, 
	case p_city 
	when '10' then '서울' 
	when '20' then '경기' 
	when '30' then '강원' 
	else '대구' end as 지역명,
	count(*) as 검사건수
from tbl_patient_202004 pa, tbl_result_202004 re
where pa.p_no = re.p_no
group by p_city
order by 지역코드 asc;
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "DB.DBConnect" %>
<%@ page import = "java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String sql = "select pa.p_no as 환자번호, pa.p_name as 환자명, la.t_name as 검사명, "
			+"to_char(re.t_sdate, 'yyyy-mm-dd') as 검사시작일, "
			+"case re.t_status when '1' then '검사중' else '검사완료' end as 검사상태, "
			+"to_char(re.t_ldate, 'yyyy-mm-dd') as 검사완료일, "
			+"case re.t_result when 'X' then '미입력' when 'P' then '양성' else '음성' end as 검사결과 "
			+"from tbl_patient_202004 pa, tbl_lab_test_202004 la, tbl_result_202004 re "
			+"where pa.p_no = re.p_no and re.t_code = la.t_code "
			+"order by 환자번호 asc, 검사결과 asc, 검사명 desc";
	Connection conn = DBConnect.getConnection();
	PreparedStatement ps = conn.prepareStatement(sql);
	ResultSet rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검사결과조회</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<header>
	<jsp:include page="layout/header.jsp"></jsp:include>
</header>
<nav>
	<jsp:include page="layout/nav.jsp"></jsp:include>
</nav>
<section class = "section">
	<h2>검사결과조회</h2>
	<table border="1" style="margin-left:auto; margin-right: auto; text-align : center;">
	<tr>
		<th>환자번호</th>
		<th>환자명</th>
		<th>검사명</th>
		<th>검사시작일</th>
		<th>검사상태</th>
		<th>검사완료일</th>
		<th>검사결과</th>
	</tr>
	<% while(rs.next()) { %>
	<tr>
		<td><%= rs.getString("환자번호") %></td>
		<td><%= rs.getString("환자명") %></td>
		<td><%= rs.getString("검사명") %></td>
		<td><%= rs.getString("검사시작일") %></td>
		<td><%= rs.getString("검사상태") %></td>
		<td><%= rs.getString("검사완료일") %></td>
		<td><%= rs.getString("검사결과") %></td>
	</tr>
	<% } %>
	</table>
</section>
<footer>
	<jsp:include page="layout/footer.jsp"></jsp:include>
</footer>
</body>
</html>
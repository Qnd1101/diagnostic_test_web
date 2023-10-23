<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "DB.DBConnect" %>
<%@ page import = "java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String sql = "select p_no as 환자번호, p_name as 환자성명, "
			+"substr(p_birth, 1, 4) || '년' || substr(p_birth, 5, 2) || '월' || substr(p_birth, 7, 2) || '일' as 생년월일, "
			+"case when p_gender = 'M' then '남' else '여' end as 성별, "
			+"p_tel1 || '-' || p_tel2 || '-' || p_tel3 as 전화번호, "
			+"case p_city when '10' then '서울' when '20' then '경기' when '30' then '강원' else '대구' end as 지역 "
			+"from tbl_patient_202004";
	Connection conn = DBConnect.getConnection();
	PreparedStatement ps = conn.prepareStatement(sql);
	ResultSet rs = ps.executeQuery();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>환자조회</title>
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
	<h2>환자조회</h2>
	<table border="1" style="margin-left:auto; margin-right: auto; text-align : center;">
		<tr>
			<th>환자번호</th>
			<th>환자성명</th>
			<th>생년월일</th>
			<th>성별</th>
			<th>전화번호</th>
			<th>지역</th>
		</tr>
		<% while(rs.next()) { %>
		<tr>
			<td><%= rs.getString("환자번호") %></td>
			<td><%= rs.getString("환자성명") %></td>
			<td><%= rs.getString("생년월일") %></td>
			<td><%= rs.getString("성별") %></td>
			<td><%= rs.getString("전화번호") %></td>
			<td><%= rs.getString("지역") %></td>
		</tr>
		<% } %>
	</table>
</section>
<footer>
	<jsp:include page="layout/footer.jsp"></jsp:include>
</footer>
</body>
</html>
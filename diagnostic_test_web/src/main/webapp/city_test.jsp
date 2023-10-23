<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "DB.DBConnect" %>
<%@ page import = "java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String sql = "select p_city as 지역코드, "
				+"case p_city "
				+"when '10' then '서울' "
				+"when '20' then '경기' "
				+"when '30' then '강원' "
				+"else '대구' end as 지역명, "
				+"count(*) as 검사건수 "
				+"from tbl_patient_202004 pa, tbl_result_202004 re "
				+"where pa.p_no = re.p_no "
				+"group by p_city "
				+"order by 지역코드 asc";
	Connection conn = DBConnect.getConnection();
	PreparedStatement ps = conn.prepareStatement(sql);
	ResultSet rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지역별검사건수</title>
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
	<h2>(지역별)검사건수통계</h2>
	<table border="1" style="margin-left:auto; margin-right: auto; text-align : center;">
		<tr>
			<th>지역코드</th>
			<th>지역명</th>
			<th>검사건수</th>
		</tr>
		<% while(rs.next()) { %>
		<tr>
			<td><%= rs.getString("지역코드") %></td>
			<td><%= rs.getString("지역명") %></td>
			<td><%= rs.getString("검사건수") %></td>
		</tr>
		<% } %>
	</table>
</section>
<footer>
	<jsp:include page="layout/footer.jsp"></jsp:include>
</footer>
</body>
</html>
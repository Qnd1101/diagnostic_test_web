<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "DB.DBConnect" %>
<%@ page import = "java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String sql = "insert into tbl_result_202004 values(?, ?, ?, ?, ?, ?)";
	
	Connection conn = DBConnect.getConnection();
	PreparedStatement ps = conn.prepareStatement(sql);
	
	ps.setString(1, request.getParameter("p_no"));
	ps.setString(2, request.getParameter("t_code"));
	ps.setString(3, request.getParameter("t_sdate"));
	ps.setString(4, request.getParameter("t_status"));
	ps.setString(5, request.getParameter("t_ldate"));
	ps.setString(6, request.getParameter("t_result"));
	
	ps.executeUpdate();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:forward page="result_list.jsp"></jsp:forward>
</body>
</html>
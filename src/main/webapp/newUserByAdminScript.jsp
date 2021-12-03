<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "cs336proj.*"%>
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	String userName = request.getParameter("userName");
	String password = request.getParameter("password");
	String fName = request.getParameter("fName");
	String lName = request.getParameter("lName");
	String role = request.getParameter("role");
	registerDao db = new registerDao();
	Connection con = db.getConnection();
	
	String query = "INSERT INTO user VALUES(?,?,?,?,?)";
	PreparedStatement ps = con.prepareStatement(query);
	ps.setString(1, userName);
	ps.setString(2, password);
	ps.setString(3, fName);
	ps.setString(4, lName);
	ps.setString(5, role);
	ps.executeUpdate();
	con.close();
	response.sendRedirect("AdminLoginSuccess.jsp");
%>
</body>
</html>
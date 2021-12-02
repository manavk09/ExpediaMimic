<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "cs336proj.*"%>
    
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
		String airportID = request.getParameter("Airport_id");
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		PreparedStatement stmnt = con.prepareStatement("insert into airport values(?)");
		stmnt.setString(1, airportID);
		stmnt.executeUpdate();
		response.sendRedirect("customerRepLoginSuccess.jsp");
	

%>

</body>
</html>
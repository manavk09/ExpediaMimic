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
		String aircraftID = request.getParameter("Aircraft_id");
		String numSeats = request.getParameter("num_seats");
		String operatingDays = request.getParameter("operating_days");
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		PreparedStatement stmnt = con.prepareStatement("insert into aircraft values(?,?,?)");
		stmnt.setString(1, aircraftID);
		stmnt.setString(2, numSeats);
		stmnt.setString(3,operatingDays);
		stmnt.executeUpdate();
		response.sendRedirect("customerRepLoginSuccess.jsp");
	

%>

</body>
</html>
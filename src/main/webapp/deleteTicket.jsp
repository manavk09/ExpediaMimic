<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "cs336proj.*"%>
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Deleting ticket</title>
</head>
<body>
<%
	registerDao db = new registerDao();
	Connection con = db.getConnection();
	String query = "DELETE FROM ticket WHERE Ticket_num = ?";
	PreparedStatement ps = con.prepareStatement(query);
	ps.setString(1, request.getParameter("ticketNum"));
	ps.executeUpdate();
	response.sendRedirect("viewUpcomingCustomerReservations.jsp");
%>

</body>
</html>
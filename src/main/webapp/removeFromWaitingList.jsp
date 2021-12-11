<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "cs336proj.*" %>
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Removing from waiting list</title>
</head>
<body>
<%
	registerDao db = new registerDao();
	Connection con = db.getConnection();
	String[] waitInfo = request.getParameter("itemInfo").split(",");
	String flightnum = waitInfo[0];
	String flightairline = waitInfo[1];
	String queryDelete = "DELETE FROM waitinglist WHERE userid = ? and flightnum = ? and flightairline = ?";
	PreparedStatement ps = con.prepareStatement(queryDelete);
	ps.setString(1, (String)session.getAttribute("customerUsername"));
	ps.setString(2, flightnum);
	ps.setString(3, flightairline);
	ps.executeUpdate();
	response.sendRedirect("customerLoginSuccess.jsp");
%>
</body>
</html>
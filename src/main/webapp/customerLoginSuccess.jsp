<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "cs336proj.*" %>
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find Flights</title>
</head>
<body>
<%
	String username = LoginServelet.userName;
	session.setAttribute("userType", "Customer");
	session.setAttribute("customerUsername", username);
%>
<h1>Welcome <%= username %>
<a href = "logoutSuccess.jsp"><button style="float: right" >Logout</button></a>
</h1>
<div><a href = "customerForum.jsp"><button style="float: right">Go to Forum</button></a></div>

<form action = "viewPastCustomerReservations.jsp">
	<input type = "submit" value = "View your past flight reservations">
</form>

<form action = "viewUpcomingCustomerReservations.jsp">
	<input type = "submit" value = "View your upcoming flight reservations">
</form>

<form action = "searchFlights.jsp" method = "post">
	<input type = "submit" value = "Search for flights">
</form>
</body>
</html>
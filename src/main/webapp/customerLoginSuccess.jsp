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

<div>
	<form action="searchFlights.jsp" method= "post">
		<h2>
			<label>Departure Airport: </label><input type="text" name="departure-airport">
			<label>Destination Airport: </label><input type="text" name="destination-airport">
			<input type="submit" name="search-type" value="Search by airports">
		</h2>
		<div style="padding: 5px">
			<label for="one-way-date"> Enter date for one way flights</label>
			<input id="one-way-date" type="date" name="one_way_date">
			<input type="submit" name="search-type" value="Search One way flights">
			<br> <input type="checkbox" name="flex" value="flexible">Flexible
		</div>
		<div style="padding: 5px">
			<label for="roundtrip-date"> Enter date for round-trip flights</label>
			<input id="roundtrip-date" type="date" name="roundtrip_date">
			<input id="roundtrip-date1" type="date" name="roundtrip_date1">
			<input type="submit" name="search-type" value="Search round trip flights">
			<br> <input type="checkbox" name="flex" value="flexible">Flexible
		</div>
	</form>
</div>
</body>
</html>
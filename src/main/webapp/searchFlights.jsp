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
	String backPage;
	if(session.getAttribute("userType").equals("Customer")){
		backPage = "customerLoginSuccess.jsp";
	}
	else{
		backPage = "customerRepLoginSuccess.jsp";
	}
%>
<form action = <%= backPage %> method = "post">
	<input type = "submit" value = "Back">
</form>

<h1>Search for flights</h1>
<div>
	<form action="searchForFlight.jsp" method= "post">
		<h2>
			<label>Departure Airport: </label><input type="text" name="departure-airport">
			<label>Destination Airport: </label><input type="text" name="destination-airport">
		</h2>
		<div style="padding: 5px">
			<label for="one-way-date"> Enter date for one way flights</label>
			<input id="one-way-date" type="date" name="one_way_date">
			<input type="submit" name="search-type" value="Search One way flights">
			<br> <input type="checkbox" name="flex" value="flexible">Flexible
		</div>
		<div style="padding: 5px">
			<label for="roundtrip-date"> Enter dates for round-trip flights</label>
			<input id="roundtrip-date" type="date" name="roundtrip_date1">
			<input id="roundtrip-date1" type="date" name="roundtrip_date2">
			<input type="submit" name="search-type" value="Search round trip flights">
			<br> <input type="checkbox" name="flex" value="flexible">Flexible
		</div>
	</form>
</div>
</body>
</html>
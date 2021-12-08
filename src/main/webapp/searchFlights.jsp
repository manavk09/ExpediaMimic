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
	String backPage;
	if(session.getAttribute("userType").equals("Customer")){
		backPage = "customerLoginSuccess.jsp";
	}
	else{
		backPage = "customerRepLoginSuccess.jsp";
	}
	registerDao db = new registerDao();
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
%>
<form action = <%= backPage %> method = "post">
	<input type = "submit" value = "Back">
</form>

<h1>Search for flights</h1>
<div>
	<form action="searchForFlight.jsp" method= "post">
		<h2>
			<%	String str = "SELECT distinct Departure_Airport FROM flight";
				ResultSet result = stmt.executeQuery(str); %>
			<label>Departure Airport: </label><input placeholder="Departure Airport" type="text" name="departure-airport" list="depart-airports">
			<datalist id="depart-airports">
				<%while(result.next()){ %>
					<option value=<%= result.getString("Departure_Airport") %>>
				<%} %>
			</datalist>
			<%	str = "SELECT distinct Destination_Airport FROM flight";
				result = stmt.executeQuery(str); %>
			<label>Destination Airport: </label><input placeholder="Destination Airport" type="text" name="destination-airport" list="dest-airports">
			<datalist id="dest-airports">
				<%while(result.next()){ %>
					<option value=<%= result.getString("Destination_Airport") %>>
				<%} %>
			</datalist>
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
		<div>
			<label for="sort">Sort by:</label>
			<select name="Sort" id="sort">
  				<option value="Price low to high">Price low to high</option>
  				<option value="Price high to low">Price high to low</option>
				<option value="Take off time earlier to later">Take off time earlier to later</option>
  				<option value="Take off time later to earlier">Take off time later to earlier</option>
  				<option value="Landing time earlier to later">Landing time earlier to later</option>
  				<option value="Landing time later to earlier">Landing time later to earlier</option>
  				<option value="Duration of flights shortest">Duration of flights shortest</option>
  				<option value="Duration of flights longest">Duration of flights longest</option>
			</select>
		</div>
		<div>
			<table>
				<tr>
					<th>Selection</th>
					<th>Filter Type</th>
				</tr>
				<tr>
					<td><input type = "radio" name = "Filter-Type" value="price"></td>
					<td><label>Total fare: </label>
					<td><input placeholder = "Minimum total fare price" type="number" name= "price-min"></td>
					<td><input placeholder = "Maximum total fare price" type="number" name= "price-max"></td>
				</tr>
				<tr>
					<td><input type = "radio" name = "Filter-Type" value="airline"></td>
					<td><label>Airline: </label>
					<td><input placeholder = "Airline ID" type="text" name= "airline-id"></td>
				</tr>
				<tr>
					<td><input type = "radio" name = "Filter-Type" value="take-off-time"></td>
					<td><label>Take off time: </label>
					<td><input placeholder = "Minimum take off time" type="time" name= "min-take-off-time"></td>
					<td><input placeholder = "Maximum take off time" type="time" name= "max-take-off-time"></td>
				</tr>
				<tr>
					<td><input type = "radio" name = "Filter-Type" value="landing-time"></td>
					<td><label>Landing Time: </label>
					<td><input placeholder = "Minimum landing time" type="time" name= "min-landing-time"></td>
					<td><input placeholder = "Maximum landing time" type="time" name= "max-landing-time"></td>
				</tr>
			</table>
		</div>
	</form>
</div>
</body>
</html>
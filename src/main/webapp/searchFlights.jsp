<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "cs336proj.*" %>
<%@ page import = "java.io.*, java.util.*, java.sql.*, java.time.*"%>
<!DOCTYPE html>
<html>
<style>
th, td {
  border:1px solid black;
}
</style>
<head>
<meta charset="ISO-8859-1">
<title>Flights</title>
</head>
<body>
<a href="customerLoginSuccess.jsp"><button style="float: right">Go back to your home page</button></a>
<%
	registerDao db = new registerDao();
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
	String str = "SELECT * FROM flight where Departure_Airport = '" + request.getParameter("departure-airport") + "' and Destination_Airport = '" + request.getParameter("destination-airport") + "'";
	ResultSet result = stmt.executeQuery(str);
	String option = request.getParameter("search-type");
%>

<% if(option.equals("Search by airports")){
			str = "SELECT * FROM flight where Departure_Airport = '" + request.getParameter("departure-airport") + "' and Destination_Airport = '" + request.getParameter("destination-airport") + "'";
			result = stmt.executeQuery(str);
	} 
	else if(option.equals("Search One way flights")){
			if(request.getParameter("flex") == null){
				str = "SELECT * FROM flight where Departure_Airport = '" + request.getParameter("departure-airport") + "' and Destination_Airport = '" + request.getParameter("destination-airport") + "' and isRoundTrip = 0 and date(Arrival_Time) = '" + request.getParameter("one_way_date") + "'";
				result = stmt.executeQuery(str);
			} else{
					LocalDate ld = LocalDate.parse(request.getParameter("one_way_date"));
					LocalDate minusThreeDays = ld.minusDays(3);
					LocalDate plusThreeDays = ld.plusDays(4); //adds one more due to time
					str = "SELECT * FROM flight where Departure_Airport = '" + request.getParameter("departure-airport") + "' and Destination_Airport = '" + request.getParameter("destination-airport") + "' and isRoundTrip = 0 and Arrival_Time between ('" + minusThreeDays + "') and ('" + plusThreeDays + "')";
					result = stmt.executeQuery(str);
			} 
	} 
	else if(option.equals("Search round trip flights")){
		if(request.getParameter("flex") == null){
		LocalDate ld = LocalDate.parse(request.getParameter("roundtrip_date"));
		LocalDate ld1 = LocalDate.parse(request.getParameter("roundtrip_date1"));
		LocalDate plusOneDays = ld1.plusDays(1);
		str = "SELECT * FROM flight where Departure_Airport = '" + request.getParameter("departure-airport") + "' and Destination_Airport = '" + request.getParameter("destination-airport") + "' and isRoundTrip = 1 and Arrival_Time between ('" + ld + "') and ('" + plusOneDays + "')";
		result = stmt.executeQuery(str);
		} else{ 
			LocalDate ld = LocalDate.parse(request.getParameter("roundtrip_date"));
			LocalDate ld1 = LocalDate.parse(request.getParameter("roundtrip_date1"));
			LocalDate minusThreeDays = ld.minusDays(3);
			LocalDate plusThreeDays = ld1.plusDays(4); //adds one more due to time
			str = "SELECT * FROM flight where Departure_Airport = '" + request.getParameter("departure-airport") + "' and Destination_Airport = '" + request.getParameter("destination-airport") + "' and isRoundTrip = 1 and Arrival_Time between ('" + minusThreeDays + "') and ('" + plusThreeDays + "')";
			result = stmt.executeQuery(str);
		}
	} %>
	<h1>Available Flights</h1>
	<table>
		<tr>
			<th>Flight Number</th>
			<th>Airline</th>
			<th>Departure Airport</th>
			<th>Destination Airport</th>
			<th>Departure Date</th>
			<th>Departure Time</th>
			<th>Arrival Date</th>
			<th>Arrival Time</th>
			<th>Type of Flight</th>
			<th>Type of trip</th>
		</tr>
		<% while(result.next()){ %>
			<tr>
				<td><%= result.getInt("Flight_num") %></td>
				<td><%= result.getString("ID_Airline") %></td>
				<td><%= result.getString("Departure_Airport") %></td>
				<td><%= result.getString("Destination_Airport") %></td>
				<td><%= result.getDate("Departure_Time") %></td>
				<td><%= result.getTime("Departure_Time") %></td>
				<td><%= result.getDate("Arrival_Time") %></td>
				<td><%= result.getTime("Arrival_Time") %></td>
				<% if(result.getBoolean("isDomestic")){ %>
					<td>Domestic</td>
					<%}
				   else{%>
				   		<td>International</td>
			   	   <%} %>
		   	    <% if(result.getBoolean("isRoundTrip")){ %>
					<td>Round Trip</td>
					<%}
				   else{%>
				   		<td>One Way</td>
			   	   <%} %>
			   	<td><input type="submit" name="Book flight"></td>
			</tr>
			<%} %>
	</table>
</body>
</html>
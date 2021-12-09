<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "cs336proj.*" %>
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find Flights</title>
<style>
	table, th, td {
		border: 1px solid black;
		padding: 2px;
	}
</style>
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

<%
	registerDao db = new registerDao();
	Connection con = db.getConnection();
	String waitingListQuery = "SELECT w.class, Flight_num, ID_Airline, ID_Aircraft, Departure_Airport, Destination_Airport, Departure_Time, Arrival_Time, Fair, travelType FROM waitinglist w, flight f WHERE w.flightnum = f.Flight_num and w.flightairline = f.ID_airline and w.userid = ?";
	PreparedStatement ps = con.prepareStatement(waitingListQuery);
	ps.setString(1, (String)session.getAttribute("customerUsername"));
	ResultSet waitingListResults = ps.executeQuery();
	
	if(!waitingListResults.next()){
		%>
		<h1>You have no flights on your waiting list.</h1>
		<%
	}
	else{
		%>
		<h1>All your waiting list flights:</h1>
		<table>
		<tr>
			<th>Class</th>
			<th>Flight number</th>
			<th>Airline</th>
			<th>Aircraft</th>
			<th>Departure Airport</th>
			<th>Destination Airport</th>
			<th>Departure Time</th>
			<th>Arrival Time</th>
			<th>Fare</th>
			<th>Travel Type</th>
		</tr>
		<%
		do{
			%>
			<tr>
				<td><%=waitingListResults.getString(1)%></td>
				<td><%=waitingListResults.getString(2)%></td>
				<td><%=waitingListResults.getString(3)%></td>
				<td><%=waitingListResults.getString(4)%></td>
				<td><%=waitingListResults.getString(5)%></td>
				<td><%=waitingListResults.getString(6)%></td>
				<td><%=waitingListResults.getString(7)%></td>
				<td><%=waitingListResults.getString(8)%></td>
				<td><%=waitingListResults.getString(9)%></td>
				<td><%=waitingListResults.getString(10)%></td>
			</tr>
			<%
		}
		while(waitingListResults.next());
		%>
		</table>
		<%
	}
	
	//Flights that are open on the waiting list:
	String openQuery = "SELECT w.class, f.Flight_num, f.ID_Airline, f.ID_Aircraft, f.Departure_Airport, f.Destination_Airport, f.Departure_Time, f.Arrival_Time, f.Fair, f.travelType FROM waitinglist w, flight f, aircraft a, (SELECT Flight_num, idline, count(*) BookedTickets FROM contains Group by Flight_num, idline) as bookedSeats WHERE w.userid = ? and w.flightnum = f.Flight_num and w.flightairline = f.ID_airline and a.Aircraft_id = f.ID_Aircraft and a.airlineid = f.ID_Airline and bookedSeats.Flight_num = f.Flight_num and bookedSeats.idline = f.ID_Airline and bookedSeats.BookedTickets < a.num_seats";
	ps = con.prepareStatement(openQuery);
	ps.setString(1, (String)session.getAttribute("customerUsername"));
	ResultSet openFlightsResult = ps.executeQuery();
	if(!openFlightsResult.next()){
		%>
		<h1>There are no openings in any of your waiting list flights.</h1>
		<%
	}
	else{
		%>
		<h1>There ARE openings in your waiting list flights! See them below:</h1>
		<table>
		<tr>
			<th>Class</th>
			<th>Flight number</th>
			<th>Airline</th>
			<th>Aircraft</th>
			<th>Departure Airport</th>
			<th>Destination Airport</th>
			<th>Departure Time</th>
			<th>Arrival Time</th>
			<th>Fare</th>
			<th>Travel Type</th>
		</tr>
		<%
		do{
			%>
			<tr>
				<td><%=openFlightsResult.getString(1)%></td>
				<td><%=openFlightsResult.getString(2)%></td>
				<td><%=openFlightsResult.getString(3)%></td>
				<td><%=openFlightsResult.getString(4)%></td>
				<td><%=openFlightsResult.getString(5)%></td>
				<td><%=openFlightsResult.getString(6)%></td>
				<td><%=openFlightsResult.getString(7)%></td>
				<td><%=openFlightsResult.getString(8)%></td>
				<td><%=openFlightsResult.getString(9)%></td>
				<td><%=openFlightsResult.getString(10)%></td>
			</tr>
			<%
		}
		while(openFlightsResult.next());
		%>
		</table>
		<%
		
	}
%>

<form action = "viewPastCustomerReservations.jsp">
	<input type = "submit" value = "View your past flight reservations">
</form>

<form action = "viewUpcomingCustomerReservations.jsp">
	<input type = "submit" value = "View your upcoming flight reservations">
</form>

<form action = "SearchFlights.jsp" method = "post">
	<input type = "submit" value = "Search for flights">
</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "cs336proj.*" %>
<%@ page import = "java.io.*, java.util.*, java.sql.*, java.time.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Flight Search Results</title>
<style>
	table, th, td {
		border: 1px solid black;
		padding: 2px;
	}
</style>
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
		
%>

<form action = <%=backPage%> method = "post">
	<input type = "submit" value = "Back">
</form>

<%
	String searchType = request.getParameter("search-type");
	String sortType = request.getParameter("Sort");
	int flex = 0;
	if(request.getParameter("flex") != null){
		flex = 3;
	}
	
	registerDao db = new registerDao();
	Connection con = db.getConnection();
	
	if(searchType.equals("Search One way flights")){
		PreparedStatement stmt = con.prepareStatement("SELECT * FROM flight where Departure_Airport = ? and Destination_Airport = ? and ABS(DATEDIFF(Departure_Time, ?)) <= ?");
		switch (sortType){
			case "Price low to high":
				stmt = con.prepareStatement("SELECT * FROM flight where Departure_Airport = ? and Destination_Airport = ? and ABS(DATEDIFF(Departure_Time, ?)) <= ? order by Fair");
				break;
			case "Price high to low":
				stmt = con.prepareStatement("SELECT * FROM flight where Departure_Airport = ? and Destination_Airport = ? and ABS(DATEDIFF(Departure_Time, ?)) <= ? order by Fair Desc");
				break;
			case "Take off time earlier to later":
				stmt = con.prepareStatement("SELECT * FROM flight where Departure_Airport = ? and Destination_Airport = ? and ABS(DATEDIFF(Departure_Time, ?)) <= ? order by Departure_Time");
				break;
		}
		stmt.setString(1, request.getParameter("departure-airport"));
		stmt.setString(2, request.getParameter("destination-airport"));
		stmt.setString(3, request.getParameter("one_way_date"));
		stmt.setInt(4, flex);
		ResultSet flights = stmt.executeQuery();
		
		if(!flights.next()){
			%>
			<h1>There are no flights for the given dates and airports.</h1>
			<%
		}
		else{
			%>
			<form action = "createTicketSubmit.jsp" method = "post">
			<table>
			<tr>
				<th>Selection</th>
				<th>Flight number</th>
				<th>Airline</th>
				<th>Aircraft</th>
				<th>Departure Airport</th>
				<th>Destination Airport</th>
				<th>Departure Time</th>
				<th>Arrival Time</th>
				<th>Fair</th>
				<th>International or Domestic</th>
				
			</tr>
			<%
			do{
				%>
				<tr>
					<td><input type = "radio" name = "flightInfo" value = <%=flights.getString(1) + "," + flights.getString(2) + "," + flights.getString(3) + "," + flights.getString(8)%>></td>
					<td><%=flights.getString(1) %></td>
					<td><%=flights.getString(2) %></td>
					<td><%=flights.getString(3) %></td>
					<td><%=flights.getString(4) %></td>
					<td><%=flights.getString(5) %></td>
					<td><%=flights.getString(6) %></td>
					<td><%=flights.getString(7) %></td>
					<td><%=flights.getString(8) %></td>
					<td><%=flights.getString(9) %></td>
				</tr>
				<%
			}
			while(flights.next());
			%>
			</table>
			Select class:<br>
			<input type = "radio" name = "class" id = "classEconomy" value = "Economy">
			<label for = "classEconomy">Economy</label><br>
			
			<input type = "radio" name = "class" id = "classBusiness" value = "Business">
			<label for = "classBusiness">Business</label><br>
		
			<input type = "radio" name = "class" id = "classFirst" value = "First">
			<label for = "classFirst">First</label><br>
			<input type = "submit" name = "action" value = "Confirm Ticket">
			</form>
			<%
		}
	}
	else{
		PreparedStatement stmt = con.prepareStatement("SELECT * FROM(SELECT * FROM flight WHERE Departure_Airport = ? and Destination_Airport = ? and ABS(DATEDIFF(Departure_Time, ?)) <= ?) as f1, flight f2 WHERE f2.Departure_Airport = ? and f2.Destination_Airport = ? and ABS(DATEDIFF(f2.Arrival_Time, ?)) <= ? and DATEDIFF(f1.Arrival_Time, f2.Departure_Time) < 0");
		stmt.setString(1, request.getParameter("departure-airport"));
		stmt.setString(2, request.getParameter("destination-airport"));
		stmt.setString(3, request.getParameter("roundtrip_date1"));
		stmt.setInt(4, flex);
		stmt.setString(5, request.getParameter("destination-airport"));
		stmt.setString(6, request.getParameter("departure-airport"));
		stmt.setString(7, request.getParameter("roundtrip_date2"));
		stmt.setInt(8, flex);
		ResultSet flights = stmt.executeQuery();
		
		if(!flights.next()){
			%>
			<h1>There are no round trip flights for the given dates and airports.</h1>
			<%
		}
		else{
			%>
			<form action = "createTicketSubmit.jsp" method = "post">
			<table>
			<tr>
				<th>Selection</th>
				<th>Flight set</th>
				
			</tr>
			<%
			do{
				%>
				<tr>
					<td>
						<input type = "radio" name = "roundFlightsInfo" value = <%=flights.getString(1) + "," + flights.getString(2) + "," + flights.getString(3) + "," + flights.getString(8) + ","+ flights.getString(10) + "," + flights.getString(11) + "," + flights.getString(12) + "," + flights.getString(17)%>>
					</td>
					<td>
						<table>
							<tr>
								<th>Flight number</th>
								<th>Airline</th>
								<th>Aircraft</th>
								<th>Departure Airport</th>
								<th>Destination Airport</th>
								<th>Departure Time</th>
								<th>Arrival Time</th>
								<th>Fair</th>
								<th>International or Domestic</th>
							<tr>
							<tr>
								<td><%=flights.getString(1) %></td>
								<td><%=flights.getString(2) %></td>
								<td><%=flights.getString(3) %></td>
								<td><%=flights.getString(4) %></td>
								<td><%=flights.getString(5) %></td>
								<td><%=flights.getString(6) %></td>
								<td><%=flights.getString(7) %></td>
								<td><%=flights.getString(8) %></td>
								<td><%=flights.getString(9) %></td>
							</tr>
							<tr>
								<td><%=flights.getString(10) %></td>
								<td><%=flights.getString(11) %></td>
								<td><%=flights.getString(12) %></td>
								<td><%=flights.getString(13) %></td>
								<td><%=flights.getString(14) %></td>
								<td><%=flights.getString(15) %></td>
								<td><%=flights.getString(16) %></td>
								<td><%=flights.getString(17) %></td>
								<td><%=flights.getString(18) %></td>
							</tr>
						</table>
						</td>
				</tr>
				<%
			}
			while(flights.next());
			%>
			</table>
			Select class:<br>
			
			<input type = "radio" name = "class" id = "classEconomy" value = "Economy">
			<label for = "classEconomy">Economy</label><br>
			
			<input type = "radio" name = "class" id = "classBusiness" value = "Business">
			<label for = "classBusiness">Business</label><br>
		
			<input type = "radio" name = "class" id = "classFirst" value = "First">
			<label for = "classFirst">First</label><br>
			<input type = "submit" name = "action" value = "Confirm Round Trip Ticket">
			</form>
			<%
		}
	}

%>

</body>
</html>
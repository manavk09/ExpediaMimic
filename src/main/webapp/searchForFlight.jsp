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
		border-collapse: collapse;
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
	String query;
	if(searchType.equals("Search One way flights")){
		query = "SELECT * FROM flight where Departure_Airport = ? and Destination_Airport = ? and ABS(DATEDIFF(Departure_Time, ?)) <= ?";
		if(request.getParameter("Filter-Type") != null){
			switch(request.getParameter("Filter-Type")){
				case "price" :
					query += " and Fair >= " + request.getParameter("price-min") + " and Fair <= " + request.getParameter("price-max");
					break;
				case "airline" :
					query += " and ID_Airline = " + request.getParameter("airline-id");
					break;
				case "take-off-time" :
					query += " and TIMEDIFF(TIME(Departure_Time), '" + request.getParameter("min-take-off-time") + "') >= 0 and TIMEDIFF(TIME(Departure_Time), '" + request.getParameter("max-take-off-time") + "') <= 0";
					break;
				case "landing-time" :
					query += " and TIMEDIFF(TIME(Arrival_Time), '" + request.getParameter("min-landing-time") + "') >= 0 and TIMEDIFF(TIME(Arrival_Time), '" + request.getParameter("max-landing-time") + "') <= 0";
					break;
			}
		}
		switch (sortType){
			case "Price low to high":
				query += " order by Fair";
				break;
			case "Price high to low":
				query += " order by Fair Desc";
				break;
			case "Take off time earlier to later":
				query += " order by Departure_Time";
				break;
			case "Take off time later to earlier":
				query += " order by Departure_Time Desc";
				break;
			case "Landing time earlier to later":
				query += " order by Arrival_Time";
				break;
			case "Landing time later to earlier":
				query += " order by Arrival_Time Desc";
				break;
			case "Duration of flights shortest":
				query += " order by TIMEDIFF(Arrival_Time,Departure_Time)";
				break;
			case "Duration of flights longest":
				query += " order by TIMEDIFF(Arrival_Time,Departure_Time) Desc";
				break;
		}
		PreparedStatement stmt = con.prepareStatement(query);
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
		query = "SELECT * FROM(SELECT * FROM flight WHERE Departure_Airport = ? and Destination_Airport = ? and ABS(DATEDIFF(Departure_Time, ?)) <= ?) as f1, flight f2 WHERE f2.Departure_Airport = ? and f2.Destination_Airport = ? and ABS(DATEDIFF(f2.Arrival_Time, ?)) <= ? and DATEDIFF(f1.Arrival_Time, f2.Departure_Time) < 0";
		if(request.getParameter("Filter-Type") != null){
			switch(request.getParameter("Filter-Type")){
				case "price" :
					query += " and (f1.Fair + f2.Fair) >= " + request.getParameter("price-min") + " and (f1.Fair + f2.Fair) <= " + request.getParameter("price-max");
					break;
				case "airline" :
					query += " and f1.ID_Airline = " + request.getParameter("airline-id") + " and f2.ID_Airline = " + request.getParameter("airline-id");
					break;
				case "take-off-time" :
					query += " and TIMEDIFF(TIME(f1.Departure_Time), '" + request.getParameter("min-take-off-time") + "') >= 0 and TIMEDIFF(TIME(f1.Departure_Time), '" + request.getParameter("max-take-off-time") + "') <= 0";
					break;
				case "landing-time" :
					query += " and TIMEDIFF(TIME(f2.Arrival_Time), '" + request.getParameter("min-landing-time") + "') >= 0 and TIMEDIFF(TIME(f2.Arrival_Time), '" + request.getParameter("max-landing-time") + "') <= 0";
					break;
			}
		}
		switch (sortType){
			case "Price low to high":
				query += " order by (f1.Fair + f2.Fair)";
				break;
			case "Price high to low":
				query += " order by (f1.Fair + f2.Fair) Desc";
				break;
			case "Take off time earlier to later":
				query += " order by f1.Departure_Time";
				break;
			case "Take off time later to earlier":
				query += " order by f1.Departure_Time Desc";
				break;
			case "Landing time earlier to later":
				query += " order by f2.Arrival_Time";
				break;
			case "Landing time later to earlier":
				query += " order by f2.Arrival_Time Desc";
				break;
			case "Duration of flights shortest":
				query += " order by (TIMEDIFF(f1.Arrival_Time,f1.Departure_Time) + TIMEDIFF(f2.Arrival_Time,f2.Departure_Time))";
				break;
			case "Duration of flights longest":
				query += " order by (TIMEDIFF(f1.Arrival_Time,f1.Departure_Time) + TIMEDIFF(f2.Arrival_Time,f2.Departure_Time)) Desc";
				break;
		}
		PreparedStatement stmt = con.prepareStatement(query);
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
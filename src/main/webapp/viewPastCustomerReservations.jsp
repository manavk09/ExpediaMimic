<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "cs336proj.*"%>
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View your reservations</title>
<style>
	table, th, td {
		border: 1px solid black;
		padding: 2px;
	}
</style>
</head>
<body>

<form action = "customerLoginSuccess.jsp" method = "post">
	<input type = "submit" value = "Back">
</form>

<%
	registerDao db = new registerDao();
	Connection con = db.getConnection();
	PreparedStatement stmt = con.prepareStatement("SELECT f.Flight_num, f.ID_Airline, f.Departure_Airport, f.Destination_Airport, f.Departure_Time, f.Arrival_Time, t.class, t.Ticket_num FROM flight f, contains c, books b, user u, ticket t WHERE t.Ticket_num = c.Ticket_num and f.Flight_num = c.Flight_num and c.Ticket_num = b.ticketNum and b.userId = u.Username and u.Username = ? and DATEDIFF(NOW(), f.Departure_Time) >= 0");
	stmt.setString(1, LoginServelet.userName);
	ResultSet reservations = stmt.executeQuery();
	
	if(!reservations.next()){
		%>
		<h1>You've had no past flight reservations.</h1>
		<%
	}
	else{
		%>
		<table>
			<tr>
				<th>Flight number</th>
				<th>Airline</th>
				<th>Departure Airport</th>
				<th>Arrival Airport</th>
				<th>Departure date/time</th>
				<th>Arrival date/time</th>
				<th>Class</th>
				<th>Ticket number</th>
			</tr>
			<%
			do{
				%>
				<tr>
					<td><%=reservations.getString(1) %></td>
					<td><%=reservations.getString(2) %></td>
					<td><%=reservations.getString(3) %></td>
					<td><%=reservations.getString(4) %></td>
					<td><%=reservations.getString(5) %></td>
					<td><%=reservations.getString(6) %></td>
					<td><%=reservations.getString(7) %></td>
					<td><%=reservations.getString(8) %></td>
				</tr>
				
				<%
			}
			while(reservations.next());
			%>
		</table>
		<%
	}
%>


</body>
</html>
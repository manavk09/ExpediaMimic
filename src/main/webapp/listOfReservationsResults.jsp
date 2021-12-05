<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "cs336proj.*"%>
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reservation List Results</title>
<style>
	table, th, td {
		border: 1px solid black;
		padding: 2px;
	}
</style>
</head>
<body>

	<form action = "listOfReservations.jsp" method = "post">
		<input type = "submit" value = "Back">
	</form>
	<%
	String action = request.getParameter("listingType");
	
	if(action.equals("Reservations by flight")){
		String flightAndAirline = request.getParameter("flightAndAirline");
		if(flightAndAirline != null){
			String[] flightInfos = flightAndAirline.split(",");
			registerDao db = new registerDao();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String str = "SELECT b.userId, c.Flight_num FROM contains c, books b WHERE c.Ticket_num = b.ticketNum and c.Flight_num = \'" + flightInfos[0] + "\' and c.idline = \'" + flightInfos[1] +  "\'";
			ResultSet reservations = stmt.executeQuery(str);
			
			if(!reservations.next()){
				%>
				<h1>There are no reservations for flight <%=flightAndAirline%>.</h1>
				<%
			}
			else{
				%>
				<h1>Reservations for airline <%=flightInfos[1]%></h1>
				
				<table>
				<tr>
					<th>Customer ID</th>
					<th>Flight Number</th>
				</tr>
				<%
				do{
					%>
					<tr>
						<td><%=reservations.getString(1)%></td>
						<td><%=reservations.getString(2)%></td>
					</tr>
					<%
				}
				while(reservations.next());
				%>
				</table>
				<%
			}
		}
		else{
			response.sendRedirect("listOfReservations.jsp");
		}
	}
	else if(action.equals("Reservations by customer")){
		String userid = request.getParameter("customer");
		if(userid != null){
			registerDao db = new registerDao();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String str = "SELECT b.userId, c.Flight_num, c.idline FROM contains c, books b WHERE c.Ticket_num = b.ticketNum and b.userId = \'" + userid + "\'";
			ResultSet reservations = stmt.executeQuery(str);
			
			if(!reservations.next()){
				%>
				<h1>There are no reservations for customer <%=userid%>.</h1>
				<%
			}
			else{
				%>
				<h1>Reservations for customer <%=userid%>:</h1>
				
				<table>
				<tr>
					<th>Customer ID</th>
					<th>Flight Number</th>
					<th>Airline</th>
				</tr>
				<%
				do{
					%>
					<tr>
						<td><%=reservations.getString(1)%></td>
						<td><%=reservations.getString(2)%></td>
						<td><%=reservations.getString(3)%></td>
					</tr>
					<%
				}
				while(reservations.next());
				%>
				</table>
				<%
			}
		}
		else{
			response.sendRedirect("listOfReservations.jsp");
			
		}
	}
	%>

</body>
</html>
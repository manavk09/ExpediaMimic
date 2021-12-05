<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "cs336proj.*"%>
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Summary Listing</title>
<style>
	table, th, td {
		border: 1px solid black;
		padding: 2px;
	}
</style>
</head>
<body>
<form method = "post" action = "summaryListings.jsp">
	<input type = "submit" value = "Back">
</form>

<%
	String action = request.getParameter("summaryType");
	if(action.equals("Summary by flight")){
		String flightAndAirline = request.getParameter("flightAndAirline");
		String[] flightInfos = flightAndAirline.split(",");
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		String str = "select c.Flight_num, c.idline, t.Ticket_num, sum(t.Fair + t.Booking_Fees) as revenue from contains c, ticket t where t.Ticket_num = c.Ticket_num and c.Flight_num = \'" + flightInfos[0] + "\' and c.idline = \'" + flightInfos[1] +  "\' group by Flight_num, idline, Ticket_num";
		ResultSet flights = stmt.executeQuery(str);
		
		stmt = con.createStatement();
		String str2 = "select c.Flight_num, c.idline, t.Ticket_num, sum(t.Fair + t.Booking_Fees) as revenue from contains c, ticket t where t.Ticket_num = c.Ticket_num and c.Flight_num = \'" + flightInfos[0] + "\' and c.idline = \'" + flightInfos[1] +  "\' group by Flight_num, idline";
		ResultSet totalRevenue = stmt.executeQuery(str2);
		
		if(!totalRevenue.next()){
			%>
			<h1>
				There is no revenue for flight <%=flightAndAirline%>.
			</h1>
			<%
		}
		else{
			%>
			<h1>
				Total revenue for flight <%=flightAndAirline%>: <%=totalRevenue.getString(4)%> dollars.
			</h1>
			<table>
			<tr>
				<th>Flight number</th>
				<th>Airline</th>
				<th>Ticket number</th>
				<th>Revenue</th>
			</tr>
			<%
				while(flights.next()){%>
					<tr>
						<td><%=flights.getString(1)%></td>
						<td><%=flights.getString(2)%></td>
						<td><%=flights.getString(3)%></td>
						<td><%=flights.getString(4)%></td>
					</tr>
				<%}
			%>
		</table>
		<%
		}
		%>
		
	<%}
	
	else if(action.equals("Summary by airline")){
		String airline = request.getParameter("airline");
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		String str = "select c.idline, t.Ticket_num, sum(t.Fair + t.Booking_Fees) as revenue from contains c, ticket t where t.Ticket_num = c.Ticket_num and c.idline = \'" + airline + "\'group by idline, Ticket_num";
		ResultSet airlinesRev = stmt.executeQuery(str);
		
		stmt = con.createStatement();
		String str2 = "select c.idline, t.Ticket_num, sum(t.Fair + t.Booking_Fees) as revenue from contains c, ticket t where t.Ticket_num = c.Ticket_num and c.idline = \'" + airline + "\'group by idline";
		ResultSet totalRevenue = stmt.executeQuery(str2);
		
		if(!totalRevenue.next()){
			%>
			<h1>
				There is no revenue for airline <%=airline%>.
			</h1>
			<%
		}
		else{%>
			<h1>
				Total revenue for airline <%=airline%>: <%=totalRevenue.getString(3)%> dollars.
			</h1>
		
			<table>
				<tr>
					<th>Airline</th>
					<th>Ticket number</th>
					<th>Revenue</th>
				</tr>
				<%
					while(airlinesRev.next()){%>
						<tr>
							<td><%=airlinesRev.getString(1)%></td>
							<td><%=airlinesRev.getString(2)%></td>
							<td><%=airlinesRev.getString(3)%></td>
						</tr>
					<%}
				%>
			</table>
		<%}
		%>
		
	<%}
	else if(action.equals("Summary by customer")){
		String userid = request.getParameter("customer");
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		String str = "SELECT userID, ticketNum, (Booking_Fees + Fair) as Revenue FROM books b, user u, ticket t WHERE b.ticketNum = t.Ticket_num and u.Username = b.userId and u.Username = \'" + userid + "\'";
		ResultSet customerRev = stmt.executeQuery(str);
		
		stmt = con.createStatement();
		String str2 = "SELECT userID, sum(Booking_Fees + Fair) as Revenue FROM books b, user u, ticket t WHERE b.ticketNum = t.Ticket_num and u.Username = b.userId and u.Username = \'" + userid + "\' group by userID";
		ResultSet totalRevenue = stmt.executeQuery(str2);
		
		if(!totalRevenue.next()){
			%>
			<h1>
				There is no revenue for customer <%=userid%>.
			</h1>
			<%
		}
		else{%>
			<h1>
			Total revenue for customer <%=userid%>: <%=totalRevenue.getString(2)%> dollars.
			</h1>
			
			<table>
				<tr>
					<th>Customer ID</th>
					<th>Ticket Number</th>
					<th>Revenue</th>
				</tr>
				<%
					while(customerRev.next()){%>
						<tr>
							<td><%=customerRev.getString(1)%></td>
							<td><%=customerRev.getString(2)%></td>
							<td><%=customerRev.getString(3)%></td>
						</tr>
					<%}
				%>
			</table>
		<%}
		
	}
%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "cs336proj.*"%>
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sales report</title>
<style>
	table, th, td {
		border: 1px solid black;
		padding: 2px;
	}
</style>
</head>
<body>
	<form method = "post" action = "AdminLoginSuccess.jsp">
		<input type = "submit" value = "Back">
	</form>
	<%
		String dateInfo = request.getParameter("salesReportDate");
		String[] date = dateInfo.split("-");
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		PreparedStatement stmt = con.prepareStatement("SELECT f.Flight_num, f.ID_Airline, f.ID_Aircraft, f.Departure_Airport, f.Destination_Airport, sum(f.Fair) as Revenue FROM flight f, contains c, ticket t WHERE f.Flight_num = c.Flight_num and f.ID_Airline = c.idline and t.Ticket_num = c.Ticket_num and MONTH(t.Purchase_Date) = ? and YEAR(t.Purchase_Date) = ? GROUP BY f.Flight_num, f.ID_Airline");
		stmt.setString(1, date[1]);
		stmt.setString(2, date[0]);
		ResultSet result = stmt.executeQuery();
		
		if(!result.next()){
			%>
			<h1>No sales for year and month of: <%=dateInfo%></h1>
			<%
		}
		else{
		 	stmt = con.prepareStatement("SELECT sum(f.Fair) as Revenue FROM flight f, contains c, ticket t WHERE f.Flight_num = c.Flight_num and f.ID_Airline = c.idline and t.Ticket_num = c.Ticket_num and MONTH(t.Purchase_Date) = ? and YEAR(t.Purchase_Date) = ?");
			stmt.setString(1, date[1]);
			stmt.setString(2, date[0]);
			ResultSet totalRevenue = stmt.executeQuery();
			totalRevenue.next();
			%>
			<h1>Total revenue for the year and month <%=dateInfo%>: $<%=totalRevenue.getString(1)%></h1>
			<table>
			<tr>
				<th>Flight number</th>
				<th>Airline</th>
				<th>Aircraft</th>
				<th>Departure Airport</th>
				<th>Destination Airport</th>
				<th>Revenue</th>
			</tr>
			
			<%
			do{
				%>
					<tr>
						<td><%=result.getString(1)%></td>
						<td><%=result.getString(2)%></td>
						<td><%=result.getString(3)%></td>
						<td><%=result.getString(4)%></td>
						<td><%=result.getString(5)%></td>
						<td><%=result.getString(6)%></td>
					</tr>
				<%
			}
			while(result.next());
			%>
			</table>
			<%
		}
	%>
</body>
</html>
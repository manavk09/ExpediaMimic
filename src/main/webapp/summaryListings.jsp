<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "cs336proj.*"%>
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form method = "post" action = "AdminLoginSuccess.jsp">
	<input type = "submit" value = "Back">
</form>

	<%
	registerDao db = new registerDao();
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
	String str = "SELECT Flight_num, ID_Airline FROM flight";
	ResultSet flights = stmt.executeQuery(str);
	
	stmt = con.createStatement();
	String str2 = "SELECT Airline_id FROM airlinecompany";
	ResultSet airlines = stmt.executeQuery(str2);
	
	stmt = con.createStatement();
	String str3 = "SELECT Username FROM user";
	ResultSet customers = stmt.executeQuery(str3);
	%>
	<form method = "post" action = "summaryListingsResults.jsp">
		<table>
			<tr>
				<td><input type = "submit" name = "summaryType" value = "Summary by flight"></td>
				<td><input type = "submit" name = "summaryType" value = "Summary by airline"></td>
				<td><input type = "submit" name = "summaryType" value = "Summary by customer"></td>
			</tr>
			<tr>
				<th>Flight number, Airline</th>
				<th>Airline</th>
				<th>Customer</th>
			</tr>
			<tr><td>
				<table>
					<%
					while(flights.next()){%>
						<tr><td><input type = "radio" name = "flightAndAirline" value =<%=flights.getString(1) + "," + flights.getString(2)%>></td><td> <%=flights.getString(1) + ", " + flights.getString(2)%></td></tr>
					<%} %>
				</table>
			</td>
			<td>
				<table>
					<%
					while(airlines.next()){%>
						<tr><td><input type = "radio" name = "airline" value =<%=airlines.getString(1)%>></td><td> <%=airlines.getString(1)%></td></tr>
					<%} %>
				</table>
			</td>
			<td>
				<table>
					<%
					while(customers.next()){%>
						<tr><td><input type = "radio" name = "customer" value =<%=customers.getString(1)%>></td><td> <%=customers.getString(1)%></td></tr>
					<%} %>
				</table>
			</td></tr>
		</table>
		
	</form>
	<%
	con.close();
	%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "cs336proj.*"%>
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
	table, th, td {
		border: 1px solid black;
		padding: 2px;
	}
</style>
</head>
<body>
<h1>Most active flights</h1>

<%
	registerDao db = new registerDao();
	Connection con = db.getConnection();
	String query = "SELECT f.Flight_num, c.idline, f.Departure_Airport, f.Destination_Airport, count(f.Flight_num) FROM contains c, flight f WHERE c.Flight_num = f.Flight_num and c.idline = f.ID_Airline GROUP BY f.Flight_num, c.idline, f.Departure_Airport, f.Destination_Airport ORDER BY count(Flight_num) DESC";
	PreparedStatement stmnt = con.prepareStatement(query);
	ResultSet result = stmnt.executeQuery();
	%>
	<table>
		<tr>
			<th>Flight number</th>
			<th>Airline</th>
			<th>Departure airport</th>
			<th>Arrival airport</th>
			<th>Tickets sold</th>
		</tr>
		<%
			while(result.next()){
				%>
				<tr>
					<td><%=result.getString(1)%></td>
					<td><%=result.getString(2)%></td>
					<td><%=result.getString(3)%></td>
					<td><%=result.getString(4)%></td>
					<td><%=result.getString(5)%></td>
				</tr>
				<%
			}
		con.close();
		%>
	</table>
<form action = "AdminLoginSuccess.jsp" method = "post">
	<input type = "submit" value = "Back">
</form>
</body>
</html>
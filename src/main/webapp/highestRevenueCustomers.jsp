<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "cs336proj.*"%>
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Highest revenue customers</title>
<style>
	table, th, td {
		border: 1px solid black;
		padding: 2px;
	}
</style>
</head>
<body>
	<%
	registerDao db = new registerDao();
	Connection con = db.getConnection();
	String query = "SELECT userId, sum(revenue) FROM (SELECT userId, Fair + Booking_Fees as revenue FROM books JOIN ticket on books.ticketNum = ticket.Ticket_num) as fairSums GROUP BY userId ORDER BY sum(revenue) DESC";
	PreparedStatement stmnt = con.prepareStatement(query);
	ResultSet result = stmnt.executeQuery();
	%>
	<table>
		<tr>
			<td>User ID</td><td>Total Revenue (dollars)</td>
		</tr>
		<%
			while(result.next()){
				%>
				<tr>
					<td><%=result.getString(1)%></td>
					<td><%=result.getString(2)%></td>
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
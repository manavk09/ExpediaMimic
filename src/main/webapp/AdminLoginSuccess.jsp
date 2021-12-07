<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "cs336proj.*" %>
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin</title>
</head>
<body>
<h1>Welcome! You have successfully logged in as an Admin!</h1>

<%
session.setAttribute("userType", "Admin");
registerDao db = new registerDao();
Connection con = db.getConnection();
Statement stmt = con.createStatement();
String str = "SELECT * FROM user WHERE Username != 'admin'";
ResultSet result = stmt.executeQuery(str);
%>

<form method = "post" action = editUsers.jsp>
	<h1>Edit users:</h1>
	<table>
	<%
	while(result.next()){%>
	<tr><td>
		<input type = "radio" name = "username" value =<%=result.getString(1)%>> <%=result.getString("Username")%>
		<br>
	</td></tr>
	<% }
	con.close();
	%>
	</table>
	
	What do you want to do?
	<input name = "action" type = "submit" value = "Add user"><br>
	<input name = "action" type = "submit" value = "Delete user"><br>
	<input name = "action" type = "submit" value = "Edit user"><br>
</form>

<form method = "post" action = "mostActiveFlights.jsp">
	<input type = "submit" value = "See most active flights">
</form>

<form method = "post" action = "highestRevenueCustomers.jsp">
	<input type = "submit" value = "See highest revenue generating customers">
</form>

<form method = "post" action = "summaryListings.jsp">
	<input type = "submit" value = "Get summary listings of revenue by flight, airline, or customer">
</form>

<form method = "post" action = "listOfReservations.jsp">
	<input type = "submit" value = "Get list of reservations by flight or customer">
</form>

<form method = "post" action = "salesReport.jsp">
	<label for = "salesReportMonth"> Select month and year for sales report: </label>
	<input type = "month" id = "salesReportDate" name = "salesReportDate">
	<input type = "submit" value = "Obtain sales report for selected month and year.">
</form>

<a href = "logoutSuccess.jsp"><button>Logout</button></a>
</body>
</html>
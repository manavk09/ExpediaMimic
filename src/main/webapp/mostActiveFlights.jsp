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
<h1>Most active flights</h1>

<%
	registerDao db = new registerDao();
	Connection con = db.getConnection();
	String query = "SELECT Flight_num, idline, idport, idcraft, count(Flight_num) FROM contains GROUP BY Flight_num, idline, idport, idcraft ORDER BY count(Flight_num) DESC";
	PreparedStatement stmnt = con.prepareStatement(query);
	ResultSet result = stmnt.executeQuery();
	%>
	<table>
		<tr>
			<td>Flight number</td><td>Airline</td><td>Airport</td><td>Aircraft</td><td>Tickets sold</td>
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
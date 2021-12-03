<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "cs336proj.*"%>
    
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String action = request.getParameter("action");
	if(action.equals("Delete Airport")){
		String airportID = request.getParameter("Airport_ID");
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		PreparedStatement stmnt = con.prepareStatement("DELETE FROM airport WHERE Airport_id = ?");
		stmnt.setString(1, airportID);
		stmnt.executeUpdate();
		response.sendRedirect("customerRepLoginSuccess.jsp");
	}
	else if(action.equals("Add Airport")){
		%> 
		<form action="addedAirport.jsp" method ="post">
		<table>
			<tr><td>Airport: </td><td><input type="text" name="Airport_id"></td></tr>
			<tr><td></td><td><input type="submit" value="Add Airport"></td></tr>
		</table>
		</form>
		<%
	}
	else if(action.equals("Edit Airport")){
		String airportID = request.getParameter("Airport_ID");
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		PreparedStatement stmnt = con.prepareStatement("SELECT * FROM airport WHERE Airport_id = ?");
		stmnt.setString(1, airportID);
		ResultSet result = stmnt.executeQuery();
		result.next();
		%>
		<form action = "editSubmittedAirport.jsp" method = post>
			<input name = "oldAirportID" value = <%=airportID%>>
			<table>
				<tr><td>Airport: </td><td><input type="text" name="airportID" value = <%=result.getString(1)%>></td></tr>
				<tr>
					<td><input name = "action" type = "submit" value = "Confirm edits"></td>
					<td><input name = "action" type = "submit" value = "Cancel edits"></td>
				</tr>
			</table>
			
		<%}
		%>
		</form>
</body>
</html>
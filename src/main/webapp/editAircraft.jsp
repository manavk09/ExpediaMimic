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
	if(action.equals("Delete Aircraft")){
		String[] inputs = request.getParameter("Aircraft_id").split(",");
		String AircraftID = inputs[0];
		String airlineID =  inputs[1];
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		PreparedStatement stmnt = con.prepareStatement("DELETE FROM aircraft WHERE Aircraft_id = ? AND airlineid = ?");
		stmnt.setString(1, AircraftID);
		stmnt.setString(2, airlineID);
		stmnt.executeUpdate();
		response.sendRedirect("customerRepLoginSuccess.jsp");
	}
	else if(action.equals("Add Aircraft")){
		%> 
		<form action="addedAircraft.jsp" method ="post">
		<table>
			<tr><td>Aircraft ID: </td><td><input type="text" name="Aircraft_id"></td></tr>
			<tr><td>Airline ID: </td><td><input type="text" name="Airline_id"></td></tr>
			<tr><td>Number of Seats: </td><td><input type="text" name="num_seats"></td></tr>
			<tr><td>Operating Days: </td><td><input type="text" name="operating_days"></td></tr>
			<tr><td></td><td><input type="submit" value="addAircraft"></td></tr>
		</table>
		</form>
		<%
	}
	else if(action.equals("Edit Aircraft")){
		String[] inputs = request.getParameter("Aircraft_id").split(",");
		String AircraftID = inputs[0];
		String airlineID =  inputs[1];
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		PreparedStatement stmnt = con.prepareStatement("SELECT * FROM aircraft WHERE Aircraft_id = ? AND airlineid = ?");
		stmnt.setString(1, AircraftID);
		stmnt.setString(2, airlineID);
		ResultSet result = stmnt.executeQuery();
		result.next();
		%>
		<form action = "editSubmittedAircraft.jsp" method = post>
			<input name = "oldAircraftID" value = <%=AircraftID%>>
			<input name = "oldAirlineID" value = <%=airlineID%>>
			<table>
				<tr><td>Aircraft ID: </td><td><input type="text" name="aircraftID" value = <%=result.getString(1)%>></td></tr>
				<tr><td>Airline ID: </td><td><input type="text" name="airlineID" value = <%=result.getString(2)%>></td></tr>
				<tr><td>Number of Seats: </td><td><input type="text" name="numSeats" value = <%=result.getString(3)%>></td></tr>
				<tr><td>Operating Days: </td><td><input type="text" name="opDays" value = <%=result.getString(4)%>></td></tr>
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
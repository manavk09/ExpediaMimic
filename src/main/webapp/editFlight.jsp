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
	if(action.equals("Delete Flight")){
		String flightNum = request.getParameter("flight_num");
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		PreparedStatement stmnt = con.prepareStatement("DELETE FROM Flight WHERE Flight_num = ?");
		stmnt.setString(1, flightNum);
		stmnt.executeUpdate();
		response.sendRedirect("customerRepLoginSuccess.jsp");
	}
	else if(action.equals("Add Flight")){
		%> 
		<form action="addedFlight.jsp" method ="post">
		<table>
			<tr><td>Flight number: </td><td><input type="text" name="flightNum"></td></tr>
			<tr><td>Airline: </td><td><input type="text" name="airline"></td></tr>
			<tr><td>Airport: </td><td><input type="text" name="airport"></td></tr>
			<tr><td>Aircraft: </td><td><input type="text" name="aircraft"></td></tr>
			<tr><td>Days Operating: </td><td><input type="text" name="dayOp"></td></tr>
			<tr><td>Departure Airport: </td><td><input type="text" name="depAir"></td></tr>
			<tr><td>Destination Airport: </td><td><input type="text" name="destAir"></td></tr>
			<tr><td>Arrival Time: </td><td><input type="text" name="arrival"></td></tr>
			<tr><td>Departure Time: </td><td><input type="text" name="dep"></td></tr>
			<tr><td>isDomestic: </td><td><input type="text" name="isdom"></td></tr>
			<tr><td>isInternational: </td><td><input type="text" name="isIn"></td></tr>
			
			<tr><td></td><td><input type="submit" value="Add Flight"></td></tr>
		</table>
		</form>
		<%
	}
	else if(action.equals("Edit Aircraft")){
		String AircraftID = request.getParameter("Aircraft_id");
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		PreparedStatement stmnt = con.prepareStatement("SELECT * FROM aircraft WHERE Aircraft_id = ?");
		stmnt.setString(1, AircraftID);
		ResultSet result = stmnt.executeQuery();
		result.next();
		%>
		<form action = "editSubmittedAircraft.jsp" method = post>
			<input name = "oldAircraftID" value = <%=AircraftID%>>
			<table>
				<tr><td>Aircraft ID: </td><td><input type="text" name="aircraftID" value = <%=result.getString(1)%>></td></tr>
				<tr><td>Number of Seats: </td><td><input type="text" name="numSeats" value = <%=result.getString(2)%>></td></tr>
				<tr><td>Operating Days: </td><td><input type="text" name="opDays" value = <%=result.getString(3)%>></td></tr>
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
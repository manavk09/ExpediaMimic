<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "cs336proj.*"%>
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Updating Flight</title>
</head>
<body>
<%
	if(request.getParameter("action").equals("Confirm edits")){
		
		String oldFlightNum = request.getParameter("oldFlightNum");
		String oldAirline = request.getParameter("oldAirline");
		String flightNum = request.getParameter("flightNum");
		String airline = request.getParameter("airline");
		String aircraft = request.getParameter("aircraft");
		String depAir = request.getParameter("depAir");
		String destAir = request.getParameter("destAir");
		String depTime = request.getParameter("dep");
		String arrivalTime = request.getParameter("arrival");
		String fair = request.getParameter("Fair");
		String travelType = request.getParameter("travelType");
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		String sqlStatement =
			"UPDATE flight SET Flight_num = ?, ID_Airline = ?, ID_Aircraft = ?, Departure_Airport = ?, Destination_Airport = ?,  Departure_Time = ?, Arrival_Time = ?, Fair = ?, travelType = ? WHERE Flight_num = ? AND ID_Airline = ?";
		try{
			PreparedStatement stmnt = con.prepareStatement(sqlStatement);
			stmnt.setString(1, flightNum);
			stmnt.setString(2, airline);
			stmnt.setString(3,aircraft);
			stmnt.setString(4,depAir);
			stmnt.setString(5,destAir);
			stmnt.setString(6,depTime);
			stmnt.setString(7,arrivalTime);
			stmnt.setString(8,fair);
			stmnt.setString(9,travelType);
			stmnt.setString(10,oldFlightNum);
			stmnt.setString(11,oldAirline);
			stmnt.executeUpdate();
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		
		
	}
	response.sendRedirect("customerRepLoginSuccess.jsp");
%>

</body>
</html>
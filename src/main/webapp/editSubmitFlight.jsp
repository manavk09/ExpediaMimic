<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "cs336proj.*"%>
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Updating user</title>
</head>
<body>
<%
	if(request.getParameter("action").equals("Confirm edits")){
		String oldFlightNum = request.getParameter("oldFlightNum");
		String flightNum = request.getParameter("flightNum");
		String airline = request.getParameter("airline");
		String airport = request.getParameter("airport");
		String aircraft = request.getParameter("aircraft");
		String daysOp = request.getParameter("dayOp");
		String depAir = request.getParameter("depAir");
		String destAir = request.getParameter("destAir");
		String arrivalTime = request.getParameter("arrival");
		String depTime = request.getParameter("dep");
		String isDom = request.getParameter("isdom");
		String isIn = request.getParameter("isIn");
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		String sqlStatement =
			"UPDATE flight SET Flight_num = ?, ID_Airline = ?, ID_Airport = ?, ID_Aircraft = ?, Days_operating = ?, Departure_Airport = ?, Destination_Airport = ?, Arrival_Time = ?, Departure_Time = ?, isDomestic = ?, isInternational = ? WHERE Flight_num = ?";
		try{
			PreparedStatement stmnt = con.prepareStatement(sqlStatement);
			stmnt.setString(1, flightNum);
			stmnt.setString(2, airline);
			stmnt.setString(3,airport);
			stmnt.setString(4,aircraft);
			stmnt.setString(5,daysOp);
			stmnt.setString(6,depAir);
			stmnt.setString(7,destAir);
			stmnt.setString(8,arrivalTime);
			stmnt.setString(9,depTime);
			stmnt.setString(10,isDom);
			stmnt.setString(11,isIn);
			stmnt.setString(12,oldFlightNum);
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
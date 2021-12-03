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
	if(request.getParameter("action").equals("Confirm Ticket")){
		String ticketNum = request.getParameter("ticketNumber");
		String fair = request.getParameter("fair");
		String bookingFees = request.getParameter("bookingFees");
		String purchaseDate = request.getParameter("purchaseDate");
		String isOne = request.getParameter("isOne");
		String isRound = request.getParameter("isRound");
		String ticketClass = request.getParameter("class");
		String seatNum = request.getParameter("SeatNum");
		
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		String sqlStatement = "Insert into ticket values(?,?,?,?,?,?,?,?)";
		PreparedStatement stmnt = con.prepareStatement(sqlStatement);
		stmnt.setString(1, ticketNum);
		stmnt.setString(2, fair);
		stmnt.setString(3, bookingFees);
		stmnt.setString(4, purchaseDate);
		stmnt.setString(5, isOne);
		stmnt.setString(6, isRound);
		stmnt.setString(7, ticketClass);
		stmnt.setString(8, seatNum);
		stmnt.executeUpdate();
		
		String flightNum = request.getParameter("flight_num");
		String airlineID = request.getParameter("airlineID");
		String airportID = request.getParameter("airportID");
		String aircraftID = request.getParameter("aircraftID");
		
		sqlStatement = "Insert into contains values(?,?,?,?,?)";
		stmnt = con.prepareStatement(sqlStatement);
		stmnt.setString(1, ticketNum);
		stmnt.setString(2, flightNum);
		stmnt.setString(3, airlineID);
		stmnt.setString(4, airportID);
		stmnt.setString(5, aircraftID);
		stmnt.executeUpdate();
		
		String userID = request.getParameter("userID");
		sqlStatement = "Insert into books values(?,?)";
		stmnt = con.prepareStatement(sqlStatement);
		stmnt.setString(1, ticketNum);
		stmnt.setString(2, userID);
		stmnt.executeUpdate();
		
	}
	response.sendRedirect("customerRepLoginSuccess.jsp");

%>
</body>
</html>
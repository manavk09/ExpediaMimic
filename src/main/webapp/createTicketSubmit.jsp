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
	
	registerDao db = new registerDao();
	Connection con = db.getConnection();
	String sqlStatement = "Insert into ticket values(?,?,?,?,?,?,?,?)";
	PreparedStatement stmnt = con.prepareStatement(sqlStatement);
	
	if(request.getParameter("action").equals("Confirm Ticket")){
		
		String ticketNum = request.getParameter("ticketNumber");
		String fair = request.getParameter("fair");
		String bookingFees = request.getParameter("bookingFees");
		String purchaseDate = request.getParameter("purchaseDate");
		String isOne = request.getParameter("isOne");
		String isRound = request.getParameter("isRound");
		String ticketClass = request.getParameter("class");
		String seatNum = request.getParameter("SeatNum");
		String flightNum = request.getParameter("flight_num");
		String airlineID = request.getParameter("airlineID");
		String airportID = request.getParameter("airportID");
		String aircraftID = request.getParameter("aircraftID");
		String userID = request.getParameter("userID");

		
		//check the num seats 
		registerDao database = new registerDao();
		Connection conn = database.getConnection();
		Statement stm = conn.createStatement();
		String s = "SELECT * FROM aircraft WHERE Aircraft_id = '"+aircraftID+"' AND airlineid = '"+airlineID+"'";
		ResultSet res = stm.executeQuery(s);
		res.next();
		int numSeat = Integer.parseInt(res.getString("num_seats"));
		if(numSeat > 0){
			numSeat--;
			sqlStatement = "Insert into ticket values(?,?,?,?,?,?,?,?)";
			stmnt = con.prepareStatement(sqlStatement);
			stmnt.setString(1, ticketNum);
			stmnt.setString(2, fair);
			stmnt.setString(3, bookingFees);
			stmnt.setString(4, purchaseDate);
			stmnt.setString(5, isOne);
			stmnt.setString(6, isRound);
			stmnt.setString(7, ticketClass);
			stmnt.setString(8, seatNum);
			stmnt.executeUpdate();
			

			
			sqlStatement = "Insert into contains values(?,?,?,?,?)";
			stmnt = con.prepareStatement(sqlStatement);
			stmnt.setString(1, ticketNum);
			stmnt.setString(2, flightNum);
			stmnt.setString(3, airlineID);
			stmnt.setString(4, airportID);
			stmnt.setString(5, aircraftID);
			stmnt.executeUpdate();
			
			sqlStatement = "Insert into books values(?,?)";
			stmnt = con.prepareStatement(sqlStatement);
			stmnt.setString(1, ticketNum);
			stmnt.setString(2, userID);
			stmnt.executeUpdate();
			
			sqlStatement = "UPDATE aircraft SET num_seats = ? WHERE Aircraft_id = ? AND airlineid = ?";
			stmnt = con.prepareStatement(sqlStatement);
			stmnt.setString(1, String.valueOf(numSeat));
			stmnt.setString(2, aircraftID);
			stmnt.setString(3, airlineID);
			stmnt.executeUpdate();

		}
		else{
			sqlStatement = "Insert into waitinglist values(?,?,?)";
			stmnt = con.prepareStatement(sqlStatement);
			stmnt.setString(1, userID);
			stmnt.setString(2, flightNum);
			stmnt.setString(3, airlineID);
			stmnt.executeUpdate();
		}
		
		

		
		
	}
	response.sendRedirect("customerRepLoginSuccess.jsp");

%>
</body>
</html>
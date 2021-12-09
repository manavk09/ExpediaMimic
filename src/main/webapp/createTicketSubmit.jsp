<%@page import="java.sql.Date"%>
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
	String backPage;
	if(session.getAttribute("userType").equals("Customer")){
		backPage = "customerLoginSuccess.jsp";
	}
	else{
		backPage = "customerRepLoginSuccess.jsp";
	}
	registerDao db = new registerDao();
	Connection con = db.getConnection();
	
	if(request.getParameter("action").equals("Confirm Ticket")){
		int bookingFees = 10;
		String roundTripString = request.getParameter("flightInfo");
		String[] roundTripInfo = roundTripString.split(",");
		String flightNum = roundTripInfo[0];
		String airline = roundTripInfo[1];
		String aircraft = roundTripInfo[2];
		int fair = Integer.parseInt(roundTripInfo[3]);
		String username = (String)session.getAttribute("customerUsername");
		
		//Generate ticket number
		int max = 100;
		int min = 1;
		int range = max - min + 1; 
		int ticketNum = (int)(Math.random()*range);
		Statement stmt = con.createStatement();
		String s = "SELECT * FROM ticket WHERE Ticket_num = "+"'"+ticketNum+"'";
		ResultSet res = stmt.executeQuery(s);
		while(res.next()){
			ticketNum = (int)(Math.random());
			res.close();
			res = stmt.executeQuery(s);
		}
		
		//Check if there's an available seat
		//Query the number of taken seats for the flights
		String takenSeatsQuery = "select count(*) FROM contains where Flight_num = ? and idline = ?";
		PreparedStatement ps = con.prepareStatement(takenSeatsQuery);
		ps.setString(1, flightNum);
		ps.setString(2, airline);
		ResultSet seatResults1 = ps.executeQuery();
		ps = con.prepareStatement("SELECT num_seats FROM aircraft WHERE Aircraft_id = ? and airlineid = ?");
		ps.setString(1, aircraft);
		ps.setString(2, airline);
		ResultSet aircraft1seatsResult = ps.executeQuery();
		aircraft1seatsResult.next();
		
		boolean areSeatsAvailable = true;
		if(seatResults1.next()){
			if(aircraft1seatsResult.getInt(1) - seatResults1.getInt(1) <= 0){
				areSeatsAvailable = false;
			}
		}
		
		if(areSeatsAvailable){
			ps = con.prepareStatement("Insert into ticket values(?, ?, ?, ?, ?, ?, ?, ?)");
			ps.setInt(1, ticketNum);
			ps.setInt(2, fair);
			ps.setInt(3, bookingFees);
			java.util.Date jDate = new java.util.Date();
			java.sql.Date purchaseDate = new java.sql.Date(jDate.getTime());
			ps.setDate(4, purchaseDate);
			ps.setInt(5, 0);
			ps.setInt(6, 1);
			ps.setString(7, request.getParameter("class"));
			//Need to select proper seat num
			ps.setInt(8, 1);
			ps.executeUpdate();
			
			//Insert both flights into contains
			ps = con.prepareStatement("Insert into contains values(?, ?, ?)");
			ps.setInt(1, ticketNum);
			ps.setInt(2, Integer.parseInt(flightNum));
			ps.setString(3, airline);
			ps.executeUpdate();
			
			//Insert into books
			ps = con.prepareStatement("Insert into books values(?, ?)");
			ps.setInt(1, ticketNum);
			ps.setString(2, username);
			ps.executeUpdate();
		}
		else{
			//Add to waiting list
			ps.close();
			ps = con.prepareStatement("Insert into waitinglist values(?,?,?,?)");
			ps.setString(1, username);
			ps.setInt(2, Integer.parseInt(flightNum));
			ps.setString(3, airline);
			ps.setString(4, request.getParameter("class"));
			ps.executeUpdate();
		}
		response.sendRedirect(backPage);

	}
	else if(request.getParameter("action").equals("Confirm Round Trip Ticket")){
		int bookingFees = 10;
		String roundTripString = request.getParameter("roundFlightsInfo");
		String[] roundTripInfo = roundTripString.split(",");
		String flightNum1 = roundTripInfo[0];
		String airline1 = roundTripInfo[1];
		String aircraft1 = roundTripInfo[2];
		String fair1 = roundTripInfo[3];
		String username = (String)session.getAttribute("customerUsername");
		String flightNum2 = roundTripInfo[4];
		String airline2 = roundTripInfo[5];
		String aircraft2 = roundTripInfo[6];
		String fair2 = roundTripInfo[7];
		int totalFair = Integer.parseInt(fair1) + Integer.parseInt(fair2);
		
		//Generate ticket number
		int max = 100;
		int min = 1;
		int range = max - min + 1; 
		int ticketNum = (int)(Math.random()*range);
		Statement stmt = con.createStatement();
		String s = "SELECT * FROM ticket WHERE Ticket_num = "+"'"+ticketNum+"'";
		ResultSet res = stmt.executeQuery(s);
		while(res.next()){
			ticketNum = (int)(Math.random());
			res.close();
			res = stmt.executeQuery(s);
		}
		
		//Check if there's an available seat
		//Query the number of taken seats for the flights
		String takenSeatsQuery = "select count(*) FROM contains where Flight_num = ? and idline = ?";
		PreparedStatement ps = con.prepareStatement(takenSeatsQuery);
		ps.setString(1, flightNum1);
		ps.setString(2, airline1);
		ResultSet seatResults1 = ps.executeQuery();
		ps = con.prepareStatement("SELECT num_seats FROM aircraft WHERE Aircraft_id = ? and airlineid = ?");
		ps.setString(1, aircraft1);
		ps.setString(2, airline1);
		ResultSet aircraft1seatsResult = ps.executeQuery();
		aircraft1seatsResult.next();
		
		boolean areSeatsAvailable = true;
		if(seatResults1.next()){
			if(aircraft1seatsResult.getInt(1) - seatResults1.getInt(1) <= 0){
				areSeatsAvailable = false;
			}
		}
		
		ps = con.prepareStatement(takenSeatsQuery);
		ps.setString(1, flightNum2);
		ps.setString(2, airline2);
		ResultSet seatResults2 = ps.executeQuery();
		ps = con.prepareStatement("SELECT num_seats FROM aircraft WHERE Aircraft_id = ? and airlineid = ?");
		ps.setString(1, aircraft2);
		ps.setString(2, airline2);
		ResultSet aircraft2seatsResult = ps.executeQuery();
		aircraft2seatsResult.next();
		
		if(seatResults2.next()){
			if(aircraft2seatsResult.getInt(1) - seatResults2.getInt(1) <= 0){
				areSeatsAvailable = false;
			}
		}
		if(areSeatsAvailable){
			ps = con.prepareStatement("Insert into ticket values(?, ?, ?, ?, ?, ?, ?, ?)");
			ps.setInt(1, ticketNum);
			ps.setInt(2, totalFair);
			ps.setInt(3, bookingFees);
			java.util.Date jDate = new java.util.Date();
			java.sql.Date purchaseDate = new java.sql.Date(jDate.getTime());
			ps.setDate(4, purchaseDate);
			ps.setInt(5, 0);
			ps.setInt(6, 1);
			ps.setString(7, request.getParameter("class"));
			//Need to select proper seat num
			ps.setInt(8, 1);
			ps.executeUpdate();
			
			//Insert both flights into contains
			ps = con.prepareStatement("Insert into contains values(?, ?, ?)");
			ps.setInt(1, ticketNum);
			ps.setInt(2, Integer.parseInt(flightNum1));
			ps.setString(3, airline1);
			ps.executeUpdate();
			ps = con.prepareStatement("Insert into contains values(?, ?, ?)");
			ps.setInt(1, ticketNum);
			ps.setInt(2, Integer.parseInt(flightNum2));
			ps.setString(3, airline2);
			ps.executeUpdate();
			
			//Insert into books
			ps = con.prepareStatement("Insert into books values(?, ?)");
			ps.setInt(1, ticketNum);
			ps.setString(2, username);
			ps.executeUpdate();
		}
		else{
			//Add to waiting list
			ps.close();
			ps = con.prepareStatement("Insert into waitinglist values(?,?,?,?)");
			ps.setString(1, username);
			ps.setInt(2, Integer.parseInt(flightNum1));
			ps.setString(3, airline1);
			ps.setString(4, request.getParameter("class"));
			ps.executeUpdate();
		}
		response.sendRedirect(backPage);
	}
	

%>
</body>
</html>
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
	if(request.getParameter("action").equals("Confirm edits")){
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
		String sqlStatement =
			"UPDATE ticket SET Fair = ?, Booking_Fees = ?, Purchase_Date = ?, IsOne_Way = ?, Is_Round = ?, Class = ?, SeatNum = ? WHERE Ticket_num = ?";
		PreparedStatement stmnt = con.prepareStatement(sqlStatement);
		stmnt.setString(1, fair);
		stmnt.setString(2, bookingFees);
		stmnt.setString(3, purchaseDate);
		stmnt.setString(4, isOne);
		stmnt.setString(5, isRound);
		stmnt.setString(6, ticketClass);
		stmnt.setString(7, seatNum);
		stmnt.setString(8, ticketNum);
		stmnt.executeUpdate();
	}
	response.sendRedirect("customerRepLoginSuccess.jsp");

%>
</body>
</html>
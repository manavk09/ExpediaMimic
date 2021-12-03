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

<% 		String userID = request.getParameter("userID");
		String flight_num = request.getParameter("flight_num");
		String airlineID = request.getParameter("airlineID");
		String airportID = request.getParameter("airportID");
		String aircraftID = request.getParameter("aircraftID");
		int max = 100;
		int min = 1;
		int range = max - min + 1; 
		int ticketNum = (int)(Math.random()*range);
		registerDao database = new registerDao();
		Connection conn = database.getConnection();
		Statement stm = conn.createStatement();
		String s = "SELECT * FROM ticket WHERE Ticket_num = "+"'"+ticketNum+"'";
		ResultSet res = stm.executeQuery(s);
		while(res.next()){
			ticketNum = (int)(Math.random());
			res = stm.executeQuery(s);
		}
		%>
		<form action = "editSubmitTicket.jsp" method = post>
			<lable name = "userID" value = <%=userID%>> <%=userID%></lable>
			<input type="hidden" name="userID" value = <%=userID%>>
			<br>
			<lable name = "ticketNumber" value = <%=ticketNum%>> <%=ticketNum%></lable>
			<input type="hidden" name="ticketNumber" value = <%=ticketNum%>>
			<br>
			<lable name = "flightNum" value = <%=flight_num%>> <%=flight_num%></lable>
			<input type="hidden" name="flight_num" value = <%=flight_num%>>
			<br>
			<lable name = "airlineID" value = <%=airlineID%>> <%=airlineID%></lable>
			<input type="hidden" name="airlineID" value = <%=airlineID%>>
			<br>
			<lable name = "airportID" value = <%=airportID%>> <%=airportID%></lable>
			<input type="hidden" name="airportID" value = <%=airportID%>>
			<br>
			<lable name = "ticketNumber" value = <%=aircraftID%>> <%=aircraftID%></lable>
			<input type="hidden" name="aircraftID" value = <%=aircraftID%>>
			<br>
			<table>
				<tr><td>Fair: </td><td><input type="text" name="fair" value = ""></td></tr>
				<tr><td>Booking Fees: </td><td><input type="text" name="bookingFees" value = ""></td></tr>
				<tr><td>Purchase Date: </td><td><input type="text" name="purchaseDate" value = ""></td></tr>
				<tr><td>is One Way: </td><td><input type="text" name="isOne" value = ""></td></tr>
				<tr><td>is Round: </td><td><input type="text" name="isRound" value = ""></td></tr>
				<tr><td>Class: </td><td><input type="text" name="class" value = ""></td></tr>
				<tr><td>Seat Number: </td><td><input type="text" name="SeatNum" value = ""></td></tr>
				<tr>
					<td><input name = "action" type = "submit" value = "Confirm Ticket"></td>
					<td><input name = "action" type = "submit" value = "Cancel Ticket"></td>
				</tr>
			</table>
		
		</form>
</body>
</html>
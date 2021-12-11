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
	if(action.equals("Book New Ticket")){
		response.sendRedirect("searchFlights.jsp");
		
	}
	else if(action.equals("Edit Ticket")){
		String ticketNum = request.getParameter("ticketNum");
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		PreparedStatement stmnt = con.prepareStatement("SELECT * FROM ticket WHERE Ticket_num = ?");
		stmnt.setString(1, ticketNum);
		ResultSet result = stmnt.executeQuery();
		result.next();
		session.setAttribute("ticketNum", ticketNum);
		%>
		<form action = "editSubmitTicket.jsp" method = post>
			Ticket number: <%=ticketNum%>
			<table>
				<tr><td>Fair: </td><td><input type="text" name="fair" value = <%=result.getString(2)%>></td></tr>
				<tr><td>Booking Fees: </td><td><input type="text" name="bookingFees" value = <%=result.getString(3)%>></td></tr>
				<tr><td>Class: </td><td><input type="text" name="class" value = <%=result.getString(7)%>></td></tr>
				<tr><td>Seat Number: </td><td><input type="text" name="SeatNum" value = <%=result.getString(8)%>></td></tr>
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
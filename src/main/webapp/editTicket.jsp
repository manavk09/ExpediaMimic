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
		String userID = request.getParameter("userID");
		session.setAttribute("customerUsername", userID);
		registerDao database = new registerDao();
		Connection conn = database.getConnection();
		Statement stm = conn.createStatement();
		String s = "SELECT * FROM flight";
		ResultSet res = stm.executeQuery(s);
		%>
		<h3>Select Flights for <%=userID%></h3>
		<form method = "post" action = createTicket.jsp>
<table border=1 align=left style="text-align:center">
      <thead>
          <tr>
             <th>Flight Number</th>
             <th>Airline</th>
             <th>Airport</th>
             <th>Aircraft</th>
             <th>Days Operating</th>
             <th>Departure Airport</th>
             <th>Destination Airport</th>
             <th>Arrival Time</th>
             <th>Departure Time</th>
             <th>isDomestic</th>
             <th>isInternational</th>
          </tr>
      </thead>
      <tbody>
        <%while(res.next())
        {
            %>
            <tr>
            	
                <td><input type = "radio" name = "flight_num" value =<%=res.getString("Flight_num")%>><%=res.getString("Flight_num")%></td>
                <td><input type = "radio" name = "airlineID" value =<%=res.getString("ID_Airline")%>><%=res.getString("ID_Airline")%></td>
                <td><input type = "radio" name = "airportID" value =<%=res.getString("ID_Airport")%>><%=res.getString("ID_Airport")%></td>
                <td><input type = "radio" name = "aircraftID" value =<%=res.getString("ID_Aircraft")%>><%=res.getString("ID_Aircraft")%></td>
                <td><%=res.getString("Days_operating") %></td>
                <td><%=res.getString("Departure_Airport") %></td>
                <td><%=res.getString("Destination_Airport") %></td>
                <td><%=res.getString("Arrival_Time") %></td>
                <td><%=res.getString("Departure_Time") %></td>
                <td><%=res.getString("isDomestic") %></td>
                <td><%=res.getString("isInternational") %></td>
                
            </tr>
            <%}%>
           </tbody>
        </table>
        <input type = "hidden" name = "userID" value =<%=userID%>>
        Create Ticket
        <br>
	<input name = "action" type = "submit" value = "Book Ticket"><br>
</form>
</div>
<% 
	}
	else if(action.equals("Edit Ticket")){
		String ticketNum = request.getParameter("ticketNum");
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		PreparedStatement stmnt = con.prepareStatement("SELECT * FROM ticket WHERE Ticket_num = ?");
		stmnt.setString(1, ticketNum);
		ResultSet result = stmnt.executeQuery();
		result.next();
		%>
		<form action = "editSubmitTicket.jsp" method = post>
			<input name = "ticketNumber" value = <%=ticketNum%>>
			<table>
				<tr><td>Fair: </td><td><input type="text" name="fair" value = <%=result.getString(2)%>></td></tr>
				<tr><td>Booking Fees: </td><td><input type="text" name="bookingFees" value = <%=result.getString(3)%>></td></tr>
				<tr><td>Purchase Date: </td><td><input type="text" name="purchaseDate" value = <%=result.getString(4)%>></td></tr>
				<tr><td>is One Way: </td><td><input type="text" name="isOne" value = <%=result.getString(5)%>></td></tr>
				<tr><td>is Round: </td><td><input type="text" name="isRound" value = <%=result.getString(6)%>></td></tr>
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
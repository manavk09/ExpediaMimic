<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "cs336proj.*" %>
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Welcome! You have successfully logged in as a Customer Representative!
<a href = "repForum.jsp" ><button style = "float: right">Go to Answer Forum Questions</button></a>
</h1>
<a href = "logoutSuccess.jsp"><button>Logout</button></a>
<div align = left>
<%
session.setAttribute("userType", "Rep");
registerDao db = new registerDao();
Connection con = db.getConnection();
Statement stmt = con.createStatement();
String str = "SELECT * FROM aircraft";
ResultSet result = stmt.executeQuery(str);
%>

<h3>Adding/Editing/Deleting Aircrafts</h3>
<form method = "post" action = editAircraft.jsp>
<table border=1 style="text-align:center">
      <thead>
          <tr>
             <th>Aircraft ID</th>
             <th>Airline ID</th>
             <th>Number of Seats</th>
             <th>Operating days</th>
          </tr>
      </thead>
      <tbody>
        <%while(result.next())
        {
            %>
            <tr>
                <td><input type = "radio" name = "Aircraft_id" value =<%=result.getString("Aircraft_id")+","+result.getString("airlineid")%>><%=result.getString("Aircraft_id")%></td>
                <td><%=result.getString("airlineid") %></td>
                <td><%=result.getString("num_seats") %></td>
                <td><%=result.getString("operating_days") %></td>
            </tr>
            <%}%>
           </tbody>
        </table>
        What do you want to do?
        <br>
	<input name = "action" type = "submit" value = "Add Aircraft"><br>
	<input name = "action" type = "submit" value = "Delete Aircraft"><br>
	<input name = "action" type = "submit" value = "Edit Aircraft"><br>
	<br>
</form>
<br>
</div>
<br>
<div align = left>
<%
registerDao d = new registerDao();
Connection c = d.getConnection();
Statement st = c.createStatement();
String strk = "SELECT * FROM airport";
ResultSet r = st.executeQuery(strk);
%>
<br>
<h3 align = left>Adding/Editing/deleting Airport</h3>
<form method = "post" action = editAirport.jsp>
<table border=1 style="text-align:center">
      <thead>
          <tr>
             <th>ID</th>
          </tr>
      </thead>
      <tbody>
        <%while(r.next())
        {
            %>
            <tr>
                <td><input type = "radio" name = "Airport_ID" value =<%=r.getString("Airport_ID")%>><%=r.getString("Airport_id")%></td>
                
            </tr>
            <%}%>
           </tbody>
        </table>
        What do you want to do?
        <br>
	<input name = "action" type = "submit" value = "Add Airport"><br>
	<input name = "action" type = "submit" value = "Delete Airport"><br>
	<input name = "action" type = "submit" value = "Edit Airport"><br>
</form>


</div>
<br>
<div align = left>
<%
registerDao database = new registerDao();
Connection conn = database.getConnection();
Statement stm = conn.createStatement();
String s = "SELECT * FROM flight";
ResultSet res = stm.executeQuery(s);
%>
<h3>Adding/Editing/deleting Flights</h3>
<form method = "post" action = editFlight.jsp>
<table border=1 style="text-align:center">
      <thead>
          <tr>
             <th>Flight Number</th>
             <th>Airline</th>
             <th>Aircraft</th>
             <th>Departure Airport</th>
             <th>Destination Airport</th>
             <th>Departure Time</th>
             <th>Arrival Time</th>
             <th>Fair</th>
             <th>Travel Type</th>
          </tr>
      </thead>
      <tbody>
        <%while(res.next())
        {
            %>
            <tr>
                <td><input type = "radio" name = "flight_num" value =<%=res.getString("Flight_num")+","+res.getString("ID_Airline")%>><%=res.getString("Flight_num")%></td>
                <td><%=res.getString("ID_Airline") %></td>
                <td><%=res.getString("ID_Aircraft") %></td>
                <td><%=res.getString("Departure_Airport") %></td>
                <td><%=res.getString("Destination_Airport") %></td>
                <td><%=res.getString("Departure_Time") %></td>
                <td><%=res.getString("Arrival_Time") %></td>
                <td><%=res.getString("Fair") %></td>
                <td><%=res.getString("travelType") %></td>
                
            </tr>
            <%}%>
           </tbody>
        </table>
        
        What do you want to do?
        <br>
	<input name = "action" type = "submit" value = "Add Flight"><br>
	<input name = "action" type = "submit" value = "Delete Flight"><br>
	<input name = "action" type = "submit" value = "Edit Flight"><br>
</form>
</div>

<br>
<br>

<div>
<div align = left>
<%
registerDao dao = new registerDao();
Connection connect = dao.getConnection();
Statement state = connect.createStatement();
String querry = "SELECT * FROM user WHERE Role != 'Admin' AND Role != 'Customer Representative'";
ResultSet set = state.executeQuery(querry);
%>
<br>
<h3 align = left>Make and Edit Reservation for users!</h3>
<form method = "post" action = creatReservation.jsp>
<table border=1 style="text-align:center">
      <thead>
          <tr>
             <th>Users</th>
          </tr>
      </thead>
      <tbody>
        <%while(set.next())
        {
            %>
            <tr>
                <td><input type = "radio" name = "user" value =<%=set.getString("Username")%>><%=set.getString("Username")%></td>
                
            </tr>
            <%}%>
           </tbody>
        </table>
          <br>
        What do you want to do?
        <br>
	<input name = "action" type = "submit" value = "Make/Edit Reservation"><br>

</form>


<div align = left>
<%
registerDao rd = new registerDao();
Connection connection = rd.getConnection();
Statement ment = connection.createStatement();
String sql = "SELECT * FROM airport";
ResultSet answer = ment.executeQuery(sql);
%>
<br>
<h3 align = left>Select Airport to See Flight List</h3>
<form method = "post" action = flightList.jsp>
<table border=1 style="text-align:center">
      <thead>
          <tr>
             <th>ID</th>
          </tr>
      </thead>
      <tbody>
        <%while(answer.next())
        {
            %>
            <tr>
                <td><input type = "radio" name = "Airport_ID" value =<%=answer.getString("Airport_ID")%>><%=answer.getString("Airport_id")%></td>
                
            </tr>
            <%}%>
           </tbody>
        </table>
	<input name = "action" type = "submit" value = "Show Flights"><br>

</form>


</div>

<br>
<div>
<%

		registerDao da = new registerDao();
		Connection nn = da.getConnection();
		Statement m = nn.createStatement();
		String quer = "SELECT * FROM flight";
		ResultSet sol = m.executeQuery(s);
		%>
		<h3 align = left>Select Flight to see waiting List</h3>
		<form method = "post" action = presentWaitList.jsp>
<table border=1 style="text-align:center">
      <thead>
          <tr>
             <th>Flight Number</th>
             <th>Airline</th>
             <th>Aircraft</th>
             <th>Departure Airport</th>
             <th>Destination Airport</th>
             <th>Departure Time</th>
             <th>Arrival Time</th>
             <th>Fair</th>
             <th>Travel Type</th>
          </tr>
      </thead>
      <tbody>
        <%while(sol.next())
        {
            %>
            <tr>
            	
                <td><input type = "radio" name = "flight_num" value =<%=sol.getString("Flight_num")+","+sol.getString("ID_Airline")+","+sol.getString("ID_Aircraft")%>><%=sol.getString("Flight_num")%></td>
                <td><%=sol.getString("ID_Airline")%></td>
                <td><%=sol.getString("ID_Aircraft")%></td>
                <td><%=sol.getString("Departure_Airport") %></td>
                <td><%=sol.getString("Destination_Airport") %></td>
                <td><%=sol.getString("Departure_Time") %></td>
                <td><%=sol.getString("Arrival_Time") %></td>
                <td><%=sol.getString("Fair") %></td>
                <td><%=sol.getString("travelType") %></td>
                
            </tr>
            <%}%>
           </tbody>
        </table>

        <br>
	<input name = "action" type = "submit" value = "View Waiting List"><br>
</form>
</div>
</body>
</html>
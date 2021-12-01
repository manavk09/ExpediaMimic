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
<h1>Welcome! You have successfully logged in as a Customer Representative!</h1>

<%
registerDao db = new registerDao();
Connection con = db.getConnection();
Statement stmt = con.createStatement();
String str = "SELECT * FROM aircraft";
ResultSet result = stmt.executeQuery(str);
%>

<h3>Adding/Editing/deleting Aircrafts</h3>
<form method = "post" action = editAircraft.jsp>
<table border=1 align=left style="text-align:center">
      <thead>
          <tr>
             <th>ID</th>
             <th>Number of Seats</th>
             <th>Operating days</th>
          </tr>
      </thead>
      <tbody>
        <%while(result.next())
        {
            %>
            <tr>
                <td><input type = "radio" name = "Aircraft_id" value =<%=result.getString("Aircraft_id")%>><%=result.getString("Aircraft_id")%></td>
                <td><%=result.getString("num_seats") %></td>
                <td><%=result.getString("operating_days") %></td>
            </tr>
            <%}%>
           </tbody>
        </table>
        What do you want to do?
	<input name = "action" type = "submit" value = "Add Aircraft"><br>
	<input name = "action" type = "submit" value = "Delete Aircraft"><br>
	<input name = "action" type = "submit" value = "Edit Aircraft"><br>
</form>

<%
registerDao database = new registerDao();
Connection conn = database.getConnection();
Statement stm = conn.createStatement();
String s = "SELECT * FROM flight";
ResultSet res = stm.executeQuery(s);
%>
<h3>Adding/Editing/deleting Flights</h3>
<form method = "post" action = editFlight.jsp>
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
                <td><%=res.getString("ID_Airline") %></td>
                <td><%=res.getString("ID_Airport") %></td>
                <td><%=res.getString("ID_Aircraft") %></td>
                <td><%=res.getString("Days_operating") %></td>
                <td><%=res.getString("Departure_Airport") %></td>
                <td><%=res.getString("Destination_Airport") %></td>
                <td><%=res.getString("Arrival_Time") %></td>
                <td><%=res.getString("Departure_Time") %></td>
                <td><%=res.getString("isDomestic") %></td>
                <td><%=res.getString("isInternation") %></td>
                
            </tr>
            <%}%>
           </tbody>
        </table>
        What do you want to do?
	<input name = "action" type = "submit" value = "Add Flight"><br>
	<input name = "action" type = "submit" value = "Delete Flight"><br>
	<input name = "action" type = "submit" value = "Edit Flight"><br>
</form>


<a href = "logoutSuccess.jsp"><button>Logout</button></a>
</body>
</html>
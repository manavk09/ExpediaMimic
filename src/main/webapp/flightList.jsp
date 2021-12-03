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

<div align = left>
<%
String airportID = request.getParameter("Airport_ID");
registerDao database = new registerDao();
Connection conn = database.getConnection();
Statement stm = conn.createStatement();
String s = "SELECT * FROM flight WHERE Departure_Airport = '"+airportID+"' OR Destination_Airport = '"+airportID+"'";
ResultSet res = stm.executeQuery(s);
%>
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
                <td><%=res.getString("Flight_num")%></td>
                <td><%=res.getString("ID_Airline") %></td>
                <td><%=res.getString("ID_Airport") %></td>
                <td><%=res.getString("ID_Aircraft") %></td>
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
 
</form>
<a href = "customerRepLoginSuccess.jsp"><button>Go back</button></a>
</div>

<br>
<br>

</body>
</html>
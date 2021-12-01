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


<a href = "logoutSuccess.jsp"><button>Logout</button></a>
</body>
</html>
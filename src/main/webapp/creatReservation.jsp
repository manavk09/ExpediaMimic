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
String userID = request.getParameter("user");
session.setAttribute("customerUsername",userID);
registerDao dao = new registerDao();
Connection connect = dao.getConnection();
Statement state = connect.createStatement();
String querry = "SELECT * FROM books WHERE userId = " + "'"+userID+"'";
ResultSet set = state.executeQuery(querry);
%>

<h3>Flight tickets</h3>
<form method = "post" action = editTicket.jsp>
<table border=1 align=left style="text-align:center">
      <thead>
          <tr>
             <th>Ticket Number</th>
             <th>User ID</th>
          </tr>
      </thead>
      <tbody>
        <%while(set.next())
        {
            %>
            <tr>
            	<td><input type = "radio" name = "ticketNum" value =<%=set.getString("ticketNum")%>><%=set.getString("ticketNum")%></td>
            	<td><input type = "hidden" name = "userID" value =<%=userID%>><%=userID%><br></td>
            <%}%>
          
            </tr>
           </tbody>
           
        </table>
         <br>
		 
        What do you want to do?
        <br>
	<input name = "action" type = "submit" value = "Edit Ticket"><br>
	<input name = "action" type = "submit" value = "Book New Ticket"><br>
	<br>
</form>
<br>
</div>
</body>
</html>
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
String flightNum = request.getParameter("flight_num");
String airline = request.getParameter("airlineID");
registerDao db = new registerDao();
Connection con = db.getConnection();
Statement stmt = con.createStatement();
String str = "SELECT userid FROM waitinglist where flightnum = '"+flightNum+"' and flightairline = '"+airline+"'";
ResultSet result = stmt.executeQuery(str);
%>
<%=airline %>
<%=flightNum %>
<table border=1 align=left style="text-align:center">
      <thead>
          <tr>
             <th>Users</th>

          </tr>
      </thead>
      <tbody>
        <%while(result.next())
        {
            %>
            <tr>
                
                <td><%=result.getString("userid") %></td>
     
            </tr>
            <%}%>
           </tbody>
        </table>
</div>

</body>
</html>
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
String[]inputs = request.getParameter("flight_num").split(",");
String flightNum = inputs[0];
String airline = inputs[1];
registerDao db = new registerDao();
Connection con = db.getConnection();
Statement stmt = con.createStatement();
String str = "SELECT userid FROM waitinglist where flightnum = '"+flightNum+"' and flightairline = '"+airline+"'";
ResultSet result = stmt.executeQuery(str);
%>

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
<a href = "customerRepLoginSuccess.jsp"><button>Go back</button></a>
</body>
</html>
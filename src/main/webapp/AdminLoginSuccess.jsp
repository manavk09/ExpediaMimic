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
<h1>Welcome! You have successfully logged in as an Admin!</h1>

<%
registerDao db = new registerDao();
Connection con = db.getConnection();
Statement stmt = con.createStatement();
String str = "SELECT * FROM user";
ResultSet result = stmt.executeQuery(str);
%>

<form method = "post" action = editUsers.jsp>
	<% 
	while(result.next()){%>
		<input type = "radio" name = "username" value =<%=result.getString("Username")%>> <%=result.getString("Username")%>
		<br>
	<% }
	//db.closeConnection(con);
	%>
	
	What do you want to do?
	<input name = "action" type = "submit" value = "Add user"><br>
	<input name = "action" type = "submit" value = "Delete user"><br>
	<input name = "action" type = "submit" value = "Edit user"><br>
</form>

<!--
<form action = "deleteUser.jsp" method = "post">
<table>
	<tr>
		<td> Username </td>
	</tr>
	<% 
	while(result.next()){%>
		
		<tr>
			<td>
				<label id = "userName">
					<%= result.getString("Username") %>
				</label>
			</td>
			<td>
				<input type = "button" value = "deleteUser.jsp"></input>
			</td>
		</tr>
	<% }
	//db.closeConnection(con);
	%>
</table>
</form>
-->

<a href = "logoutSuccess.jsp"><button>Logout</button></a>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "cs336proj.*"%>
    
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Editing</title>
<style>
	table, th, td {
		border: 1px solid black;
		padding: 2px;
	}
</style>
</head>
<body>
<%
	String action = request.getParameter("action");
	if(action.equals("Delete user")){
		String username = request.getParameter("username");
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		PreparedStatement stmnt = con.prepareStatement("DELETE FROM user WHERE Username = ?");
		stmnt.setString(1, username);
		stmnt.executeUpdate();
		response.sendRedirect("AdminLoginSuccess.jsp");
	}
	else if(action.equals("Add user")){
		response.sendRedirect("newUserByAdmin.jsp");
	}
	else if(action.equals("Edit user")){
		String username = request.getParameter("username");
		if(username != null){
			registerDao db = new registerDao();
			Connection con = db.getConnection();
			session.setAttribute("oldusername", username);
			PreparedStatement stmnt = con.prepareStatement("SELECT * FROM user WHERE Username = ?");
			stmnt.setString(1, username);
			ResultSet result = stmnt.executeQuery();
			result.next();
			%>
			<form action = "editSubmitted.jsp" method = post>
				<table>
					<tr><td>User Name: </td><td><input type="text" name="username" value = <%=result.getString(1)%>></td></tr>
					<tr><td>First Name: </td><td><input type="text" name="fName" value = <%=result.getString(3)%>></td></tr>
					<tr><td>Last Name: </td><td><input type="text" name="lName" value = <%=result.getString(4)%>></td></tr>
					<tr>
						<td><input name = "action" type = "submit" value = "Confirm edits"></td>
						<td><input name = "action" type = "submit" value = "Cancel edits"></td>
					</tr>
				</table>
				
			<%
			con.close();
		}
		else{
			response.sendRedirect("AdminLoginSuccess.jsp");
		}
	}
		
	%>
			</form>

</body>
</html>
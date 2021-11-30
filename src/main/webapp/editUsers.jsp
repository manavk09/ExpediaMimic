<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "cs336proj.*"%>
    
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>asdsadas</title>
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
	}
	else if(action.equals("Add user")){
		response.sendRedirect("customerRegistration.jsp");
	}
	else if(action.equals("Edit user")){
		
	}
%>
</body>
</html>
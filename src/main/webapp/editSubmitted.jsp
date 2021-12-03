<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "cs336proj.*"%>
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Updating user</title>
</head>
<body>
<%
	if(request.getParameter("action").equals("Confirm edits")){
		String username = request.getParameter("username");
		String oldusername = request.getParameter("oldusername");
		String fname = request.getParameter("fName");
		String lname = request.getParameter("lName");
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		String sqlStatement =
			"UPDATE user SET Username = ?, FirstName = ?, LastName = ? WHERE Username = ?";
		PreparedStatement stmnt = con.prepareStatement(sqlStatement);
		stmnt.setString(1, username);
		stmnt.setString(2, fname);
		stmnt.setString(3, lname);
		stmnt.setString(4, oldusername);
		stmnt.executeUpdate();
		con.close();
	}
	response.sendRedirect("AdminLoginSuccess.jsp");
%>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "cs336proj.*"%>
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Updating airport</title>
</head>
<body>
<%
	if(request.getParameter("action").equals("Confirm edits")){
		String airport = request.getParameter("airportID");
		String old = request.getParameter("oldAirportID");
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		String sqlStatement =
			"UPDATE airport SET Airport_id = ? WHERE Airport_id = ?";
		PreparedStatement stmnt = con.prepareStatement(sqlStatement);
		stmnt.setString(1, airport);
		stmnt.setString(2, old);
		stmnt.executeUpdate();
	}
	response.sendRedirect("customerRepLoginSuccess.jsp");
%>

</body>
</html>
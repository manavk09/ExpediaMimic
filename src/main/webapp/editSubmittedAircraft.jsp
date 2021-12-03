<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "cs336proj.*"%>
    
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	if(request.getParameter("action").equals("Confirm edits")){
		String oldAircraftId = request.getParameter("oldAircraftID");
		String aircraftID = request.getParameter("aircraftID");
		String numSeats = request.getParameter("numSeats");
		String opDays = request.getParameter("opDays");
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		String sqlStatement =
			"UPDATE aircraft SET Aircraft_id = ?, num_seats = ?, operating_days = ? WHERE Aircraft_id = ?";
		PreparedStatement stmnt = con.prepareStatement(sqlStatement);
		stmnt.setString(1, aircraftID);
		stmnt.setString(2, numSeats);
		stmnt.setString(3, opDays);
		stmnt.setString(4, oldAircraftId);
		stmnt.executeUpdate();
	}
	response.sendRedirect("customerRepLoginSuccess.jsp");

%>
</body>
</html>
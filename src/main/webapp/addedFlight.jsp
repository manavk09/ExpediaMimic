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
		String flightNum = request.getParameter("flightNum");
		String airline = request.getParameter("airline");
		String aircraft = request.getParameter("aircraft");
		String depAir = request.getParameter("depAir");
		String destAir = request.getParameter("destAir");
		String depTime = request.getParameter("dep");
		String arrivalTime = request.getParameter("arrival");
		depTime.replace("T", " ");
		arrivalTime.replace("T", " ");
		String fair = request.getParameter("Fair");
		String travelType = request.getParameter("travelType");
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		try{
			PreparedStatement stmnt = con.prepareStatement("insert into flight values(?,?,?,?,?,?,?,?,?)");
			stmnt.setString(1, flightNum);
			stmnt.setString(2, airline);
			stmnt.setString(3,aircraft);
			stmnt.setString(4,depAir);
			stmnt.setString(5,destAir);
			stmnt.setString(6,depTime);
			stmnt.setString(7,arrivalTime);
			stmnt.setString(8,fair);
			stmnt.setString(9, travelType);
			stmnt.executeUpdate();
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.sendRedirect("customerRepLoginSuccess.jsp");
	

%>

</body>
</html>
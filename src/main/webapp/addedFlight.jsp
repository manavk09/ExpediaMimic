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
		String airport = request.getParameter("airport");
		String aircraft = request.getParameter("aircraft");
		String daysOp = request.getParameter("dayOp");
		String depAir = request.getParameter("depAir");
		String destAir = request.getParameter("destAir");
		String arrivalTime = request.getParameter("arrival");
		String depTime = request.getParameter("dep");
		String isDom = request.getParameter("isdom");
		String isIn = request.getParameter("isIn");
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		try{
			PreparedStatement stmnt = con.prepareStatement("insert into flight values(?,?,?,?,?,?,?,?,?,?,?)");
			stmnt.setString(1, flightNum);
			stmnt.setString(2, airline);
			stmnt.setString(3,airport);
			stmnt.setString(4,aircraft);
			stmnt.setString(5,daysOp);
			stmnt.setString(6,depAir);
			stmnt.setString(7,destAir);
			stmnt.setString(8,arrivalTime);
			stmnt.setString(9,depTime);
			stmnt.setString(10,isDom);
			stmnt.setString(11,isIn);
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
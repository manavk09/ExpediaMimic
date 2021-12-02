<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "cs336proj.*"%>
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	String question = request.getParameter("question");
	if(!question.equals("")){
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		String query = "Select * from forum where forum_question = '" + question + "'";
		PreparedStatement search = con.prepareStatement(query);
		ResultSet result = search.executeQuery(query);
		if(!result.next()){
			String sqlStatement =
				"insert into forum values(?,0,'Not yet answered')";
			PreparedStatement stmnt = con.prepareStatement(sqlStatement);
			stmnt.setString(1, question);
			stmnt.executeUpdate();
		}
	}
	response.sendRedirect("customerForum.jsp");
%>
</body>
</html>
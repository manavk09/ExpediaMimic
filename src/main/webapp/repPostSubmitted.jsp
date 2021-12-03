<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "cs336proj.*" %>
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	String answer = request.getParameter("answer");
	String question = request.getParameter("question").replaceAll("%20", " ");
	if(!answer.equals("")){
		registerDao db = new registerDao();
		Connection con = db.getConnection();
		String sqlStatement = "update forum set answered = 1, answer = ? where(forum_question = '" + question + "')";
		PreparedStatement stmnt = con.prepareStatement(sqlStatement);
		stmnt.setString(1, answer);
		stmnt.executeUpdate();
	}
	response.sendRedirect("repForum.jsp");
%>
</body>
</html>
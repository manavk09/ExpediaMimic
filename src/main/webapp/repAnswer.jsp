<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "cs336proj.*" %>
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<style>
	body {
		margin: 10px 60px;
	}
	h1, h4, ol {
		margin: 0;
	}
	.top-bar {
		background-color: skyblue;
        padding: 0 40px;
	}
</style>
<meta charset="ISO-8859-1">
</head>
<body>
<div class = "top-bar">
		<h1>
			<%= request.getParameter("question").replaceAll("%20", " ")%>
		</h1>
</div>
<form method = "post" action = repPostSubmitted.jsp>
	<textarea name= "answer" style="width: 99.3%; height: 80px;"></textarea>
	<button style = "float: right" name= "question" value= <%= request.getParameter("question").replaceAll(" ", "%20")%>>Submit</button>
</form>
</body>
</html>
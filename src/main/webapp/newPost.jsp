<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "cs336proj.*" %>
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>
<!DOCTYPE html>
<html>
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
<head>
<meta charset="ISO-8859-1">
<title>New Post</title>
</head>
<body>
<div class = "top-bar">
		<h1>
			Question:
			<a href = "customerForum.jsp"><button style = "float: right">Back to forum</button></a>
		</h1>
</div>
<form method = "post" action = postSubmitted.jsp>
	<textarea name= "question" style="width: 99.3%; height: 80px;"></textarea>
	<button style = "float: right">Submit</button>
</form>
</body>
</html>
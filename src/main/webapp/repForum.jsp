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
	p {
		margin: 5px 0;
	}
	.top-bar {
		background-color: skyblue;
        padding: 0 40px;
	}
	.main 
	{
     	background-color: #F6F6EF;
     	padding: 10px 15px;
    }
    .row 
    {
    	padding 5px 0;
    }
    .answer
    {
    	display: flex;
        color: grey;
    }
</style>
<head>
<meta charset="ISO-8859-1">
<title>Unanswered questions</title>
</head>
<body>
<%
	registerDao db = new registerDao();
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
	String str = "SELECT * FROM forum where answered = 0";
	ResultSet result = stmt.executeQuery(str);
%>

<div class = "top-bar">
		<h1>
			Unanswered Forum Questions
			<a href = "customerRepLoginSuccess.jsp"><button style="float: right">Go back to Rep page</button></a>
		</h1>
</div>
<div class="main">
	<ol>
	<%	while(result.next()){ %>
		<li class = "row">
		<h4 class = "title">
			<%= result.getString("forum_question") %>
		</h4>
		<p class= "answer">
			<%= result.getString("answer") %>
		</p>
		<form method = "post" action = repAnswer.jsp>
		<% String question = result.getString("forum_question").replaceAll(" ", "%20"); %>
			<a href = "repAnswer.jsp"><button name = "question" value = <%= question %> >Answer</button></a>
		</form>
		</li>
		<%}
	%>
	</ol>
</div>

</body>
</html>
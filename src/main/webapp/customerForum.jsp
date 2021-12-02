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
<title>Forum</title>
</head>
<body>
<%
	registerDao db = new registerDao();
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
	String str = "SELECT * FROM forum";
	ResultSet result = stmt.executeQuery(str);
%>

<div class = "top-bar">
	<form method = "post" action = searchForum.jsp>
		<h1>
			Website Forum
				<input type = "text" name = "searchText"  style = "float: right"></input>
				<button style = "float: right">Search</button>
		</h1>
	</form>
</div>
<div class="main">
	<a href= "newPost.jsp"><button style = "float: right">New Post</button></a>
	<ol>
	<%	while(result.next()){ %>
		<li class = "row">
		<h4 class = "title">
			<%= result.getString("forum_question") %>
		</h4>
		<p class= "answer">
			<%= result.getString("answer") %>
		</p>
		</li>
		<%}
	%>
	</ol>
</div>

</body>
</html>
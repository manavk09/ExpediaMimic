<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>User Login</h1>
<form action="login" method="post">
<table>
<tr><td>User Name: </td><td><input type = "text" name ="username"></td></tr>
<tr><td>Password: </td><td><input type = "password" name ="password"></td></tr>
<tr><td></td><td><input type = "submit" value ="Login"></td></tr>
</table>
</form>

<a href = "customerRegistration.jsp"><button>Register</button></a>
</body>
</html>
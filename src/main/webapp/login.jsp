<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
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
<form action="customerLoginSuccess.jsp" method="post">
	<input type="hidden" name="user" value= >
</form>
<a href = "customerRegistration.jsp"><button>Register</button></a>
</body>
</html>
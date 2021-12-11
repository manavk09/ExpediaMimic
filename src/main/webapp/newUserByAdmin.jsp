<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Customer Registration</h1>
<form action="newUserByAdminScript.jsp" method ="post">
	<table>
	<tr><td>User Name: </td><td><input type="text" name="userName"></td></tr>
	<tr><td>Password: </td><td><input type="password" name="password"></td></tr>
	<tr><td>First Name: </td><td><input type="text" name="fName"></td></tr>
	<tr><td>Last Name: </td><td><input type="text" name="lName"></td></tr>
	<tr>
		<td>
		Role:
		<br><input type = "radio" name = "role" value = "Customer Representative"> Customer Representative
		<br><input type = "radio" name = "role" value = "Customer"> Customer
		</td>
	</tr>
	<tr><td></td><td><input type="submit" value="Register"></td></tr>
	</table>
</form>
<form action = "AdminLoginSuccess.jsp" method = "post">
	<input type = "submit" value = "Back">
</form>
</body>
</html>
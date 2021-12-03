<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "cs336proj.*" %>
<%@ page import = "java.io.*, java.util.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find Flights</title>
</head>
<body>
<h1>Welcome <%= request.getParameter("username") %>
<a href = "logoutSuccess.jsp"><button style="float: right" >Logout</button></a>
</h1>
<div><a href = "customerForum.jsp"><button style="float: right">Go to Forum</button></a></div>
<a><button>View all your reservations</button></a>

<div>
	<h2>
		<label>Departure Airport: </label><input>
		<label>Destination Airport: </label><input>
		<button>search by airports</button>
	</h2>
	<div style="padding: 5px">
		<label for="one-way-date"> Enter date for one way flights</label>
		<input id="one-way-date" type="datetime-local" name="one_way_date">
		<button>search one way flights</button>
	</div>
	<div style="padding: 5px">
		<label for="roundtrip-date"> Enter date for round-trip flights</label>
		<input id="roundtrip-date" type="datetime-local" name="roundtrip_date">
		<button>search round-trip flights</button>
	</div>
	<div style="padding: 5px">
		<label for="flex-date"> Enter date for flexible flights</label>
		<input id="flex-date" type="datetime-local" name="flex_date">
		<button>search flexible flights</button>
	</div>
</div>
</body>
</html>
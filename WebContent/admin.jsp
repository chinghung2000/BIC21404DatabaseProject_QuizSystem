<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Homepage</title>
<style type="text/css">
body {
	font-family: verdana;
	font-size: 16px;
}

div.welcome-text {
	margin: 30px;
}

span.welcome-name {
	font-weight: bold;
}

div.menu {
	margin: 10px 30px;
	padding: 10px;
}

div.container {
	border: 2px solid;
	border-radius: 10px;
	margin: 0px 30px;
	padding: 10px;
	min-height: 500px;
}

div.title {
	margin: 10px 0px;
	padding: 10px;
}

span.title {
	font-size: 20px;
}

div.content {
	margin: 10px 0px;
	padding: 10px;
}

div.button {
	margin: 10px 0px;
	text-align: center;
	display: block;
	position: absolute;
	left: 0px;
	right: 0px;
	bottom: 0px;
}

button {
	border-radius: 5px;
	font-family: verdana;
	font-size: 16px;
	box-shadow: 1px 1px 1px 0px;
	cursor: pointer;
}

button:hover {
	box-shadow: 0px 0px 1px 0px;
}
</style>
</head>
<body>
	<div class="welcome-text">
		Welcome, <span class="welcome-name" id="span-welcome-name">Guest</span> !
	</div>
	<hr>
	<div class="menu">
		<a href=""><button>Home</button></a>
		<a href=""><button>Admin Registration</button></a>
		<a href=""><button>Lecturer Registration</button></a>
		<a href=""><button>Subject Registration</button></a>
		<a href=""><button>Workload Registration</button></a>
		<a href=""><button>Student Registration</button></a>
		<a href=""><button>View Log</button></a>
		<a href=""><button>Log Out</button></a>
	</div>
	<div class="container">
		<div class="title">
			<span class="title">Admin Homepage</span>
		</div>
		<br><br>
		<div class="content">
			Admin ID: <span></span>
			<br><br>
			Name: <span></span>
			<br><br>
			Session ID: <span></span>
		</div>
	</div>
</body>
</html>
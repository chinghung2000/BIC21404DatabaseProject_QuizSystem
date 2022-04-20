<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="checkSessionAdmin.jsp"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Registration</title>
<script type="text/javascript">
	function $e(id) {
		var element = document.getElementById(id);
		return element;
	}
	
	function XHRequest(method, jsonString, async = true) {
		var xhttp = new XMLHttpRequest();
		xhttp.open("POST", "api/" + method + ".jsp", async);
		xhttp.setRequestHeader("Content-Type", "application/json");
		xhttp.send(jsonString);
	
		xhttp.onreadystatechange = function() {
			if (this.readyState === 4) {
				switch (this.status) {
					case 200:
						var r = JSON.parse(this.responseText);
						
						if (r["ok"] === true) {
							if ("result" in r) {
								loadTable(r["result"]);
							} else {
								loadUserInfo(r);
							}
						} else {
							if ("kickout" in r) {
								location.href = "index.jsp";
							}
							
							if ("message" in r) {
								$e("span-message").innerHTML = r["message"];
							} else {
								$e("span-message").innerHTML = "Error " + r["error_code"] + ": " + r["description"];
							}
						}
						
						break;
					case 404:
						alert("Requested server file not found. Error code: " + this.status);
						break;
					default:
						alert("Request failed. " + this.statusText + "Error Code: " + this.status);
				}
			}
		}
	}
	
	function logout() {
		XHRequest("logout", JSON.stringify({}), false);
		location.href = "index.jsp";
	}
	
	function loadUserInfo(r = null) {
		if (r == null) {
			XHRequest("getUserInfo", JSON.stringify({}));
		} else {
			$e("span-user-id").innerHTML = r["user_id"];
			$e("span-welcome-name").innerHTML = $e("span-name").innerHTML = r["name"];
		}
	}
	
	function loadTable(r = null) {
		if (r == null) {
			XHRequest("getAllAdmins", JSON.stringify({}));
		} else {
			clearTable();
			
			var tBody = $e("list").tBodies[0];
			var row, cell;
			
			for (var i in r) {
				row = tBody.insertRow();
				cell = row.insertCell();
				cell.innerHTML = r[i]["admin_id"];
				cell = row.insertCell();
				cell.innerHTML = r[i]["admin_name"];
				cell = row.insertCell();
				var btnUpdate = document.createElement("button");
				btnUpdate.innerHTML = "Update";
				btnUpdate.setAttribute("onclick", "update('" + r[i]["admin_id"] + "', '" + r[i]["admin_name"] + "');");
				cell.appendChild(btnUpdate);
				cell = row.insertCell();
				var btnDelete = document.createElement("button");
				btnDelete.innerHTML = "Remove";
				btnDelete.setAttribute("onclick", "remove('" + r[i]["admin_id"] + "');");
				cell.appendChild(btnDelete);
			}
		}
	}
	
	function clearTable() {
		var tBody = $e("list").tBodies[0];
		
		for (var i = 0; i < tBody.rows.length; i++) {
			tBody.deleteRow();
		}
	}
	
	function add(adminId, adminName) {
		var d = {};
		d["admin_id"] = adminId;
		d["admin_name"] = adminName;
		
		if (d["admin_id"] != "") {
			if (d["admin_name"] != "") {
				XHRequest("addAdmin", JSON.stringify(d));
				loadTable();
			} else {
				$e("span-message").innerHTML = "Please enter admin name.";
				clearMessage();
			}
		} else {
			$e("span-message").innerHTML = "Please enter admin ID.";
			clearMessage();
		}
	}
	
	function update(adminId, adminName) {
		var d = {};
		d["admin_id"] = adminId;
		d["admin_name"] = adminName;
		
		if (d["admin_id"] != "") {
			if (d["admin_name"] != "") {
				XHRequest("updateAdmin", JSON.stringify(d));
				loadTable();
			} else {
				$e("span-message").innerHTML = "Missing admin name.";
				clearMessage();
			}
		} else {
			$e("span-message").innerHTML = "Missing admin ID.";
			clearMessage();
		}
	}
	
	function remove(adminId) {
		var d = {};
		d["admin_id"] = adminId;
		
		if (d["admin_id"] != "") {
			XHRequest("deleteAdmin", JSON.stringify(d));
			loadTable();
		} else {
			$e("span-message").innerHTML = "Missing admin ID.";
			clearMessage();
		}
	}
	
	var t;
	
	function clearMessage() {
		clearTimeout(t);
		t = setTimeout(function () {
			$e("span-message").innerHTML = null;
		}, 5000);
	}
</script>
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

div.message {
	margin: 10px 0px;
	padding: 10px;
	height: 20px;
}

span.message {
	color: red;
}

div.content {
	margin: 10px 0px;
	padding: 10px;
}

table {
	border: 1px solid #bfbfbf;
	border-collapse: collapse;
}

table tr {
	height: 25px;
}

table th {
	background-color: #efefef;
	text-align: left;
}

table th, table td {
	border: 1px solid #bfbfbf;
	padding: 5px 10px;
	max-width: 400px;
}

input[type=text], [type=password] {
	width: 150px;
	font-family: verdana;
	font-size: 16px;
}

input[type=text]:hover, [type=password]:hover {
	outline: 1px solid;
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
<body onload="loadUserInfo(); loadTable();">
	<div class="welcome-text">
		Welcome, <span class="welcome-name" id="span-welcome-name">Guest</span> !
	</div>
	<hr>
	<div class="menu">
		<a href="admin.jsp"><button>Home</button></a>
		<a href="adminRegistration.jsp"><button>Admin Registration</button></a>
		<a href="lecturerRegistration.jsp"><button>Lecturer Registration</button></a>
		<a href="subjectRegistration.jsp"><button>Subject Registration</button></a>
		<a href="workloadRegistration.jsp"><button>Workload Registration</button></a>
		<a href="studentRegistration.jsp"><button>Student Registration</button></a>
		<a href="log.jsp"><button>View Log</button></a>
		<button onclick="logout();">Log Out</button>
	</div>
	<div class="container">
		<div class="title">
			<span class="title">Admin Registration</span>
		</div>
		<div class="message">
			<span class="message" id="span-message"></span>
		</div>
		<div class="content">
			<table id="list" border="1">
				<thead>
					<tr>
						<th>Admin ID</th>
						<th>Admin Name</th>
						<th>Update</th>
						<th>Delete</th>
					</tr>
				</thead>
				<tbody></tbody>
				<tfoot>
					<tr>
						<td><input type="text" id="input-admin-id" maxlength="6"></td>
						<td><input type="text" id="input-admin-name" style="width: 300px;" maxlength="50"></td>
						<td><button onclick="add($e('input-admin-id').value, $e('input-admin-name').value);">ADD</button></td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
</body>
</html>
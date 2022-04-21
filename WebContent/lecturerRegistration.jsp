<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="checkSessionAdmin.jsp"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Lecturer Registration</title>
<script type="text/javascript">
	function $e(id) {
		var element = document.getElementById(id);
		return element;
	}
	
	function XHRequest(APIMethod, jsonString, {async = true, callback = null, nextCall = null} = {}) {
		var xhttp = new XMLHttpRequest();
		xhttp.open("POST", "api/" + APIMethod + ".jsp", async);
		xhttp.setRequestHeader("Content-Type", "application/json");
		xhttp.send(jsonString);
	
		xhttp.onreadystatechange = function() {
			if (this.readyState === 4) {
				switch (this.status) {
					case 200:
						var rc = JSON.parse(this.responseText);
						
						if (rc["ok"] === true) {
							if (callback != null) window[callback](rc);
						} else {
							if ("kickout" in rc) {
								location.href = "index.jsp";
							} else if ("message" in rc) {
								$e("span-message").innerHTML = rc["message"];
							} else {
								$e("span-message").innerHTML = "Error " + rc["error_code"] + ": " + rc["description"];
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
			
			if (nextCall != null) window[nextCall]();
		}
	}
	
	function logout() {
		XHRequest("logout", JSON.stringify({}), {async: false});
		location.href = "index.jsp";
	}
	
	function loadUserInfo(rc = null) {
		if (rc == null) {
			XHRequest("getUserInfo", JSON.stringify({}), {callback: "loadUserInfo"});
		} else {
			$e("span-welcome-name").innerHTML = rc["name"];
		}
	}
	
	function loadTable(rc = null) {
		if (rc == null) {
			XHRequest("getAllLecturers", JSON.stringify({}), {callback: "loadTable"});
		} else {
			clearTable();
			
			var r = rc["result"]; 
			var tBody = $e("list").tBodies[0];
			var row, cell;
			
			for (var i in r) {
				row = tBody.insertRow();
				cell = row.insertCell();
				cell.innerHTML = r[i]["lecturer_id"];
				cell = row.insertCell();
				cell.innerHTML = r[i]["lecturer_name"];
				cell = row.insertCell();
				cell.innerHTML = r[i]["modified_by"];
				cell = row.insertCell();
				cell.innerHTML = r[i]["modified_on"];
				cell = row.insertCell();
				var btnUpdate = document.createElement("button");
				btnUpdate.innerHTML = "Update";
				btnUpdate.setAttribute("onclick", "update('" + r[i]["lecturer_id"] + "', '" + r[i]["lecturer_name"] + "');");
				cell.appendChild(btnUpdate);
				cell = row.insertCell();
				var btnDelete = document.createElement("button");
				btnDelete.innerHTML = "Remove";
				btnDelete.setAttribute("onclick", "remove('" + r[i]["lecturer_id"] + "');");
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
	
	function add(lecturerId, lecturerName) {
		var d = {};
		d["lecturer_id"] = lecturerId;
		d["lecturer_name"] = lecturerName;
		
		if (d["lecturer_id"] != "") {
			if (d["lecturer_name"] != "") {
				XHRequest("addLecturer", JSON.stringify(d));
				loadTable();
			} else {
				$e("span-message").innerHTML = "Please enter lecturer name.";
				clearMessage();
			}
		} else {
			$e("span-message").innerHTML = "Please enter lecturer ID.";
			clearMessage();
		}
	}
	
	function update(lecturerId, lecturerName) {
		var d = {};
		d["lecturer_id"] = lecturerId;
		d["lecturer_name"] = lecturerName;
		
		if (d["lecturer_id"] != "") {
			if (d["lecturer_name"] != "") {
				XHRequest("updateLecturer", JSON.stringify(d));
				loadTable();
			} else {
				$e("span-message").innerHTML = "Missing lecturer name.";
				clearMessage();
			}
		} else {
			$e("span-message").innerHTML = "Missing lecturer ID.";
			clearMessage();
		}
	}
	
	function remove(lecturerId) {
		var d = {};
		d["lecturer_id"] = lecturerId;
		
		if (d["lecturer_id"] != "") {
			XHRequest("deleteAdmin", JSON.stringify(d));
			loadTable();
		} else {
			$e("span-message").innerHTML = "Missing lecturer ID.";
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
			<span class="title">Lecturer Registration</span>
		</div>
		<div class="message">
			<span class="message" id="span-message"></span>
		</div>
		<div class="content">
			<table id="list" border="1">
				<thead>
					<tr>
						<th>Lecturer ID</th>
						<th>Lecturer Name</th>
						<th>Modified By</th>
						<th>Modified On</th>
						<th>Update</th>
						<th>Delete</th>
					</tr>
				</thead>
				<tbody></tbody>
				<tfoot>
					<tr>
						<td><input type="text" id="input-lecturer-id" maxlength="6"></td>
						<td><input type="text" id="input-lecturer-name" style="width: 300px;" maxlength="50"></td>
						<td></td>
						<td></td>
						<td><button onclick="add($e('input-lecturer-id').value, $e('input-lecturer-name').value);">ADD</button></td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
</body>
</html>
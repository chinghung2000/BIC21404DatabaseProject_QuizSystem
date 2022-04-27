<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="checkSessionAdmin.jsp"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Registration</title>
<script type="text/javascript">
	function $e(id) {
		var element = document.getElementById(id);
		return element;
	}
	
	function XHRequest(APIMethod, jsonString, {async = true, callback = null, nextCall = null} = {}) {
		var xhttp = new XMLHttpRequest();
		xhttp.open("POST", "api/" + APIMethod + ".jsp", async);
		xhttp.setRequestHeader("Content-Type", "application/json");
	
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
		
		xhttp.send(jsonString);
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
			XHRequest("getAllStudents", JSON.stringify({}), {callback: "loadTable"});
		} else {
			clearTable();
			
			var r = rc["result"]; 
			var tBody = $e("list").tBodies[0];
			var row, cell, span, button;
			
			for (var i in r) {
				row = tBody.insertRow();
				
				cell = row.insertCell();
				span = document.createElement("span");
				span.innerHTML = r[i]["student_id"];
				span.setAttribute("style", "display: block;");
				cell.appendChild(span);
				
				cell = row.insertCell();
				span = document.createElement("span");
				span.innerHTML = r[i]["student_name"];
				span.setAttribute("style", "display: block;");
				cell.appendChild(span);
				
				cell = row.insertCell();
				span = document.createElement("span");
				span.innerHTML = r[i]["student_email"];
				span.setAttribute("style", "display: block;");
				cell.appendChild(span);
				
				cell = row.insertCell();
				cell.innerHTML = r[i]["modified_by"];
				
				cell = row.insertCell();
				cell.innerHTML = r[i]["modified_on"];
				
				cell = row.insertCell();
				button = document.createElement("button");
				button.innerHTML = "Update";
				button.setAttribute("onclick", "edit(this, '" + r[i]["student_id"] + "');");
				cell.appendChild(button);
				
				cell = row.insertCell();
				button = document.createElement("button");
				button.innerHTML = "Delete";
				button.setAttribute("onclick", "remove('" + r[i]["student_id"] + "');");
				cell.appendChild(button);
			}
		}
	}
	
	function clearTable() {
		var tBody = $e("list").tBodies[0];
		
		for (var i = tBody.rows.length; i > 0; i--) {
			tBody.deleteRow(0);
		}
	}
	
	function add(studentId, studentName, studentEmail) {
		var d = {};
		d["student_id"] = studentId;
		d["student_name"] = studentName;
		d["student_email"] = studentEmail;
		
		if (d["student_id"] != "") {
			if (d["student_name"] != "") {
				if (d["student_email"] != "") {
					XHRequest("addStudent", JSON.stringify(d));
					loadTable();
				} else {
					$e("span-message").innerHTML = "Please enter student email.";
					clearMessage();
				}
			} else {
				$e("span-message").innerHTML = "Please enter student name.";
				clearMessage();
			}
		} else {
			$e("span-message").innerHTML = "Please enter student ID.";
			clearMessage();
		}
	}
	
	function update(studentId, studentName, studentEmail) {
		var d = {};
		d["student_id"] = studentId;
		d["student_name"] = studentName;
		d["student_email"] = studentEmail;
		
		if (d["student_id"] != "") {
			if (d["student_name"] != "") {
				if (d["student_email"] != "") {
					XHRequest("updateStudent", JSON.stringify(d));
					loadTable();
				} else {
					$e("span-message").innerHTML = "Please enter student email.";
					clearMessage();
				}
			} else {
				$e("span-message").innerHTML = "Please enter student name.";
				clearMessage();
			}
		} else {
			$e("span-message").innerHTML = "Please enter student ID.";
			clearMessage();
		}
	}
	
	function remove(studentId) {
		var d = {};
		d["student_id"] = studentId;
		
		if (d["student_id"] != "") {
			XHRequest("deleteStudent", JSON.stringify(d));
			loadTable();
		} else {
			$e("span-message").innerHTML = "Missing student ID.";
			clearMessage();
		}
	}
	
	function edit(element, studentId) {
		var row = element.parentNode.parentNode;
		var cell, input, button;
		
		cell = row.cells[0];
		span = cell.childNodes[0];
		span.style.display = "none";
		input = document.createElement("input");
		input.type = "text";
		input.value = span.innerHTML;
		cell.appendChild(input);
		
		cell = row.cells[1];
		span = cell.childNodes[0];
		span.style.display = "none";
		input = document.createElement("input");
		input.type = "text";
		input.value = span.innerHTML;
		cell.appendChild(input);
		
		cell = row.cells[4];
		button = cell.childNodes[0];
		button.innerHTML = "Done";
		button.setAttribute("onclick", "update(this.parentNode.parentNode.cells[0].childNodes[1].value, "
				+ "this.parentNode.parentNode.cells[1].childNodes[1].value);");
		
		cell = row.cells[5];
		button = cell.childNodes[0];
		button.innerHTML = "Cancel";
		button.setAttribute("onclick", "cancelEdit(this, '" + studentId + "');");
	}
	
	function cancelEdit(element, studentId) {
		var row = element.parentNode.parentNode;
		var cell;
		
		cell = row.cells[0];
		cell.childNodes[0].style.display = "block";
		cell.removeChild(cell.childNodes[1]);
		
		cell = row.cells[1];
		cell.childNodes[0].style.display = "block";
		cell.removeChild(cell.childNodes[1]);
		
		cell = row.cells[4];
		button = cell.childNodes[0];
		button.innerHTML = "Update";
		button.setAttribute("onclick", "edit(this, '" + studentId + "');");
		
		cell = row.cells[5];
		button = cell.childNodes[0];
		button.innerHTML = "Delete";
		button.setAttribute("onclick", "remove('" + studentId + "');");
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
		<a href="systemLog.jsp"><button>View Log</button></a>
		<button onclick="logout();">Log Out</button>
	</div>
	<div class="container">
		<div class="title">
			<span class="title">Student Registration</span>
		</div>
		<div class="message">
			<span class="message" id="span-message"></span>
		</div>
		<div class="content">
			<table id="list" border="1">
				<thead>
					<tr>
						<th>Student ID</th>
						<th>Student Name</th>
						<th>Email</th>
						<th>Modified By</th>
						<th>Modified On</th>
						<th>Update</th>
						<th>Delete</th>
					</tr>
				</thead>
				<tbody></tbody>
				<tfoot>
					<tr>
						<td><input type="text" id="input-student-id" maxlength="8"></td>
						<td><input type="text" id="input-student-name" style="width: 300px;" maxlength="50"></td>
						<td></td>
						<td></td>
						<td></td>
						<td><button onclick="add($e('input-student-id').value, $e('input-student-name').value);">ADD</button></td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="checkSessionLecturer.jsp"%>


<%

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quiz (Objective)</title>
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
			var d = {};
			d["subject_id"] = "<% out.print(request.getParameter("subject_id")); %>";
			
			XHRequest("getAllQuizObjective", JSON.stringify(d), {callback: "loadTable"});
		} else {
			clearTable();
			
			var r = rc["result"]; 
			var tBody = $e("list").tBodies[0];
			var row, cell, span, button;
			
			for (var i in r) {
				row = tBody.insertRow();
				
				cell = row.insertCell();
				cell.innerHTML = Number(i) + 1;
				
				cell = row.insertCell();
				span = document.createElement("span");
				span.innerHTML = r[i]["question"];
				span.setAttribute("style", "display: block;");
				cell.appendChild(span);
				
				cell = row.insertCell();
				span = document.createElement("span");
				span.innerHTML = r[i]["choice_a"];
				span.setAttribute("style", "display: block;");
				cell.appendChild(span);
				
				cell = row.insertCell();
				span = document.createElement("span");
				span.innerHTML = r[i]["choice_b"];
				span.setAttribute("style", "display: block;");
				cell.appendChild(span);
				
				cell = row.insertCell();
				span = document.createElement("span");
				span.innerHTML = r[i]["choice_c"];
				span.setAttribute("style", "display: block;");
				cell.appendChild(span);
				
				cell = row.insertCell();
				span = document.createElement("span");
				span.innerHTML = r[i]["choice_d"];
				span.setAttribute("style", "display: block;");
				cell.appendChild(span);
				
				cell = row.insertCell();
				span = document.createElement("span");
				span.innerHTML = r[i]["answer"];
				span.setAttribute("style", "display: block;");
				cell.appendChild(span);
				
				cell = row.insertCell();
				cell.innerHTML = r[i]["modified_by"];
				
				cell = row.insertCell();
				cell.innerHTML = r[i]["modified_on"];
				
				cell = row.insertCell();
				button = document.createElement("button");
				button.innerHTML = "Update";
				button.setAttribute("onclick", "edit(this, '" + r[i]["quiz_obj_id"] + "');");
				cell.appendChild(button);
				
				cell = row.insertCell();
				button = document.createElement("button");
				button.innerHTML = "Delete";
				button.setAttribute("onclick", "remove('" + r[i]["quiz_obj_id"] + "');");
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
	
	function add(question, choiceA, choiceB, choiceC, choiceD, answer) {
		var d = {};
		d["question"] = question;
		d["choice_a"] = choiceA;
		d["choice_b"] = choiceB;
		d["choice_c"] = choiceC;
		d["choice_d"] = choiceD;
		d["answer"] = answer;
		
		if (d["question"] != "") {
			if (d["choice_a"] != "") {
				if (d["choice_b"] != "") {
					if (d["answer"] != "") {
						XHRequest("addQuizObjective", JSON.stringify(d));
						loadTable();
					} else {
						$e("span-message").innerHTML = "Please enter answer.";
						clearMessage();
					}
				} else {
					$e("span-message").innerHTML = "Please enter choice B.";
					clearMessage();
				}
			} else {
				$e("span-message").innerHTML = "Please enter choice A.";
				clearMessage();
			}
		} else {
			$e("span-message").innerHTML = "Please enter question.";
			clearMessage();
		}
	}
	
	function update(quizObjId, question, choiceA, choiceB, choiceC, choiceD, answer) {
		var d = {};
		d["quiz_obj_id"] = quizObjId;
		d["question"] = question;
		d["choice_a"] = choiceA;
		d["choice_b"] = choiceB;
		d["choice_c"] = choiceC;
		d["choice_d"] = choiceD;
		d["answer"] = answer;
		
		if (d["quiz_obj_id"] != "") {
			if (d["question"] != "") {
				if (d["choice_a"] != "") {
					if (d["choice_b"] != "") {
						if (d["answer"] != "") {
							XHRequest("updateQuizObjective", JSON.stringify(d));
							loadTable();
						} else {
							$e("span-message").innerHTML = "Please enter answer.";
							clearMessage();
						}
					} else {
						$e("span-message").innerHTML = "Please enter choice B.";
						clearMessage();
					}
				} else {
					$e("span-message").innerHTML = "Please enter choice A.";
					clearMessage();
				}
			} else {
				$e("span-message").innerHTML = "Please enter question.";
				clearMessage();
			}
		} else {
			$e("span-message").innerHTML = "Missing quiz objective ID.";
			clearMessage();
		}
	}
	
	function remove(quizObjId) {
		var d = {};
		d["quiz_obj_id"] = quizObjId;
		
		if (d["quiz_obj_id"] != "") {
			XHRequest("deleteQuizObjective", JSON.stringify(d));
			loadTable();
		} else {
			$e("span-message").innerHTML = "Missing quiz objective ID.";
			clearMessage();
		}
	}
	
	function edit(element, quizObjId) {
		var row = element.parentNode.parentNode;
		var cell, span, input, button;
		
		cell = row.cells[1];
		span = cell.childNodes[0];
		span.style.display = "none";
		input = document.createElement("input");
		input.type = "text";
		input.value = span.innerHTML;
		cell.appendChild(input);
		
		cell = row.cells[2];
		span = cell.childNodes[0];
		span.style.display = "none";
		input = document.createElement("input");
		input.type = "text";
		input.value = span.innerHTML;
		cell.appendChild(input);
		
		cell = row.cells[3];
		span = cell.childNodes[0];
		span.style.display = "none";
		input = document.createElement("input");
		input.type = "text";
		input.value = span.innerHTML;
		cell.appendChild(input);
		
		cell = row.cells[4];
		span = cell.childNodes[0];
		span.style.display = "none";
		input = document.createElement("input");
		input.type = "text";
		input.value = span.innerHTML;
		cell.appendChild(input);
		
		cell = row.cells[5];
		span = cell.childNodes[0];
		span.style.display = "none";
		input = document.createElement("input");
		input.type = "text";
		input.value = span.innerHTML;
		cell.appendChild(input);
		
		cell = row.cells[6];
		span = cell.childNodes[0];
		span.style.display = "none";
		input = document.createElement("input");
		input.type = "text";
		input.value = span.innerHTML;
		cell.appendChild(input);
		
		cell = row.cells[9];
		button = cell.childNodes[0];
		button.innerHTML = "Done";
		button.setAttribute("onclick", "update('" + quizObjId + "', "
				+ "this.parentNode.parentNode.cells[1].childNodes[1].value, "
				+ "this.parentNode.parentNode.cells[2].childNodes[1].value, "
				+ "this.parentNode.parentNode.cells[3].childNodes[1].value, "
				+ "this.parentNode.parentNode.cells[4].childNodes[1].value, "
				+ "this.parentNode.parentNode.cells[5].childNodes[1].value, "
				+ "this.parentNode.parentNode.cells[6].childNodes[1].value);");
		
		cell = row.cells[10];
		button = cell.childNodes[0];
		button.innerHTML = "Cancel";
		button.setAttribute("onclick", "cancelEdit(this, '" + quizObjId + "');");
	}
	
	function cancelEdit(element, quizObjId) {
		var row = element.parentNode.parentNode;
		var cell, button;
		
		cell = row.cells[1];
		cell.childNodes[0].style.display = "block";
		cell.removeChild(cell.childNodes[1]);
		
		cell = row.cells[2];
		cell.childNodes[0].style.display = "block";
		cell.removeChild(cell.childNodes[1]);
		
		cell = row.cells[3];
		cell.childNodes[0].style.display = "block";
		cell.removeChild(cell.childNodes[1]);
		
		cell = row.cells[4];
		cell.childNodes[0].style.display = "block";
		cell.removeChild(cell.childNodes[1]);
		
		cell = row.cells[5];
		cell.childNodes[0].style.display = "block";
		cell.removeChild(cell.childNodes[1]);
		
		cell = row.cells[6];
		cell.childNodes[0].style.display = "block";
		cell.removeChild(cell.childNodes[1]);
		
		cell = row.cells[9];
		button = cell.childNodes[0];
		button.innerHTML = "Update";
		button.setAttribute("onclick", "edit(this, '" + quizObjId + "');");
		
		cell = row.cells[10];
		button = cell.childNodes[0];
		button.innerHTML = "Delete";
		button.setAttribute("onclick", "remove('" + quizObjId + "');");
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
	max-width: 100px;
}

input[type=text], [type=password] {
	width: 100px;
	font-family: verdana;
	font-size: 16px;
}

input[type=text]:hover, [type=password]:hover {
	outline: 1px solid;
}

input[type=checkbox] {
	height: 20px;
	width: 20px;
	cursor: pointer;
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
		<a href="lecturer.jsp"><button>Home</button></a>
		<a href="workload.jsp"><button>View Workloads</button></a>
		<button onclick="logout();">Log Out</button>
	</div>
	<div class="container">
		<div class="title">
			<span class="title">Quiz (Objective)</span>
		</div>
		<div class="message">
			<span class="message" id="span-message"></span>
		</div>
		<div class="content">
			<table id="list" border="1">
				<thead>
					<tr>
						<th>No</th>
						<th>Question</th>
						<th>Choice A</th>
						<th>Choice B</th>
						<th>Choice C</th>
						<th>Choice D</th>
						<th>Answer</th>
						<th>Modified By</th>
						<th>Modified On</th>
						<th>Update</th>
						<th>Delete</th>
					</tr>
				</thead>
				<tbody></tbody>
				<tfoot>
					<tr>
						<td></td>
						<td><input type="text" id="input-question"></td>
						<td><input type="text" id="input-choice-a"></td>
						<td><input type="text" id="input-choice-b"></td>
						<td><input type="text" id="input-choice-c"></td>
						<td><input type="text" id="input-choice-d"></td>
						<td><input type="text" id="input-answer"></td>
						<td></td>
						<td></td>
						<td><button onclick="add($e('input-question').value, $e('input-is-true').value);">ADD</button></td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
</body>
</html>
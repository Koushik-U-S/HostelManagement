<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.model.Student" %>

<%
Student s = (Student) request.getAttribute("student");
%>

<!DOCTYPE html>
<html>
<head>
<title>Update Student</title>

<style>
body {
  font-family: 'Segoe UI';
  background: #eef2ff;
}

.container {
  max-width: 500px;
  margin: 40px auto;
}

.card {
  background: white;
  padding: 30px;
  border-radius: 12px;
  box-shadow: 0 6px 18px rgba(0,0,0,0.1);
}

h2 {
  text-align: center;
  color: #4a00e0;
  margin-bottom: 20px;
}

input {
  width: 100%;
  padding: 10px;
  margin: 10px 0;
  border-radius: 6px;
  border: 1px solid #ccc;
}

input:focus {
  border-color: #4a00e0;
}

.btn {
  width: 100%;
  padding: 12px;
  background: linear-gradient(135deg,#4a00e0,#8e2de2);
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
}

.btn:hover {
  opacity: 0.9;
}

.msg {
  padding: 10px;
  margin-bottom: 10px;
  border-radius: 6px;
}

.error { background: #f8d7da; color: #721c24; }
.success { background: #d4edda; color: #155724; }

.back {
  display:block;
  text-align:center;
  margin-top:15px;
  color:#4a00e0;
}
</style>
</head>

<body>

<div class="container">
<div class="card">

<h2>✏️ Update Student</h2>

<%
String msg = (String) request.getAttribute("message");
String type = (String) request.getAttribute("msgType");
if(msg!=null){
%>
<div class="msg <%=type%>"><%=msg%></div>
<% } %>

<!-- ✅ STEP 1: ASK ID -->
<% if(s == null){ %>

<form action="UpdateStudentServlet" method="get">

<label>Enter Student ID</label>
<input type="number" name="id" required>

<button type="submit" class="btn">Search Student</button>

</form>

<% } else { %>

<!-- ✅ STEP 2: SHOW DETAILS -->

<form action="UpdateStudentServlet" method="post">

<input type="hidden" name="id" value="<%= s.getStudentID() %>">

<label>Name</label>
<input type="text" name="name" value="<%= s.getStudentName() %>" required>

<label>Room</label>
<input type="text" name="roomNumber" value="<%= s.getRoomNumber() %>" required>

<label>Fees Paid</label>
<input type="number" name="feesPaid" value="<%= s.getFeesPaid() %>" required>

<label>Pending Fees</label>
<input type="number" name="pendingFees" value="<%= s.getPendingFees() %>" required>

<button type="submit" class="btn">Update Student</button>

</form>

<% } %>

<a href="index.jsp" class="back">← Back</a>

</div>
</div>

</body>
</html>
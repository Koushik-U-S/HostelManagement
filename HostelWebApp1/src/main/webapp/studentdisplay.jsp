<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.model.Student, java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<title>View Students</title>

<style>
body {
  font-family: 'Segoe UI', sans-serif;
  background: #f0f4ff;
}

.topbar {
  background: linear-gradient(135deg, #8e44ad, #6c3483);
  padding: 18px 30px;
  color: white;
}

.container { margin: 30px; }

.back {
  color: #8e44ad;
  text-decoration: none;
  margin-bottom: 15px;
  display: inline-block;
}

.table-wrap {
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.1);
  overflow: hidden;
}

table {
  width: 100%;
  border-collapse: collapse;
}

thead {
  background: #8e44ad;
  color: white;
}

th, td {
  padding: 12px;
  border-bottom: 1px solid #eee;
}

tr:hover {
  background: #faf5ff;
}

.badge {
  background: #f8d7da;
  color: #c0392b;
  padding: 4px 10px;
  border-radius: 20px;
}

.badge-ok {
  background: #d4edda;
  color: #155724;
}

.none {
  text-align: center;
  padding: 30px;
  color: #999;
}

.msg {
  padding: 10px;
  margin-bottom: 15px;
  border-radius: 6px;
}

.success { background: #d4edda; color: #155724; }
.error { background: #f8d7da; color: #721c24; }

.count-box {
  background: #4CAF50;
  color: white;
  padding: 10px;
  border-radius: 6px;
  margin-bottom: 15px;
  display: inline-block;
}
</style>

</head>
<body>

<div class="topbar">
  <h2>📋 All Students</h2>
</div>

<div class="container">

<a href="index.jsp" class="back">← Back to Home</a>

<%
String msg = request.getParameter("msg");
if ("added".equals(msg)) {
%>
<div class="msg success">Student Added Successfully!</div>
<%
} else if ("deleted".equals(msg)) {
%>
<div class="msg success">Student Deleted Successfully!</div>
<%
}

List<Student> students = (List<Student>) request.getAttribute("students");

if (students != null && !students.isEmpty()) {
%>

<div class="count-box">
Total Students: <%= students.size() %>
</div>

<div class="table-wrap">

<table>
<thead>
<tr>
  <th>ID</th>
  <th>Name</th>
  <th>Room</th>
  <th>Date</th>
  <th>Fees Paid</th>
  <th>Pending</th>
</tr>
</thead>

<tbody>

<% for (Student s : students) { %>
<tr>
  <td><%= s.getStudentID() %></td>
  <td><%= s.getStudentName() %></td>
  <td><%= s.getRoomNumber() %></td>
  <td><%= s.getAdmissionDate() %></td>
  <td><%= s.getFeesPaid() %></td>

  <td>
    <% if (s.getPendingFees().doubleValue() > 0) { %>
        <span class="badge"><%= s.getPendingFees() %></span>
    <% } else { %>
        <span class="badge badge-ok">Cleared</span>
    <% } %>
  </td>
</tr>
<% } %>

</tbody>
</table>

</div>

<% } else { %>

<div class="none">No students found.</div>

<% } %>

</div>

</body>
</html>
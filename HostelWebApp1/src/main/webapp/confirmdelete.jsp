<%@ page import="com.model.Student" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    Student s = (Student) request.getAttribute("student");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Confirm Delete</title>

<style>
body { font-family: Arial; text-align: center; background: #f4f6f9; }
.box {
    width: 350px;
    margin: 50px auto;
    padding: 20px;
    background: white;
    box-shadow: 0 0 10px #ccc;
    border-radius: 10px;
}
.btn {
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}
.delete { background: #e74c3c; color: white; }
.cancel { background: #4CAF50; color: white; }
</style>

</head>
<body>

<div class="box">

<h3>⚠ Confirm Deletion</h3>

<p><b>ID:</b> <%= s.getStudentID() %></p>
<p><b>Name:</b> <%= s.getStudentName() %></p>
<p><b>Room:</b> <%= s.getRoomNumber() %></p>

<br>

<form action="DeleteStudentServlet" method="post">
    <input type="hidden" name="id" value="<%= s.getStudentID() %>">

    <button type="submit" class="btn delete">❌ Confirm Delete</button>
    <a href="studentdisplay.jsp" class="btn cancel">Cancel</a>
</form>

</div>

</body>
</html>
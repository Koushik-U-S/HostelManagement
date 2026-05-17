<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Report Results</title>
<style>
  body { font-family: 'Segoe UI', sans-serif; background:#f4f4f4; padding:20px; }
  h2 { color:#333; }
  table { width:100%; border-collapse:collapse; margin-top:20px; }
  th, td { border:1px solid #ccc; padding:8px; text-align:center; }
  th { background:#eee; }
  .summary { margin-top:15px; font-weight:bold; color:#333; }
  a { display:inline-block; margin-top:20px; padding:8px 12px; background:#3498db; color:white; text-decoration:none; border-radius:4px; }
  a:hover { background:#2980b9; }
</style>
</head>
<body>

<h2>📊 Report Results</h2>

<table>
  <tr>
    <th>ID</th>
    <th>Name</th>
    <th>Room</th>
    <th>Fees Paid</th>
    <th>Pending Fees</th>
    <th>Admission Date</th>
  </tr>
  <%
    java.util.List<com.model.Student> students =
        (java.util.List<com.model.Student>) request.getAttribute("students");
    int count = 0;
    if (students != null && !students.isEmpty()) {
        for (com.model.Student s : students) {
            count++;
  %>
  <tr>
    <td><%= s.getStudentID() %></td>
    <td><%= s.getStudentName() %></td>
    <td><%= s.getRoomNumber() %></td>
    <td><%= s.getFeesPaid() %></td>
    <td><%= s.getPendingFees() %></td>
    <td><%= s.getAdmissionDate() %></td>
  </tr>
  <%
        }
    } else {
  %>
  <tr><td colspan="6">No records found</td></tr>
  <%
    }
  %>
</table>

<div class="summary">Total students found: <%= count %></div>

<a href="reports.jsp">← Back to Reports</a>

</body>
</html>

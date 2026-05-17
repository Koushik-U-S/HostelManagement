<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Hostel Dashboard</title>

<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }

  body {
    font-family: 'Segoe UI', sans-serif;
    background: linear-gradient(135deg, #2ecc71, #3498db);
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .sidebar {
    background: rgba(255, 255, 255, 0.15);
    backdrop-filter: blur(10px);
    border-radius: 16px;
    padding: 30px 40px;
    display: flex;
    flex-direction: column;
    align-items: center;
    box-shadow: 0 8px 20px rgba(0,0,0,0.2);
  }

  .sidebar h2 {
    color: white;
    font-size: 22px;
    margin-bottom: 25px;
    font-weight: 600;
  }

  .sidebar a {
    color: white;
    text-decoration: none;
    padding: 12px 20px;
    margin: 8px 0;
    border-radius: 8px;
    background: rgba(255,255,255,0.2);
    transition: all 0.3s ease;
    width: 180px;
    text-align: center;
    font-size: 16px;
  }

  .sidebar a:hover {
    background: rgba(255,255,255,0.4);
    transform: scale(1.05);
  }
</style>
</head>
<body>

<div class="sidebar">
  <h2>🏠 Hostel Menu</h2>
  <a href="AddStudentServlet">➕ Add Student</a>
  <a href="DisplayStudentsServlet">📋 View Students</a>
  <a href="UpdateStudentServlet">✏️ Update Student</a>
  <a href="DeleteStudentServlet">❌ Delete Student</a>
  <a href="report_form.jsp">📊 Reports</a>
</div>

</body>
</html>

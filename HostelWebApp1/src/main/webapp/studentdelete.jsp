<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Student</title>

<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }

  body {
    font-family: 'Segoe UI', sans-serif;
    background: #f0f4ff;
    min-height: 100vh;
  }

  .topbar {
    background: linear-gradient(135deg, #e74c3c, #c0392b);
    padding: 18px 30px;
    color: white;
    text-align: center;
  }

  .topbar h2 {
    font-size: 20px;
    font-weight: 600;
  }

  .topbar p {
    font-size: 13px;
    opacity: 0.85;
    margin-top: 2px;
  }

  .container {
    max-width: 420px;
    margin: 40px auto;
  }

  .card {
    background: white;
    border-radius: 14px;
    padding: 30px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
  }

  .warn-box {
    background: #fff3cd;
    border-left: 4px solid #ffc107;
    padding: 12px 16px;
    border-radius: 8px;
    margin-bottom: 20px;
    font-size: 13px;
    color: #856404;
  }

  .form-group {
    margin-bottom: 18px;
  }

  label {
    display: block;
    font-size: 13px;
    font-weight: 600;
    color: #555;
    margin-bottom: 6px;
  }

  input[type=number] {
    width: 100%;
    padding: 10px 14px;
    border: 1.5px solid #dce1ec;
    border-radius: 8px;
    font-size: 14px;
    outline: none;
  }

  input:focus {
    border-color: #e74c3c;
  }

  .btn {
    width: 100%;
    padding: 12px;
    background: linear-gradient(135deg, #e74c3c, #c0392b);
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 15px;
    font-weight: 600;
    cursor: pointer;
  }

  .btn:hover {
    opacity: 0.9;
  }

  .back {
    display: block;
    text-align: center;
    margin-top: 14px;
    color: #e74c3c;
    text-decoration: none;
    font-size: 13px;
  }

  .error {
    background: #f8d7da;
    color: #721c24;
    padding: 10px 14px;
    border-radius: 8px;
    margin-bottom: 15px;
    font-size: 14px;
  }

</style>

<!-- ✅ VALIDATION SCRIPT -->
<script>
function validateDelete() {
    var id = document.getElementsByName("id")[0].value;

    if (id === "" || id <= 0) {
        alert("Please enter a valid Student ID!");
        return false;
    }

    return true;
}
</script>

</head>

<body>

<div class="topbar">
  <h2>🗑 Delete Student</h2>
  <p>Enter Student ID to view details before deletion</p>
</div>

<div class="container">

<!-- ❌ ERROR MESSAGE -->
<%
    String msg = request.getParameter("msg");

    if("notfound".equals(msg)){
%>
    <div class="error">⚠ Student ID not found!</div>
<%
    } else if("error".equals(msg)){
%>
    <div class="error">❌ Something went wrong!</div>
<%
    }
%>

<div class="card">

  <div class="warn-box">
    ⚠ First view student details, then confirm deletion.
  </div>

  <!-- ✅ STEP 1: GET METHOD -->
  <form action="DeleteStudentServlet" method="get" onsubmit="return validateDelete()">

    <div class="form-group">
      <label>Enter Student ID</label>
      <input type="number" name="id" placeholder="e.g. 101" required />
    </div>

    <button type="submit" class="btn">
      🔍 Show Details
    </button>

  </form>

  <a href="index.jsp" class="back">← Back to Home</a>

</div>
</div>

</body>
</html>
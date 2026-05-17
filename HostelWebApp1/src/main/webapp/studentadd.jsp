<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Add Student</title>

<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }

  body {
    font-family: 'Segoe UI', sans-serif;
    background: linear-gradient(135deg, #3498db, #2ecc71);
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .form-container {
    background: rgba(255,255,255,0.15);
    backdrop-filter: blur(12px);
    border-radius: 16px;
    padding: 40px;
    width: 420px;
    box-shadow: 0 8px 24px rgba(0,0,0,0.2);
    color: #fff;
  }

  .form-container h2 {
    text-align: center;
    margin-bottom: 20px;
    font-size: 22px;
    font-weight: 600;
  }

  .form-group {
    margin-bottom: 18px;
  }

  label {
    display: block;
    font-size: 14px;
    font-weight: 600;
    margin-bottom: 6px;
  }

  input[type=text], input[type=number], input[type=date] {
    width: 100%;
    padding: 12px;
    border: none;
    border-radius: 8px;
    font-size: 14px;
    outline: none;
    background: rgba(255,255,255,0.9);
    color: #333;
  }

  input:focus {
    background: #fff;
    box-shadow: 0 0 0 2px #3498db;
  }

  input[readonly] {
    background: #eaeaea;
    color: #777;
  }

  .btn {
    width: 100%;
    padding: 12px;
    background: linear-gradient(135deg, #2ecc71, #27ae60);
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 15px;
    cursor: pointer;
    transition: transform 0.2s ease, opacity 0.2s ease;
  }

  .btn:hover {
    opacity: 0.9;
    transform: translateY(-2px);
  }

  .back {
    display: block;
    text-align: center;
    margin-top: 14px;
    color: #fff;
    text-decoration: none;
    font-size: 14px;
  }

  .back:hover {
    text-decoration: underline;
  }

  .error {
    background: rgba(231,76,60,0.9);
    color: white;
    padding: 10px;
    border-radius: 8px;
    margin-bottom: 15px;
    text-align: center;
    font-weight: 600;
  }
</style>

<script>
function allowOnlyAlphabets(e) {
    let char = String.fromCharCode(e.which);
    if (!/[a-zA-Z ]/.test(char)) {
        e.preventDefault();
    }
}
</script>
</head>

<body>

<div class="form-container">
  <h2>👤 Add New Student</h2>

  <%
      Integer nextId = (Integer) request.getAttribute("nextID");
      if(nextId == null){ nextId = 0; }
      String msg = request.getParameter("msg");
      if("invalidname".equals(msg)){
  %>
      <div class="error">❌ Name must contain only alphabets!</div>
  <%
      }
  %>

  <form action="AddStudentServlet" method="post">

    <div class="form-group">
      <label>Student ID (Auto Generated)</label>
      <input type="text" name="studentID"
             value="<%= request.getAttribute("nextID") != null ? request.getAttribute("nextID") : "" %>"
             readonly>
    </div>

    <div class="form-group">
      <label>Student Name</label>
      <input type="text" name="name" placeholder="Student Name"
             pattern="[A-Za-z ]+" title="Only alphabets allowed"
             onkeypress="allowOnlyAlphabets(event)" required>
    </div>

    <div class="form-group">
      <label>Room Number</label>
      <input type="number" name="roomNumber" min="1" placeholder="e.g. 101" required>
    </div>

    <div class="form-group">
      <label>Admission Date</label>
      <%
          java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
          String today = sdf.format(new java.util.Date());
      %>
      <input type="date" name="admissionDate" value="<%= today %>" readonly>
    </div>

    <div class="form-group">
      <label>Fees Paid (₹)</label>
      <input type="number" step="0.01" name="feesPaid" min="0" required>
    </div>

    <div class="form-group">
      <label>Pending Fees (₹)</label>
      <input type="number" step="0.01" name="pendingFees" min="0" required>
    </div>

    <button type="submit" class="btn">✔ Add Student</button>
  </form>

  <a href="index.jsp" class="back">← Back to Home</a>
</div>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Reports</title>

<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }

  body {
    font-family: 'Segoe UI', sans-serif;
    background: linear-gradient(135deg,#1a1a2e,#16213e);
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .card {
    background: #0f3460;
    border-radius: 16px;
    padding: 35px;
    width: 360px;
    box-shadow: 0 8px 30px rgba(0,0,0,0.4);
  }

  .title {
    text-align: center;
    margin-bottom: 25px;
  }

  .title h2 {
    color: #f39c12;
    font-size: 22px;
  }

  .title p {
    color: #ccc;
    font-size: 13px;
    margin-top: 5px;
  }

  .form-group {
    margin-bottom: 15px;
  }

  label {
    color: #ddd;
    font-size: 14px;
    display: block;
    margin-bottom: 5px;
  }

  select, input {
    width: 100%;
    padding: 10px;
    border-radius: 8px;
    border: none;
    outline: none;
    font-size: 14px;
  }

  .btn {
    width: 100%;
    padding: 12px;
    background: #f39c12;
    border: none;
    border-radius: 8px;
    font-weight: bold;
    cursor: pointer;
    margin-top: 10px;
  }

  .btn:hover {
    background: #ffb347;
  }

  .link-btn {
    display: block;
    text-align: center;
    margin-top: 15px;
    padding: 10px;
    background: #16213e;
    color: white;
    border-radius: 8px;
    text-decoration: none;
  }

  .link-btn:hover {
    background: #f39c12;
    color: black;
  }

  .back {
    display: block;
    text-align: center;
    margin-top: 15px;
    color: #aaa;
    text-decoration: none;
  }

  .back:hover {
    color: #f39c12;
  }

  /* Hide date range fields initially */
  .date-range { display: none; }
</style>

<script>
  function toggleFields() {
    const type = document.querySelector("select[name='type']").value;
    const roomField = document.getElementById("roomField");
    const dateRangeFields = document.getElementById("dateRangeFields");

    if (type === "room") {
      roomField.style.display = "block";
      dateRangeFields.style.display = "none";
    } else if (type === "daterange") {
      roomField.style.display = "none";
      dateRangeFields.style.display = "block";
    } else {
      roomField.style.display = "none";
      dateRangeFields.style.display = "none";
    }
  }
</script>

</head>

<body>

<div class="card">

  <div class="title">
    <h2>📊 Reports</h2>
    <p>Generate hostel reports</p>
  </div>

  <!-- ✅ REPORT FORM -->
  <form action="ReportServlet" method="post">

    <div class="form-group">
      <label>Select Report Type</label>
      <select name="type" required onchange="toggleFields()">
        <option value="pending">Pending Fees</option>
        <option value="room">By Room</option>
        <option value="daterange">By Date Range</option>
      </select>
    </div>

    <!-- Room Number -->
    <div class="form-group" id="roomField" style="display:none;">
      <label>Room Number</label>
      <input type="text" name="room" placeholder="Enter room number">
    </div>

    <!-- Date Range -->
    <div id="dateRangeFields" class="date-range">
      <div class="form-group">
        <label>Start Date</label>
        <input type="date" name="startDate">
      </div>
      <div class="form-group">
        <label>End Date</label>
        <input type="date" name="endDate">
      </div>
    </div>

    <button type="submit" class="btn">Generate Report</button>

  </form>

  <!-- VIEW ALL -->
  <a href="DisplayStudentsServlet" class="link-btn">📋 View All Students</a>

  <!-- BACK -->
  <a href="index.jsp" class="back">← Back to Home</a>

</div>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Reports</title>

<style>
  body { font-family: Arial, sans-serif; background: #eef2ff; }

  .container {
    width: 400px;
    margin: 50px auto;
    background: white;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  }

  h2 { text-align: center; margin-bottom: 20px; }

  input, select {
    width: 100%;
    padding: 8px;
    margin: 10px 0;
    border: 1px solid #ccc;
    border-radius: 6px;
  }

  button {
    width: 100%;
    padding: 10px;
    background: #4CAF50;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
  }

  button:hover { background: #45a049; }

  .form-group { margin-bottom: 15px; }
</style>

<script>
  function toggleFields() {
    const type = document.querySelector("select[name='type']").value;
    const roomField = document.getElementById("roomField");
    const dateFields = document.getElementById("dateFields");

    if (type === "room") {
      roomField.style.display = "block";
      dateFields.style.display = "none";
    } else if (type === "daterange") {
      roomField.style.display = "none";
      dateFields.style.display = "block";
    } else {
      roomField.style.display = "none";
      dateFields.style.display = "none";
    }
  }
</script>

</head>
<body>

<div class="container">
  <h2>Generate Report</h2>

  <form action="ReportServlet" method="post">

    <div class="form-group">
      <label>Select Report Type</label>
      <select name="type" required onchange="toggleFields()">
        <option value="">-- Select Report --</option>
        <option value="pending">Pending Fees</option>
        <option value="room">By Room</option>
        <option value="daterange">By Date Range</option>
      </select>
    </div>

    <div class="form-group" id="roomField" style="display:none;">
      <label>Room Number</label>
      <input type="text" name="room" placeholder="Enter Room Number">
    </div>

    <div id="dateFields" style="display:none;">
      <div class="form-group">
        <label>From Date</label>
        <input type="date" name="startDate">
      </div>
      <div class="form-group">
        <label>To Date</label>
        <input type="date" name="endDate">
      </div>
    </div>

    <button type="submit">Generate</button>
  </form>
</div>

</body>
</html>

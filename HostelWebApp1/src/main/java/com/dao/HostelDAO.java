package com.dao;

import com.model.Student;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HostelDAO {

    private static final String URL =
        "jdbc:mysql://localhost:3306/hostel_db?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "root";

    // ✅ Load Driver
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception e) {
            throw new RuntimeException("MySQL Driver not found!", e);
        }
    }

    // ✅ Connection
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // 🔁 Map ResultSet → Student object
    private Student mapRow(ResultSet rs) throws SQLException {
        Student s = new Student();
        s.setStudentID(rs.getInt("StudentID"));
        s.setStudentName(rs.getString("StudentName"));
        s.setRoomNumber(rs.getString("RoomNumber"));
        s.setAdmissionDate(rs.getDate("AdmissionDate"));
        s.setFeesPaid(rs.getBigDecimal("FeesPaid"));
        s.setPendingFees(rs.getBigDecimal("PendingFees"));
        return s;
    }

    // ✅ Counter for next ID
    private static int counter = 0;

    // Initialize counter once at startup (sync with DB)
    public HostelDAO() {
        if (counter == 0) {
            try (Connection con = getConnection();
                 Statement st = con.createStatement();
                 ResultSet rs = st.executeQuery("SELECT MAX(StudentID) FROM HostelStudents")) {
                if (rs.next()) {
                    counter = rs.getInt(1); // start from current max ID
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // ✅ Get Next Student ID (increment counter)
    public synchronized int getNextStudentID() {
        counter++;
        return counter;
    }

    // ➕ Add Student
    public boolean addStudent(Student s) {
        String sql = "INSERT INTO HostelStudents " +
                     "(StudentName, RoomNumber, AdmissionDate, FeesPaid, PendingFees) " +
                     "VALUES (?,?,?,?,?)";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, s.getStudentName());
            ps.setString(2, s.getRoomNumber());
            ps.setDate(3, s.getAdmissionDate());
            ps.setBigDecimal(4, s.getFeesPaid());
            ps.setBigDecimal(5, s.getPendingFees());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Check if a room exists in the database
    public boolean isRoomExists(String room) {
        String sql = "SELECT COUNT(*) FROM HostelStudents WHERE RoomNumber=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, room);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 📋 Get All Students
    public List<Student> getAllStudents() {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT * FROM HostelStudents ORDER BY StudentID";
        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 🔍 Get Student by ID
    public Student getStudentById(int id) {
        String sql = "SELECT * FROM HostelStudents WHERE StudentID=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✏️ Update Student
    public boolean updateStudent(Student s) {
        String sql = "UPDATE HostelStudents SET " +
                     "StudentName=?, RoomNumber=?, AdmissionDate=?, FeesPaid=?, PendingFees=? " +
                     "WHERE StudentID=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, s.getStudentName());
            ps.setString(2, s.getRoomNumber());
            ps.setDate(3, s.getAdmissionDate());
            ps.setBigDecimal(4, s.getFeesPaid());
            ps.setBigDecimal(5, s.getPendingFees());
            ps.setInt(6, s.getStudentID());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ❌ Delete Student
    public boolean deleteStudent(int id) {
        String sql = "DELETE FROM HostelStudents WHERE StudentID=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 📊 Pending Fees Report
    public List<Student> getStudentsWithPendingFees() {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT * FROM HostelStudents WHERE PendingFees > 0";
        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 📊 Room Report
    public List<Student> getStudentsByRoom(String room) {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT * FROM HostelStudents WHERE RoomNumber=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, room);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 📊 Date Range Report
    public List<Student> getStudentsByDateRange(Date from, Date to) {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT * FROM HostelStudents WHERE AdmissionDate BETWEEN ? AND ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, from);
            ps.setDate(2, to);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}

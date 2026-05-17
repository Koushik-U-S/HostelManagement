package com.servlet;

import com.dao.HostelDAO;
import com.model.Student;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;

public class AddStudentServlet extends HttpServlet {

    private HostelDAO dao = new HostelDAO();

    // ✅ LOAD ADD STUDENT PAGE (SHOW NEXT ID)
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int nextId = dao.getNextStudentID();   // get next auto ID
        req.setAttribute("nextID", nextId);

        req.getRequestDispatcher("studentadd.jsp").forward(req, res);
    }

    // ✅ ADD STUDENT
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            String name = req.getParameter("name");
            String room = req.getParameter("roomNumber");

            // ✅ NAME VALIDATION (ONLY ALPHABETS)
            if (name == null || !name.matches("[A-Za-z ]+")) {
                req.setAttribute("message", "❌ Only alphabets allowed in name!");
                req.setAttribute("msgType", "error");
                doGet(req, res);
                return;
            }

            // ✅ ROOM VALIDATION (NO DUPLICATE ROOM)
            if (dao.isRoomExists(room)) {
                req.setAttribute("message", "❌ Room already assigned to another student!");
                req.setAttribute("msgType", "error");
                doGet(req, res);
                return;
            }

            // ✅ GET FEES
            BigDecimal feesPaid = new BigDecimal(req.getParameter("feesPaid"));
            BigDecimal pendingFees = new BigDecimal(req.getParameter("pendingFees"));

            // ❌ NEGATIVE VALIDATION
            if (feesPaid.compareTo(BigDecimal.ZERO) < 0 ||
                pendingFees.compareTo(BigDecimal.ZERO) < 0) {

                req.setAttribute("message", "❌ Fees cannot be negative!");
                req.setAttribute("msgType", "error");
                doGet(req, res);
                return;
            }

            // ✅ CREATE STUDENT OBJECT
            Student s = new Student();
            s.setStudentName(name);
            s.setRoomNumber(room);
            s.setAdmissionDate(new java.sql.Date(System.currentTimeMillis()));
            s.setFeesPaid(feesPaid);
            s.setPendingFees(pendingFees);

            // ✅ INSERT INTO DATABASE
            boolean status = dao.addStudent(s);

            if (status) {
                // ✅ REDIRECT TO VIEW PAGE (IMPORTANT FIX)
                res.sendRedirect("DisplayStudentsServlet?msg=added");
                return;
            } else {
                req.setAttribute("message", "❌ Failed to add student!");
                req.setAttribute("msgType", "error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("message", "❌ Error: " + e.getMessage());
            req.setAttribute("msgType", "error");
        }

        // 🔁 reload form if error
        doGet(req, res);
    }
}
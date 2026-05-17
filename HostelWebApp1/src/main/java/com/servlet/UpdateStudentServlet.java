package com.servlet;

import com.dao.HostelDAO;
import com.model.Student;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.math.BigDecimal;

public class UpdateStudentServlet extends HttpServlet {

    HostelDAO dao = new HostelDAO();

    // ✅ STEP 1: FETCH STUDENT
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(req.getParameter("id"));

            Student s = dao.getStudentById(id);

            if (s != null) {
                req.setAttribute("student", s);
            } else {
                req.setAttribute("message", "Student not found!");
                req.setAttribute("msgType", "error");
            }

        } catch (Exception e) {
            req.setAttribute("message", "Invalid ID!");
            req.setAttribute("msgType", "error");
        }

        req.getRequestDispatcher("studentupdate.jsp").forward(req, res);
    }

    // ✅ STEP 2: UPDATE
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(req.getParameter("id"));

            Student s = new Student();
            s.setStudentID(id);
            s.setStudentName(req.getParameter("name"));
            s.setRoomNumber(req.getParameter("roomNumber"));
            s.setAdmissionDate(new Date(System.currentTimeMillis()));
            s.setFeesPaid(new BigDecimal(req.getParameter("feesPaid")));
            s.setPendingFees(new BigDecimal(req.getParameter("pendingFees")));

            boolean status = dao.updateStudent(s);

            if (status) {
                res.sendRedirect("DisplayStudentsServlet?msg=updated");
                return;
            } else {
                req.setAttribute("message", "Update failed!");
                req.setAttribute("msgType", "error");
            }

        } catch (Exception e) {
            req.setAttribute("message", "Error occurred!");
            req.setAttribute("msgType", "error");
        }

        req.getRequestDispatcher("studentupdate.jsp").forward(req, res);
    }
}
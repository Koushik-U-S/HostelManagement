package com.servlet;

import com.dao.HostelDAO;
import com.model.Student;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class DeleteStudentServlet extends HttpServlet {

    private HostelDAO dao = new HostelDAO();

    // 🔍 SHOW STUDENT DETAILS
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            String idStr = req.getParameter("id");

            if (idStr == null) {
                req.getRequestDispatcher("studentdelete.jsp").forward(req, res);
                return;
            }

            int id = Integer.parseInt(idStr);
            Student s = dao.getStudentById(id);

            if (s != null) {
                req.setAttribute("student", s);
                req.getRequestDispatcher("confirmdelete.jsp").forward(req, res);
            } else {
                res.sendRedirect("studentdelete.jsp?msg=notfound");
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("studentdelete.jsp?msg=error");
        }
    }

    // ❌ DELETE
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(req.getParameter("id"));

            dao.deleteStudent(id);

            // ✅ IMPORTANT FIX
            res.sendRedirect("DisplayStudentsServlet");

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("DisplayStudentsServlet");
        }
    }
}
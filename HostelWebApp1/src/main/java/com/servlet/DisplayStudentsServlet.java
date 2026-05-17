package com.servlet;

import com.dao.HostelDAO;
import com.model.Student;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class DisplayStudentsServlet extends HttpServlet {

    private HostelDAO dao = new HostelDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        List<Student> list = dao.getAllStudents();

        req.setAttribute("students", list);
        req.setAttribute("count", list.size());

        req.getRequestDispatcher("studentdisplay.jsp").forward(req, res);
    }
}
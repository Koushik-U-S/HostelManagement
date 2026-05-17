package com.servlet;

import com.dao.HostelDAO;
import com.model.Student;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

public class ReportServlet extends HttpServlet {

    private HostelDAO dao = new HostelDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String type = req.getParameter("type");
        List<Student> list = null;

        try {
            if ("pending".equals(type)) {
                // ✅ Pending fees report
                list = dao.getStudentsWithPendingFees();

            } else if ("room".equals(type)) {
                // ✅ Room-based report
                String room = req.getParameter("room");
                if (room != null && !room.trim().isEmpty()) {
                    list = dao.getStudentsByRoom(room.trim());
                }

            } else if ("daterange".equals(type)) {
                // ✅ Date range report
                String startDateStr = req.getParameter("startDate");
                String endDateStr = req.getParameter("endDate");

                if (startDateStr != null && endDateStr != null &&
                    !startDateStr.isEmpty() && !endDateStr.isEmpty()) {

                    // Convert String → java.sql.Date
                    Date startDate = Date.valueOf(startDateStr);
                    Date endDate = Date.valueOf(endDateStr);

                    list = dao.getStudentsByDateRange(startDate, endDate);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // If no records found, set empty list
        if (list == null) {
            list = java.util.Collections.emptyList();
        }

        req.setAttribute("students", list);
        req.getRequestDispatcher("/report_result.jsp").forward(req, res);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        // Redirect GET to reports.jsp
        res.sendRedirect("reports.jsp");
    }
}

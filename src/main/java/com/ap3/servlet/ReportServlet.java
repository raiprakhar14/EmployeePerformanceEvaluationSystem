package com.ap3.servlet;

import com.ap3.model.Evaluation;
import com.ap3.service.PerformanceService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/reports")
public class ReportServlet extends HttpServlet {

    private final PerformanceService performanceService =
            new PerformanceService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String userRole =
                (String) session.getAttribute("userRole");

        // Only managers can view reports
        if (userRole == null ||
                !"MANAGER".equalsIgnoreCase(userRole)) {

            response.sendRedirect("login.jsp");
            return;
        }

        try {

            List<Evaluation> evaluations =
                    performanceService.getAllEvaluations();

            double averageScore =
                    performanceService.getAverageScore();

            request.setAttribute(
                    "evaluations",
                    evaluations
            );

            request.setAttribute(
                    "averageScore",
                    averageScore
            );

            request.getRequestDispatcher(
                    "reports.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "dashboard.jsp?error=reports"
            );
        }
    }
}
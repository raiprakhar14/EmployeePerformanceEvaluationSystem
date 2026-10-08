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

@WebServlet("/my-performance")
public class EmployeePerformanceServlet extends HttpServlet {

    private final PerformanceService performanceService =
            new PerformanceService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Object userIdObject =
                session.getAttribute("userId");

        String userRole =
                (String) session.getAttribute("userRole");

        // Only logged-in employees can access this page
        if (userIdObject == null ||
                !"EMPLOYEE".equalsIgnoreCase(userRole)) {

            response.sendRedirect("login.jsp");
            return;
        }

        try {

            int employeeId = (Integer) userIdObject;

            List<Evaluation> evaluations =
                    performanceService
                            .getEmployeeEvaluations(employeeId);

            request.setAttribute(
                    "evaluations",
                    evaluations
            );

            request.getRequestDispatcher(
                    "my-performance.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "dashboard.jsp?error=performance"
            );
        }
    }
}
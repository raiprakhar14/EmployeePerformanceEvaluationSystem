package com.ap3.servlet;

import com.ap3.model.Goal;
import com.ap3.service.PerformanceService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/my-goals")
public class EmployeeGoalsServlet extends HttpServlet {

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

        // Only logged-in employees can access My Goals
        if (userIdObject == null ||
                !"EMPLOYEE".equalsIgnoreCase(userRole)) {

            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int userId = (Integer) userIdObject;

            /*
             * The session contains the ID from the users table.
             * The goals table stores employee_id from the employees table.
             *
             * PerformanceService/GoalDAO will handle the conversion
             * from user ID to employee ID.
             */
            List<Goal> goals =
                    performanceService.getEmployeeGoals(userId);

            request.setAttribute("goals", goals);

            request.getRequestDispatcher(
                    "my-goals.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "dashboard.jsp?error=goals"
            );
        }
    }
}
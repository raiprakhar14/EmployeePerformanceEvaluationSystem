package com.ap3.servlet;

import com.ap3.model.Goal;
import com.ap3.model.User;
import com.ap3.service.PerformanceService;
import com.ap3.dao.DatabaseConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/goal")
public class GoalServlet extends HttpServlet {

    private final PerformanceService performanceService =
            new PerformanceService();


    // ==========================================
    // OPEN GOAL PAGE
    // ==========================================

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String userRole =
                (String) session.getAttribute("userRole");

        if (!"MANAGER".equalsIgnoreCase(userRole)) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<User> employees = new ArrayList<>();

        String sql = "SELECT id, name, email, role " +
                "FROM users " +
                "WHERE role = 'EMPLOYEE' " +
                "ORDER BY name";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                User employee = new User();

                employee.setId(resultSet.getInt("id"));
                employee.setName(resultSet.getString("name"));
                employee.setEmail(resultSet.getString("email"));
                employee.setRole(resultSet.getString("role"));

                employees.add(employee);
            }

            request.setAttribute("employees", employees);

            request.getRequestDispatcher("goal.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "goal.jsp?error=database");
        }
    }


    // ==========================================
    // SAVE GOAL
    // ==========================================

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            HttpSession session = request.getSession();

            Object managerIdObject =
                    session.getAttribute("userId");

            String userRole =
                    (String) session.getAttribute("userRole");

            // Only managers can create goals
            if (managerIdObject == null ||
                    !"MANAGER".equalsIgnoreCase(userRole)) {

                response.sendRedirect("login.jsp");
                return;
            }

            int employeeId =
                    Integer.parseInt(
                            request.getParameter("employeeId"));

            String goalTitle =
                    request.getParameter("goalTitle");

            String description =
                    request.getParameter("description");

            String targetDate =
                    request.getParameter("targetDate");

            String status =
                    request.getParameter("status");


            // Basic validation
            if (goalTitle == null ||
                    goalTitle.trim().isEmpty() ||
                    targetDate == null ||
                    targetDate.trim().isEmpty()) {

                response.sendRedirect(
                        "goal?error=invalid");

                return;
            }


            Goal goal = new Goal();

            goal.setEmployeeId(employeeId);
            goal.setGoalTitle(goalTitle.trim());
            goal.setDescription(description);
            goal.setTargetDate(targetDate);
            goal.setStatus(status);


            boolean saved =
                    performanceService.addGoal(goal);


            if (saved) {

                response.sendRedirect(
                        "goal?success=true");

            } else {

                response.sendRedirect(
                        "goal?error=save");
            }


        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "goal?error=invalid");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "goal?error=database");
        }
    }
}
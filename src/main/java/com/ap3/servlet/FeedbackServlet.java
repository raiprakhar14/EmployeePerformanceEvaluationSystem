package com.ap3.servlet;

import com.ap3.model.Feedback;
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

@WebServlet("/feedback")
public class FeedbackServlet extends HttpServlet {

    private final PerformanceService performanceService =
            new PerformanceService();

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

            request.getRequestDispatcher("feedback.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "feedback.jsp?error=database");
        }
    }

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

            if (managerIdObject == null ||
                    !"MANAGER".equalsIgnoreCase(userRole)) {

                response.sendRedirect("login.jsp");
                return;
            }

            int managerId =
                    (Integer) managerIdObject;

            int employeeId =
                    Integer.parseInt(
                            request.getParameter("employeeId"));

            String feedbackText =
                    request.getParameter("feedbackText");

            if (feedbackText == null ||
                    feedbackText.trim().isEmpty()) {

                response.sendRedirect(
                        "feedback?error=invalid");

                return;
            }

            Feedback feedback = new Feedback();

            feedback.setEmployeeId(employeeId);
            feedback.setManagerId(managerId);
            feedback.setFeedbackText(
                    feedbackText.trim());

            boolean saved =
                    performanceService.addFeedback(feedback);

            if (saved) {

                response.sendRedirect(
                        "feedback?success=true");

            } else {

                response.sendRedirect(
                        "feedback?error=save");
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "feedback?error=invalid");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "feedback?error=database");
        }
    }
}
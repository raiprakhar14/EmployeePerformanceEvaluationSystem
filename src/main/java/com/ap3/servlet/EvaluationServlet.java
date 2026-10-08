package com.ap3.servlet;

import com.ap3.model.Evaluation;
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

@WebServlet("/evaluation")
public class EvaluationServlet extends HttpServlet {

    private final PerformanceService performanceService =
            new PerformanceService();


    // ==========================================
    // OPEN EVALUATION PAGE
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

            request.getRequestDispatcher("evaluation.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "evaluation.jsp?error=database");
        }
    }


    // ==========================================
    // SAVE EVALUATION
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

            // Only managers can submit evaluations
            if (managerIdObject == null ||
                    !"MANAGER".equalsIgnoreCase(userRole)) {

                response.sendRedirect("login.jsp");
                return;
            }

            int managerId = (Integer) managerIdObject;

            int employeeId =
                    Integer.parseInt(
                            request.getParameter("employeeId"));

            int productivity =
                    Integer.parseInt(
                            request.getParameter("productivity"));

            int quality =
                    Integer.parseInt(
                            request.getParameter("quality"));

            int teamwork =
                    Integer.parseInt(
                            request.getParameter("teamwork"));

            int communication =
                    Integer.parseInt(
                            request.getParameter("communication"));

            String comments =
                    request.getParameter("comments");


            // Validate ratings
            if (productivity < 1 || productivity > 10 ||
                    quality < 1 || quality > 10 ||
                    teamwork < 1 || teamwork > 10 ||
                    communication < 1 || communication > 10) {

                response.sendRedirect(
                        "evaluation?error=rating");

                return;
            }


            Evaluation evaluation = new Evaluation();

            evaluation.setEmployeeId(employeeId);
            evaluation.setManagerId(managerId);
            evaluation.setProductivity(productivity);
            evaluation.setQuality(quality);
            evaluation.setTeamwork(teamwork);
            evaluation.setCommunication(communication);
            evaluation.setComments(comments);


            boolean saved =
                    performanceService.addEvaluation(evaluation);


            if (saved) {

                response.sendRedirect(
                        "evaluation?success=true");

            } else {

                response.sendRedirect(
                        "evaluation?error=save");
            }


        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "evaluation?error=invalid");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "evaluation?error=database");
        }
    }
}
package com.ap3.servlet;

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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null ||
                email.trim().isEmpty() || password.trim().isEmpty()) {

            response.sendRedirect("login.jsp?error=invalid");
            return;
        }

        String sql = "SELECT id, name, role FROM users " +
                "WHERE email = ? AND password = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);
            statement.setString(2, password);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {

                    int id = resultSet.getInt("id");
                    String name = resultSet.getString("name");
                    String role = resultSet.getString("role");

                    HttpSession session = request.getSession();

                    session.setAttribute("userId", id);
                    session.setAttribute("userName", name);
                    session.setAttribute("userRole", role);

                    response.sendRedirect("dashboard.jsp");

                } else {

                    response.sendRedirect("login.jsp?error=invalid");
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
            response.sendRedirect("login.jsp?error=database");
        }
    }
}
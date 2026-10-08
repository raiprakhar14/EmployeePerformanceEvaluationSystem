package com.ap3.servlet;

import com.ap3.dao.UserDAO;
import com.ap3.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/employee-list")
public class EmployeeListServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Object userIdObject =
                session.getAttribute("userId");

        String userRole =
                (String) session.getAttribute("userRole");

        // Only managers can access these pages
        if (userIdObject == null ||
                !"MANAGER".equalsIgnoreCase(userRole)) {

            response.sendRedirect("login.jsp");
            return;
        }

        try {

            List<User> employees =
                    userDAO.getAllEmployees();

            request.setAttribute(
                    "employees",
                    employees
            );

            String page =
                    request.getParameter("page");

            if ("goal".equalsIgnoreCase(page)) {

                request.getRequestDispatcher(
                        "goal.jsp"
                ).forward(request, response);

            } else if ("feedback".equalsIgnoreCase(page)) {

                request.getRequestDispatcher(
                        "feedback.jsp"
                ).forward(request, response);

            } else {

                request.getRequestDispatcher(
                        "evaluation.jsp"
                ).forward(request, response);
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "dashboard.jsp?error=employees"
            );
        }
    }
}
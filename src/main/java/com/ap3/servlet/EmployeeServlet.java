package com.ap3.servlet;

import com.ap3.model.Employee;
import com.ap3.service.PerformanceService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/employees")
public class EmployeeServlet extends HttpServlet {

    private final PerformanceService performanceService =
            new PerformanceService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String userRole =
                (String) session.getAttribute("userRole");

        // Only managers can access the employee section
        if (userRole == null ||
                !"MANAGER".equalsIgnoreCase(userRole)) {

            response.sendRedirect("login.jsp");
            return;
        }

        try {

            List<Employee> employees =
                    performanceService.getAllEmployees();

            request.setAttribute(
                    "employees",
                    employees
            );

            request.getRequestDispatcher(
                    "employees.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "dashboard.jsp?error=employees"
            );
        }
    }
}
package com.ap3.servlet;

import com.ap3.model.PersonalGoal;
import com.ap3.service.PerformanceService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/personal-goal")
public class PersonalGoalServlet extends HttpServlet {

    private final PerformanceService performanceService =
            new PerformanceService();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            HttpSession session = request.getSession();

            Object userIdObject =
                    session.getAttribute("userId");

            String userRole =
                    (String) session.getAttribute("userRole");

            // Only logged-in employees can create personal goals
            if (userIdObject == null ||
                    !"EMPLOYEE".equalsIgnoreCase(userRole)) {

                response.sendRedirect("login.jsp");
                return;
            }

            int userId = (Integer) userIdObject;

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
                    goalTitle.trim().isEmpty()) {

                response.sendRedirect(
                        "personal-goals.jsp?error=invalid"
                );

                return;
            }


            // Default status if none is provided
            if (status == null ||
                    status.trim().isEmpty()) {

                status = "NOT_STARTED";
            }


            PersonalGoal goal =
                    new PersonalGoal();

            /*
             * This is users.id.
             *
             * PersonalGoalDAO converts it to
             * employees.id before inserting.
             */
            goal.setEmployeeId(userId);

            goal.setGoalTitle(
                    goalTitle.trim()
            );

            goal.setDescription(
                    description
            );

            goal.setTargetDate(
                    targetDate
            );

            goal.setStatus(
                    status
            );


            boolean saved =
                    performanceService.addPersonalGoal(goal);


            if (saved) {

                response.sendRedirect(
                        "personal-goals.jsp?success=true"
                );

            } else {

                response.sendRedirect(
                        "personal-goals.jsp?error=save"
                );
            }


        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "personal-goals.jsp?error=database"
            );
        }
    }
}
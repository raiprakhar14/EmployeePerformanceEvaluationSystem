package com.ap3.dao;

import com.ap3.model.Goal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class GoalDAO {

    // Save a new goal
    public boolean saveGoal(Goal goal) {

        /*
         * The JSP sends users.id as employeeId.
         *
         * But the goals table requires employees.id.
         *
         * So we find the employees.id using employees.user_id.
         */
        String sql = "INSERT INTO goals " +
                "(employee_id, goal_title, description, target_date, status) " +
                "SELECT id, ?, ?, ?, ? " +
                "FROM employees " +
                "WHERE user_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, goal.getGoalTitle());
            statement.setString(2, goal.getDescription());
            statement.setString(3, goal.getTargetDate());
            statement.setString(4, goal.getStatus());

            // This is the users.id received from the JSP
            statement.setInt(5, goal.getEmployeeId());

            int rows = statement.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // Get all goals of an employee
    public List<Goal> getGoalsByEmployee(int userId) {

        List<Goal> goals = new ArrayList<>();

        /*
         * The session contains users.id.
         *
         * The goals table contains employees.id.
         *
         * Therefore, we join users' employee record through
         * employees.user_id to find the correct goals.
         */
        String sql = "SELECT g.id, g.employee_id, g.goal_title, " +
                "g.description, g.target_date, g.status " +
                "FROM goals g " +
                "INNER JOIN employees e ON g.employee_id = e.id " +
                "WHERE e.user_id = ? " +
                "ORDER BY g.id DESC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            // This is the users.id from the logged-in session
            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    Goal goal = new Goal(
                            resultSet.getInt("id"),
                            resultSet.getInt("employee_id"),
                            resultSet.getString("goal_title"),
                            resultSet.getString("description"),
                            resultSet.getString("target_date"),
                            resultSet.getString("status")
                    );

                    goals.add(goal);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return goals;
    }


    // Get all goals
    public List<Goal> getAllGoals() {

        List<Goal> goals = new ArrayList<>();

        String sql = "SELECT id, employee_id, goal_title, " +
                "description, target_date, status " +
                "FROM goals " +
                "ORDER BY id DESC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                Goal goal = new Goal(
                        resultSet.getInt("id"),
                        resultSet.getInt("employee_id"),
                        resultSet.getString("goal_title"),
                        resultSet.getString("description"),
                        resultSet.getString("target_date"),
                        resultSet.getString("status")
                );

                goals.add(goal);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return goals;
    }
}
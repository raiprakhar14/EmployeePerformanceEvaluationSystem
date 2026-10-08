package com.ap3.dao;

import com.ap3.model.Feedback;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO {

    // Save new feedback
    public boolean saveFeedback(Feedback feedback) {

        /*
         * The JSP sends users.id as employeeId.
         *
         * But feedback.employee_id requires employees.id.
         *
         * So we convert:
         *
         * users.id → employees.user_id → employees.id
         */

        String sql = "INSERT INTO feedback " +
                "(employee_id, manager_id, feedback_text) " +
                "SELECT e.id, ?, ? " +
                "FROM employees e " +
                "WHERE e.user_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            // manager_id is correctly a users.id
            statement.setInt(1, feedback.getManagerId());

            // Feedback text
            statement.setString(2, feedback.getFeedbackText());

            // Employee users.id received from JSP
            statement.setInt(3, feedback.getEmployeeId());

            int rows = statement.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // Get feedback for a particular employee
    public List<Feedback> getFeedbackByEmployee(int userId) {

        List<Feedback> feedbackList = new ArrayList<>();

        /*
         * The logged-in employee has users.id.
         *
         * The feedback table stores employees.id.
         *
         * Therefore we join:
         *
         * feedback.employee_id → employees.id
         * employees.user_id → users.id
         */

        String sql = "SELECT f.id, f.employee_id, f.manager_id, " +
                "f.feedback_text, f.feedback_date " +
                "FROM feedback f " +
                "INNER JOIN employees e ON f.employee_id = e.id " +
                "WHERE e.user_id = ? " +
                "ORDER BY f.id DESC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            // This is the users.id from the logged-in session
            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    Feedback feedback = new Feedback(
                            resultSet.getInt("id"),
                            resultSet.getInt("employee_id"),
                            resultSet.getInt("manager_id"),
                            resultSet.getString("feedback_text"),
                            resultSet.getString("feedback_date")
                    );

                    feedbackList.add(feedback);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return feedbackList;
    }


    // Get all feedback
    public List<Feedback> getAllFeedback() {

        List<Feedback> feedbackList = new ArrayList<>();

        String sql = "SELECT id, employee_id, manager_id, " +
                "feedback_text, feedback_date " +
                "FROM feedback " +
                "ORDER BY id DESC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                Feedback feedback = new Feedback(
                        resultSet.getInt("id"),
                        resultSet.getInt("employee_id"),
                        resultSet.getInt("manager_id"),
                        resultSet.getString("feedback_text"),
                        resultSet.getString("feedback_date")
                );

                feedbackList.add(feedback);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return feedbackList;
    }
}
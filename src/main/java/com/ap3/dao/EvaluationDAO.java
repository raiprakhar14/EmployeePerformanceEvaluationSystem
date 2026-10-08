package com.ap3.dao;

import com.ap3.model.Evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EvaluationDAO {

    // =========================
    // SAVE EVALUATION
    // =========================

    public boolean saveEvaluation(Evaluation evaluation) {

        /*
         * employeeId received from the JSP is users.id.
         *
         * evaluations.employee_id requires employees.id.
         *
         * So we find the employee record using:
         *
         * employees.user_id = users.id
         */

        String sql = "INSERT INTO evaluations " +
                "(employee_id, manager_id, productivity, quality, " +
                "teamwork, communication, overall_score, comments) " +
                "SELECT e.id, ?, ?, ?, ?, ?, ?, ? " +
                "FROM employees e " +
                "WHERE e.user_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            // Parameter 1: manager_id
            statement.setInt(1, evaluation.getManagerId());

            // Parameter 2: productivity
            statement.setInt(2, evaluation.getProductivity());

            // Parameter 3: quality
            statement.setInt(3, evaluation.getQuality());

            // Parameter 4: teamwork
            statement.setInt(4, evaluation.getTeamwork());

            // Parameter 5: communication
            statement.setInt(5, evaluation.getCommunication());

            // Parameter 6: overall score
            statement.setDouble(6, evaluation.calculateScore());

            // Parameter 7: comments
            statement.setString(7, evaluation.getComments());

            // Parameter 8: users.id
            statement.setInt(8, evaluation.getEmployeeId());

            int rows = statement.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // =========================
    // GET ALL EVALUATIONS
    // =========================

    public List<Evaluation> getAllEvaluations() {

        List<Evaluation> evaluations = new ArrayList<>();

        String sql = "SELECT id, employee_id, manager_id, " +
                "productivity, quality, teamwork, communication, " +
                "overall_score, comments " +
                "FROM evaluations " +
                "ORDER BY id DESC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                Evaluation evaluation = new Evaluation(
                        resultSet.getInt("id"),
                        resultSet.getInt("employee_id"),
                        resultSet.getInt("manager_id"),
                        resultSet.getInt("productivity"),
                        resultSet.getInt("quality"),
                        resultSet.getInt("teamwork"),
                        resultSet.getInt("communication"),
                        resultSet.getDouble("overall_score"),
                        resultSet.getString("comments")
                );

                evaluations.add(evaluation);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return evaluations;
    }


    // =========================
    // GET EMPLOYEE EVALUATIONS
    // =========================

    public List<Evaluation> getEvaluationsByEmployee(int employeeId) {

        List<Evaluation> evaluations = new ArrayList<>();

        String sql = "SELECT id, employee_id, manager_id, " +
                "productivity, quality, teamwork, communication, " +
                "overall_score, comments " +
                "FROM evaluations " +
                "WHERE employee_id = ? " +
                "ORDER BY id DESC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, employeeId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    Evaluation evaluation = new Evaluation(
                            resultSet.getInt("id"),
                            resultSet.getInt("employee_id"),
                            resultSet.getInt("manager_id"),
                            resultSet.getInt("productivity"),
                            resultSet.getInt("quality"),
                            resultSet.getInt("teamwork"),
                            resultSet.getInt("communication"),
                            resultSet.getDouble("overall_score"),
                            resultSet.getString("comments")
                    );

                    evaluations.add(evaluation);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return evaluations;
    }


    // =========================
    // GET AVERAGE SCORE
    // =========================

    public double getAverageScore() {

        String sql = "SELECT AVG(overall_score) AS average_score " +
                "FROM evaluations";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                return resultSet.getDouble("average_score");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0.0;
    }
}
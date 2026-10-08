package com.ap3.dao;

import com.ap3.model.PersonalGoal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PersonalGoalDAO {

    // Save a personal goal
    public boolean savePersonalGoal(PersonalGoal goal) {

        /*
         * The employee session contains users.id.
         *
         * The personal_goals table stores employees.id.
         *
         * Therefore we convert:
         *
         * users.id → employees.user_id → employees.id
         */

        String sql = "INSERT INTO personal_goals " +
                "(employee_id, goal_title, description, target_date, status) " +
                "SELECT e.id, ?, ?, ?, ? " +
                "FROM employees e " +
                "WHERE e.user_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, goal.getGoalTitle());
            statement.setString(2, goal.getDescription());
            statement.setString(3, goal.getTargetDate());
            statement.setString(4, goal.getStatus());

            // users.id from the logged-in employee
            statement.setInt(5, goal.getEmployeeId());

            int rows = statement.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // Get personal goals of a particular employee
    public List<PersonalGoal> getPersonalGoalsByEmployee(int userId) {

        List<PersonalGoal> goals = new ArrayList<>();

        String sql = "SELECT pg.id, pg.employee_id, pg.goal_title, " +
                "pg.description, pg.target_date, pg.status " +
                "FROM personal_goals pg " +
                "INNER JOIN employees e ON pg.employee_id = e.id " +
                "WHERE e.user_id = ? " +
                "ORDER BY pg.id DESC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            // users.id from the logged-in employee
            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    PersonalGoal goal = new PersonalGoal(
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
}
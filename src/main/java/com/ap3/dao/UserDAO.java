package com.ap3.dao;

import com.ap3.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public List<User> getAllEmployees() {

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

        } catch (Exception e) {
            e.printStackTrace();
        }

        return employees;
    }
}
package com.ap3.dao;

import com.ap3.model.Employee;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDAO {

    // Get all employees
    public List<Employee> getAllEmployees() {

        List<Employee> employees = new ArrayList<>();

        String sql =
                "SELECT u.id, u.name, u.email, u.password, u.role " +
                        "FROM users u " +
                        "INNER JOIN employees e ON u.id = e.user_id " +
                        "WHERE u.role = 'EMPLOYEE' " +
                        "ORDER BY u.name";

        try (Connection connection =
                     DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet =
                     statement.executeQuery()) {

            while (resultSet.next()) {

                Employee employee = new Employee(
                        resultSet.getInt("id"),
                        resultSet.getString("name"),
                        resultSet.getString("email"),
                        resultSet.getString("password")
                );

                employees.add(employee);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return employees;
    }
}
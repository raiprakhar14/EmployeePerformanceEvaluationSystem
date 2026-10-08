package com.ap3.model;

import com.ap3.Evaluatable;

public class Employee extends User implements Evaluatable {

    public Employee() {
        super();
    }

    public Employee(int id, String name, String email, String password) {
        super(id, name, email, password, "EMPLOYEE");
    }

    public String getDashboardRole() {
        return "Employee Dashboard";
    }

    @Override
    public double calculateScore() {
        return 0.0;
    }
}
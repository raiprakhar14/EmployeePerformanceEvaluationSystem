package com.ap3.model;

import com.ap3.Evaluatable;

public class Manager extends User implements Evaluatable {

    public Manager() {
        super();
    }

    public Manager(int id, String name, String email, String password) {
        super(id, name, email, password, "MANAGER");
    }

    public String getDashboardRole() {
        return "Manager Dashboard";
    }

    @Override
    public double calculateScore() {
        return 0.0;
    }
}
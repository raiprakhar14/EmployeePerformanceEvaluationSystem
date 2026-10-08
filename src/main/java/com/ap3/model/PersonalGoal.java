package com.ap3.model;

public class PersonalGoal {

    private int id;
    private int employeeId;
    private String goalTitle;
    private String description;
    private String targetDate;
    private String status;

    public PersonalGoal() {
    }

    public PersonalGoal(int id,
                        int employeeId,
                        String goalTitle,
                        String description,
                        String targetDate,
                        String status) {

        this.id = id;
        this.employeeId = employeeId;
        this.goalTitle = goalTitle;
        this.description = description;
        this.targetDate = targetDate;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(int employeeId) {
        this.employeeId = employeeId;
    }

    public String getGoalTitle() {
        return goalTitle;
    }

    public void setGoalTitle(String goalTitle) {
        this.goalTitle = goalTitle;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTargetDate() {
        return targetDate;
    }

    public void setTargetDate(String targetDate) {
        this.targetDate = targetDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
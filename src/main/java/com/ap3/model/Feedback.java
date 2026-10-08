package com.ap3.model;

public class Feedback {

    private int id;
    private int employeeId;
    private int managerId;
    private String feedbackText;
    private String feedbackDate;

    public Feedback() {
    }

    public Feedback(int id, int employeeId, int managerId,
                    String feedbackText, String feedbackDate) {

        this.id = id;
        this.employeeId = employeeId;
        this.managerId = managerId;
        this.feedbackText = feedbackText;
        this.feedbackDate = feedbackDate;
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

    public int getManagerId() {
        return managerId;
    }

    public void setManagerId(int managerId) {
        this.managerId = managerId;
    }

    public String getFeedbackText() {
        return feedbackText;
    }

    public void setFeedbackText(String feedbackText) {
        this.feedbackText = feedbackText;
    }

    public String getFeedbackDate() {
        return feedbackDate;
    }

    public void setFeedbackDate(String feedbackDate) {
        this.feedbackDate = feedbackDate;
    }
}
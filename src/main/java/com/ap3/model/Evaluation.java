package com.ap3.model;

import com.ap3.Evaluatable;

public class Evaluation implements Evaluatable {

    private int id;
    private int employeeId;
    private int managerId;

    private int productivity;
    private int quality;
    private int teamwork;
    private int communication;

    private double overallScore;

    private String comments;


    // =========================
    // DEFAULT CONSTRUCTOR
    // =========================

    public Evaluation() {
    }


    // =========================
    // PARAMETERIZED CONSTRUCTOR
    // =========================

    public Evaluation(int id,
                      int employeeId,
                      int managerId,
                      int productivity,
                      int quality,
                      int teamwork,
                      int communication,
                      double overallScore,
                      String comments) {

        this.id = id;
        this.employeeId = employeeId;
        this.managerId = managerId;
        this.productivity = productivity;
        this.quality = quality;
        this.teamwork = teamwork;
        this.communication = communication;
        this.overallScore = overallScore;
        this.comments = comments;
    }


    // =========================
    // GETTERS AND SETTERS
    // =========================

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


    public int getProductivity() {
        return productivity;
    }

    public void setProductivity(int productivity) {
        this.productivity = productivity;
    }


    public int getQuality() {
        return quality;
    }

    public void setQuality(int quality) {
        this.quality = quality;
    }


    public int getTeamwork() {
        return teamwork;
    }

    public void setTeamwork(int teamwork) {
        this.teamwork = teamwork;
    }


    public int getCommunication() {
        return communication;
    }

    public void setCommunication(int communication) {
        this.communication = communication;
    }


    public double getOverallScore() {
        return overallScore;
    }

    public void setOverallScore(double overallScore) {
        this.overallScore = overallScore;
    }


    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }


    // =========================
    // CALCULATE PERFORMANCE SCORE
    // =========================

    @Override
    public double calculateScore() {

        overallScore =
                (productivity
                        + quality
                        + teamwork
                        + communication) / 4.0;

        return overallScore;
    }
}
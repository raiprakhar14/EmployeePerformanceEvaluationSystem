package com.ap3.service;

import com.ap3.dao.EmployeeDAO;
import com.ap3.dao.EvaluationDAO;
import com.ap3.dao.FeedbackDAO;
import com.ap3.dao.GoalDAO;
import com.ap3.dao.PersonalGoalDAO;

import com.ap3.model.Employee;
import com.ap3.model.Evaluation;
import com.ap3.model.Feedback;
import com.ap3.model.Goal;
import com.ap3.model.PersonalGoal;

import java.util.List;

public class PerformanceService {

    private final EvaluationDAO evaluationDAO;
    private final GoalDAO goalDAO;
    private final FeedbackDAO feedbackDAO;
    private final PersonalGoalDAO personalGoalDAO;
    private final EmployeeDAO employeeDAO;


    public PerformanceService() {

        evaluationDAO = new EvaluationDAO();

        goalDAO = new GoalDAO();

        feedbackDAO = new FeedbackDAO();

        personalGoalDAO = new PersonalGoalDAO();

        employeeDAO = new EmployeeDAO();
    }


    // =========================
    // EVALUATION
    // =========================

    public boolean addEvaluation(Evaluation evaluation) {

        return evaluationDAO.saveEvaluation(evaluation);
    }


    public List<Evaluation> getAllEvaluations() {

        return evaluationDAO.getAllEvaluations();
    }


    public List<Evaluation> getEmployeeEvaluations(int employeeId) {

        return evaluationDAO.getEvaluationsByEmployee(employeeId);
    }


    public double getAverageScore() {

        return evaluationDAO.getAverageScore();
    }


    // =========================
    // MANAGER GOALS
    // =========================

    public boolean addGoal(Goal goal) {

        return goalDAO.saveGoal(goal);
    }


    public List<Goal> getEmployeeGoals(int employeeId) {

        return goalDAO.getGoalsByEmployee(employeeId);
    }


    public List<Goal> getAllGoals() {

        return goalDAO.getAllGoals();
    }


    // =========================
    // FEEDBACK
    // =========================

    public boolean addFeedback(Feedback feedback) {

        return feedbackDAO.saveFeedback(feedback);
    }


    public List<Feedback> getEmployeeFeedback(int employeeId) {

        return feedbackDAO.getFeedbackByEmployee(employeeId);
    }


    public List<Feedback> getAllFeedback() {

        return feedbackDAO.getAllFeedback();
    }


    // =========================
    // PERSONAL GOALS
    // =========================

    public boolean addPersonalGoal(PersonalGoal goal) {

        return personalGoalDAO.savePersonalGoal(goal);
    }


    public List<PersonalGoal> getEmployeePersonalGoals(int employeeId) {

        return personalGoalDAO.getPersonalGoalsByEmployee(employeeId);
    }


    // =========================
    // EMPLOYEES
    // =========================

    public List<Employee> getAllEmployees() {

        return employeeDAO.getAllEmployees();
    }
}
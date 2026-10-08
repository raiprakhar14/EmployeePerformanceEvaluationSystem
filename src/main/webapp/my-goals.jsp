<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ap3.model.Goal" %>

<%
    String userName = (String) session.getAttribute("userName");

    List<Goal> goals =
            (List<Goal>) request.getAttribute("goals");

    if (goals == null) {
        goals = new java.util.ArrayList<>();
    }

    int completed = 0;
    int inProgress = 0;
    int notStarted = 0;

    for (Goal goal : goals) {

        String status = goal.getStatus();

        if ("Completed".equalsIgnoreCase(status)) {
            completed++;
        } else if ("In Progress".equalsIgnoreCase(status)) {
            inProgress++;
        } else {
            notStarted++;
        }
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>My Goals | AP3</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f4f7fc;
            color: #172033;
        }

        .navbar {
            height: 70px;
            background: linear-gradient(135deg, #2563eb, #4f46e5);
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 45px;
            box-shadow: 0 4px 15px rgba(37, 99, 235, 0.18);
        }

        .logo {
            font-size: 22px;
            font-weight: bold;
        }

        .logo span {
            opacity: 0.8;
            font-weight: normal;
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .user-name {
            font-size: 14px;
        }

        .logout {
            text-decoration: none;
            color: white;
            border: 1px solid rgba(255,255,255,0.5);
            padding: 9px 17px;
            border-radius: 8px;
            font-size: 13px;
        }

        .logout:hover {
            background: rgba(255,255,255,0.15);
        }

        .container {
            width: 92%;
            max-width: 1200px;
            margin: 35px auto;
        }

        .back {
            display: inline-block;
            text-decoration: none;
            color: #2563eb;
            font-size: 14px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .header {
            background: white;
            padding: 28px 30px;
            border-radius: 16px;
            box-shadow: 0 5px 20px rgba(15, 23, 42, 0.06);
            margin-bottom: 25px;
        }

        .header h1 {
            font-size: 28px;
            margin-bottom: 8px;
        }

        .header p {
            color: #64748b;
            font-size: 14px;
        }

        .stats {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 18px;
            margin-bottom: 25px;
        }

        .stat-card {
            background: white;
            padding: 22px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(15, 23, 42, 0.06);
        }

        .stat-label {
            color: #64748b;
            font-size: 13px;
            margin-bottom: 10px;
        }

        .stat-value {
            font-size: 29px;
            font-weight: bold;
            color: #2563eb;
        }

        .goals-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 5px 20px rgba(15, 23, 42, 0.06);
            overflow: hidden;
        }

        .card-header {
            padding: 24px 28px;
            border-bottom: 1px solid #e5e7eb;
        }

        .card-header h2 {
            font-size: 19px;
            margin-bottom: 5px;
        }

        .card-header p {
            color: #64748b;
            font-size: 13px;
        }

        .goal-list {
            padding: 20px;
        }

        .goal {
            border: 1px solid #e5e7eb;
            border-radius: 13px;
            padding: 22px;
            margin-bottom: 15px;
            transition: 0.2s;
        }

        .goal:last-child {
            margin-bottom: 0;
        }

        .goal:hover {
            border-color: #bfdbfe;
            box-shadow: 0 5px 15px rgba(37, 99, 235, 0.07);
        }

        .goal-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            margin-bottom: 12px;
        }

        .goal-title {
            font-size: 17px;
            font-weight: bold;
            color: #1e293b;
        }

        .status {
            padding: 7px 13px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            white-space: nowrap;
        }

        .completed {
            background: #dcfce7;
            color: #15803d;
        }

        .progress {
            background: #dbeafe;
            color: #1d4ed8;
        }

        .not-started {
            background: #f1f5f9;
            color: #64748b;
        }

        .description {
            color: #64748b;
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 15px;
        }

        .goal-info {
            display: flex;
            gap: 30px;
            color: #64748b;
            font-size: 13px;
        }

        .goal-info strong {
            color: #334155;
        }

        .empty {
            text-align: center;
            padding: 60px 20px;
            color: #64748b;
        }

        .empty-icon {
            font-size: 45px;
            margin-bottom: 15px;
        }

        .empty h3 {
            color: #334155;
            margin-bottom: 8px;
        }

        @media (max-width: 850px) {

            .navbar {
                padding: 0 20px;
            }

            .container {
                width: 94%;
            }

            .stats {
                grid-template-columns: repeat(2, 1fr);
            }

            .goal-top {
                align-items: flex-start;
                flex-direction: column;
            }
        }

        @media (max-width: 550px) {

            .stats {
                grid-template-columns: 1fr;
            }

            .goal-info {
                flex-direction: column;
                gap: 8px;
            }
        }

    </style>

</head>

<body>

<div class="navbar">

    <div class="logo">
        AP3 <span>Employee Performance System</span>
    </div>

    <div class="nav-right">

        <div class="user-name">
            Welcome, <%= userName != null ? userName : "Employee" %>
        </div>

        <a href="logout" class="logout">
            Logout
        </a>

    </div>

</div>


<div class="container">

    <a href="dashboard.jsp" class="back">
        Back to Dashboard
    </a>


    <div class="header">

        <h1>My Goals</h1>

        <p>
            Track your assigned goals and monitor your progress.
        </p>

    </div>


    <div class="stats">

        <div class="stat-card">

            <div class="stat-label">
                Total Goals
            </div>

            <div class="stat-value">
                <%= goals.size() %>
            </div>

        </div>


        <div class="stat-card">

            <div class="stat-label">
                Completed
            </div>

            <div class="stat-value">
                <%= completed %>
            </div>

        </div>


        <div class="stat-card">

            <div class="stat-label">
                In Progress
            </div>

            <div class="stat-value">
                <%= inProgress %>
            </div>

        </div>


        <div class="stat-card">

            <div class="stat-label">
                Not Started
            </div>

            <div class="stat-value">
                <%= notStarted %>
            </div>

        </div>

    </div>


    <div class="goals-card">

        <div class="card-header">

            <h2>Assigned Goals</h2>

            <p>
                Goals assigned to you by your manager.
            </p>

        </div>


        <% if (goals.isEmpty()) { %>

            <div class="empty">

                <div class="empty-icon">
                    GOAL
                </div>

                <h3>No goals assigned</h3>

                <p>
                    Your manager has not assigned any goals yet.
                </p>

            </div>

        <% } else { %>

            <div class="goal-list">

                <%
                    for (Goal goal : goals) {

                        String status = goal.getStatus();

                        String statusClass = "not-started";

                        if ("Completed".equalsIgnoreCase(status)) {
                            statusClass = "completed";
                        } else if ("In Progress".equalsIgnoreCase(status)) {
                            statusClass = "progress";
                        }
                %>

                <div class="goal">

                    <div class="goal-top">

                        <div class="goal-title">
                            <%= goal.getGoalTitle() %>
                        </div>

                        <div class="status <%= statusClass %>">
                            <%= status != null ? status : "Not Started" %>
                        </div>

                    </div>


                    <div class="description">

                        <%= goal.getDescription() != null &&
                            !goal.getDescription().trim().isEmpty()
                                ? goal.getDescription()
                                : "No description provided." %>

                    </div>


                    <div class="goal-info">

                        <div>
                            Target Date:
                            <strong>
                                <%= goal.getTargetDate() != null
                                        ? goal.getTargetDate()
                                        : "Not specified" %>
                            </strong>
                        </div>

                        <div>
                            Goal ID:
                            <strong>
                                #<%= goal.getId() %>
                            </strong>
                        </div>

                    </div>

                </div>

                <% } %>

            </div>

        <% } %>

    </div>

</div>

</body>

</html>
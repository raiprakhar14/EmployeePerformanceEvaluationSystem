<%@ page import="java.util.List" %>
<%@ page import="com.ap3.model.PersonalGoal" %>

<%
    String userName = (String) session.getAttribute("userName");

    List<PersonalGoal> personalGoals =
            (List<PersonalGoal>) request.getAttribute("personalGoals");

    if (personalGoals == null) {
        personalGoals = new java.util.ArrayList<>();
    }

    String success = request.getParameter("success");
    String error = request.getParameter("error");

    int totalGoals = personalGoals.size();
    int completedGoals = 0;
    int inProgressGoals = 0;
    int notStartedGoals = 0;

    for (PersonalGoal goal : personalGoals) {

        String status = goal.getStatus();

        if ("COMPLETED".equalsIgnoreCase(status)) {
            completedGoals++;
        } else if ("IN_PROGRESS".equalsIgnoreCase(status)) {
            inProgressGoals++;
        } else {
            notStartedGoals++;
        }
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Personal Goals | AP3</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            color: #172033;
            min-height: 100vh;

            background:
                radial-gradient(
                    circle at 10% 20%,
                    rgba(37,99,235,0.10),
                    transparent 30%
                ),
                radial-gradient(
                    circle at 90% 10%,
                    rgba(124,58,237,0.10),
                    transparent 30%
                ),
                linear-gradient(
                    135deg,
                    #f8fbff,
                    #eef2ff
                );
        }

        .navbar {
            height: 76px;

            background: rgba(255,255,255,0.88);

            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);

            border-bottom: 1px solid #e2e8f0;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 45px;

            box-shadow:
                0 5px 25px rgba(15,23,42,0.06);
        }

        .logo {
            font-size: 22px;
            font-weight: 800;
            color: #2563eb;
        }

        .logo span {
            color: #64748b;
            font-size: 14px;
            font-weight: 500;
            margin-left: 8px;
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 18px;
        }

        .user-name {
            color: #475569;
            font-size: 14px;
            font-weight: 600;
        }

        .logout {
            text-decoration: none;

            color: #dc2626;

            border: 1px solid #fecaca;

            background: #fff5f5;

            padding: 9px 18px;

            border-radius: 9px;

            font-size: 13px;

            font-weight: 600;
        }

        .logout:hover {
            background: #dc2626;
            color: white;
        }

        .container {
            width: 92%;
            max-width: 1150px;
            margin: 38px auto 60px;
        }

        .back {
            display: inline-block;

            text-decoration: none;

            color: #2563eb;

            font-size: 14px;

            font-weight: 700;

            margin-bottom: 20px;
        }

        .header {
            background: rgba(255,255,255,0.95);

            padding: 30px;

            border-radius: 20px;

            border: 1px solid #e2e8f0;

            box-shadow:
                0 10px 30px rgba(15,23,42,0.06);

            margin-bottom: 25px;
        }

        .header h1 {
            font-size: 30px;
            margin-bottom: 9px;
            color: #172033;
        }

        .header p {
            color: #64748b;
            font-size: 14px;
            line-height: 1.7;
        }

        .message {
            padding: 14px 18px;

            border-radius: 10px;

            margin-bottom: 22px;

            font-size: 13px;

            font-weight: 600;
        }

        .success {
            background: #ecfdf5;
            color: #047857;
            border: 1px solid #a7f3d0;
        }

        .error {
            background: #fef2f2;
            color: #b91c1c;
            border: 1px solid #fecaca;
        }

        .summary {
            display: grid;

            grid-template-columns:
                repeat(4, 1fr);

            gap: 18px;

            margin-bottom: 25px;
        }

        .summary-card {
            background: rgba(255,255,255,0.95);

            padding: 22px;

            border-radius: 16px;

            border: 1px solid #e2e8f0;

            box-shadow:
                0 7px 22px rgba(15,23,42,0.05);
        }

        .summary-label {
            color: #64748b;

            font-size: 12px;

            margin-bottom: 9px;

            font-weight: 600;
        }

        .summary-value {
            font-size: 28px;

            font-weight: 800;

            color: #2563eb;
        }

        .main-grid {
            display: grid;

            grid-template-columns:
                1fr 1.35fr;

            gap: 22px;

            align-items: start;
        }

        .panel {
            background: rgba(255,255,255,0.95);

            border-radius: 18px;

            border: 1px solid #e2e8f0;

            box-shadow:
                0 8px 25px rgba(15,23,42,0.05);

            overflow: hidden;
        }

        .panel-header {
            padding: 23px 25px;

            border-bottom: 1px solid #e5e7eb;
        }

        .panel-header h2 {
            font-size: 19px;

            color: #1e293b;

            margin-bottom: 5px;
        }

        .panel-header p {
            color: #64748b;

            font-size: 12px;

            line-height: 1.6;
        }

        .form {
            padding: 24px 25px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;

            font-size: 13px;

            font-weight: 700;

            color: #334155;

            margin-bottom: 7px;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {

            width: 100%;

            padding: 11px 13px;

            border: 1px solid #cbd5e1;

            border-radius: 9px;

            font-family: Arial, Helvetica, sans-serif;

            font-size: 13px;

            color: #334155;

            background: white;

            outline: none;

            transition: 0.2s;
        }

        .form-group textarea {
            min-height: 105px;
            resize: vertical;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {

            border-color: #2563eb;

            box-shadow:
                0 0 0 3px rgba(37,99,235,0.10);
        }

        .submit-btn {

            width: 100%;

            border: none;

            padding: 12px 18px;

            border-radius: 9px;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #4f46e5
                );

            color: white;

            font-size: 13px;

            font-weight: 700;

            cursor: pointer;

            transition: 0.25s;
        }

        .submit-btn:hover {

            transform: translateY(-2px);

            box-shadow:
                0 8px 18px rgba(37,99,235,0.22);
        }

        .goals-list {
            padding: 20px;
        }

        .goal-item {

            border: 1px solid #e2e8f0;

            border-radius: 13px;

            padding: 20px;

            margin-bottom: 15px;

            transition: 0.25s;

            background: #ffffff;
        }

        .goal-item:last-child {
            margin-bottom: 0;
        }

        .goal-item:hover {

            border-color: #bfdbfe;

            box-shadow:
                0 7px 18px rgba(37,99,235,0.07);

            transform: translateY(-2px);
        }

        .goal-top {

            display: flex;

            align-items: flex-start;

            justify-content: space-between;

            gap: 15px;

            margin-bottom: 12px;
        }

        .goal-title {

            font-size: 16px;

            font-weight: 800;

            color: #1e293b;
        }

        .status {

            display: inline-block;

            padding: 6px 10px;

            border-radius: 20px;

            font-size: 10px;

            font-weight: 800;

            white-space: nowrap;
        }

        .status-completed {

            background: #dcfce7;

            color: #15803d;
        }

        .status-progress {

            background: #dbeafe;

            color: #1d4ed8;
        }

        .status-not-started {

            background: #f1f5f9;

            color: #475569;
        }

        .goal-description {

            color: #64748b;

            font-size: 13px;

            line-height: 1.65;

            margin-bottom: 15px;
        }

        .goal-meta {

            display: flex;

            flex-wrap: wrap;

            gap: 10px;
        }

        .meta-item {

            background: #f8fafc;

            border: 1px solid #e2e8f0;

            padding: 7px 10px;

            border-radius: 8px;

            color: #64748b;

            font-size: 11px;
        }

        .meta-item strong {

            color: #334155;
        }

        .empty {

            text-align: center;

            padding: 55px 20px;

            color: #64748b;
        }

        .empty-icon {

            font-size: 42px;

            margin-bottom: 13px;
        }

        .empty h3 {

            color: #334155;

            margin-bottom: 7px;

            font-size: 17px;
        }

        .empty p {

            font-size: 13px;

            line-height: 1.6;
        }

        @media (max-width: 900px) {

            .summary {

                grid-template-columns:
                    repeat(2, 1fr);
            }

            .main-grid {

                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 650px) {

            .navbar {

                padding: 0 20px;
            }

            .logo span {

                display: none;
            }

            .user-name {

                display: none;
            }

            .container {

                width: 94%;
            }

            .summary {

                grid-template-columns: 1fr;
            }

            .header {

                padding: 24px;
            }

            .goal-top {

                flex-direction: column;
            }
        }

    </style>

</head>

<body>

<div class="navbar">

    <div class="logo">

        AP3

        <span>
            Employee Performance System
        </span>

    </div>

    <div class="nav-right">

        <div class="user-name">

            Welcome,
            <%= userName != null ? userName : "Employee" %>

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

        <h1>
            Personal Goals
        </h1>

        <p>
            Create and track your own professional objectives,
            development priorities and personal improvement goals.
        </p>

    </div>


    <% if ("true".equals(success)) { %>

        <div class="message success">

            Personal goal created successfully.

        </div>

    <% } %>


    <% if ("invalid".equals(error)) { %>

        <div class="message error">

            Please enter a goal title.

        </div>

    <% } %>


    <% if ("save".equals(error)) { %>

        <div class="message error">

            Unable to save the personal goal. Please try again.

        </div>

    <% } %>


    <% if ("database".equals(error)) { %>

        <div class="message error">

            A database error occurred. Please try again.

        </div>

    <% } %>


    <div class="summary">

        <div class="summary-card">

            <div class="summary-label">
                Total Goals
            </div>

            <div class="summary-value">
                <%= totalGoals %>
            </div>

        </div>


        <div class="summary-card">

            <div class="summary-label">
                Completed
            </div>

            <div class="summary-value">
                <%= completedGoals %>
            </div>

        </div>


        <div class="summary-card">

            <div class="summary-label">
                In Progress
            </div>

            <div class="summary-value">
                <%= inProgressGoals %>
            </div>

        </div>


        <div class="summary-card">

            <div class="summary-label">
                Not Started
            </div>

            <div class="summary-value">
                <%= notStartedGoals %>
            </div>

        </div>

    </div>


    <div class="main-grid">


        <!-- CREATE PERSONAL GOAL -->

        <div class="panel">

            <div class="panel-header">

                <h2>
                    Create Personal Goal
                </h2>

                <p>
                    Set a goal for your own professional
                    development and track your progress.
                </p>

            </div>


            <form
                    class="form"
                    action="personal-goal"
                    method="post"
            >

                <div class="form-group">

                    <label for="goalTitle">
                        Goal Title
                    </label>

                    <input
                            type="text"
                            id="goalTitle"
                            name="goalTitle"
                            placeholder="Example: Improve Java skills"
                            maxlength="200"
                            required
                    >

                </div>


                <div class="form-group">

                    <label for="description">
                        Description
                    </label>

                    <textarea
                            id="description"
                            name="description"
                            placeholder="Describe what you want to achieve..."
                    ></textarea>

                </div>


                <div class="form-group">

                    <label for="targetDate">
                        Target Date
                    </label>

                    <input
                            type="date"
                            id="targetDate"
                            name="targetDate"
                    >

                </div>


                <div class="form-group">

                    <label for="status">
                        Status
                    </label>

                    <select
                            id="status"
                            name="status"
                    >

                        <option value="NOT_STARTED">
                            Not Started
                        </option>

                        <option value="IN_PROGRESS">
                            In Progress
                        </option>

                        <option value="COMPLETED">
                            Completed
                        </option>

                    </select>

                </div>


                <button
                        type="submit"
                        class="submit-btn"
                >
                    Add Personal Goal
                </button>

            </form>

        </div>


        <!-- PERSONAL GOALS LIST -->

        <div class="panel">

            <div class="panel-header">

                <h2>
                    My Personal Goals
                </h2>

                <p>
                    Your self-defined professional and
                    development objectives.
                </p>

            </div>


            <% if (personalGoals.isEmpty()) { %>

                <div class="empty">

                    <div class="empty-icon">
                        GOAL
                    </div>

                    <h3>
                        No personal goals yet
                    </h3>

                    <p>
                        Create your first personal goal using
                        the form on the left.
                    </p>

                </div>

            <% } else { %>

                <div class="goals-list">

                    <%
                        for (PersonalGoal goal : personalGoals) {

                            String status =
                                    goal.getStatus();

                            String statusClass =
                                    "status-not-started";

                            if ("COMPLETED".equalsIgnoreCase(status)) {

                                statusClass =
                                        "status-completed";

                            } else if ("IN_PROGRESS".equalsIgnoreCase(status)) {

                                statusClass =
                                        "status-progress";
                            }
                    %>


                    <div class="goal-item">

                        <div class="goal-top">

                            <div class="goal-title">

                                <%= goal.getGoalTitle() %>

                            </div>

                            <div class="status <%= statusClass %>">

                                <%= status != null
                                        ? status.replace("_", " ")
                                        : "NOT STARTED" %>

                            </div>

                        </div>


                        <div class="goal-description">

                            <%= goal.getDescription() != null &&
                                !goal.getDescription().trim().isEmpty()
                                    ? goal.getDescription()
                                    : "No description provided." %>

                        </div>


                        <div class="goal-meta">

                            <div class="meta-item">

                                <strong>
                                    Target:
                                </strong>

                                <%= goal.getTargetDate() != null &&
                                    !goal.getTargetDate().trim().isEmpty()
                                        ? goal.getTargetDate()
                                        : "Not specified" %>

                            </div>


                            <div class="meta-item">

                                <strong>
                                    Goal ID:
                                </strong>

                                #<%= goal.getId() %>

                            </div>

                        </div>

                    </div>


                    <% } %>

                </div>

            <% } %>

        </div>

    </div>

</div>

</body>

</html>
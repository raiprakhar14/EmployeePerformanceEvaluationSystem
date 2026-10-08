<%@ page import="java.util.List" %>
<%@ page import="com.ap3.model.Feedback" %>

<%
    String userName = (String) session.getAttribute("userName");

    List<Feedback> feedbackList =
            (List<Feedback>) request.getAttribute("feedbackList");

    if (feedbackList == null) {
        feedbackList = new java.util.ArrayList<>();
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>My Feedback | AP3</title>

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
            max-width: 1100px;
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

        .summary {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 25px;
        }

        .summary-card {
            background: white;
            padding: 24px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(15, 23, 42, 0.06);
        }

        .summary-label {
            color: #64748b;
            font-size: 13px;
            margin-bottom: 10px;
        }

        .summary-value {
            font-size: 30px;
            font-weight: bold;
            color: #2563eb;
        }

        .feedback-card {
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

        .feedback-list {
            padding: 20px;
        }

        .feedback-item {
            border: 1px solid #e5e7eb;
            border-radius: 13px;
            padding: 22px;
            margin-bottom: 15px;
            transition: 0.2s;
        }

        .feedback-item:last-child {
            margin-bottom: 0;
        }

        .feedback-item:hover {
            border-color: #bfdbfe;
            box-shadow: 0 5px 15px rgba(37, 99, 235, 0.07);
        }

        .feedback-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .feedback-label {
            font-size: 15px;
            font-weight: bold;
            color: #334155;
        }

        .feedback-date {
            font-size: 12px;
            color: #64748b;
            background: #f1f5f9;
            padding: 7px 11px;
            border-radius: 8px;
        }

        .feedback-text {
            background: #f8fafc;
            border-left: 4px solid #2563eb;
            padding: 17px;
            border-radius: 8px;
            color: #475569;
            line-height: 1.7;
            font-size: 14px;
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

        @media (max-width: 700px) {

            .navbar {
                padding: 0 20px;
            }

            .container {
                width: 94%;
            }

            .summary {
                grid-template-columns: 1fr;
            }

            .feedback-top {
                align-items: flex-start;
                gap: 10px;
                flex-direction: column;
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

        <h1>My Feedback</h1>

        <p>
            Review feedback provided by your manager and use it
            to improve your performance.
        </p>

    </div>


    <div class="summary">

        <div class="summary-card">

            <div class="summary-label">
                Total Feedback
            </div>

            <div class="summary-value">
                <%= feedbackList.size() %>
            </div>

        </div>


        <div class="summary-card">

            <div class="summary-label">
                Latest Feedback
            </div>

            <div class="summary-value"
                 style="font-size:22px;">

                <%= feedbackList.isEmpty()
                        ? "Not Available"
                        : "Available" %>

            </div>

        </div>

    </div>


    <div class="feedback-card">

        <div class="card-header">

            <h2>Manager Feedback</h2>

            <p>
                Feedback and suggestions shared by your manager.
            </p>

        </div>


        <% if (feedbackList.isEmpty()) { %>

            <div class="empty">

                <div class="empty-icon">
                    💬
                </div>

                <h3>No feedback available</h3>

                <p>
                    Your manager has not provided any feedback yet.
                </p>

            </div>

        <% } else { %>

            <div class="feedback-list">

                <%
                    for (Feedback feedback : feedbackList) {
                %>

                <div class="feedback-item">

                    <div class="feedback-top">

                        <div class="feedback-label">
                            Manager Feedback
                        </div>

                        <div class="feedback-date">

                            <%= feedback.getFeedbackDate() != null
                                    ? feedback.getFeedbackDate()
                                    : "Date not available" %>

                        </div>

                    </div>


                    <div class="feedback-text">

                        <%= feedback.getFeedbackText() != null
                                ? feedback.getFeedbackText()
                                : "No feedback text available." %>

                    </div>

                </div>

                <% } %>

            </div>

        <% } %>

    </div>

</div>

</body>

</html>
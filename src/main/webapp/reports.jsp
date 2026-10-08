<%@ page import="java.util.List" %>
<%@ page import="com.ap3.model.Evaluation" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String userRole = (String) session.getAttribute("userRole");

    if (userRole == null || !"MANAGER".equalsIgnoreCase(userRole)) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Evaluation> evaluations =
            (List<Evaluation>) request.getAttribute("evaluations");

    Double averageScoreObject =
            (Double) request.getAttribute("averageScore");

    double averageScore =
            averageScoreObject != null ? averageScoreObject : 0.0;

    int evaluationCount =
            evaluations != null ? evaluations.size() : 0;

    String performanceLevel;

    if (averageScore >= 8.5) {
        performanceLevel = "Excellent";
    } else if (averageScore >= 7.0) {
        performanceLevel = "Good";
    } else if (averageScore >= 5.0) {
        performanceLevel = "Average";
    } else {
        performanceLevel = "Needs Improvement";
    }
%>

<!DOCTYPE html>
<html>
<head>

    <title>Performance Reports & Analytics</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f7fb;
            color: #1f2937;
        }

        .header {
            background: linear-gradient(135deg, #1769d1, #4f46e5);
            color: white;
            padding: 22px 45px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            margin: 0;
            font-size: 23px;
        }

        .header a {
            background: white;
            color: #1769d1;
            text-decoration: none;
            padding: 10px 18px;
            border-radius: 7px;
            font-weight: bold;
        }

        .container {
            width: 90%;
            max-width: 1250px;
            margin: 35px auto;
        }

        .page-title h2 {
            margin-bottom: 8px;
            color: #1769d1;
            font-size: 30px;
        }

        .page-title p {
            color: #6b7280;
            margin-bottom: 30px;
        }

        /* STATISTICS */

        .stats {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 14px;
            box-shadow: 0 5px 18px rgba(0,0,0,0.07);
        }

        .stat-title {
            color: #6b7280;
            font-size: 14px;
            margin-bottom: 10px;
        }

        .stat-value {
            color: #1769d1;
            font-size: 30px;
            font-weight: bold;
        }

        .stat-description {
            margin-top: 8px;
            color: #6b7280;
            font-size: 13px;
        }

        /* PERFORMANCE SUMMARY */

        .summary {
            background: white;
            padding: 30px;
            border-radius: 14px;
            box-shadow: 0 5px 18px rgba(0,0,0,0.07);
            margin-bottom: 30px;
        }

        .summary h3 {
            margin-top: 0;
            color: #1769d1;
        }

        .score-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .score {
            font-size: 42px;
            font-weight: bold;
            color: #1769d1;
        }

        .level {
            background: #dcfce7;
            color: #166534;
            padding: 10px 18px;
            border-radius: 20px;
            font-weight: bold;
        }

        .progress-background {
            width: 100%;
            height: 15px;
            background: #e5e7eb;
            border-radius: 20px;
            overflow: hidden;
            margin-top: 18px;
        }

        .progress {
            height: 100%;
            background: linear-gradient(90deg, #1769d1, #4f46e5);
            border-radius: 20px;

            width: <%= Math.min(averageScore * 10, 100) %>%;
        }

        /* TABLE */

        .table-card {
            background: white;
            padding: 30px;
            border-radius: 14px;
            box-shadow: 0 5px 18px rgba(0,0,0,0.07);
            overflow-x: auto;
        }

        .table-card h3 {
            margin-top: 0;
            color: #1769d1;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #f0f6ff;
            color: #1769d1;
            text-align: left;
            padding: 14px;
            font-size: 14px;
        }

        td {
            padding: 14px;
            border-bottom: 1px solid #e5e7eb;
            font-size: 14px;
        }

        tr:hover {
            background: #f9fafb;
        }

        .score-badge {
            background: #eef2ff;
            color: #4338ca;
            padding: 6px 10px;
            border-radius: 15px;
            font-weight: bold;
        }

        .empty {
            text-align: center;
            padding: 45px;
            color: #6b7280;
        }

        .footer-note {
            margin-top: 25px;
            color: #6b7280;
            font-size: 13px;
        }

        @media (max-width: 800px) {

            .stats {
                grid-template-columns: 1fr;
            }

            .container {
                width: 94%;
            }

            .header {
                padding: 18px 20px;
            }

            .header h1 {
                font-size: 18px;
            }

            .score-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
        }

    </style>

</head>

<body>

<div class="header">

    <h1>Employee Performance Evaluation System</h1>

    <a href="dashboard.jsp">Dashboard</a>

</div>


<div class="container">

    <div class="page-title">

        <h2>Performance Reports & Analytics</h2>

        <p>
            Analyze employee evaluations and monitor overall
            performance trends.
        </p>

    </div>


    <!-- STATISTICS -->

    <div class="stats">

        <div class="stat-card">

            <div class="stat-title">
                Total Evaluations
            </div>

            <div class="stat-value">
                <%= evaluationCount %>
            </div>

            <div class="stat-description">
                Evaluations recorded in the system
            </div>

        </div>


        <div class="stat-card">

            <div class="stat-title">
                Average Performance
            </div>

            <div class="stat-value">
                <%= String.format("%.1f", averageScore) %>/10
            </div>

            <div class="stat-description">
                Average overall employee score
            </div>

        </div>


        <div class="stat-card">

            <div class="stat-title">
                Performance Level
            </div>

            <div class="stat-value">
                <%= performanceLevel %>
            </div>

            <div class="stat-description">
                Based on current evaluations
            </div>

        </div>

    </div>


    <!-- PERFORMANCE SUMMARY -->

    <div class="summary">

        <h3>Overall Performance Summary</h3>

        <div class="score-row">

            <div>

                <div class="score">
                    <%= String.format("%.1f", averageScore) %>
                    <span style="font-size:20px;">/ 10</span>
                </div>

            </div>

            <div class="level">
                <%= performanceLevel %>
            </div>

        </div>


        <div class="progress-background">

            <div class="progress"></div>

        </div>

    </div>


    <!-- EVALUATION HISTORY -->

    <div class="table-card">

        <h3>Evaluation History</h3>


        <% if (evaluations != null && !evaluations.isEmpty()) { %>

            <table>

                <thead>

                <tr>

                    <th>ID</th>
                    <th>Employee ID</th>
                    <th>Productivity</th>
                    <th>Quality</th>
                    <th>Teamwork</th>
                    <th>Communication</th>
                    <th>Overall Score</th>
                    <th>Comments</th>

                </tr>

                </thead>


                <tbody>

                <% for (Evaluation evaluation : evaluations) { %>

                    <tr>

                        <td>
                            <%= evaluation.getId() %>
                        </td>

                        <td>
                            Employee #<%= evaluation.getEmployeeId() %>
                        </td>

                        <td>
                            <%= evaluation.getProductivity() %>/10
                        </td>

                        <td>
                            <%= evaluation.getQuality() %>/10
                        </td>

                        <td>
                            <%= evaluation.getTeamwork() %>/10
                        </td>

                        <td>
                            <%= evaluation.getCommunication() %>/10
                        </td>

                        <td>

                            <span class="score-badge">

                                <%= String.format(
                                        "%.1f",
                                        evaluation.getOverallScore()
                                ) %>/10

                            </span>

                        </td>

                        <td>
                            <%= evaluation.getComments() != null
                                    ? evaluation.getComments()
                                    : "No comments" %>
                        </td>

                    </tr>

                <% } %>

                </tbody>

            </table>

        <% } else { %>

            <div class="empty">

                <h3>No evaluations yet</h3>

                <p>
                    Performance evaluations will appear here
                    after managers submit them.
                </p>

            </div>

        <% } %>


        <div class="footer-note">

            Reports are generated using information stored
            in the Employee Performance Evaluation System database.

        </div>

    </div>

</div>

</body>
</html>
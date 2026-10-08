<%@ page import="java.util.List" %>
<%@ page import="com.ap3.model.Evaluation" %>

<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");

    List<Evaluation> evaluations =
            (List<Evaluation>) request.getAttribute("evaluations");

    if (userName == null || userRole == null ||
            !"EMPLOYEE".equalsIgnoreCase(userRole)) {
        response.sendRedirect("login.jsp");
        return;
    }

    if (evaluations == null) {
        evaluations = new java.util.ArrayList<>();
    }

    double averageScore = 0;

    if (!evaluations.isEmpty()) {
        double total = 0;

        for (Evaluation evaluation : evaluations) {
            total += evaluation.getOverallScore();
        }

        averageScore = total / evaluations.size();
    }

    String performanceLevel;

    if (averageScore >= 9) {
        performanceLevel = "Excellent";
    } else if (averageScore >= 7) {
        performanceLevel = "Very Good";
    } else if (averageScore >= 5) {
        performanceLevel = "Good";
    } else if (averageScore > 0) {
        performanceLevel = "Needs Improvement";
    } else {
        performanceLevel = "Not Evaluated";
    }

    int progress = (int) (averageScore * 10);
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>My Performance | AP3</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            min-height: 100vh;
            color: #172033;

            background:
                radial-gradient(circle at 10% 20%,
                    rgba(37,99,235,0.12),
                    transparent 30%),

                radial-gradient(circle at 90% 10%,
                    rgba(124,58,237,0.13),
                    transparent 30%),

                linear-gradient(135deg, #f8fbff, #eef2ff);

            overflow-x: hidden;
        }

        body::before {
            content: "";
            position: fixed;

            width: 420px;
            height: 420px;

            border-radius: 50%;

            background: rgba(99,102,241,0.07);

            top: -180px;
            right: -150px;

            filter: blur(5px);

            animation: floatOne 8s ease-in-out infinite;

            z-index: -1;
        }

        body::after {
            content: "";
            position: fixed;

            width: 350px;
            height: 350px;

            border-radius: 50%;

            background: rgba(37,99,235,0.06);

            bottom: -150px;
            left: -120px;

            animation: floatTwo 10s ease-in-out infinite;

            z-index: -1;
        }


        /* NAVBAR */

        .navbar {
            height: 76px;

            background: rgba(255,255,255,0.82);

            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);

            border-bottom: 1px solid rgba(226,232,240,0.8);

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 45px;

            position: sticky;
            top: 0;

            z-index: 100;

            box-shadow:
                0 5px 25px rgba(15,23,42,0.06);

            animation: slideDown 0.6s ease;
        }

        .logo {
            font-size: 22px;
            font-weight: 800;
            color: #2563eb;
            letter-spacing: 0.5px;
        }

        .logo span {
            color: #64748b;
            font-weight: 500;
            font-size: 14px;
            margin-left: 8px;
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .user-name {
            font-size: 14px;
            color: #475569;
            font-weight: 600;
        }

        .dashboard-btn {
            text-decoration: none;

            color: #2563eb;

            border: 1px solid #bfdbfe;

            background: rgba(239,246,255,0.85);

            padding: 9px 17px;

            border-radius: 9px;

            font-size: 13px;
            font-weight: 600;

            transition: all 0.25s ease;
        }

        .dashboard-btn:hover {
            background: #2563eb;
            color: white;

            transform: translateY(-2px);

            box-shadow:
                0 7px 18px rgba(37,99,235,0.25);
        }

        .logout {
            text-decoration: none;

            color: #dc2626;

            border: 1px solid #fecaca;

            background: #fff5f5;

            padding: 9px 17px;

            border-radius: 9px;

            font-size: 13px;
            font-weight: 600;

            transition: all 0.25s ease;
        }

        .logout:hover {
            background: #dc2626;
            color: white;

            transform: translateY(-2px);
        }


        /* MAIN */

        .container {
            width: 92%;
            max-width: 1200px;

            margin: 42px auto 60px;

            animation: fadeUp 0.8s ease;
        }


        /* HEADER */

        .header {
            position: relative;
            overflow: hidden;

            background:
                linear-gradient(
                    135deg,
                    rgba(255,255,255,0.97),
                    rgba(239,246,255,0.95)
                );

            padding: 35px;

            border-radius: 22px;

            border: 1px solid rgba(191,219,254,0.8);

            box-shadow:
                0 15px 40px rgba(37,99,235,0.08);

            margin-bottom: 25px;

            animation: fadeUp 0.8s ease 0.1s both;
        }

        .header::after {
            content: "";

            position: absolute;

            width: 180px;
            height: 180px;

            border-radius: 50%;

            background: rgba(37,99,235,0.06);

            right: -60px;
            top: -70px;

            animation: rotateCircle 12s linear infinite;
        }

        .header h1 {
            position: relative;
            z-index: 2;

            font-size: 30px;

            color: #172033;

            margin-bottom: 9px;
        }

        .header p {
            position: relative;
            z-index: 2;

            color: #64748b;

            font-size: 14px;

            line-height: 1.7;
        }


        /* STAT CARDS */

        .stats {
            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 20px;

            margin-bottom: 25px;
        }

        .stat-card {
            background: rgba(255,255,255,0.94);

            padding: 25px;

            border-radius: 18px;

            border: 1px solid #e5e7eb;

            box-shadow:
                0 8px 25px rgba(15,23,42,0.06);

            transition:
                transform 0.3s ease,
                box-shadow 0.3s ease;

            animation: fadeUp 0.7s ease both;
        }

        .stat-card:nth-child(1) {
            animation-delay: 0.15s;
        }

        .stat-card:nth-child(2) {
            animation-delay: 0.25s;
        }

        .stat-card:nth-child(3) {
            animation-delay: 0.35s;
        }

        .stat-card:hover {
            transform: translateY(-6px);

            box-shadow:
                0 16px 35px rgba(37,99,235,0.12);
        }

        .stat-label {
            color: #64748b;

            font-size: 13px;

            margin-bottom: 10px;
        }

        .stat-value {
            font-size: 29px;

            font-weight: 800;

            color: #2563eb;
        }


        /* PERFORMANCE */

        .performance-card {
            background: rgba(255,255,255,0.94);

            padding: 30px;

            border-radius: 19px;

            border: 1px solid #e5e7eb;

            box-shadow:
                0 8px 25px rgba(15,23,42,0.06);

            margin-bottom: 25px;

            animation: fadeUp 0.8s ease 0.35s both;
        }

        .performance-top {
            display: flex;

            justify-content: space-between;

            align-items: center;

            margin-bottom: 18px;
        }

        .performance-top h2 {
            font-size: 20px;
            color: #1e293b;
        }

        .level {
            padding: 8px 15px;

            background:
                linear-gradient(
                    135deg,
                    #dbeafe,
                    #ede9fe
                );

            color: #4338ca;

            border-radius: 30px;

            font-size: 12px;

            font-weight: 800;

            border: 1px solid #c7d2fe;
        }

        .score {
            font-size: 44px;

            font-weight: 800;

            color: #2563eb;

            margin-bottom: 16px;
        }

        .score span {
            font-size: 18px;
            color: #64748b;
        }

        .progress-background {
            width: 100%;

            height: 13px;

            background: #e5e7eb;

            border-radius: 20px;

            overflow: hidden;
        }

        .progress-bar {
            height: 100%;

            width: <%= progress %>%;

            background:
                linear-gradient(
                    90deg,
                    #2563eb,
                    #6366f1
                );

            border-radius: 20px;

            animation: progressAnimation 1.2s ease;
        }

        .progress-text {
            margin-top: 11px;

            color: #64748b;

            font-size: 13px;
        }


        /* TABLE */

        .table-card {
            background: rgba(255,255,255,0.95);

            border-radius: 19px;

            border: 1px solid #e5e7eb;

            box-shadow:
                0 8px 25px rgba(15,23,42,0.06);

            overflow: hidden;

            animation: fadeUp 0.8s ease 0.45s both;
        }

        .table-header {
            padding: 25px 28px;

            border-bottom: 1px solid #e5e7eb;
        }

        .table-header h2 {
            font-size: 20px;
            color: #1e293b;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        table {
            width: 100%;

            border-collapse: collapse;
        }

        th {
            background: #f8fafc;

            color: #475569;

            font-size: 12px;

            text-transform: uppercase;

            letter-spacing: 0.5px;

            padding: 16px;

            text-align: center;
        }

        td {
            padding: 17px 15px;

            text-align: center;

            border-top: 1px solid #eef2f7;

            font-size: 14px;
        }

        tr {
            transition: background 0.2s ease;
        }

        tr:hover td {
            background: #f8fbff;
        }

        .score-badge {
            display: inline-block;

            padding: 7px 12px;

            border-radius: 9px;

            background: #eaf2ff;

            color: #2563eb;

            font-weight: 800;
        }

        .comments {
            max-width: 280px;

            text-align: left;

            color: #64748b;

            line-height: 1.5;
        }


        /* EMPTY STATE */

        .empty {
            text-align: center;

            padding: 60px 20px;

            color: #64748b;
        }

        .empty-box {
            width: 65px;
            height: 65px;

            margin: 0 auto 18px;

            display: flex;

            align-items: center;
            justify-content: center;

            border-radius: 18px;

            background:
                linear-gradient(
                    135deg,
                    #eff6ff,
                    #eef2ff
                );

            border: 1px solid #dbeafe;

            color: #2563eb;

            font-size: 22px;

            font-weight: 800;
        }

        .empty h3 {
            color: #334155;

            margin-bottom: 8px;

            font-size: 18px;
        }

        .empty p {
            font-size: 13px;
        }


        /* ANIMATIONS */

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes floatOne {
            0%, 100% {
                transform: translate(0, 0);
            }

            50% {
                transform: translate(-25px, 30px);
            }
        }

        @keyframes floatTwo {
            0%, 100% {
                transform: translate(0, 0);
            }

            50% {
                transform: translate(30px, -20px);
            }
        }

        @keyframes rotateCircle {
            from {
                transform: rotate(0deg);
            }

            to {
                transform: rotate(360deg);
            }
        }

        @keyframes progressAnimation {
            from {
                width: 0;
            }

            to {
                width: <%= progress %>%;
            }
        }


        /* MOBILE */

        @media (max-width: 800px) {

            .navbar {
                padding: 0 20px;
            }

            .logo span {
                display: none;
            }

            .container {
                width: 94%;
            }

            .stats {
                grid-template-columns: 1fr;
            }

            .performance-top {
                align-items: flex-start;

                gap: 15px;

                flex-direction: column;
            }

            .user-name {
                display: none;
            }
        }

    </style>

</head>

<body>


<!-- NAVBAR -->

<div class="navbar">

    <div class="logo">

        AP3

        <span>
            Employee Performance System
        </span>

    </div>


    <div class="nav-right">

        <div class="user-name">
            Welcome, <%= userName != null ? userName : "Employee" %>
        </div>

        <a href="dashboard.jsp" class="dashboard-btn">
            Dashboard
        </a>

        <a href="logout" class="logout">
            Logout
        </a>

    </div>

</div>


<!-- MAIN -->

<div class="container">


    <!-- HEADER -->

    <div class="header">

        <h1>
            My Performance
        </h1>

        <p>
            Track your evaluation results and understand your
            overall performance.
        </p>

    </div>


    <!-- STATISTICS -->

    <div class="stats">

        <div class="stat-card">

            <div class="stat-label">
                Total Evaluations
            </div>

            <div class="stat-value">
                <%= evaluations.size() %>
            </div>

        </div>


        <div class="stat-card">

            <div class="stat-label">
                Average Score
            </div>

            <div class="stat-value">
                <%= String.format("%.2f", averageScore) %>/10
            </div>

        </div>


        <div class="stat-card">

            <div class="stat-label">
                Performance Level
            </div>

            <div class="stat-value" style="font-size:22px;">
                <%= performanceLevel %>
            </div>

        </div>

    </div>


    <!-- OVERALL PERFORMANCE -->

    <div class="performance-card">

        <div class="performance-top">

            <h2>
                Overall Performance
            </h2>

            <div class="level">
                <%= performanceLevel %>
            </div>

        </div>


        <div class="score">

            <%= String.format("%.2f", averageScore) %>

            <span>
                / 10
            </span>

        </div>


        <div class="progress-background">

            <div class="progress-bar"></div>

        </div>


        <div class="progress-text">

            Your overall performance score is based on
            productivity, quality, teamwork and communication.

        </div>

    </div>


    <!-- EVALUATION HISTORY -->

    <div class="table-card">

        <div class="table-header">

            <h2>
                Evaluation History
            </h2>

        </div>


        <% if (evaluations.isEmpty()) { %>

            <div class="empty">

                <div class="empty-box">
                    P
                </div>

                <h3>
                    No evaluations available
                </h3>

                <p>
                    Your manager has not submitted a performance
                    evaluation yet.
                </p>

            </div>

        <% } else { %>


            <div class="table-wrapper">

                <table>

                    <thead>

                    <tr>

                        <th>#</th>

                        <th>
                            Productivity
                        </th>

                        <th>
                            Quality
                        </th>

                        <th>
                            Teamwork
                        </th>

                        <th>
                            Communication
                        </th>

                        <th>
                            Overall
                        </th>

                        <th>
                            Comments
                        </th>

                    </tr>

                    </thead>


                    <tbody>

                    <%
                        int count = 1;

                        for (Evaluation evaluation : evaluations) {
                    %>

                    <tr>

                        <td>
                            <%= count++ %>
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
                                        "%.2f",
                                        evaluation.getOverallScore()
                                ) %>

                            </span>

                        </td>

                        <td class="comments">

                            <%= evaluation.getComments() != null
                                    ? evaluation.getComments()
                                    : "No comments" %>

                        </td>

                    </tr>

                    <% } %>

                    </tbody>

                </table>

            </div>

        <% } %>

    </div>


</div>

</body>
</html>
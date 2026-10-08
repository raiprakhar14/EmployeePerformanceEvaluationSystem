<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");

    if (userName == null || userRole == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <title>Employee Performance Evaluation System</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background: #f4f7fb;
            color: #333;
        }

        .navbar {
            background: #1f4e79;
            color: white;
            padding: 18px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar h2 {
            font-size: 22px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .logout {
            background: #e74c3c;
            color: white;
            text-decoration: none;
            padding: 9px 16px;
            border-radius: 6px;
        }

        .logout:hover {
            background: #c0392b;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 40px auto;
        }

        .welcome {
            background: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
        }

        .welcome h1 {
            color: #1f4e79;
            margin-bottom: 8px;
        }

        .welcome p {
            color: #666;
        }

        .section-title {
            margin-bottom: 20px;
            color: #1f4e79;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
            transition: 0.2s;
        }

        .card:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.12);
        }

        .card h3 {
            color: #1f4e79;
            margin-bottom: 12px;
        }

        .card p {
            color: #666;
            line-height: 1.5;
            margin-bottom: 18px;
        }

        .btn {
            display: inline-block;
            background: #1f4e79;
            color: white;
            text-decoration: none;
            padding: 10px 18px;
            border-radius: 6px;
        }

        .btn:hover {
            background: #163a5c;
        }

        .disabled {
            background: #999;
            cursor: not-allowed;
        }

        .disabled:hover {
            background: #999;
        }

        .role-badge {
            display: inline-block;
            padding: 5px 10px;
            background: #eaf2f8;
            color: #1f4e79;
            border-radius: 15px;
            font-size: 13px;
            margin-top: 5px;
        }

    </style>
</head>

<body>

<!-- NAVIGATION BAR -->

<div class="navbar">

    <h2>Employee Performance Evaluation System</h2>

    <div class="user-info">

        <div>
            <strong><%= userName %></strong>
            <br>
            <span class="role-badge">
                <%= userRole %>
            </span>
        </div>

        <a href="logout" class="logout">Logout</a>

    </div>

</div>


<!-- MAIN CONTAINER -->

<div class="container">

    <div class="welcome">

        <h1>Welcome, <%= userName %>!</h1>

        <p>
            Manage employee performance, goals and feedback
            from one place.
        </p>

    </div>


    <% if ("MANAGER".equalsIgnoreCase(userRole)) { %>

        <!-- MANAGER DASHBOARD -->

        <h2 class="section-title">Manager Dashboard</h2>

        <div class="cards">

            <!-- PERFORMANCE EVALUATION -->

            <div class="card">

                <h3>Performance Evaluation</h3>

                <p>
                    Evaluate employees based on predefined
                    performance criteria such as productivity,
                    quality, teamwork and communication.
                </p>

                <a href="evaluation" class="btn">
                    Evaluate Employee
                </a>

            </div>


            <!-- GOAL SETTING -->

            <div class="card">

                <h3>Goal Setting</h3>

                <p>
                    Create and manage performance goals for
                    employees with target dates and status.
                </p>

                <a href="goal" class="btn">
                    Set Goals
                </a>

            </div>


            <!-- FEEDBACK -->

            <div class="card">

                <h3>Employee Feedback</h3>

                <p>
                    Provide constructive feedback to employees
                    and help them improve their performance.
                </p>

                <a href="feedback" class="btn">
                    Give Feedback
                </a>

            </div>


            <!-- REPORTS -->

            <div class="card">

                <h3>Performance Reports</h3>

                <p>
                    View employee performance information and
                    analyze evaluation results.
                </p>

                <a href="#" class="btn disabled">
                    Reports
                </a>

            </div>

        </div>


    <% } else { %>


        <!-- EMPLOYEE DASHBOARD -->

        <h2 class="section-title">Employee Dashboard</h2>

        <div class="cards">

            <!-- PERFORMANCE TRACKING -->

            <div class="card">

                <h3>Performance Tracking</h3>

                <p>
                    Track your performance evaluations and
                    monitor your progress over time.
                </p>

                <a href="#" class="btn disabled">
                    View Performance
                </a>

            </div>


            <!-- FEEDBACK -->

            <div class="card">

                <h3>My Feedback</h3>

                <p>
                    View feedback provided by your manager
                    and identify areas for improvement.
                </p>

                <a href="#" class="btn disabled">
                    View Feedback
                </a>

            </div>


            <!-- PERSONAL GOALS -->

            <div class="card">

                <h3>Personal Goals</h3>

                <p>
                    View your assigned goals and track their
                    progress and completion status.
                </p>

                <a href="#" class="btn disabled">
                    View Goals
                </a>

            </div>

        </div>

    <% } %>

</div>

</body>
</html>
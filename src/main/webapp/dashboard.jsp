<%@ page contentType="text/html;charset=UTF-8" %>

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

    <title>Dashboard | AP3 Employee Performance System</title>

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
            overflow-x: hidden;

            background:
                radial-gradient(
                    circle at 10% 20%,
                    rgba(37,99,235,0.12),
                    transparent 30%
                ),
                radial-gradient(
                    circle at 90% 10%,
                    rgba(124,58,237,0.13),
                    transparent 30%
                ),
                linear-gradient(
                    135deg,
                    #f8fbff,
                    #eef2ff
                );

            animation: pageLoad 0.7s ease;
        }


        /* BACKGROUND */

        body::before {
            content: "";

            position: fixed;

            width: 450px;
            height: 450px;

            border-radius: 50%;

            background: rgba(99,102,241,0.08);

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

            background: rgba(37,99,235,0.07);

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

            gap: 18px;
        }


        .user-name {
            font-size: 14px;

            color: #475569;

            font-weight: 600;
        }


        .logout {
            text-decoration: none;

            color: #dc2626;

            border: 1px solid #fecaca;

            background: rgba(255,245,245,0.85);

            padding: 9px 18px;

            border-radius: 9px;

            font-size: 13px;

            font-weight: 600;

            transition: all 0.25s ease;
        }


        .logout:hover {
            background: #dc2626;

            color: white;

            transform: translateY(-2px);

            box-shadow:
                0 7px 18px rgba(220,38,38,0.20);
        }


        /* MAIN */

        .container {
            width: 92%;

            max-width: 1150px;

            margin: 42px auto 60px;

            animation: fadeUp 0.8s ease;
        }


        /* WELCOME */

        .welcome {
            position: relative;

            overflow: hidden;

            background:
                linear-gradient(
                    135deg,
                    rgba(255,255,255,0.96),
                    rgba(239,246,255,0.94)
                );

            padding: 35px;

            border-radius: 22px;

            border: 1px solid rgba(191,219,254,0.8);

            box-shadow:
                0 15px 40px rgba(37,99,235,0.08);

            margin-bottom: 35px;

            animation:
                fadeUp 0.8s ease 0.1s both;
        }


        .welcome::before {
            content: "";

            position: absolute;

            width: 180px;

            height: 180px;

            border-radius: 50%;

            background: rgba(37,99,235,0.07);

            right: -50px;

            top: -70px;

            animation:
                rotateCircle 12s linear infinite;
        }


        .welcome h2 {
            position: relative;

            font-size: 30px;

            color: #172033;

            margin-bottom: 10px;
        }


        .welcome p {
            position: relative;

            color: #64748b;

            font-size: 15px;

            line-height: 1.7;

            max-width: 700px;
        }


        .role-badge {
            position: relative;

            display: inline-block;

            margin-top: 18px;

            padding: 8px 15px;

            border-radius: 30px;

            background:
                linear-gradient(
                    135deg,
                    #dbeafe,
                    #ede9fe
                );

            color: #4338ca;

            font-size: 11px;

            font-weight: 800;

            letter-spacing: 0.5px;

            border: 1px solid #c7d2fe;
        }


        /* SECTION */

        .section-heading {
            margin-bottom: 20px;

            animation:
                fadeUp 0.8s ease 0.2s both;
        }


        .section-heading h2 {
            font-size: 22px;

            color: #1e293b;

            margin-bottom: 6px;
        }


        .section-heading p {
            color: #64748b;

            font-size: 13px;
        }


        /* CARDS */

        .cards {
            display: grid;

            grid-template-columns:
                repeat(2, 1fr);

            gap: 22px;

            margin-bottom: 38px;
        }


        .card-link {
            text-decoration: none;

            color: inherit;

            display: block;
        }


        .card {
            position: relative;

            overflow: hidden;

            background: rgba(255,255,255,0.94);

            padding: 28px;

            border-radius: 19px;

            border: 1px solid #e5e7eb;

            box-shadow:
                0 8px 25px rgba(15,23,42,0.06);

            min-height: 205px;

            transition:
                transform 0.3s ease,
                box-shadow 0.3s ease,
                border-color 0.3s ease;

            animation:
                fadeUp 0.7s ease both;
        }


        .card:nth-child(1) {
            animation-delay: 0.15s;
        }

        .card:nth-child(2) {
            animation-delay: 0.25s;
        }

        .card:nth-child(3) {
            animation-delay: 0.35s;
        }

        .card:nth-child(4) {
            animation-delay: 0.45s;
        }


        .card::after {
            content: "";

            position: absolute;

            width: 130px;

            height: 130px;

            border-radius: 50%;

            background: rgba(37,99,235,0.045);

            right: -50px;

            bottom: -55px;

            transition:
                transform 0.4s ease;
        }


        .card:hover {
            transform: translateY(-8px);

            border-color: #bfdbfe;

            box-shadow:
                0 18px 38px rgba(37,99,235,0.13);
        }


        .card:hover::after {
            transform: scale(1.5);
        }


        /* CARD ICON */

        .card-icon {
            width: 50px;

            height: 50px;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 14px;

            background:
                linear-gradient(
                    135deg,
                    #eff6ff,
                    #eef2ff
                );

            color: #2563eb;

            font-size: 17px;

            font-weight: 800;

            margin-bottom: 19px;

            border: 1px solid #dbeafe;

            transition:
                all 0.3s ease;
        }


        .card:hover .card-icon {
            transform:
                rotate(-5deg)
                scale(1.08);

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #4f46e5
                );

            color: white;

            box-shadow:
                0 8px 18px rgba(37,99,235,0.25);
        }


        .card h3 {
            font-size: 18px;

            color: #1e293b;

            margin-bottom: 9px;

            position: relative;

            z-index: 2;
        }


        .card p {
            color: #64748b;

            font-size: 13px;

            line-height: 1.65;

            position: relative;

            z-index: 2;
        }


        .card-arrow {
            display: inline-block;

            margin-top: 16px;

            color: #2563eb;

            font-size: 13px;

            font-weight: 700;

            position: relative;

            z-index: 2;

            transition:
                transform 0.25s ease;
        }


        .card:hover .card-arrow {
            transform:
                translateX(5px);
        }


        /* INFORMATION BOX */

        .info-box {
            background: rgba(255,255,255,0.92);

            padding: 28px;

            border-radius: 19px;

            border: 1px solid #e5e7eb;

            box-shadow:
                0 8px 25px rgba(15,23,42,0.05);

            animation:
                fadeUp 0.8s ease 0.5s both;
        }


        .info-box h3 {
            font-size: 19px;

            margin-bottom: 10px;

            color: #1e293b;
        }


        .info-box p {
            color: #64748b;

            font-size: 13px;

            line-height: 1.7;
        }


        .features {
            margin-top: 20px;

            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 15px;
        }


        .feature {
            background: #f8fafc;

            padding: 17px;

            border-radius: 12px;

            border: 1px solid #e2e8f0;

            transition:
                all 0.25s ease;
        }


        .feature:hover {
            transform:
                translateY(-3px);

            background: #f1f5ff;

            border-color: #c7d2fe;
        }


        .feature strong {
            display: block;

            color: #334155;

            font-size: 13px;

            margin-bottom: 5px;
        }


        .feature span {
            color: #64748b;

            font-size: 12px;
        }


        /* ANIMATIONS */

        @keyframes fadeUp {

            from {
                opacity: 0;

                transform:
                    translateY(20px);
            }

            to {
                opacity: 1;

                transform:
                    translateY(0);
            }
        }


        @keyframes pageLoad {

            from {
                opacity: 0;
            }

            to {
                opacity: 1;
            }
        }


        @keyframes slideDown {

            from {
                opacity: 0;

                transform:
                    translateY(-20px);
            }

            to {
                opacity: 1;

                transform:
                    translateY(0);
            }
        }


        @keyframes floatOne {

            0%, 100% {
                transform:
                    translate(0, 0);
            }

            50% {
                transform:
                    translate(-25px, 30px);
            }
        }


        @keyframes floatTwo {

            0%, 100% {
                transform:
                    translate(0, 0);
            }

            50% {
                transform:
                    translate(30px, -20px);
            }
        }


        @keyframes rotateCircle {

            from {
                transform:
                    rotate(0deg);
            }

            to {
                transform:
                    rotate(360deg);
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

            .cards {
                grid-template-columns: 1fr;
            }

            .features {
                grid-template-columns: 1fr;
            }

            .user-name {
                display: none;
            }

            .welcome {
                padding: 27px;
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

            Welcome, <%= userName %>

        </div>


        <a href="logout" class="logout">

            Logout

        </a>

    </div>

</div>


<!-- MAIN -->

<div class="container">


    <!-- WELCOME -->

    <div class="welcome">

        <h2>
            Welcome, <%= userName %>
        </h2>

        <p>
            Manage employee performance, goals, evaluations
            and constructive feedback from one place.
        </p>

        <span class="role-badge">
            <%= userRole %> DASHBOARD
        </span>

    </div>


    <!-- MANAGER DASHBOARD -->

    <% if ("MANAGER".equalsIgnoreCase(userRole)) { %>


        <div class="section-heading">

            <h2>
                Manager Workspace
            </h2>

            <p>
                Evaluate employees, assign goals and provide feedback.
            </p>

        </div>


        <div class="cards">


            <!-- PERFORMANCE EVALUATION -->

            <a href="evaluation" class="card-link">

                <div class="card">

                    <div class="card-icon">
                        E
                    </div>

                    <h3>
                        Performance Evaluation
                    </h3>

                    <p>
                        Evaluate employees using predefined criteria
                        such as productivity, quality, teamwork and
                        communication.
                    </p>

                    <span class="card-arrow">
                        Open Evaluation
                    </span>

                </div>

            </a>


            <!-- GOAL SETTING -->

            <a href="goal" class="card-link">

                <div class="card">

                    <div class="card-icon">
                        G
                    </div>

                    <h3>
                        Goal Setting
                    </h3>

                    <p>
                        Create measurable goals for employees,
                        define target dates and track goal status.
                    </p>

                    <span class="card-arrow">
                        Open Goal Setting
                    </span>

                </div>

            </a>


            <!-- FEEDBACK -->

            <a href="feedback" class="card-link">

                <div class="card">

                    <div class="card-icon">
                        F
                    </div>

                    <h3>
                        Employee Feedback
                    </h3>

                    <p>
                        Provide specific and constructive feedback
                        to help employees improve their performance.
                    </p>

                    <span class="card-arrow">
                        Give Feedback
                    </span>

                </div>

            </a>


            <!-- REPORTS -->

            <a href="reports" class="card-link">

                <div class="card">

                    <div class="card-icon">
                        R
                    </div>

                    <h3>
                        Performance Reports
                    </h3>

                    <p>
                        Review employee performance information,
                        evaluation scores and overall progress.
                    </p>

                    <span class="card-arrow">
                        View performance reports and analytics
                    </span>

                </div>

            </a>


        </div>
        <!-- EMPLOYEE MANAGEMENT -->

        <a href="employees" class="card-link">

            <div class="card">

                <div class="card-icon">
                    E
                </div>

                <h3>
                    Employee Management
                </h3>

                <p>
                    View employees in the organization and access
                    employee performance information.
                </p>

                <span class="card-arrow">
                    View Employees
                </span>

            </div>

        </a>


        <!-- MANAGER INFORMATION -->

        <div class="info-box">

            <h3>
                Performance Management
            </h3>

            <p>
                Use the available tools to evaluate employee
                performance, establish measurable goals and provide
                meaningful feedback. All submitted information is
                stored in the Employee Performance Evaluation System
                database.
            </p>


            <div class="features">

                <div class="feature">

                    <strong>
                        Evaluation
                    </strong>

                    <span>
                        Rate employee performance from 1 to 10.
                    </span>

                </div>


                <div class="feature">

                    <strong>
                        Goal Tracking
                    </strong>

                    <span>
                        Set targets and monitor employee goals.
                    </span>

                </div>


                <div class="feature">

                    <strong>
                        Feedback
                    </strong>

                    <span>
                        Give constructive performance feedback.
                    </span>

                </div>

            </div>

        </div>


    <% } else { %>


        <!-- EMPLOYEE DASHBOARD -->

        <div class="section-heading">

            <h2>
                Employee Workspace
            </h2>

            <p>
                Track your performance, goals and feedback.
            </p>

        </div>


        <div class="cards">


            <!-- PERFORMANCE TRACKING -->

            <a href="my-performance" class="card-link">

                <div class="card">

                    <div class="card-icon">
                        P
                    </div>

                    <h3>
                        Performance Tracking
                    </h3>

                    <p>
                        View your performance evaluation scores
                        and track your progress over time.
                    </p>

                    <span class="card-arrow">
                        View Performance
                    </span>

                </div>

            </a>


            <!-- MY GOALS -->

           <a href="my-goals" class="card-link">

                <div class="card">

                    <div class="card-icon">
                        G
                    </div>

                    <h3>
                        My Goals
                    </h3>

                    <p>
                        View assigned goals, target dates and
                        current goal status.
                    </p>

                    <span class="card-arrow">
                        View Goals
                    </span>

                </div>

            </a>


            <!-- MY FEEDBACK -->

           <a href="my-feedback" class="card-link">

                <div class="card">

                    <div class="card-icon">
                        F
                    </div>

                    <h3>
                        My Feedback
                    </h3>

                    <p>
                        View feedback provided by your manager
                        and use it to improve your performance.
                    </p>

                    <span class="card-arrow">
                        View Feedback
                    </span>

                </div>

            </a>


            <!-- PERSONAL GOALS -->

            <a href="personal-goals" class="card-link">

                <div class="card">

                    <div class="card-icon">
                        U
                    </div>

                    <h3>
                        Personal Goals
                    </h3>

                    <p>
                        Review your professional objectives and
                        development priorities.
                    </p>

                    <span class="card-arrow">
                        Personal Goals
                    </span>

                </div>

            </a>


        </div>


        <div class="info-box">

            <h3>
                Keep Improving
            </h3>

            <p>
                Review your performance information regularly,
                work toward your assigned goals and use manager
                feedback to improve your skills and productivity.
            </p>

        </div>


    <% } %>


</div>


</body>

</html>
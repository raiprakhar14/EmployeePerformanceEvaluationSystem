<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ap3.model.User" %>

<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");

    if (userRole == null || !"MANAGER".equalsIgnoreCase(userRole)) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<User> employees =
            (List<User>) request.getAttribute("employees");

    if (employees == null) {
        employees = new java.util.ArrayList<>();
    }

    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Goal Setting | AP3 Employee Performance System</title>

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
                    rgba(37, 99, 235, 0.12),
                    transparent 30%
                ),
                radial-gradient(
                    circle at 90% 10%,
                    rgba(124, 58, 237, 0.13),
                    transparent 30%
                ),
                linear-gradient(
                    135deg,
                    #f8fbff,
                    #eef2ff
                );

            animation: pageLoad 0.7s ease;
        }


        /* BACKGROUND ANIMATION */

        body::before {
            content: "";

            position: fixed;

            width: 430px;
            height: 430px;

            border-radius: 50%;

            background: rgba(99, 102, 241, 0.07);

            top: -170px;
            right: -130px;

            filter: blur(5px);

            animation: floatOne 9s ease-in-out infinite;

            z-index: -1;
        }


        body::after {
            content: "";

            position: fixed;

            width: 330px;
            height: 330px;

            border-radius: 50%;

            background: rgba(37, 99, 235, 0.06);

            bottom: -150px;
            left: -120px;

            animation: floatTwo 11s ease-in-out infinite;

            z-index: -1;
        }


        /* NAVBAR */

        .navbar {
            height: 76px;

            background: rgba(255, 255, 255, 0.80);

            backdrop-filter: blur(16px);

            -webkit-backdrop-filter: blur(16px);

            border-bottom: 1px solid rgba(226, 232, 240, 0.8);

            display: flex;

            align-items: center;

            justify-content: space-between;

            padding: 0 45px;

            position: sticky;

            top: 0;

            z-index: 100;

            box-shadow:
                0 5px 25px rgba(15, 23, 42, 0.06);

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

            color: #2563eb;

            border: 1px solid #bfdbfe;

            background: rgba(239, 246, 255, 0.8);

            padding: 9px 18px;

            border-radius: 9px;

            font-size: 13px;

            font-weight: 600;

            transition: all 0.25s ease;
        }


        .logout:hover {
            background: #2563eb;

            color: white;

            transform: translateY(-2px);

            box-shadow:
                0 7px 18px rgba(37, 99, 235, 0.25);
        }


        /* MAIN */

        .container {
            width: 92%;

            max-width: 1050px;

            margin: 42px auto 60px;

            animation: fadeUp 0.8s ease;
        }


        /* BACK LINK */

        .back {
            display: inline-flex;

            align-items: center;

            text-decoration: none;

            color: #2563eb;

            font-size: 14px;

            font-weight: 700;

            margin-bottom: 20px;

            transition: all 0.25s ease;
        }


        .back:hover {
            transform: translateX(-4px);

            color: #4338ca;
        }


        /* HEADER */

        .header {
            position: relative;

            overflow: hidden;

            background:
                linear-gradient(
                    135deg,
                    rgba(255, 255, 255, 0.96),
                    rgba(239, 246, 255, 0.94)
                );

            padding: 34px;

            border-radius: 22px;

            border: 1px solid rgba(191, 219, 254, 0.8);

            box-shadow:
                0 15px 40px rgba(37, 99, 235, 0.08);

            margin-bottom: 25px;

            animation: fadeUp 0.8s ease 0.1s both;
        }


        .header::after {
            content: "";

            position: absolute;

            width: 190px;
            height: 190px;

            border-radius: 50%;

            background: rgba(37, 99, 235, 0.06);

            right: -65px;
            top: -75px;

            animation: rotateCircle 14s linear infinite;
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


        /* FORM CARD */

        .form-card {
            background: rgba(255, 255, 255, 0.92);

            padding: 32px;

            border-radius: 20px;

            border: 1px solid #e5e7eb;

            box-shadow:
                0 10px 30px rgba(15, 23, 42, 0.06);

            animation: fadeUp 0.8s ease 0.2s both;
        }


        .section-title {
            font-size: 18px;

            margin-bottom: 20px;

            color: #1e293b;
        }


        .form-grid {
            display: grid;

            grid-template-columns: repeat(2, 1fr);

            gap: 20px;
        }


        .form-group {
            display: flex;

            flex-direction: column;
        }


        .form-group.full {
            grid-column: 1 / -1;
        }


        label {
            font-size: 13px;

            font-weight: 700;

            color: #334155;

            margin-bottom: 8px;
        }


        input,
        select,
        textarea {
            width: 100%;

            padding: 13px 14px;

            border: 1px solid #dbe2ea;

            border-radius: 10px;

            font-size: 14px;

            font-family: Arial, Helvetica, sans-serif;

            outline: none;

            background: #ffffff;

            color: #1e293b;

            transition:
                border-color 0.25s ease,
                box-shadow 0.25s ease,
                transform 0.25s ease;
        }


        input:hover,
        select:hover,
        textarea:hover {
            border-color: #bfdbfe;
        }


        input:focus,
        select:focus,
        textarea:focus {
            border-color: #2563eb;

            box-shadow:
                0 0 0 4px rgba(37, 99, 235, 0.09);

            transform: translateY(-1px);
        }


        textarea {
            min-height: 130px;

            resize: vertical;
        }


        .rating-help {
            font-size: 12px;

            color: #64748b;

            margin-top: 7px;

            line-height: 1.5;
        }


        /* EMPLOYEE HELP */

        .employee-help {
            background: #eff6ff;

            border: 1px solid #bfdbfe;

            color: #1e40af;

            padding: 14px 16px;

            border-radius: 11px;

            margin-bottom: 22px;

            font-size: 13px;

            line-height: 1.6;
        }


        .employee-help strong {
            color: #1d4ed8;
        }


        /* BUTTONS */

        .button-area {
            margin-top: 28px;

            display: flex;

            gap: 12px;
        }


        .submit-btn {
            border: none;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #4f46e5
                );

            color: white;

            padding: 13px 27px;

            border-radius: 10px;

            font-size: 14px;

            font-weight: 700;

            cursor: pointer;

            transition: all 0.25s ease;

            box-shadow:
                0 7px 18px rgba(37, 99, 235, 0.18);
        }


        .submit-btn:hover {
            transform: translateY(-3px);

            box-shadow:
                0 12px 25px rgba(37, 99, 235, 0.28);
        }


        .submit-btn:active {
            transform: translateY(-1px);
        }


        .cancel-btn {
            text-decoration: none;

            background: #f1f5f9;

            color: #475569;

            padding: 13px 27px;

            border-radius: 10px;

            font-size: 14px;

            font-weight: 700;

            transition: all 0.25s ease;
        }


        .cancel-btn:hover {
            background: #e2e8f0;

            transform: translateY(-2px);
        }


        /* MESSAGES */

        .message {
            padding: 14px 16px;

            border-radius: 11px;

            margin-bottom: 22px;

            font-size: 14px;

            animation: messageAppear 0.5s ease;
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


        .no-employees {
            padding: 15px 16px;

            background: #fff7ed;

            border: 1px solid #fed7aa;

            color: #9a3412;

            border-radius: 11px;

            margin-bottom: 22px;

            font-size: 14px;

            line-height: 1.6;
        }


        /* INFORMATION CARDS */

        .footer-info {
            margin-top: 24px;

            display: grid;

            grid-template-columns: repeat(3, 1fr);

            gap: 15px;
        }


        .info-card {
            background: #f8fafc;

            border: 1px solid #e2e8f0;

            border-radius: 12px;

            padding: 17px;

            transition: all 0.25s ease;
        }


        .info-card:hover {
            transform: translateY(-4px);

            background: #f1f5ff;

            border-color: #c7d2fe;

            box-shadow:
                0 8px 20px rgba(37, 99, 235, 0.08);
        }


        .info-card h3 {
            font-size: 13px;

            color: #2563eb;

            margin-bottom: 7px;
        }


        .info-card p {
            font-size: 12px;

            color: #64748b;

            line-height: 1.6;
        }


        /* ANIMATIONS */

        @keyframes fadeUp {

            from {
                opacity: 0;

                transform: translateY(22px);
            }

            to {
                opacity: 1;

                transform: translateY(0);
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

                transform: translateY(-20px);
            }

            to {
                opacity: 1;

                transform: translateY(0);
            }

        }


        @keyframes floatOne {

            0%,
            100% {
                transform: translate(0, 0);
            }

            50% {
                transform: translate(-25px, 30px);
            }

        }


        @keyframes floatTwo {

            0%,
            100% {
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


        @keyframes messageAppear {

            from {
                opacity: 0;

                transform: translateY(-8px);
            }

            to {
                opacity: 1;

                transform: translateY(0);
            }

        }


        /* MOBILE */

        @media (max-width: 700px) {

            .navbar {
                padding: 0 20px;
            }


            .logo {
                font-size: 18px;
            }


            .logo span {
                display: none;
            }


            .container {
                width: 94%;
            }


            .form-card {
                padding: 24px;
            }


            .form-grid {
                grid-template-columns: 1fr;
            }


            .form-group.full {
                grid-column: auto;
            }


            .button-area {
                flex-direction: column;
            }


            .submit-btn,
            .cancel-btn {
                width: 100%;

                text-align: center;
            }


            .footer-info {
                grid-template-columns: 1fr;
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

            Welcome,
            <%= userName != null ? userName : "Manager" %>

        </div>


        <a href="logout" class="logout">

            Logout

        </a>

    </div>

</div>



<!-- MAIN -->

<div class="container">


    <a href="dashboard.jsp" class="back">
        Back to Dashboard
    </a>


    <!-- HEADER -->

    <div class="header">

        <h1>
            Goal Setting
        </h1>

        <p>
            Create and assign measurable goals to employees.
            Track progress and improve employee performance.
        </p>

    </div>



    <!-- FORM CARD -->

    <div class="form-card">


        <% if ("true".equals(success)) { %>

            <div class="message success">

                Goal assigned successfully.

            </div>

        <% } %>



        <% if ("invalid".equals(error)) { %>

            <div class="message error">

                Please enter all required goal details.

            </div>

        <% } else if ("save".equals(error)) { %>

            <div class="message error">

                Goal could not be saved.
                Please verify the selected employee and try again.

            </div>

        <% } else if ("database".equals(error)) { %>

            <div class="message error">

                A database error occurred. Please try again.

            </div>

        <% } %>



        <% if (employees.isEmpty()) { %>

            <div class="no-employees">

                <strong>No employees were found.</strong>

                Please make sure employee accounts exist
                in the users table.

            </div>

        <% } else { %>

            <div class="employee-help">

                <strong>Goal Assignment:</strong>

                Select an employee and create a clear,
                measurable goal with a target completion date.

            </div>

        <% } %>



        <!-- FORM -->

        <form action="goal" method="post">


            <h2 class="section-title">
                Goal Information
            </h2>


            <div class="form-grid">


                <!-- EMPLOYEE -->

                <div class="form-group">

                    <label for="employeeId">
                        Select Employee
                    </label>


                    <select
                            id="employeeId"
                            name="employeeId"
                            required>

                        <option value="">
                            Select Employee
                        </option>


                        <%
                            for (User employee : employees) {
                        %>

                            <option value="<%= employee.getId() %>">

                                <%= employee.getName() %>
                                -
                                <%= employee.getEmail() %>

                            </option>

                        <%
                            }
                        %>

                    </select>


                    <div class="rating-help">

                        Choose the employee who will be
                        responsible for this goal.

                    </div>

                </div>



                <!-- TARGET DATE -->

                <div class="form-group">

                    <label for="targetDate">
                        Target Date
                    </label>


                    <input
                            type="date"
                            id="targetDate"
                            name="targetDate"
                            required>


                    <div class="rating-help">

                        Select the expected completion date.

                    </div>

                </div>



                <!-- GOAL TITLE -->

                <div class="form-group">

                    <label for="goalTitle">
                        Goal Title
                    </label>


                    <input
                            type="text"
                            id="goalTitle"
                            name="goalTitle"
                            placeholder="Example: Improve project delivery"
                            maxlength="200"
                            required>


                    <div class="rating-help">

                        Keep the goal short and specific.

                    </div>

                </div>



                <!-- STATUS -->

                <div class="form-group">

                    <label for="status">
                        Initial Status
                    </label>


                    <select
                            id="status"
                            name="status"
                            required>

                        <option value="Not Started">
                            Not Started
                        </option>

                        <option value="In Progress">
                            In Progress
                        </option>

                        <option value="Completed">
                            Completed
                        </option>

                    </select>


                    <div class="rating-help">

                        The goal can be updated as progress is made.

                    </div>

                </div>



                <!-- DESCRIPTION -->

                <div class="form-group full">

                    <label for="description">
                        Goal Description
                    </label>


                    <textarea
                            id="description"
                            name="description"
                            placeholder="Describe the goal, expected outcome and important requirements..."
                            maxlength="2000"></textarea>


                    <div class="rating-help">

                        A clear description helps the employee
                        understand exactly what is expected.

                    </div>

                </div>


            </div>



            <!-- BUTTONS -->

            <div class="button-area">

                <button
                        type="submit"
                        class="submit-btn">

                    Assign Goal

                </button>


                <a
                        href="dashboard.jsp"
                        class="cancel-btn">

                    Cancel

                </a>

            </div>


        </form>



        <!-- INFORMATION CARDS -->

        <div class="footer-info">


            <div class="info-card">

                <h3>
                    Specific
                </h3>

                <p>
                    Define exactly what the employee needs
                    to accomplish.
                </p>

            </div>



            <div class="info-card">

                <h3>
                    Measurable
                </h3>

                <p>
                    Use clear outcomes so progress can be
                    evaluated objectively.
                </p>

            </div>



            <div class="info-card">

                <h3>
                    Time-Bound
                </h3>

                <p>
                    Set a target date to keep the goal
                    focused and achievable.
                </p>

            </div>


        </div>


    </div>


</div>


</body>

</html>
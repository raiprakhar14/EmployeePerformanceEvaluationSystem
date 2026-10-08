<%@ page import="java.util.List" %>
<%@ page import="com.ap3.model.User" %>

<%
    String userName = (String) session.getAttribute("userName");

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

    <title>Performance Evaluation | AP3</title>

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


        /* BACKGROUND CIRCLES */

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


        /* BACK BUTTON */

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
            min-height: 125px;

            resize: vertical;
        }


        .rating-help {
            font-size: 12px;

            color: #64748b;

            margin-top: 7px;

            line-height: 1.5;
        }


        .readonly {
            background: #f8fafc;

            color: #64748b;

            cursor: not-allowed;
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
                text-align: center;

                width: 100%;
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

            Welcome, <%= userName != null ? userName : "Manager" %>

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
            Performance Evaluation
        </h1>

        <p>
            Evaluate an employee using predefined performance criteria.
            Each criterion is rated from 1 to 10.
        </p>

    </div>



    <!-- FORM -->

    <div class="form-card">


        <% if ("true".equals(success)) { %>

            <div class="message success">

                Performance evaluation saved successfully.

            </div>

        <% } %>


        <% if ("rating".equals(error)) { %>

            <div class="message error">

                Please enter ratings between 1 and 10.

            </div>

        <% } else if ("invalid".equals(error)) { %>

            <div class="message error">

                Please enter valid evaluation details.

            </div>

        <% } else if ("save".equals(error)) { %>

            <div class="message error">

                Evaluation could not be saved.

            </div>

        <% } else if ("database".equals(error)) { %>

            <div class="message error">

                A database error occurred. Please try again.

            </div>

        <% } %>



        <% if (employees.isEmpty()) { %>

            <div class="no-employees">

                No employees were found in the database.

                Please make sure employee accounts exist
                in the users table.

            </div>

        <% } %>



        <form action="evaluation" method="post">


            <h2 class="section-title">
                Employee Information
            </h2>


            <div class="form-grid">


                <div class="form-group">

                    <label for="employeeId">
                        Select Employee
                    </label>

                    <select id="employeeId"
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

                </div>



                <div class="form-group">

                    <label for="evaluationType">
                        Evaluation Type
                    </label>

                    <input type="text"
                           id="evaluationType"
                           value="Performance Evaluation"
                           class="readonly"
                           readonly>

                </div>


            </div>



            <h2 class="section-title"
                style="margin-top: 32px;">

                Performance Criteria

            </h2>


            <div class="form-grid">


                <div class="form-group">

                    <label for="productivity">
                        Productivity
                    </label>

                    <input type="number"
                           id="productivity"
                           name="productivity"
                           min="1"
                           max="10"
                           placeholder="Enter rating 1-10"
                           required>

                    <div class="rating-help">
                        Measures work output and efficiency.
                    </div>

                </div>



                <div class="form-group">

                    <label for="quality">
                        Quality
                    </label>

                    <input type="number"
                           id="quality"
                           name="quality"
                           min="1"
                           max="10"
                           placeholder="Enter rating 1-10"
                           required>

                    <div class="rating-help">
                        Measures accuracy and quality of work.
                    </div>

                </div>



                <div class="form-group">

                    <label for="teamwork">
                        Teamwork
                    </label>

                    <input type="number"
                           id="teamwork"
                           name="teamwork"
                           min="1"
                           max="10"
                           placeholder="Enter rating 1-10"
                           required>

                    <div class="rating-help">
                        Measures collaboration and team contribution.
                    </div>

                </div>



                <div class="form-group">

                    <label for="communication">
                        Communication
                    </label>

                    <input type="number"
                           id="communication"
                           name="communication"
                           min="1"
                           max="10"
                           placeholder="Enter rating 1-10"
                           required>

                    <div class="rating-help">
                        Measures clarity and communication skills.
                    </div>

                </div>



                <div class="form-group full">

                    <label for="comments">
                        Manager Comments
                    </label>

                    <textarea id="comments"
                              name="comments"
                              placeholder="Write constructive feedback or observations about the employee..."></textarea>

                </div>


            </div>



            <div class="button-area">

                <button type="submit"
                        class="submit-btn">

                    Save Evaluation

                </button>


                <a href="dashboard.jsp"
                   class="cancel-btn">

                    Cancel

                </a>

            </div>


        </form>


    </div>


</div>


</body>

</html>
<%@ page import="com.ap3.model.Evaluation" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");

    if (userName == null || userRole == null ||
            !"EMPLOYEE".equalsIgnoreCase(userRole)) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Evaluation> evaluations =
            (List<Evaluation>) request.getAttribute("evaluations");
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
            font-family: Arial, sans-serif;
            min-height: 100vh;
            color: #172033;
            background:
                radial-gradient(circle at 10% 20%, rgba(37,99,235,0.12), transparent 30%),
                radial-gradient(circle at 90% 10%, rgba(124,58,237,0.13), transparent 30%),
                linear-gradient(135deg, #f8fbff, #eef2ff);
        }

        .navbar {
            height: 76px;
            background: rgba(255,255,255,0.82);
            backdrop-filter: blur(16px);
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 45px;
            box-shadow: 0 5px 25px rgba(15,23,42,0.06);
        }

        .logo {
            color: #2563eb;
            font-size: 22px;
            font-weight: 800;
        }

        .user {
            color: #475569;
            font-size: 14px;
            font-weight: 600;
        }

        .back {
            text-decoration: none;
            color: #2563eb;
            border: 1px solid #bfdbfe;
            background: #eff6ff;
            padding: 9px 17px;
            border-radius: 9px;
            margin-left: 15px;
            font-size: 13px;
            font-weight: 600;
        }

        .container {
            width: 92%;
            max-width: 1100px;
            margin: 45px auto;
        }

        .header {
            background: rgba(255,255,255,0.94);
            padding: 32px;
            border-radius: 20px;
            border: 1px solid #dbeafe;
            box-shadow: 0 12px 35px rgba(37,99,235,0.08);
            margin-bottom: 25px;
        }

        .header h1 {
            color: #172033;
            font-size: 28px;
            margin-bottom: 8px;
        }

        .header p {
            color: #64748b;
            font-size: 14px;
        }

        .evaluation {
            background: rgba(255,255,255,0.94);
            padding: 27px;
            border-radius: 18px;
            border: 1px solid #e5e7eb;
            box-shadow: 0 8px 25px rgba(15,23,42,0.06);
            margin-bottom: 20px;
            transition: 0.3s ease;
        }

        .evaluation:hover {
            transform: translateY(-4px);
            box-shadow: 0 15px 35px rgba(37,99,235,0.10);
        }

        .score {
            font-size: 30px;
            font-weight: 800;
            color: #2563eb;
            margin-bottom: 18px;
        }

        .criteria {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 15px;
        }

        .criterion {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 16px;
        }

        .criterion strong {
            display: block;
            color: #334155;
            font-size: 13px;
            margin-bottom: 7px;
        }

        .criterion span {
            color: #2563eb;
            font-size: 20px;
            font-weight: 700;
        }

        .comments {
            margin-top: 20px;
            padding: 17px;
            background: #f8fafc;
            border-radius: 12px;
            color: #475569;
            font-size: 14px;
            line-height: 1.6;
        }

        .empty {
            background: white;
            padding: 40px;
            text-align: center;
            border-radius: 18px;
            color: #64748b;
            box-shadow: 0 8px 25px rgba(15,23,42,0.06);
        }

        @media (max-width: 750px) {
            .navbar {
                padding: 0 20px;
            }

            .criteria {
                grid-template-columns: repeat(2, 1fr);
            }
        }
    </style>
</head>

<body>

<div class="navbar">

    <div class="logo">
        AP3
    </div>

    <div>
        <span class="user">
            Welcome, <%= userName %>
        </span>

        <a href="dashboard.jsp" class="back">
            Dashboard
        </a>
    </div>

</div>


<div class="container">

    <div class="header">
        <h1>My Performance</h1>

        <p>
            View your performance evaluations and review the scores
            provided by your manager.
        </p>
    </div>


    <%
        if (evaluations == null || evaluations.isEmpty()) {
    %>

        <div class="empty">
            No performance evaluations have been submitted yet.
        </div>

    <%
        } else {
            for (Evaluation evaluation : evaluations) {
    %>

        <div class="evaluation">

            <div class="score">
                Overall Score:
                <%= String.format("%.2f", evaluation.getOverallScore()) %>
                / 10
            </div>

            <div class="criteria">

                <div class="criterion">
                    <strong>Productivity</strong>
                    <span><%= evaluation.getProductivity() %>/10</span>
                </div>

                <div class="criterion">
                    <strong>Quality</strong>
                    <span><%= evaluation.getQuality() %>/10</span>
                </div>

                <div class="criterion">
                    <strong>Teamwork</strong>
                    <span><%= evaluation.getTeamwork() %>/10</span>
                </div>

                <div class="criterion">
                    <strong>Communication</strong>
                    <span><%= evaluation.getCommunication() %>/10</span>
                </div>

            </div>


            <%
                if (evaluation.getComments() != null &&
                        !evaluation.getComments().trim().isEmpty()) {
            %>

                <div class="comments">
                    <strong>Manager Comments</strong><br><br>
                    <%= evaluation.getComments() %>
                </div>

            <%
                }
            %>

        </div>

    <%
            }
        }
    %>

</div>

</body>
</html>
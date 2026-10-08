<%@ page import="java.util.List" %>
<%@ page import="com.ap3.model.Employee" %>

<%
    // Only managers can access this page
    String userRole = (String) session.getAttribute("userRole");

    if (userRole == null ||
            !"MANAGER".equalsIgnoreCase(userRole)) {

        response.sendRedirect("login.jsp");
        return;
    }

    List<Employee> employees =
            (List<Employee>) request.getAttribute("employees");

    int employeeCount =
            employees != null ? employees.size() : 0;
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Employees | Performance Evaluation System</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f5f7fb;
            color: #1f2937;
        }

        .header {
            background: #111827;
            color: white;
            padding: 22px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            font-size: 25px;
        }

        .back-link {
            color: white;
            text-decoration: none;
            background: #374151;
            padding: 10px 18px;
            border-radius: 8px;
        }

        .back-link:hover {
            background: #4b5563;
        }

        .container {
            max-width: 1200px;
            margin: 35px auto;
            padding: 0 25px;
        }

        .intro {
            margin-bottom: 25px;
        }

        .intro h2 {
            font-size: 30px;
            margin-bottom: 8px;
        }

        .intro p {
            color: #6b7280;
            font-size: 16px;
        }

        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            border-radius: 14px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.06);
        }

        .stat-card h3 {
            color: #6b7280;
            font-size: 14px;
            margin-bottom: 10px;
            text-transform: uppercase;
        }

        .stat-card .number {
            font-size: 32px;
            font-weight: bold;
        }

        .employee-section {
            background: white;
            border-radius: 16px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.06);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .section-header h2 {
            font-size: 22px;
        }

        .badge {
            background: #eef2ff;
            color: #4338ca;
            padding: 7px 13px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: bold;
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #f9fafb;
            color: #6b7280;
            text-align: left;
            padding: 15px;
            font-size: 13px;
            text-transform: uppercase;
            border-bottom: 1px solid #e5e7eb;
        }

        td {
            padding: 17px 15px;
            border-bottom: 1px solid #f0f0f0;
            font-size: 15px;
        }

        tr:hover {
            background: #fafafa;
        }

        .employee-name {
            font-weight: bold;
            color: #111827;
        }

        .role-badge {
            display: inline-block;
            background: #ecfdf5;
            color: #047857;
            padding: 6px 10px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: bold;
        }

        .view-btn {
            display: inline-block;
            text-decoration: none;
            background: #2563eb;
            color: white;
            padding: 8px 14px;
            border-radius: 7px;
            font-size: 13px;
        }

        .view-btn:hover {
            background: #1d4ed8;
        }

        .empty {
            text-align: center;
            padding: 50px 20px;
            color: #6b7280;
        }

        .empty h3 {
            margin-bottom: 8px;
            color: #374151;
        }

        .footer {
            text-align: center;
            color: #9ca3af;
            font-size: 13px;
            padding: 35px;
        }

        @media (max-width: 700px) {

            .header {
                padding: 18px 20px;
            }

            .header h1 {
                font-size: 20px;
            }

            .container {
                padding: 0 15px;
            }

            .intro h2 {
                font-size: 24px;
            }

            .employee-section {
                padding: 15px;
            }

        }

    </style>

</head>

<body>

<div class="header">

    <h1>Employee Management</h1>

    <a href="dashboard.jsp"
       class="back-link">
        Back to Dashboard
    </a>

</div>


<div class="container">

    <div class="intro">

        <h2>Employees</h2>

        <p>
            View and manage employees in the performance
            evaluation system.
        </p>

    </div>


    <div class="stats">

        <div class="stat-card">

            <h3>Total Employees</h3>

            <div class="number">
                <%= employeeCount %>
            </div>

        </div>

    </div>


    <div class="employee-section">

        <div class="section-header">

            <h2>Employee Directory</h2>

            <span class="badge">
                <%= employeeCount %> Employees
            </span>

        </div>


        <div class="table-container">

            <%
                if (employees != null &&
                        !employees.isEmpty()) {
            %>

            <table>

                <thead>

                <tr>

                    <th>ID</th>

                    <th>Employee Name</th>

                    <th>Email</th>

                    <th>Role</th>

                    <th>Action</th>

                </tr>

                </thead>

                <tbody>

                <%
                    for (Employee employee : employees) {
                %>

                <tr>

                    <td>
                        <%= employee.getId() %>
                    </td>

                    <td class="employee-name">
                        <%= employee.getName() %>
                    </td>

                    <td>
                        <%= employee.getEmail() %>
                    </td>

                    <td>

                        <span class="role-badge">
                            <%= employee.getRole() %>
                        </span>

                    </td>

                    <td>

                        <a href="#"
                           class="view-btn">
                            View
                        </a>

                    </td>

                </tr>

                <%
                    }
                %>

                </tbody>

            </table>

            <%
                } else {
            %>

            <div class="empty">

                <h3>No Employees Found</h3>

                <p>
                    There are currently no employees
                    registered in the system.
                </p>

            </div>

            <%
                }
            %>

        </div>

    </div>

</div>


<div class="footer">

    Employee Performance Evaluation System

</div>

</body>

</html>
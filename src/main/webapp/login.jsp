<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>AP3 | Employee Performance Evaluation System</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;

            background:
                    radial-gradient(circle at 15% 20%, rgba(59, 130, 246, 0.28), transparent 35%),
                    radial-gradient(circle at 85% 80%, rgba(139, 92, 246, 0.28), transparent 35%),
                    linear-gradient(135deg, #0f172a, #172554, #312e81);

            position: relative;
        }

        /* Animated background circles */

        .circle {
            position: absolute;
            border-radius: 50%;
            filter: blur(2px);
            opacity: 0.35;
            animation: float 8s ease-in-out infinite;
        }

        .circle-one {
            width: 220px;
            height: 220px;
            background: #3b82f6;
            top: -80px;
            left: -60px;
        }

        .circle-two {
            width: 280px;
            height: 280px;
            background: #8b5cf6;
            bottom: -120px;
            right: -80px;
            animation-delay: 2s;
        }

        .circle-three {
            width: 120px;
            height: 120px;
            background: #06b6d4;
            top: 15%;
            right: 15%;
            animation-delay: 4s;
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0) translateX(0);
            }

            50% {
                transform: translateY(-25px) translateX(15px);
            }
        }

        /* Login card */

        .login-box {
            position: relative;
            z-index: 2;

            width: 420px;
            padding: 42px;

            background: rgba(255, 255, 255, 0.10);
            border: 1px solid rgba(255, 255, 255, 0.20);
            border-radius: 24px;

            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);

            box-shadow:
                    0 25px 60px rgba(0, 0, 0, 0.35),
                    inset 0 1px 1px rgba(255, 255, 255, 0.15);

            animation: cardAppear 0.8s ease forwards;
        }

        @keyframes cardAppear {
            from {
                opacity: 0;
                transform: translateY(30px) scale(0.96);
            }

            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        /* Logo / branding */

        .logo {
            width: 72px;
            height: 72px;
            margin: 0 auto 20px;

            display: flex;
            justify-content: center;
            align-items: center;

            border-radius: 20px;

            background: linear-gradient(135deg, #3b82f6, #8b5cf6);

            color: white;
            font-size: 24px;
            font-weight: bold;

            box-shadow:
                    0 10px 30px rgba(59, 130, 246, 0.35);

            animation: logoPulse 3s ease-in-out infinite;
        }

        @keyframes logoPulse {
            0%, 100% {
                transform: translateY(0);
            }

            50% {
                transform: translateY(-5px);
            }
        }

        h1 {
            margin: 0;
            text-align: center;

            color: white;
            font-size: 26px;
            font-weight: 700;

            letter-spacing: 0.3px;
        }

        .subtitle {
            text-align: center;
            color: rgba(255, 255, 255, 0.70);

            margin-top: 9px;
            margin-bottom: 32px;

            font-size: 14px;
        }

        /* Form */

        label {
            display: block;

            color: rgba(255, 255, 255, 0.90);

            font-size: 14px;
            font-weight: 600;

            margin-bottom: 8px;
        }

        .input-group {
            margin-bottom: 20px;
        }

        input {
            width: 100%;
            height: 48px;

            padding: 0 15px;

            color: white;
            font-size: 14px;

            background: rgba(255, 255, 255, 0.08);

            border: 1px solid rgba(255, 255, 255, 0.18);
            border-radius: 12px;

            outline: none;

            transition:
                    border-color 0.25s ease,
                    background 0.25s ease,
                    box-shadow 0.25s ease,
                    transform 0.25s ease;
        }

        input::placeholder {
            color: rgba(255, 255, 255, 0.45);
        }

        input:focus {
            background: rgba(255, 255, 255, 0.12);

            border-color: #60a5fa;

            box-shadow:
                    0 0 0 3px rgba(59, 130, 246, 0.15);

            transform: translateY(-1px);
        }

        /* Login button */

        button {
            width: 100%;
            height: 50px;

            margin-top: 8px;

            border: none;
            border-radius: 12px;

            background: linear-gradient(135deg, #2563eb, #7c3aed);

            color: white;

            font-size: 15px;
            font-weight: 700;

            cursor: pointer;

            box-shadow:
                    0 10px 25px rgba(37, 99, 235, 0.30);

            transition:
                    transform 0.25s ease,
                    box-shadow 0.25s ease,
                    filter 0.25s ease;
        }

        button:hover {
            transform: translateY(-3px);

            box-shadow:
                    0 15px 32px rgba(37, 99, 235, 0.42);

            filter: brightness(1.08);
        }

        button:active {
            transform: translateY(-1px);
        }

        /* Error message */

        .error {
            margin-top: 18px;
            padding: 11px 14px;

            text-align: center;

            color: #fecaca;
            background: rgba(220, 38, 38, 0.14);

            border: 1px solid rgba(248, 113, 113, 0.25);
            border-radius: 10px;

            font-size: 13px;

            animation: errorAppear 0.4s ease;
        }

        @keyframes errorAppear {
            from {
                opacity: 0;
                transform: translateY(-5px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .footer-text {
            margin-top: 25px;

            text-align: center;

            color: rgba(255, 255, 255, 0.45);

            font-size: 12px;
        }

        /* Mobile */

        @media (max-width: 520px) {
            .login-box {
                width: calc(100% - 30px);
                padding: 32px 25px;
            }

            h1 {
                font-size: 23px;
            }
        }
    </style>
</head>

<body>

<!-- Animated background -->

<div class="circle circle-one"></div>
<div class="circle circle-two"></div>
<div class="circle circle-three"></div>


<!-- Login Card -->

<div class="login-box">

    <div class="logo">
        AP3
    </div>

    <h1>Employee Performance</h1>

    <div class="subtitle">
        Evaluation System
    </div>


    <form action="login" method="post">

        <div class="input-group">

            <label for="email">
                Email Address
            </label>

            <input
                    type="email"
                    id="email"
                    name="email"
                    placeholder="Enter your email"
                    required>

        </div>


        <div class="input-group">

            <label for="password">
                Password
            </label>

            <input
                    type="password"
                    id="password"
                    name="password"
                    placeholder="Enter your password"
                    required>

        </div>


        <button type="submit">
            Login to Dashboard
        </button>

    </form>


    <%
        String error = request.getParameter("error");

        if ("invalid".equals(error)) {
    %>

        <div class="error">
            Invalid email or password.
        </div>

    <%
        } else if ("database".equals(error)) {
    %>

        <div class="error">
            Database connection error.
        </div>

    <%
        }
    %>


    <div class="footer-text">
        AP3 | Employee Performance Evaluation System
    </div>

</div>

</body>
</html>
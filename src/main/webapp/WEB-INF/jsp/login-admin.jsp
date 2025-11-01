<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <title>เข้าสู่ระบบผู้ดูแลระบบ</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Merriweather:wght@400;700&family=Noto+Sans+Thai:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <style>
    
        @import url('https://fonts.googleapis.com/css2?family=Merriweather:wght@400;700&family=Noto+Sans+Thai:wght@400;700&display=swap');

        body {
            font-family: 'Noto Sans Thai', Arial, sans-serif;
            margin: 0;
            background-color: #F7F3E9;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .navbar {
            background-color: #4E342E;
            padding: 10px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: none;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        .navbar-left, .navbar-right {
           display: flex;
           align-items: center;
           gap: 20px;
        }
        .logo img {
            height: 60px;
            border-radius: 12px;
            display: block;
        }
        .search-bar {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .search-bar input[type="text"] {
            padding: 8px 12px;
            width: 240px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-family: 'Noto Sans Thai', Arial, sans-serif;
        }
        .search-bar button {
            background-color: #00796B;
            color: white;
            border: none;
            border-radius: 6px;
            padding: 8px 14px;
            cursor: pointer;
            font-weight: bold;
            font-family: 'Noto Sans Thai', Arial, sans-serif;
            transition: background-color 0.2s;
        }
        .search-bar button:hover { background-color: #004D40; }
        .search-bar .category-button {
             background-color: #A1887F; color: white;
        }
         .search-bar .category-button:hover { background-color: #6D4C41; }

        nav { display: flex; gap: 10px; }
        nav a {
            background-color: #00796B;
            color: white;
            padding: 10px 16px;
            margin-left: 0;
            border-radius: 10px;
            text-decoration: none;
            font-weight: bold;
            font-family: 'Noto Sans Thai', Arial, sans-serif;
            transition: background-color 0.2s;
        }
        nav a:hover { background-color: #004D40; }
        .menu-toggle { display: none; }

        .login-container {
            flex-grow: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
            background-color: #F7F3E9;
        }

        .login-form-card {
            background-color: #fff;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            max-width: 400px;
            width: 100%;
            text-align: center;
            position: relative;
        }

        .login-form-card h2 {
            font-family: 'Merriweather', serif;
            font-size: 2em;
            color: #5a3c2c;
            margin-bottom: 25px;
        }

        .form-group {
            text-align: left;
            margin-bottom: 20px;
        }

        .form-group label {
            font-weight: bold;
            font-size: 14px;
            color: #555;
            margin-bottom: 6px;
            display: block;
            font-family: 'Noto Sans Thai', Arial, sans-serif;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
            font-family: 'Noto Sans Thai', Arial, sans-serif;
        }

        .form-group input:focus {
            outline: none;
            border-color: #00796B;
            box-shadow: 0 0 4px rgba(0, 121, 107, 0.3);
        }

        .login-button {
            background-color: #00796B;
            color: white;
            padding: 12px 20px;
            border-radius: 6px;
            border: none;
            font-size: 18px;
            cursor: pointer;
            width: 100%;
            box-shadow: 0 4px 6px rgba(0,0,0,0.15);
            margin-top: 10px;
            font-family: 'Noto Sans Thai', Arial, sans-serif;
            font-weight: bold;
            transition: background-color 0.2s;
        }

        .login-button:hover {
            background-color: #004D40;
        }

        .footer {
            background-color: #4E342E;
            height: 60px;
            width: 100%;
            margin-top: auto;
        }

        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                align-items: flex-start;
            }
            .navbar-right {
                 width: 100%;
                 justify-content: space-between;
                 margin-top: 10px;
            }
            .search-bar {
                margin-left: 0;
                margin-right: 0;
                flex-grow: 1;
            }
            .search-bar input { flex-grow: 1; }
            nav a { margin: 0 5px; }
        }
    </style>

</head>
<body>
    <header class="navbar">
        <div class="navbar-left">
            <div class="logo">
                <a href="<c:url value='/searchbook'/>">
                    <img src="<c:url value='/assets/logo.png'/>" alt="Logo">
                </a>
            </div>
        </div>
        <div class="navbar-right">
            <nav>
                <a href="<c:url value='/login'/>">เข้าสู่ระบบ</a>
                <a href="<c:url value='/Register1'/>">ลงทะเบียน</a>
            </nav>
        </div>
    </header>
    
    <main class="login-container">
        <div class="login-form-card">
            <h2>เข้าสู่ระบบผู้ดูแลระบบ</h2>
            <c:if test="${not empty errorMessage}">
                <div style="color:red; margin-bottom: 20px; font-weight:bold;">
                    <c:out value="${errorMessage}"/>
                </div>
            </c:if>

            <form action="<c:url value='/login-admin'/>" method="post">
                <div class="form-group">
                    <label for="username">ชื่อผู้ใช้ *</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">รหัสผ่าน *</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <button type="submit" class="login-button">เข้าสู่ระบบ</button>
            </form>
        </div>
    </main>

    <footer class="footer"></footer>

</body>
</html>
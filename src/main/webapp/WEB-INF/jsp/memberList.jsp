<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>รายชื่อสมาชิก</title>
    
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

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
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
            transition: background-color 0.2s;
        }
        .search-bar button:hover {
            background-color: #004D40;
        }

        .profile-and-menu {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .admin-menu {
            position: relative;
        }
        
        .admin-info {
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: bold;
            color: #FFFFFF;
            font-family: 'Noto Sans Thai', Arial, sans-serif;
        }

        .admin-info img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
        }

        .admin-menu-toggle {
            background: none;
            border: none;
            font-size: 24px;
            color: #FFFFFF;
            cursor: pointer;
            padding: 5px;
        }

        .admin-dropdown {
            display: none;
            position: absolute;
            background-color: #fff;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            z-index: 10;
            right: 0;
            top: 100%;
            margin-top: 10px;
            border-radius: 10px;
            overflow: hidden;
            border: 1px solid #eee;
        }
        
        .admin-dropdown a {
            color: #333;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            font-family: 'Noto Sans Thai', Arial, sans-serif;
            white-space: nowrap;
        }
        
        .admin-dropdown a:hover {
            background-color: #f5f5f5;
        }
        
        .admin-menu.open .admin-dropdown {
            display: block;
        }

        .main-layout { 
            display: flex; 
            flex-grow: 1; 
            margin-top: 25px;
        }

        .main-content-box {
            flex-grow: 1;
            padding: 30px;
            border-radius: 12px;
            background-color: #fff;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        .main-content-box h2 {
            font-family: 'Merriweather', serif;
            color: #5a3c2c;
            margin-top: 0;
            margin-bottom: 25px;
            text-align: center;
            font-size: 2em;
        }
        
        .member-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 16px;
        }

        .member-table thead tr {
            background-color: #00796B;
            color: #ffffff;
            text-align: left;
        }

        .member-table th, .member-table td {
            padding: 12px 15px;
        }

        .member-table tbody tr {
            border-bottom: 1px solid #dddddd;
        }

        .member-table tbody tr:nth-of-type(even) {
            background-color: #F9F9F9;
        }

        .member-table tbody tr:last-of-type {
            border-bottom: 2px solid #00796B;
        }

        .member-table tbody tr:hover {
            background-color: #EFEBE9;
            cursor: default;
        }

        .footer {
            background-color: #4E342E;
            height: 60px;
            width: 100%;
            margin-top: auto;
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
                <div class="profile-and-menu">
                    <div class="admin-info">
                        <img src="<c:url value='/assets/images/profile-icon.png'/>" alt="Admin Profile">
                        <span>${not empty sessionScope.admin ? sessionScope.admin.usernameLibrarian : 'Admin'}</span>
                    </div>
                    <div id="admin-menu" class="admin-menu">
                        <button id="admin-menu-toggle" class="admin-menu-toggle">
                            <i class="fas fa-bars"></i>
                        </button>
                        <div id="admin-dropdown-content" class="admin-dropdown">
                            <a href="<c:url value='/memberList'/>">รายชื่อสมาชิก</a>
						    <a href="<c:url value='/adminHome'/>">รายการหนังสือ</a>
						    <a href="<c:url value='/listRecommendedBooks'/>">รายการแนะนำหนังสือ</a>
						    <a href="<c:url value='/logout'/>">ออกจากระบบ</a>
                        </div>
                    </div>
                </div>
            </nav>
        </div>
    </header>

    <div class="container main-layout">
        <div class="main-content-box">
            <h2>รายชื่อสมาชิก</h2>
            <table class="member-table">
                <thead>
                    <tr>
                        <th>รหัสสมาชิก</th>
                        <th>ชื่อผู้ใช้</th>
                        <th>ชื่อ-นามสกุล</th>
                        <th>อีเมล</th>
                        <th>เบอร์</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="member" items="${memberList}">
                        <tr>
                            <td>${member.id}</td>
                            <td>${member.username}</td>
                            <td>${member.firstname} ${member.lastname}</td>
                            <td>${member.email}</td>
                            <td>${member.phone}</td>
                        </tr>
                    </c:forEach>
                </tbody>
                </table>
        </div>
    </div>

    <footer class="footer"></footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const adminMenu = document.getElementById('admin-menu');
            const menuToggle = document.getElementById('admin-menu-toggle'); 

            if (menuToggle) {
                menuToggle.addEventListener('click', (event) => {
                    adminMenu.classList.toggle('open');
                    event.stopPropagation();
                });
            }

            document.addEventListener('click', (event) => {
                if (adminMenu && !adminMenu.contains(event.target)) {
                    adminMenu.classList.remove('open');
                }
            });
        });
    </script>
</body>
</html>
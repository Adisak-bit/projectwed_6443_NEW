<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>สถิติการอ่าน</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Merriweather:wght@400;700&family=Noto+Sans+Thai:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>

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
            margin: 20px auto;
            padding: 0 20px;
            flex-grow: 1;
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
        .navbar .logo img { height: 60px; border-radius: 12px; display: block;}
        .navbar .search-bar {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .navbar .search-bar input[type="text"] {
             padding: 8px 12px; width: 240px; border: 1px solid #ccc;
             border-radius: 6px; font-family: 'Noto Sans Thai', Arial, sans-serif;
        }
        .navbar .search-bar button {
            background-color: #00796B;
            color: white; border: none; border-radius: 6px;
            padding: 8px 14px; cursor: pointer; font-weight: bold;
            font-family: 'Noto Sans Thai', Arial, sans-serif;
            transition: background-color 0.2s;
        }
        .navbar .search-bar button:hover { background-color: #004D40; }
        .navbar .category-button {
            padding: 8px 15px; background-color: #A1887F; color: white;
            border: none; border-radius: 6px; cursor: pointer;
            display: flex; align-items: center; gap: 5px; font-weight: bold;
             font-family: 'Noto Sans Thai', Arial, sans-serif;
        }
        .navbar .category-button:hover { background-color: #6D4C41; }
        .category-dropdown { position: relative; display: inline-block; }
        .category-dropdown-content { display: none; position: absolute; background-color: #f9f9f9; min-width: 200px; box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); z-index: 100; border-radius: 5px; max-height: 300px; overflow-y: auto; }
        .category-dropdown-content a { color: black; padding: 12px 16px; text-decoration: none; display: block; background: none; color: #333; font-weight: normal; margin-left: 0; border-radius: 0; white-space: normal; font-family: 'Noto Sans Thai', Arial, sans-serif; }
        .category-dropdown-content a:hover { background-color: #ddd; }
        .category-dropdown:hover .category-dropdown-content { display: block; }

        .navbar nav { display: flex; align-items: center; gap: 10px;}
        .navbar nav > a {
             background-color: #00796B; color: white; padding: 10px 16px;
             border-radius: 10px; text-decoration: none; font-weight: bold;
             white-space: nowrap; font-family: 'Noto Sans Thai', Arial, sans-serif;
             transition: background-color 0.2s; border: none;
        }
         .navbar nav > a:hover { background-color: #004D40; }
        .user-greeting {
            background-color: #4CAF50; cursor: pointer;
            padding: 10px 16px; border-radius: 10px;
            color: white; text-decoration: none; font-weight: bold;
            white-space: nowrap; border: none; font-family: 'Noto Sans Thai', Arial, sans-serif;
            display: inline-flex; align-items: center; gap: 5px;
        }
        .navbar nav > a[href*="logout"] { background-color: #dc3545;}

        .user-menu { position: relative; display: inline-block; }
        .user-menu.open .dropdown-content { display: block; }
        .user-menu .dropdown-content {
            display: none; position: absolute; background-color: #fff;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            z-index: 10;
            right: 0; top: 100%;
            margin-top: 10px;
            border-radius: 10px;
            overflow: hidden;
            border: 1px solid #eee;
            padding: 0;
        }
        .user-menu .dropdown-content a {
            color: #333;
            padding: 12px 16px;
            display: block;
            background-color: white;
            border-radius: 0;
            margin-left: 0;
            font-weight: normal;
            text-decoration: none;
            white-space: normal;
            font-family: 'Noto Sans Thai', Arial, sans-serif;
            transition: background-color 0.2s;
        }
        .user-menu .dropdown-content a:hover {
            background-color: #f1f1f1;
        }
        .user-menu .dropdown-content a[href*="logout"] {
             background-color: white;
             color: #dc3545;
        }
        .user-menu .dropdown-content a[href*="logout"]:hover {
             background-color: #f1f1f1;
             color: #c82333;
        }
        .user-menu .dropdown-content a.active {
             background-color: #EFEBE9;
             font-weight: bold;
             color: #00796B;
         }

        .profile-container {
             display: flex;
             justify-content: center;
             gap: 30px;
             margin-top: 25px;
        }

        .stats-card {
            flex-grow: 1;
            max-width: 900px;
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        .stats-card h2 {
            font-family: 'Merriweather', serif;
            text-align: center;
            color: #5a3c2c;
            margin-top: 0;
            margin-bottom: 30px;
            font-size: 1.8em;
        }

        .chart-container {
            width: 100%;
            max-width: 500px;
            margin: 0 auto;
        }

        .footer {
            background-color: #4E342E;
            height: 60px;
            width: 100%;
            margin-top: auto;
        }

        @media (max-width: 768px) {
             .navbar { flex-direction: column; align-items: flex-start; }
             .navbar-right { width: 100%; justify-content: space-between; margin-top: 10px; }
             .search-bar { margin-left: 0; margin-right: 0; flex-grow: 1; }
             .search-bar input { flex-grow: 1; }
             nav { }
             nav a, nav .user-greeting { margin: 0 5px; }
             .profile-container { flex-direction: column; }
             .stats-card { max-width: 100%; }
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
            <form class="search-bar" action="<c:url value='/searchbook'/>" method="GET">
                <div class="category-dropdown">
                    <button type="button" class="category-button">
                        หมวดหมู่ <i class="fas fa-caret-down"></i>
                    </button>
                    <div class="category-dropdown-content">
                        <a href="<c:url value='/searchbook'/>">หมวดหมู่ทั้งหมด</a>
                        <c:forEach var="cat" items="${categories}">
                            <a href="<c:url value='/searchbook?categoryId=${cat.category_id}'/>"><c:out value="${cat.category_name}"/></a>
                        </c:forEach>
                    </div>
                </div>
                <input type="text" name="query" placeholder="ค้นหาชื่อเรื่อง, ผู้แต่ง..." value="<c:out value="${searchQuery}"/>">
                <button type="submit">ค้นหา</button>
            </form>

            <nav>
                <c:choose>
                    <c:when test="${not empty sessionScope.member}">
                        <div class="user-menu" id="user-menu">
                            <span class="user-greeting" id="user-menu-toggle">
                                สวัสดี, <c:out value="${sessionScope.member.username}"/> <i class="fas fa-caret-down"></i>
                            </span>
                            <div class="dropdown-content">
                                <a href="<c:url value='/editProfile'/>">แก้ไขโปรไฟล์</a>
                                <a href="<c:url value='/favoriteBooks'/>">หนังสือที่ชื่นชอบ</a>
                                <a href="<c:url value='/history'/>">ประวัติหนังสือ</a>
                                <a href="<c:url value='/readingStats'/>" class="active">สถิติการอ่าน</a>
                                <a href="<c:url value='/recommendBookForm'/>">แนะนำหนังสือ</a>
                                <a href="<c:url value='/listRecommendedBooks'/>">รายการแนะนำหนังสือ</a>
                                <a href="<c:url value='/logout'/>">ออกจากระบบ</a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='/login'/>">เข้าสู่ระบบ</a>
                        <a href="<c:url value='/Register1'/>">ลงทะเบียน</a>
                    </c:otherwise>
                </c:choose>
            </nav>
        </div>
    </header>

    <div class="container profile-container">
        <main class="stats-card">
            <h2>สถิติการอ่าน</h2>

            <c:choose>
                <c:when test="${not empty chartData}">
                    <div class="chart-container">
                        <canvas id="readingStatsChart"></canvas>
                    </div>
                </c:when>
                <c:otherwise>
                    <p style="text-align: center; color: #666;">ยังไม่มีข้อมูลสถิติการอ่าน (คุณยังไม่ได้อ่านหนังสือเล่มใดเลย)</p>
                </c:otherwise>
            </c:choose>

        </main>
    </div>

    <footer class="footer"></footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const userMenu = document.getElementById('user-menu');
            const userMenuToggle = document.getElementById('user-menu-toggle');

            if (userMenuToggle && userMenu) {
                userMenuToggle.addEventListener('click', (event) => {
                    userMenu.classList.toggle('open');
                    event.stopPropagation();
                });
            }

             document.addEventListener('click', (event) => {
                 if (userMenu && userMenuToggle && !userMenu.contains(event.target) && !userMenuToggle.contains(event.target)) {
                     userMenu.classList.remove('open');
                 }
             });

            Chart.register(ChartDataLabels);

            const chartLabels = [
                <c:forEach var="label" items="${chartLabels}" varStatus="status">
                    '<c:out value="${label}"/>' <c:if test="${!status.last}"><c:out value=","/></c:if>
                </c:forEach>
            ];
            
            const chartData = [
                <c:forEach var="dataPoint" items="${chartData}" varStatus="status">
                    ${dataPoint} <c:if test="${!status.last}"><c:out value=","/></c:if>
                </c:forEach>
            ];

            if (chartData && chartData.length > 0) {
                const ctx = document.getElementById('readingStatsChart').getContext('2d');
                new Chart(ctx, {
                    type: 'pie',
                    data: {
                        labels: chartLabels,
                        datasets: [{
                            label: 'จำนวนเล่มที่อ่าน',
                            data: chartData,
                            backgroundColor: [
                                '#e67e80', '#60a3d9', '#f8d64e', '#6abe9c',
                                '#9b83bd', '#e89f67', '#777777',
                                '#a1887f', '#ff8a65', '#4db6ac'
                            ],
                            borderColor: '#fff',
                            borderWidth: 2
                        }]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {
                                position: 'bottom',
                                labels: {
                                    padding: 20,
                                    font: { size: 14, family: "'Noto Sans Thai', Arial, sans-serif" }
                                }
                            },
                            datalabels: {
                                formatter: (value, ctx) => {
                                    let sum = ctx.chart.data.datasets[0].data.reduce((a, b) => a + b, 0);
                                    
                                    let percentage = (value / sum * 100).toFixed(1) + '%';
                                    return percentage;
                                },
                                color: '#fff',
                                font: {
                                    weight: 'bold',
                                    size: 14,
                                    family: "'Noto Sans Thai', Arial, sans-serif"
                                }
                            }
                        }
                    }
                });
            }
        });
    </script>
    
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ประวัติการอ่าน</title>

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

        .content-card {
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            margin: 30px 0;
        }

        .content-card h2 {
            font-family: 'Merriweather', serif;
            text-align: center;
            color: #5a3c2c;
            margin-top: 0;
            margin-bottom: 30px;
            font-size: 1.8em;
        }
        .book-cards {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }

        .book-card {
            border: 1px solid #E0E0E0;
            border-radius: 10px;
            overflow: hidden;
            width: 180px;
            text-align: center;
            background-color: white;
            box-shadow: 0 3px 8px rgba(0,0,0,0.05);
            margin-bottom: 20px;
            display: flex;
            flex-direction: column;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .book-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
        }
        .book-card img { width: 100%; height: 250px; object-fit: cover; }
        .book-card p.book-title {
             padding: 10px; font-weight: bold;
             color: #5a3c2c;
             margin: 0; flex-grow: 1;
             font-size: 0.95em;
        }

        .book-card .history-date {
            font-size: 0.85em;
            color: #6D4C41;
            padding: 0 10px 5px 10px;
            margin-top: -5px;
            flex-grow: 0;
            font-style: italic;
        }
        .card-buttons { padding: 10px; margin-top: auto; }

        .read-button {
            background-color: #00796B;
            color: white; border: none; padding: 10px 0;
            width: 100%; cursor: pointer; font-size: 15px;
            border-radius: 5px; font-family: 'Noto Sans Thai', Arial, sans-serif;
            font-weight: bold; transition: background-color 0.3s ease;
        }
        .read-button:hover { background-color: #004D40; }

        .modal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgba(0,0,0,0.6); padding-top: 100px; }
        .modal-content { background-color: #fefefe; margin: auto; padding: 30px; border: 1px solid #888; width: 80%; max-width: 400px; border-radius: 15px; text-align: center; position: relative; box-shadow: 0 5px 15px rgba(0,0,0,0.3); }
        .close-button { color: #aaa; position: absolute; top: 10px; right: 20px; font-size: 28px; font-weight: bold; }
        .close-button:hover, .close-button:focus { color: black; text-decoration: none; cursor: pointer; }
        .modal-content p { font-size: 1.2em; margin-bottom: 10px; color: #333; }
        .modal-buttons { display: flex; justify-content: center; gap: 20px; margin-top: 20px;}
        .modal-buttons button { padding: 10px 25px; border: none; border-radius: 8px; font-size: 1em; cursor: pointer; color: white; transition: background-color 0.2s ease; }
        .modal-buttons .confirm-btn { background-color: #28a745; }
        .modal-buttons .confirm-btn:hover { background-color: #218838; }
        .modal-buttons .cancel-btn { background-color: #dc3545; }
        .modal-buttons .cancel-btn:hover { background-color: #c82333; }
        .modal-buttons .login-btn { background-color: #007bff; }
        .modal-buttons .login-btn:hover { background-color: #0056b3; }

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
             .book-cards { justify-content: center; }
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
                                <a href="<c:url value='/history'/>" class="active">ประวัติหนังสือ</a>
                                <a href="<c:url value='/readingStats'/>">สถิติการอ่าน</a>
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

    <div class="container">
        <main class="content-card">
            <h2>ประวัติการอ่าน</h2>
            <div class="book-cards">
                <c:choose>
                    <c:when test="${not empty historyList}">
                        <c:forEach var="history" items="${historyList}">
                            <div class="book-card">
                                <img src="<c:url value='/assets/images/covers/${history.book.cover_image}'/>"
                                     alt="<c:out value="${history.book.book_title}"/>"
                                     onerror="this.onerror=null; this.src='<c:url value="/assets/images/placeholder.png"/>';" >
                                <p class="book-title"><c:out value="${history.book.book_title}"/></p>
                                <p class="history-date">
                                    อ่านล่าสุด: <fmt:formatDate value="${history.lastreadDate}" pattern="dd/MM/yyyy" />
                                </p>

                                <div class="card-buttons">
                                    <button class="read-button js-read-button"
                                            data-book-id="${history.book.id}"
                                            data-accesslevel="${history.book.accesslevel}">
                                        อ่านอีกครั้ง
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p style="text-align: center; width: 100%; color: #666;">คุณยังไม่มีประวัติการอ่าน</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>

    <footer class="footer"></footer>

    <div id="loginRequiredModal" class="modal">
         <div class="modal-content">
            <span class="close-button">&times;</span>
            <p>หนังสือเล่มนี้สำหรับสมาชิก</p>
            <p style="font-size: 0.9em; color: #666; margin-bottom: 25px;">กรุณาเข้าสู่ระบบ หรือ สมัครสมาชิก</p>
            <div class="modal-buttons">
              <button id="goToLoginBtn" class="confirm-btn login-btn">เข้าสู่ระบบ</button>
              <button class="cancel-btn">ยกเลิก</button>
            </div>
          </div>
    </div>

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

            const loginModal = document.getElementById('loginRequiredModal');
            const goToLoginBtn = document.getElementById('goToLoginBtn');
            const loginModalCancelBtns = loginModal ? loginModal.querySelectorAll('.cancel-btn, .close-button') : [];
            const loginUrl = "<c:url value='/login'/>";

            const readButtons = document.querySelectorAll('.js-read-button');
            const isLoggedIn = ${not empty sessionScope.member};
            const viewBookBaseUrl = "<c:url value='/viewBookDetails/'/>";

            readButtons.forEach(button => {
                 button.addEventListener('click', function() {
                     const bookId = this.dataset.bookId;
                     const accessLevel = this.dataset.accesslevel ? this.dataset.accesslevel.toLowerCase() : 'public';
                     const viewBookUrl = viewBookBaseUrl + bookId;

                     if (accessLevel === 'public' || (accessLevel === 'member' && isLoggedIn)) {
                          window.location.href = viewBookUrl;
                     } else if (accessLevel === 'member' && !isLoggedIn) {
                          if (loginModal) loginModal.style.display = 'block';
                          else alert("หนังสือเล่มนี้สำหรับสมาชิกเท่านั้น กรุณาเข้าสู่ระบบก่อนครับ");
                     } else {
                          window.location.href = viewBookUrl;
                     }
                 });
            });

            if(goToLoginBtn) { goToLoginBtn.addEventListener('click', function() { window.location.href = loginUrl; }); }
            if (loginModalCancelBtns.length > 0) { loginModalCancelBtns.forEach(btn => { btn.addEventListener('click', function() { if (loginModal) loginModal.style.display = 'none'; }); }); }
            window.addEventListener('click', function(event) { if (event.target == loginModal) { if (loginModal) loginModal.style.display = 'none'; } });

        });
    </script>

</body>
</html>
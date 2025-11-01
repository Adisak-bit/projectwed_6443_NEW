<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>เว็บไซต์อ่านหนังสือออนไลน์</title>

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

    html {
        background-color: #F7F3E9;
    }

    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 20px;
    }

    .navbar {
        background-color: #4E342E;
        padding: 10px 20px;
        display: flex;
        align-items: center;
        border-bottom: none;
        box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        gap: 15px;
    }

    .navbar .logo img {
        height: 60px;
        border-radius: 12px;
        display: block;
    }

    .navbar .search-bar {
        display: flex;
        align-items: center;
        gap: 5px;
        margin-left: auto;
    }

    .navbar .search-bar input[type="text"] {
        padding: 8px 12px;
        width: 240px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-family: 'Noto Sans Thai', Arial, sans-serif;
    }

    .navbar .search-bar button {
        background-color: #00796B;
        color: white;
        border: none;
        border-radius: 6px;
        padding: 8px 14px;
        cursor: pointer;
        font-weight: bold;
        transition: background-color 0.2s;
    }
    .navbar .search-bar button:hover {
        background-color: #004D40;
    }

    .navbar .category-button {
        padding: 8px 15px;
        background-color: #A1887F;
        color: white;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 5px;
        font-weight: bold;
    }

    .category-dropdown {
        position: relative;
        display: inline-block;
    }
    .category-dropdown-content {
        display: none;
        position: absolute;
        background-color: #f9f9f9;
        min-width: 200px;
        box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
        z-index: 100;
        border-radius: 5px;
        max-height: 300px;
        overflow-y: auto;
    }
    .category-dropdown-content a {
        color: black;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
        background: none;
        color: #333;
        font-weight: normal;
        margin-left: 0;
        border-radius: 0;
        white-space: normal;
        font-family: 'Noto Sans Thai', Arial, sans-serif;
    }
    .category-dropdown-content a:hover { background-color: #ddd; }
    .category-dropdown:hover .category-dropdown-content { display: block; }

    .navbar nav { display: flex; align-items: center; gap: 10px;}
    .navbar nav > a, .navbar nav .desktop-menu > a {
        background-color: #00796B;
        color: white;
        padding: 10px 16px;
        border-radius: 10px;
        text-decoration: none;
        font-weight: bold;
        white-space: nowrap;
        border: none;
        cursor: pointer;
        font-family: 'Noto Sans Thai', Arial, sans-serif;
        transition: background-color 0.2s;
    }
    .navbar nav > a:hover, .navbar nav .desktop-menu > a:hover {
        background-color: #004D40;
    }

    .navbar nav span.user-greeting {
        background-color: #4CAF50;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        gap: 5px;
        padding: 10px 16px;
        border-radius: 10px;
        color: white;
        text-decoration: none;
        font-weight: bold;
        white-space: nowrap;
        border: none;
        font-family: 'Noto Sans Thai', Arial, sans-serif;
    }

    .navbar nav .admin-info span {
        background-color: #4CAF50;
        color: white;
        cursor: default;
        padding: 10px 16px;
        border-radius: 10px;
        text-decoration: none;
        font-weight: bold;
        white-space: nowrap;
        border: none;
        font-family: 'Noto Sans Thai', Arial, sans-serif;
    }

    .navbar nav > a[href*="logout"] { background-color: #dc3545;}

    .profile-and-menu { display: flex; align-items: center; gap: 5px; }
    .admin-menu { position: relative; }
    .admin-info { display: flex; align-items: center; gap: 10px; font-weight: bold; color: #fff; }
    .admin-info img { width: 30px; height: 30px; border-radius: 50%; padding: 0px; margin-right: -5px;}
    .menu-toggle, .admin-menu-toggle {
        background: none; border: none; font-size: 24px; color: #FFFFFF;
        cursor: pointer; padding: 5px;
        transition: color 0.2s;
    }
    .menu-toggle:hover, .admin-menu-toggle:hover { color: #E0E0E0; }
    .admin-dropdown {
        display: none; position: absolute; background-color: #fff;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15); z-index: 10; right: 0; top: 100%;
        margin-top: 10px; border-radius: 10px; overflow: hidden; border: 1px solid #eee;
    }
    .admin-dropdown a {
        color: #333; padding: 12px 16px; text-decoration: none;
        display: block; background-color: white; font-weight: normal;
        margin-left:0; border-radius: 0;
        font-family: 'Noto Sans Thai', Arial, sans-serif;
        white-space: nowrap;
    }
    .admin-dropdown a:hover { background-color: #f5f5f5; }
    .admin-menu.open .admin-dropdown { display: block; }

    .user-menu { position: relative; display: inline-block; }
    .user-menu.open .dropdown-content { display: block; }
    .user-menu .dropdown-content {
        display: none; position: absolute; background-color: #fff;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        z-index: 10; right: 0; top: 100%;
        margin-top: 10px;
        border-radius: 10px;
        overflow: hidden;
        border: 1px solid #eee;
        padding: 0;
    }
    .user-menu .dropdown-content a {
        color: #333;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
        margin-left: 0;
        background-color: white;
        font-weight: normal;
        border-radius: 0;
        white-space: nowrap;
        margin-bottom: 0;
        font-family: 'Noto Sans Thai', Arial, sans-serif;
        transition: background-color 0.2s;
    }
    .user-menu .dropdown-content a[href*="logout"] {
         background-color: white;
         color: #dc3545;
    }
    .user-menu .dropdown-content a:hover {
        background-color: #f5f5f5;
    }
    .user-menu .dropdown-content a[href*="logout"]:hover {
         background-color: #f5f5f5;
         color: #c82333;
    }
    .menu-toggle { display: none; }

    .content {
        background-color: #FFFFFF;
        padding: 30px;
        border-radius: 12px;
        margin-top: 25px;
        flex-grow: 1;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    }
    .book-section {
        margin-bottom: 30px;
    }
    .book-section h2 {
        font-family: 'Merriweather', serif;
        color: #5a3c2c;
        margin-bottom: 20px;
        text-align: center;
        margin-left: 0;
        font-size: 1.8em;
    }
    .book-list-container {
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
        padding: 0 40px;
    }
    .book-cards {
        display: flex;
        overflow-x: auto;
        scroll-behavior: smooth;
        padding: 10px 0;
        gap: 20px;
        -ms-overflow-style: none;
        scrollbar-width: none;
    }
    .book-cards::-webkit-scrollbar {
        display: none;
    }
    .book-card {
        border: 1px solid #E0E0E0;
        border-radius: 10px;
        overflow: hidden;
        width: 180px;
        min-width: 180px;
        text-align: center;
        background-color: white;
        box-shadow: 0 3px 8px rgba(0,0,0,0.05);
        flex-shrink: 0;
        display: flex;
        flex-direction: column;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    .book-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 6px 15px rgba(0,0,0,0.1);
    }

    .book-card img {
        width: 100%;
        height: 250px;
        object-fit: cover;
        display: block;
        background-color: #eee;
        border-bottom: 1px solid #ddd;
    }
    .book-card p {
        padding: 10px;
        font-weight: bold;
        color: #5a3c2c;
        margin: 0;
        flex-grow: 1;
        font-family: 'Noto Sans Thai', Arial, sans-serif;
        font-size: 0.95em;
    }
    .card-buttons {
        padding: 10px;
        margin-top: auto;
    }
    .read-button {
        background-color: #00796B;
        color: white;
        border: none;
        padding: 10px 0;
        width: 100%;
        cursor: pointer;
        font-size: 15px;
        transition: background-color 0.3s ease;
        border-radius: 5px;
        font-family: 'Noto Sans Thai', Arial, sans-serif;
        font-weight: bold;
    }
    .read-button:hover {
        background-color: #004D40;
    }

    .nav-arrow {
        background-color: rgba(90, 60, 44, 0.7);
        color: white;
        border: none;
        padding: 10px;
        cursor: pointer;
        font-size: 24px;
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        z-index: 10;
        border-radius: 50%;
        width: 40px;
        height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: background-color 0.2s;
    }
    .nav-arrow:hover {
        background-color: rgba(90, 60, 44, 1);
    }
    .left-arrow { left: 0; }
    .right-arrow { right: 0; }

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

    .footer { background-color: #4E342E; height: 60px; width: 100%; margin-top: auto; }

    @media (max-width: 768px) {
        .navbar { flex-direction: column; align-items: flex-start; }
        .navbar .search-bar { margin-top: 10px; width: 100%; justify-content: center; margin-left: 0; margin-right: 0; }
        .navbar .search-bar input { flex-grow: 1; }
        .navbar nav { width: 100%; display: flex; flex-direction: row; justify-content: flex-end; align-items: center; margin-top: 10px; }
        .navbar nav a, .navbar nav span.user-greeting { margin: 0 5px; }
        .book-card { width: 150px; min-width: 150px; }
        .book-card img { height: 200px; }
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

        <div class="navbar-right">
            <nav>
                <c:choose>
                     <c:when test="${not empty sessionScope.admin}">
                         <div class="profile-and-menu">
                             <div class="admin-info">
                                 <img src="<c:url value='/assets/images/profile-icon.png'/>" alt="Admin Profile">
                                 <span><c:out value="${sessionScope.admin.usernameLibrarian}"/></span>
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
                     </c:when>
                     <c:otherwise>
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
                     </c:otherwise>
                </c:choose>
            </nav>
        </div>
    </header>

    <main class="container">
        <div class="content">

            <section class="book-section">
                <h2>รายการหนังสือ</h2>
                <div class="book-list-container">
                    <button class="nav-arrow left-arrow"><i class="fas fa-chevron-left"></i></button>
                    <div class="book-cards">
                        <c:set var="hasPublicBooks" value="${false}" />
                        <c:choose>
                            <c:when test="${not empty bookList}">
                                <c:forEach var="book" items="${bookList}">
                                    <c:if test="${book.accesslevel == 'public' || empty book.accesslevel}">
                                        <div class="book-card">
                                            <img src="<c:url value='/assets/images/covers/${book.cover_image}'/>"
                                                 alt="<c:out value="${book.book_title}"/>"
                                                 onerror="this.onerror=null; this.src='<c:url value="/assets/images/placeholder.png"/>';" >
                                            <p><c:out value="${book.book_title}"/></p>
                                            <div class="card-buttons">
                                                <button class="read-button js-read-button"
                                                        data-book-id="${book.id}"
                                                        data-accesslevel="${book.accesslevel}">
                                                    อ่าน
                                                </button>
                                            </div>
                                        </div>
                                        <c:set var="hasPublicBooks" value="${true}" />
                                    </c:if>
                                </c:forEach>
                                <c:if test="${!hasPublicBooks}">
                                     <p style="text-align: center; width: 100%; color: #666;">ไม่พบหนังสือทั่วไป</p>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <p style="text-align: center; width: 100%; color: #666;">ไม่พบหนังสือ</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <button class="nav-arrow right-arrow"><i class="fas fa-chevron-right"></i></button>
                </div>
            </section>
            
            <c:set var="hasMemberBooks" value="${false}" />
            <c:if test="${not empty bookList}">
                <c:forEach var="book" items="${bookList}">
                    <c:if test="${book.accesslevel == 'member'}">
                        <c:set var="hasMemberBooks" value="${true}" />
                    </c:if>
                </c:forEach>
            </c:if>

            <c:if test="${hasMemberBooks}">
                <section class="book-section">
                    <h2>สำหรับสมาชิก</h2>
                    <div class="book-list-container">
                        <button class="nav-arrow left-arrow"><i class="fas fa-chevron-left"></i></button>
                        <div class="book-cards">
                            <c:forEach var="book" items="${bookList}">
                                <c:if test="${book.accesslevel == 'member'}">
                                    <div class="book-card">
                                        <img src="<c:url value='/assets/images/covers/${book.cover_image}'/>"
                                             alt="<c:out value="${book.book_title}"/>"
                                             onerror="this.onerror=null; this.src='<c:url value="/assets/images/placeholder.png"/>';" >
                                        <p><c:out value="${book.book_title}"/></p>
                                        <div class="card-buttons">
                                            <button class="read-button js-read-button"
                                                    data-book-id="${book.id}"
                                                    data-accesslevel="${book.accesslevel}">
                                                อ่าน
                                            </button>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                        <button class="nav-arrow right-arrow"><i class="fas fa-chevron-right"></i></button>
                    </div>
                </section>
            </c:if>
        </div>
    </main>

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

            const adminMenu = document.getElementById('admin-menu');
            const adminMenuToggle = document.getElementById('admin-menu-toggle');
            const userMenu = document.getElementById('user-menu');
            const userMenuToggle = document.getElementById('user-menu-toggle');

             if (adminMenuToggle && adminMenu) {
                adminMenuToggle.addEventListener('click', (event) => {
                    if (userMenu) userMenu.classList.remove('open');
                    adminMenu.classList.toggle('open');
                    event.stopPropagation();
                });
             }
            if (userMenuToggle && userMenu) {
                userMenuToggle.addEventListener('click', (event) => {
                    if (adminMenu) adminMenu.classList.remove('open');
                    userMenu.classList.toggle('open');
                    event.stopPropagation();
                });
            }
             document.addEventListener('click', (event) => {
                 if (adminMenu && adminMenuToggle && !adminMenu.contains(event.target) && !adminMenuToggle.contains(event.target)) {
                     adminMenu.classList.remove('open');
                 }
                 if (userMenu && userMenuToggle && !userMenu.contains(event.target) && !userMenuToggle.contains(event.target)) {
                     userMenu.classList.remove('open');
                 }
             });

            const bookSections = document.querySelectorAll('.book-section');
            bookSections.forEach(section => {
                const container = section.querySelector('.book-list-container');
                if (!container) return;

                const bookCards = container.querySelector('.book-cards');
                const leftArrow = container.querySelector('.left-arrow');
                const rightArrow = container.querySelector('.right-arrow');
                const cardWidth = 180 + 20;

                if (leftArrow && rightArrow && bookCards) {
                    leftArrow.addEventListener('click', () => { bookCards.scrollBy({ left: -cardWidth * 3, behavior: 'smooth' }); });
                    rightArrow.addEventListener('click', () => { bookCards.scrollBy({ left: cardWidth * 3, behavior: 'smooth' }); });
                }
            });

            const loginModal = document.getElementById('loginRequiredModal');
            const goToLoginBtn = document.getElementById('goToLoginBtn');
            const loginModalCancelBtns = loginModal ? loginModal.querySelectorAll('.cancel-btn, .close-button') : [];
            const loginUrl = "<c:url value='/login'/>";

            const readButtons = document.querySelectorAll('.js-read-button');
            const isLoggedIn = ${not empty sessionScope.member or not empty sessionScope.admin};
            const viewBookBaseUrl = "<c:url value='/viewBookDetails/'/>";

            readButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const bookId = this.dataset.bookId;
                    const accessLevel = this.dataset.accesslevel ? this.dataset.accesslevel.toLowerCase() : 'public';
                    const viewBookUrl = viewBookBaseUrl + bookId;

                    if (accessLevel === 'public') {
                        window.location.href = viewBookUrl;
                    } else if (accessLevel === 'member') {
                        if (isLoggedIn) {
                            window.location.href = viewBookUrl;
                        } else {
                            if (loginModal) {
                                loginModal.style.display = 'block';
                            } else {
                                alert("หนังสือเล่มนี้สำหรับสมาชิกเท่านั้น กรุณาเข้าสู่ระบบก่อนครับ");
                            }
                        }
                    } else {
                        console.warn("Unknown access level:", accessLevel, "for book ID:", bookId);
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
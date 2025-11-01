<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>รายการแนะนำหนังสือ</title>
    
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
            border-bottom: none; 
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            gap: 15px;
        }
        .navbar .logo img { height: 60px; border-radius: 12px; display: block;}
        .navbar .search-bar {
            display: flex; align-items: center; gap: 10px;
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
            border: none; border-radius: 6px; cursor: pointer;
            display: flex; align-items: center; gap: 5px;
            font-weight: bold;
        }
        .category-dropdown { position: relative; display: inline-block; }
        .category-dropdown-content {
            display: none; position: absolute; background-color: #f9f9f9;
            min-width: 200px; box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 100; border-radius: 5px; max-height: 300px; overflow-y: auto;
        }
        .category-dropdown-content a {
            color: black; padding: 12px 16px; text-decoration: none; display: block;
            background: none; color: #333; font-weight: normal; 
            margin-left: 0; border-radius: 0; white-space: normal;
            font-family: 'Noto Sans Thai', Arial, sans-serif;
        }
        .category-dropdown-content a:hover { background-color: #ddd; }
        .category-dropdown:hover .category-dropdown-content { display: block; }
        .navbar nav { display: flex; align-items: center; gap: 10px;}
        .navbar nav > a, .navbar nav .desktop-menu > a {
            background-color: #00796B;
            color: white; padding: 10px 16px; border-radius: 10px;
            text-decoration: none; font-weight: bold; white-space: nowrap; 
            border: none; cursor: pointer;
            font-family: 'Noto Sans Thai', Arial, sans-serif;
            transition: background-color 0.2s;
        }
        .navbar nav > a:hover, .navbar nav .desktop-menu > a:hover {
             background-color: #004D40;
        }

        .navbar nav span.user-greeting { 
            background-color: #4CAF50;
            cursor: pointer;
            padding: 10px 16px; border-radius: 10px;
            color: white; text-decoration: none; font-weight: bold; 
            white-space: nowrap; border: none;
            font-family: 'Noto Sans Thai', Arial, sans-serif;
            display: inline-flex; align-items: center; gap: 5px;
        }

        .navbar nav .admin-info span { 
            background-color: #4CAF50;
            color: white;
            cursor: default;
            padding: 10px 16px; border-radius: 10px;
            text-decoration: none; font-weight: bold; 
            white-space: nowrap; border: none;
            font-family: 'Noto Sans Thai', Arial, sans-serif;
        }
      
        .navbar nav > a[href*="logout"] { background-color: #dc3545;}
        
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
            min-width: 200px;
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
            text-align: left;
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

        .profile-and-menu { display: flex; align-items: center; gap: 5px; }
        .admin-menu { position: relative; }
        .admin-info { display: flex; align-items: center; gap: 10px; font-weight: bold; color: #fff; } 
        .admin-info img { width: 30px; height: 30px; border-radius: 50%; padding: 0px; margin-right: -5px;}
        .admin-menu-toggle { 
            background: none; border: none; font-size: 24px; 
            color: #FFFFFF; 
            cursor: pointer; padding: 5px; 
        }
        .admin-menu.open .admin-dropdown { display: block; }
        
        .admin-dropdown { 
            display: none; position: absolute; 
            background-color: #fff;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15); 
            z-index: 10; 
            right: 0; top: 100%; margin-top: 10px; 
            border-radius: 10px;
            overflow: hidden; 
            border: 1px solid #eee; 
            padding: 0;
            min-width: 200px;
        }
        .admin-dropdown a { 
            color: #333;
            padding: 12px 16px;
            text-decoration: none; 
            display: block; 
            background-color: transparent;
            font-weight: normal;
            margin-left:0; 
            border-radius: 0;
            font-family: 'Noto Sans Thai', Arial, sans-serif; 
            white-space: nowrap; 
            text-align: left;
            transition: background-color 0.2s;
        }
        .admin-dropdown a:hover { 
            background-color: #f5f5f5;
        }

        .profile-container { 
            display: flex;
            justify-content: center;
            gap: 30px; 
            margin-top: 25px;
        }

        .content-card {
            flex-grow: 1;
            max-width: 900px;
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }
        .content-card h2 { 
            font-family: 'Merriweather', serif;
            text-align: center; 
            color: #5a3c2c;
            margin-top: 0; 
            margin-bottom: 30px; 
            font-size: 1.8em; 
        }

        .recommendation-list { display: flex; flex-direction: column; gap: 20px; }
        .recommendation-card {
            display: flex;
            gap: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #E0E0E0;
            position: relative; 
        }
        .recommendation-cover img {
            width: 100px;
            height: 150px;
            object-fit: cover;
            border-radius: 5px;
            flex-shrink: 0;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .recommendation-details {
            flex-grow: 1;
            padding-right: 30px; 
        }
        .recommendation-details .book-title {
            font-family: 'Merriweather', serif;
            font-size: 1.3em;
            font-weight: bold;
            color: #5a3c2c;
            margin: 0 0 5px 0;
            text-decoration: none;
        }
        .recommendation-details .book-title:hover { text-decoration: underline; }
        .recommendation-details .recommender-info {
            font-size: 0.9em;
            color: #6D4C41;
            font-style: italic;
            margin-bottom: 10px;
            border-bottom: 1px dashed #ccc;
            padding-bottom: 10px;
        }
        .recommendation-details .reason-label {
             font-weight: bold;
             color: #333;
             font-size: 0.9em;
             margin-bottom: 5px;
        }
        .recommendation-details .reason {
            line-height: 1.6;
            color: #555;
            margin: 0;
        }

        .delete-recommend-btn {
            position: absolute;
            top: 15px;
            right: 15px;
            background: none;
            border: none;
            color: #aaa;
            font-size: 1.1em;
            cursor: pointer;
            padding: 5px;
            z-index: 1;
        }
        .delete-recommend-btn:hover {
            color: #dc3545; 
        }
        
         .alert { padding: 10px 15px; margin-bottom: 20px; border: 1px solid transparent; border-radius: 4px; text-align: center; font-weight: bold;}
         .alert-success { color: #155724; background-color: #d4edda; border-color: #c3e6cb; }
         .alert-danger { color: #721c24; background-color: #f8d7da; border-color: #f5c6cb; }

        .footer { 
            background-color: #4E342E;
            height: 60px;
            width: 100%; 
            margin-top: auto; 
        }
        
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.6);
            z-index: 9998;
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background: #fff;
            padding: 25px 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            z-index: 9999;
            max-width: 400px;
            width: 90%;
            text-align: center;
        }
        .modal-content h3 {
            font-family: 'Merriweather', serif;
            color: #dc3545;
            margin-top: 0;
            margin-bottom: 10px;
        }
        .modal-content p {
            color: #333;
            font-size: 1.1em;
            line-height: 1.6;
            margin-bottom: 20px;
        }
        .modal-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
        }
        .modal-buttons .btn {
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: bold;
            font-family: 'Noto Sans Thai', Arial, sans-serif;
            cursor: pointer;
            border: none;
            font-size: 1em;
        }
        .modal-buttons .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        .modal-buttons .btn-danger:hover {
            background-color: #c82333;
        }
        .modal-buttons .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .modal-buttons .btn-secondary:hover {
            background-color: #5a6268;
        }

        @media (max-width: 768px) {
             .profile-container { flex-direction: column; }
             .recommendation-card { flex-direction: column; align-items: center; text-align: center;}
             .recommendation-details { padding-right: 0; }

             .navbar { flex-direction: column; align-items: flex-start; }
             .navbar .search-bar { 
                 margin-top: 10px; 
                 width: 100%; 
                 justify-content: center; 
                 margin-left: 0;
                 margin-right: 0; 
             }
             .navbar .search-bar input { flex-grow: 1; }
             .navbar nav { 
                 width: 100%; 
                 display: flex; 
                 flex-direction: row; 
                 justify-content: flex-end; 
                 align-items: center; 
                 margin-top: 10px; 
             }
             .navbar nav a, .navbar nav span.user-greeting { margin: 0 5px; }
        }
    </style>
    
</head>
<body>

    <header class="navbar">
        <div class="logo">
            <a href="<c:url value='/searchbook'/>">
                <img src="<c:url value='/assets/logo.png'/>" alt="Logo">
            </a>
        </div>
        
        <form class="search-bar" action="<c:url value='/searchbook'/>" method="GET">
            <div class="category-dropdown">
                <button type="button" class="category-button">
                    หมวดหมู่ <i class="fas fa-caret-down"></i>
                </button>
                <div class="category-dropdown-content">
                    <a href="<c:url value='/searchbook'/>">หมวดหมู่ทั้งหมด</a>
                    <c:forEach var="cat" items="${categories}">
                        <a href="<c:url value='/searchbook?categoryId=${cat.category_id}'/>">${cat.category_name}</a>
                    </c:forEach>
                </div>
            </div>
            <input type="text" name="query" placeholder="ค้นหาชื่อเรื่อง, ผู้แต่ง..." value="${searchQuery}">
            <button type="submit">ค้นหา</button>
        </form>
        
        <nav>
            <c:choose>
                 <c:when test="${not empty sessionScope.admin}">
                     <div class="profile-and-menu">
                         <div class="admin-info">
                             <img src="<c:url value='/assets/images/profile-icon.png'/>" alt="Admin Profile">
                             <span>${sessionScope.admin.usernameLibrarian}</span>
                         </div>
                         <div id="admin-menu" class="admin-menu">
                             <button id="admin-menu-toggle" class="admin-menu-toggle"><i class="fas fa-bars"></i></button>
                             <div id="admin-dropdown-content" class="admin-dropdown">
                                 <a href="<c:url value='/memberList'/>">รายชื่อสมาชิก</a>
                                 <a href="<c:url value='/adminHome'/>">รายการหนังสือ</a>
                                 <a href="<c:url value='/listRecommendedBooks'/>" class="active">รายการแนะนำหนังสือ</a> 
                                 <a href="<c:url value='/logout'/>">ออกจากระบบ</a>
                             </div>
                         </div>
                     </div>
                 </c:when>
                 <c:otherwise>
                     <c:choose>
                          <c:when test="${not empty sessionScope.member}">
                               <div class="desktop-menu">
                                    <div class="user-menu" id="user-menu"> 
                                         <span class="user-greeting" id="user-menu-toggle"> 
                                             สวัสดี, ${sessionScope.member.username} <i class="fas fa-caret-down"></i>
                                         </span>
                                         <div class="dropdown-content"> 
                                             <a href="<c:url value='/editProfile'/>">แก้ไขโปรไฟล์</a>
                                             <a href="<c:url value='/favoriteBooks'/>">หนังสือที่ชื่นชอบ</a>
                                             <a href="<c:url value='/history'/>">ประวัติหนังสือ</a>
                                             <a href="<c:url value='/readingStats'/>">สถิติการอ่าน</a>
                                             <a href="<c:url value='/recommendBookForm'/>">แนะนำหนังสือ</a>
                                             <a href="<c:url value='/listRecommendedBooks'/>" class="active">รายการแนะนำหนังสือ</a> 
                                             <a href="<c:url value='/logout'/>">ออกจากระบบ</a>
                                         </div>
                                    </div>
                               </div>
                          </c:when>
                          <c:otherwise>
                               <div class="desktop-menu">
                                    <a href="<c:url value='/login'/>">เข้าสู่ระบบ</a>
                                    <a href="<c:url value='/Register1'/>">ลงทะเบียน</a>
                               </div>
                          </c:otherwise>
                     </c:choose>
                 </c:otherwise>
            </c:choose>
        </nav>
    </header>

    <div class="container profile-container"> 
        <main class="content-card">
            <h2>รายการแนะนำหนังสือ</h2>
            
            <c:if test="${not empty successMessage}"><div class="alert alert-success">${successMessage}</div></c:if>
            <c:if test="${not empty errorMessage}"><div class="alert alert-danger">${errorMessage}</div></c:if>
            
            <div class="recommendation-list">
                <c:choose>
                    <c:when test="${not empty recommendationList}">
                        <c:forEach var="rec" items="${recommendationList}">
                            <div class="recommendation-card">
                                <div class="recommendation-cover">
                                    <a href="<c:url value='/viewBookDetails/${rec.book.id}'/>">
                                        <img src="<c:url value='/assets/images/covers/${rec.book.cover_image}'/>"
                                             alt="${rec.book.book_title}"
                                             onerror="this.onerror=null; this.src='<c:url value="/assets/images/placeholder.png"/>';">
                                    </a>
                                </div>
                                <div class="recommendation-details">
                                    <a href="<c:url value='/viewBookDetails/${rec.book.id}'/>" class="book-title">${rec.book.book_title}</a>
                                    <p class="recommender-info">
                                        แนะนำโดย: <strong>${rec.member.username}</strong>
                                    </p>
                                    <p class="reason-label">เหตุผลที่แนะนำ:</p>
                                    <p class="reason">"${rec.recommendation_reason}"</p>
                                </div>
                                
                                <c:if test="${(not empty sessionScope.admin) or (not empty sessionScope.member and sessionScope.member.id == rec.member.id)}">
                                    <a href="<c:url value='/deleteRecommendation/${rec.recommended_book_id}'/>" 
                                       class="delete-recommend-btn js-delete-confirm"
                                       title="ลบรายการแนะนำนี้">
                                        <i class="fas fa-trash-alt"></i>
                                    </a>
                                </c:if>
                                
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p style="text-align: center; color: #666;">ยังไม่มีหนังสือที่ถูกแนะนำ</p>
                    </c:otherwise>
                </c:choose>
            </div>
            
        </main>
    </div>

    <div class="modal-overlay" id="deleteConfirmModal" style="display: none;">
        <div class="modal-content">
            <h3>ยืนยันการลบ</h3>
            <p>คุณแน่ใจหรือไม่ว่าต้องการลบรายการแนะนำนี้?</p> 
            <div class="modal-buttons">
                <button class="btn btn-secondary" id="cancelDeleteBtn">ยกเลิก</button>
                <a href="#" id="confirmDeleteBtn" class="btn btn-danger">ตกลง</a>
            </div>
        </div>
    </div>

    <footer class="footer"></footer>

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

            const deleteModal = document.getElementById('deleteConfirmModal');
            const cancelDeleteBtn = document.getElementById('cancelDeleteBtn');
            const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
            const deleteButtons = document.querySelectorAll('.js-delete-confirm');

            if (deleteModal && cancelDeleteBtn && confirmDeleteBtn) {

                deleteButtons.forEach(button => {
                    button.addEventListener('click', function(event) {
                        event.preventDefault();
                        const deleteUrl = this.href;
                        
                        confirmDeleteBtn.href = deleteUrl;
                        
                        deleteModal.style.display = 'flex';
                    });
                });

                cancelDeleteBtn.addEventListener('click', () => {
                    deleteModal.style.display = 'none';
                });

                deleteModal.addEventListener('click', (event) => {
                    if (event.target === deleteModal) {
                        deleteModal.style.display = 'none';
                    }
                });
            }

        });
    </script>
    
</body>
</html>
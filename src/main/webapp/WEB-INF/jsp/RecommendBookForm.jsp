<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>แนะนำหนังสือ</title>

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

        .profile-container {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-top: 25px;
        }

        .form-card {
            flex-grow: 1;
            max-width: 900px;
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        .form-card h2 {
            font-family: 'Merriweather', serif;
            text-align: center;
            color: #5a3c2c;
            margin-top: 0;
            margin-bottom: 30px;
            font-size: 1.8em;
        }

        .recommend-form { display: grid; grid-template-columns: 200px 1fr; gap: 20px 40px; }
        .book-preview-area { grid-column: 1 / 2; }
        .book-form-area { grid-column: 2 / 3; }

        .book-preview-area img {
            width: 100%;
            height: 300px;
            object-fit: cover;
            border: 1px solid #E0E0E0;
            border-radius: 8px;
            background-color: #f0f0f0;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .book-preview-info {
            text-align: center;
            margin-top: 10px;
            min-height: 80px;
        }
        .book-preview-info p {
            margin: 5px 0; font-size: 0.9em;
            color: #555;
        }
        .book-preview-info p.title {
            font-weight: bold;
            color: #5a3c2c;
        }

        .form-group { margin-bottom: 20px; }
        .form-group label {
            display: block; margin-bottom: 8px; font-weight: bold;
            color: #555; font-family: 'Noto Sans Thai', Arial, sans-serif;
        }
        .form-group select, .form-group textarea {
            width: 100%; padding: 12px; border: 1px solid #ccc;
            border-radius: 8px; box-sizing: border-box; font-size: 1rem;
            font-family: 'Noto Sans Thai', Arial, sans-serif;
        }
        .form-group select:focus, .form-group textarea:focus {
            border-color: #00796B;
            outline: none;
            box-shadow: 0 0 6px rgba(0, 121, 107, 0.3);
        }
        .form-group textarea { height: 120px; resize: vertical; }

        .form-note { font-size: 0.9em; color: #666; margin-top: 15px; }
        .submit-button {
            display: block; width: fit-content; margin: 20px 0 0 auto;
            background-color: #00796B;
            color: white; padding: 12px 25px; border: none;
            border-radius: 8px; cursor: pointer; font-size: 1rem;
            font-weight: bold; font-family: 'Noto Sans Thai', Arial, sans-serif;
            transition: background-color 0.2s;
        }
        .submit-button:hover { background-color: #004D40; }

         .alert {
            padding: 10px 15px; margin-bottom: 20px; border: 1px solid transparent;
            border-radius: 4px; text-align: center; font-weight: bold;
            font-family: 'Noto Sans Thai', Arial, sans-serif;
         }
         .alert-success { color: #155724; background-color: #d4edda; border-color: #c3e6cb; }

        .footer {
            background-color: #4E342E;
            height: 60px;
            width: 100%;
            margin-top: auto;
        }
        
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
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
        }
        
        .modal-content #modal-message {
            text-align: center;
            line-height: 1.6;
            color: #333; 
        }
        
        .modal-content #modal-message ul {
            display: none;
        }
        
        .modal-close-btn {
            background: #00796B;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: bold;
            font-family: 'Noto Sans Thai', Arial, sans-serif;
            cursor: pointer;
            margin-top: 15px;
        }
        .modal-close-btn:hover {
            background: #004D40;
        }
        
        .form-group select.input-error,
        .form-group textarea.input-error {
            border-color: #dc3545;
            box-shadow: 0 0 5px rgba(220, 53, 69, 0.5);
        }

        @media (max-width: 768px) {
             .navbar { flex-direction: column; align-items: flex-start; }
             .navbar-right { width: 100%; justify-content: space-between; margin-top: 10px; }
             .search-bar { margin-left: 0; margin-right: 0; flex-grow: 1; }
             .search-bar input { flex-grow: 1; }
             nav { }
             nav a, nav .user-greeting { margin: 0 5px; }
             /* Form Responsive */
             .profile-container { flex-direction: column; }
             .recommend-form { grid-template-columns: 1fr; }
             .book-preview-area { max-width: 200px; margin: 0 auto; }
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
                                <a href="<c:url value='/readingStats'/>">สถิติการอ่าน</a>
                                <a href="<c:url value='/recommendBookForm'/>" class="active">แนะนำหนังสือ</a>
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
        <main class="form-card">
            <h2>แนะนำหนังสือ</h2>
             <c:if test="${not empty successMessage}"><div class="alert alert-success"><c:out value="${successMessage}"/></div></c:if>
            <form action="<c:url value='/saveRecommendation'/>" method="post" id="recommend-form" novalidate>
            
                <div class="recommend-form">
                    <div class="book-preview-area">
                        <label>รูปภาพปก</label>
                        <img id="preview-cover" src="<c:url value='/assets/images/กรุณาเลือกหนังสือ.png'/>" alt="ปกหนังสือ">
                        <div class="book-preview-info">
                            <p id="preview-title" class="title">ชื่อหนังสือ</p>
                            <p id="preview-author">ผู้เขียน&nbsp;</p>
                            <p id="preview-publisher">สำนักพิมพ์&nbsp;</p>
                            <p id="preview-year">ปีที่พิมพ์&nbsp;</Fp>
                        </div>
                    </div>

                    <div class="book-form-area">
                        <div class="form-group">
                            <label for="book_id_select">เลือกหนังสือที่จะแนะนำ</label>
                            <select id="book_id_select" name="book_id" required>
                                <option value="">-- กรุณาเลือกหนังสือ --</option>
                                <c:forEach var="book" items="${allBooks}">
                                    <option value="${book.id}"
                                            data-title="<c:out value="${book.book_title}"/>"
                                            data-author="<c:out value="${book.author}"/>"
                                            data-publisher="<c:out value="${book.publisher}"/>"
                                            data-year="${book.published_year}"
                                            data-cover="<c:url value='/assets/images/covers/${book.cover_image}'/>">
                                        <c:out value="${book.book_title}"/>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="recommendation_reason">เหตุผลที่แนะนำ</label>
                            <textarea id="recommendation_reason" name="recommendation_reason" rows="5" required></textarea>
                        </div>

                        <p class="form-note">โปรดตรวจสอบความถูกต้องของข้อมูลให้ครบถ้วน</p>
                        <button type="submit" class="submit-button">แนะนำหนังสือ</button>
                    </div>

                </div>
            </form>
        </main>
    </div>

    <footer class="footer"></footer>

    
    <div class="modal-overlay" id="validationModal" style="display: none;">
        <div class="modal-content">
            <h3>ข้อมูลไม่ครบถ้วน</h3>
            <div id="modal-message">กรุณากรอกข้อมูลต่อไปนี้ให้ครบถ้วน:</div>
            <button class="modal-close-btn" id="modal-close-btn">เข้าใจแล้ว</button>
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

        const bookSelect = document.getElementById('book_id_select');
        const previewCover = document.getElementById('preview-cover');
        const previewTitle = document.getElementById('preview-title');
        const previewAuthor = document.getElementById('preview-author');
        const previewPublisher = document.getElementById('preview-publisher');
        const previewYear = document.getElementById('preview-year');
        const placeholderImg = "<c:url value='/assets/images/กรุณาเลือกหนังสือ.png'/>";

        if (bookSelect) {
            bookSelect.addEventListener('change', function() {
                const selectedOption = this.options[this.selectedIndex];

                if (selectedOption.value === "") {
                    previewCover.src = placeholderImg;
                    previewTitle.textContent = "ชื่อหนังสือ";
                    previewAuthor.innerHTML = "ผู้เขียน&nbsp;";
                    previewPublisher.innerHTML = "สำนักพิมพ์&nbsp;";
                    previewYear.innerHTML = "ปีที่พิมพ์&nbsp;";
                } else {
                    previewCover.src = selectedOption.dataset.cover || placeholderImg;
                    previewTitle.textContent = selectedOption.dataset.title || 'N/A';
                    previewAuthor.textContent = "ผู้เขียน: " + (selectedOption.dataset.author || '-');
                    previewPublisher.textContent = "สำนักพิมพ์: " + (selectedOption.dataset.publisher || '-');
                    previewYear.textContent = "ปีที่พิมพ์: " + (selectedOption.dataset.year || '-');
                }
            });
        }

        if (previewCover) {
             previewCover.addEventListener('error', function() {
                 this.src = placeholderImg;
             });
        }

        const form = document.getElementById('recommend-form');
        const modal = document.getElementById('validationModal');
        const modalMessage = document.getElementById('modal-message');
        const closeModalBtn = document.getElementById('modal-close-btn');

        if (form && modal && modalMessage && closeModalBtn) {
            
            form.addEventListener('submit', function(event) {
                let errors = [];
                form.querySelectorAll('.input-error').forEach(el => el.classList.remove('input-error'));

                const bookSelectField = document.getElementById('book_id_select');
                if (bookSelectField.value === '') {
                    errors.push(bookSelectField.id);
                    bookSelectField.classList.add('input-error');
                }

                const reasonField = document.getElementById('recommendation_reason');
                if (reasonField.value.trim() === '') {
                    errors.push(reasonField.id);
                    reasonField.classList.add('input-error');
                }

                if (errors.length > 0) {
                    event.preventDefault();

                    modalMessage.innerHTML = 'กรุณาเลือกหนังสือและกรอกเหตุผลที่แนะนำ'; 
                    
                    modal.style.display = 'flex';
                } 
            });

            closeModalBtn.addEventListener('click', () => {
                modal.style.display = 'none';
            });

            modal.addEventListener('click', (event) => {
                if (event.target === modal) {
                    modal.style.display = 'none';
                }
            });
            
            form.querySelectorAll('select[required], textarea[required]').forEach(field => {
                field.addEventListener('input', () => {
                    if(field.value.trim() !== '') {
                        field.classList.remove('input-error');
                    }
                });
                field.addEventListener('change', () => {
                    if(field.value.trim() !== '') {
                        field.classList.remove('input-error');
                    }
                });
            });
        }

    });
    </script>

</body>
</html>
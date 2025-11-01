<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>เพิ่มหนังสือ</title>

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
        padding: 0 20px;
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

    .navbar .logo img {
        height: 60px;
        border-radius: 12px;
        display: block;
    }

    .navbar .search-bar {
        display: flex;
        align-items: center;
        gap: 10px;
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

    .navbar nav {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .navbar nav .admin-info {
        display: flex;
        align-items: center;
        gap: 8px;
        font-weight: bold;
        color: #FFFFFF;
        font-family: 'Noto Sans Thai', Arial, sans-serif;
    }

    .navbar nav .admin-info img {
        width: 30px;
        height: 30px;
        border-radius: 50%;
        background-color: #A1887F;
        padding: 0px;
        margin-right: -5px;
    }

    .profile-and-menu {
        display: flex;
        align-items: center;
        gap: 5px;
    }
    
    .admin-menu {
        position: relative;
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

    .add-book-container {
        flex-grow: 1;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 40px 20px;
    }

    .add-book-card {
        background-color: #fff;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        width: 100%;
        max-width: 800px;
    }

    .add-book-card h2 {
        font-family: 'Merriweather', serif;
        text-align: center;
        margin-top: 0;
        margin-bottom: 30px;
        color: #5a3c2c;
        font-size: 2em;
    }

    .add-book-form-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px 40px;
    }

    .form-group {
        display: flex;
        flex-direction: column;
    }

    .form-group label {
        font-weight: bold;
        margin-bottom: 8px;
        color: #555;
        font-family: 'Noto Sans Thai', Arial, sans-serif;
    }

    .form-group input[type="text"],
    .form-group input[type="file"],
    .form-group input[type="number"],
    .form-group textarea,
    .form-group select {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 6px;
        box-sizing: border-box;
        font-size: 1rem;
        font-family: 'Noto Sans Thai', Arial, sans-serif;
    }

    .form-group textarea {
        resize: vertical;
        height: 120px;
    }

    #description-counter {
        margin-top: 5px;
        text-align: right;
        font-size: 0.85em;
        color: #666;
    }
    #description-counter.warning {
        color: red;
        font-weight: bold;
    }

    .form-actions {
        grid-column: 1 / span 2;
        text-align: center;
        margin-top: 20px;
    }

    .form-actions p {
        color: #666;
        font-size: 0.9em;
        margin-bottom: 10px;
    }

    .submit-button {
        background-color: #00796B;
        color: white;
        padding: 12px 30px;
        border-radius: 6px;
        border: none;
        font-size: 18px;
        cursor: pointer;
        box-shadow: 0 4px 6px rgba(0,0,0,0.15);
        transition: background-color 0.2s ease;
        font-family: 'Noto Sans Thai', Arial, sans-serif;
        font-weight: bold;
    }

    .submit-button:hover {
        background-color: #004D40;
    }
    .submit-button:disabled {
        background-color: #aaa;
        cursor: not-allowed;
        box-shadow: none;
    }

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
        color: #dc3545; /* สีแดง */
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
    
    .form-group input.input-error,
    .form-group select.input-error,
    .form-group textarea.input-error {
        border-color: #dc3545; /* สีแดง */
        box-shadow: 0 0 5px rgba(220, 53, 69, 0.5);
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
        .navbar .search-bar {
            margin-left: 0;
            margin-right: 0;
            flex-grow: 1;
        }
        .navbar .search-bar input {
            flex-grow: 1;
        }
        
        .navbar nav {
        }


        .add-book-form-grid {
            grid-template-columns: 1fr;
        }
        .form-actions {
            grid-column: 1 / span 1;
        }
        
    }
    </style>
    
</head>
<body>
    <header class="navbar">
        <div class="navbar-left">
            <div class="logo">
                <a href="<c:url value='/adminHome'/>">
                    <img src="<c:url value='/assets/logo.png'/>" alt="Logo">
                </a>
            </div>
        </div>

        <div class="navbar-right">
            <nav>
                <div class="profile-and-menu">
                    <div class="admin-info">
                        <img src="<c:url value='/assets/images/profile-icon.png'/>" alt="Admin Profile">
                        <span><c:out value="${not empty sessionScope.admin ? sessionScope.admin.usernameLibrarian : 'Admin'}"/></span>
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

    <div class="add-book-container">
        <div class="add-book-card">
            <h2>เพิ่มหนังสือ</h2>
            <form action="<c:url value='/saveBook'/>" method="post" enctype="multipart/form-data" id="add-book-form" novalidate>
                <div class="add-book-form-grid">
                    <div class="form-group">
                        <label for="coverImage">เพิ่มรูปภาพปก</label>
                        <input type="file" id="coverImage" name="coverImage">
                    </div>
                    <div class="form-group">
                        <label for="author">ผู้เขียน</label>
                        <input type="text" id="author" name="author" required>
                    </div>
                    <div class="form-group">
                        <label for="bookTitle">ชื่อหนังสือ</label>
                        <input type="text" id="bookTitle" name="book_title" required>
                    </div>

                    <div class="form-group">
                        <label for="category">หมวดหมู่</label>
                        <select id="category" name="category_id" required>
                            <option value="">-- กรุณาเลือกหมวดหมู่ --</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.category_id}"><c:out value="${cat.category_name}"/></option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="publisher">สำนักพิมพ์</label>
                        <input type="text" id="publisher" name="publisher">
                    </div>
                    <div class="form-group">
                        <label for="pdfFile">ไฟล์หนังสือ</label>
                        <input type="file" id="pdfFile" name="pdfFile">
                    </div>

                    <div class="form-group">
                        <label for="publishedYear">ปีที่พิมพ์</label>
                        <jsp:useBean id="now" class="java.util.Date" />
                        <fmt:formatDate value="${now}" pattern="yyyy" var="currentYear" />

                        <select id="publishedYear" name="published_year" required>
                            <option value="">-- เลือกปี --</option>
                            <c:forEach var="year" begin="0" end="100">
                                <c:set var="optionYear" value="${currentYear - year}" />
                                <option value="${optionYear}">${optionYear}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="accesslevel">ระดับการเข้าถึง:</label>
                        <select id="accesslevel" name="accesslevel" required>
                            <option value="">-- กรุณาเลือก --</option>
                            <option value="public">ทั่วไป (ทุกคนเข้าถึงได้)</option>
                            <option value="member">เฉพาะสมาชิก</option>
                            </select>
                    </div>

                </div>
                <div class="form-group">
                    <label for="description">คำอธิบายหนังสือ</label>
                    <textarea id="description" name="description" rows="5"></textarea>
                    <small id="description-counter" style="margin-top: 5px; text-align: right; color: #666;">0 / 1000</small>
                </div>

                <div class="form-actions">
                    <p style="color: #666; font-size: 0.9em; margin-bottom: 10px;">โปรดตรวจสอบความถูกต้องของข้อมูลให้ครบถ้วน</p>
                    <button type="submit" class="submit-button">เพิ่มหนังสือ</button>
                </div>
            </form>
        </div>
    </div>

    <footer class="footer"></footer>

    <div class="modal-overlay" id="validationModal" style="display: none;">
        <div class="modal-content">
            <h3>ข้อมูลไม่ครบถ้วน</h3>
            <div id="modal-message">กรุณากรอกข้อมูลต่อไปนี้ให้ครบถ้วน</div>
            <button class="modal-close-btn" id="modal-close-btn">เข้าใจแล้ว</button>
        </div>
    </div>
    <script>
    document.addEventListener('DOMContentLoaded', function() {

        const descriptionTextarea = document.getElementById('description');
        const descriptionCounter = document.getElementById('description-counter');
        const submitButton = document.querySelector('.submit-button');
        const maxLength = 1000;

        if (descriptionTextarea && descriptionCounter && submitButton) {
            function updateCounter() {
                const currentLength = descriptionTextarea.value.length;
                descriptionCounter.textContent = `${currentLength} / ${maxLength}`;

                if (currentLength > maxLength) {
                    descriptionCounter.classList.add('warning');
                    submitButton.disabled = true;
                    submitButton.style.backgroundColor = '#aaa';
                    submitButton.style.cursor = 'not-allowed';
                } else {
                    descriptionCounter.classList.remove('warning');
                    submitButton.disabled = false;
                    submitButton.style.backgroundColor = '#00796B';
                    submitButton.style.cursor = 'pointer';
                }
            }
            updateCounter();
            descriptionTextarea.addEventListener('input', updateCounter);
        }

        const adminMenu = document.getElementById('admin-menu');
        const adminMenuToggle = document.getElementById('admin-menu-toggle');

        if (adminMenuToggle && adminMenu) {
            adminMenuToggle.addEventListener('click', (event) => {
                adminMenu.classList.toggle('open');
                event.stopPropagation();
            });
        }

         document.addEventListener('click', (event) => {
             if (adminMenu && adminMenuToggle && !adminMenu.contains(event.target) && !adminMenuToggle.contains(event.target)) {
                 adminMenu.classList.remove('open');
             }
         });
        
        const form = document.getElementById('add-book-form');
        const modal = document.getElementById('validationModal');
        const modalMessage = document.getElementById('modal-message');
        const closeModalBtn = document.getElementById('modal-close-btn');

        if (form && modal && modalMessage && closeModalBtn) {
            
            form.addEventListener('submit', function(event) {
                let errors = [];
                form.querySelectorAll('.input-error').forEach(el => el.classList.remove('input-error'));
                const requiredInputs = form.querySelectorAll('input[required], textarea[required]');
                requiredInputs.forEach(input => {
                    if (input.value.trim() === '') {
                        errors.push(input.id);
                        input.classList.add('input-error');
                    }
                });
                const requiredSelects = form.querySelectorAll('select[required]');
                requiredSelects.forEach(select => {
                    if (select.value === '') {
                        errors.push(select.id);
                        select.classList.add('input-error');
                    }
                });
                if (errors.length > 0) {
                    event.preventDefault();
                    modalMessage.innerHTML = 'กรุณากรอกข้อมูลต่อไปนี้ให้ครบถ้วน:'; 
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
            
            form.querySelectorAll('input[required], select[required], textarea[required]').forEach(field => {
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
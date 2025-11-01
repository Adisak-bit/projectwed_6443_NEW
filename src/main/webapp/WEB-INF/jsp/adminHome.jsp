<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>หน้าผู้ดูแลระบบ</title>
    
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
        
        .admin-book-list-container {
            flex-grow: 1;
            background-color: #FFFFFF;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        .admin-actions {
            display: flex;
            justify-content: flex-start;
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .admin-actions a {
            background-color: #00796B;
            color: white;
            padding: 12px 20px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: bold;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
            transition: transform 0.2s ease, background-color 0.2s ease;
            font-family: 'Noto Sans Thai', Arial, sans-serif;
        }
        
        .admin-actions a:hover {
            transform: translateY(-2px);
            background-color: #004D40;
        }
        
        .admin-actions a.delete-button {
            background-color: #dc3545;
        }

        .admin-book-list-container h2 {
            font-family: 'Merriweather', serif;
            color: #5a3c2c;
            margin-bottom: 20px;
            text-align: center;
            font-size: 2em;
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
            position: relative;
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
        }
        .book-card p {
            padding: 10px;
            font-weight: bold;
            color: #5a3c2c;
            margin: 0;
            flex-grow: 1; 
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
            border-radius: 5px; 
            font-family: 'Noto Sans Thai', Arial, sans-serif;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }
        
        .read-button:hover {
            background-color: #004D40;
        }

        .delete-icon {
            position: absolute;
            top: 5px;
            right: 5px;
            background-color: rgba(255, 255, 255, 0.7); 
            color: red;
            border: none;
            border-radius: 50%; 
            width: 25px;
            height: 25px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            line-height: 1; 
            padding: 0;
            transition: background-color 0.2s, color 0.2s; 
        }
        .delete-icon:hover {
            background-color: white;
            color: darkred;
        }

        .modal {
          display: none; 
          position: fixed; 
          z-index: 1000; 
          left: 0;
          top: 0;
          width: 100%;
          height: 100%;
          overflow: auto; 
          background-color: rgba(0,0,0,0.6); 
          padding-top: 100px; 
        }

        .modal-content {
          background-color: #fefefe;
          margin: auto;
          padding: 30px;
          border: 1px solid #888;
          width: 80%;
          max-width: 400px; 
          border-radius: 15px;
          text-align: center;
          position: relative;
          box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }

        .close-button {
          color: #aaa;
          position: absolute;
          top: 10px;
          right: 20px;
          font-size: 28px;
          font-weight: bold;
        }

        .close-button:hover,
        .close-button:focus {
          color: black;
          text-decoration: none;
          cursor: pointer;
        }

        .modal-content p {
            font-size: 1.2em;
            margin-bottom: 25px;
            color: #333;
        }

        .modal-buttons {
            display: flex;
            justify-content: center;
            gap: 20px; 
        }

        .modal-buttons button {
            padding: 10px 25px;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            cursor: pointer;
            color: white;
            transition: background-color 0.2s ease;
        }

        .modal-buttons .confirm-btn {
            background-color: #28a745; 
        }
        .modal-buttons .confirm-btn:hover {
            background-color: #218838;
        }

        .modal-buttons .cancel-btn {
            background-color: #dc3545; 
        }
        .modal-buttons .cancel-btn:hover {
            background-color: #c82333;
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
        <div class="admin-book-list-container">
            <div class="admin-actions">
                <a href="<c:url value='/addbook-form'/>">เพิ่มหนังสือใหม่</a>
            </div>
            <h2>รายการหนังสือ</h2>
            <div class="book-cards">
                <c:choose>
                    <c:when test="${not empty bookList}">
                        <c:forEach var="book" items="${bookList}">
                            <div class="book-card">
                                <img src="<c:url value='/assets/images/covers/${book.cover_image}'/>"
                                     alt="${book.book_title}"
                                     onerror="this.onerror=null; this.src='<c:url value="/assets/images/placeholder.png"/>';" >
                                <p>${book.book_title}</p>

                                <div class="card-buttons">
                                    <button class="read-button"
                                            onclick="window.location.href='<c:url value="/viewBookDetails/${book.id}"/>'">
                                        อ่าน
                                    </button>
                                </div>
                                <button class="delete-icon" data-book-id="${book.id}" data-book-title="${book.book_title}">
                                    &times;
                                </button>
                                </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p style="text-align: center; width: 100%; color: #666;">ยังไม่มีหนังสือในระบบ</p>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
    </div>

    <footer class="footer"></footer>

    <div id="deleteConfirmModal" class="modal">
      <div class="modal-content">
        <span class="close-button">&times;</span>
        <p>ยืนยันที่จะลบหนังสือ</p>
        <div class="modal-buttons">
          <button id="confirmDeleteBtn" class="confirm-btn">ยืนยัน</button>
          <button class="cancel-btn">ยกเลิก</button>
        </div>
      </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const modal = document.getElementById('deleteConfirmModal');
            const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
            const cancelBtns = modal.querySelectorAll('.cancel-btn, .close-button');
            const deleteIcons = document.querySelectorAll('.delete-icon');

            let deleteUrl = ''; 
            const baseUrl = "<c:url value='/deleteBook/' />"; 

            if (deleteIcons.length > 0) {
                 deleteIcons.forEach(icon => {
                    icon.addEventListener('click', function() {
                        const bookId = this.dataset.bookId;
                        deleteUrl = baseUrl + bookId; 
                        modal.style.display = 'block'; 
                    });
                });
            }

            confirmDeleteBtn.addEventListener('click', function() {
                if (deleteUrl && deleteUrl !== baseUrl && !deleteUrl.endsWith('undefined') && !deleteUrl.endsWith('null')) {
                    window.location.href = deleteUrl; 
                } else {
                     console.error("URL ผิดพลาด: ขาด ID หรือ URL ไม่ถูกต้อง!", deleteUrl);
                     alert("เกิดข้อผิดพลาด: ไม่พบ ID หนังสือ หรือ URL ไม่ถูกต้อง");
                     modal.style.display = 'none';
                     deleteUrl = '';
                }
            });

            cancelBtns.forEach(btn => {
                btn.addEventListener('click', function() {
                    modal.style.display = 'none';
                    deleteUrl = '';
                });
            });

            window.addEventListener('click', function(event) {
                if (event.target == modal) {
                    modal.style.display = 'none';
                    deleteUrl = '';
                }
            });

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
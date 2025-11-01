<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ลงทะเบียน</title>

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
        .search-bar button:hover {
            background-color: #004D40;
        }
        .search-bar .category-button {
             background-color: #A1887F;
             color: white;
        }
         .search-bar .category-button:hover {
             background-color: #6D4C41;
         }

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
        nav a:hover {
             background-color: #004D40;
        }
        .menu-toggle { display: none; }

        .register-container {
            flex-grow: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
            background-color: #F7F3E9;
        }
        .register-form-card {
            background-color: #fff;
            padding: 40px 30px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            width: 100%;
            max-width: 450px;
        }
        .register-form-card h2 {
            font-family: 'Merriweather', serif;
            text-align: center;
            margin-top: 0;
            margin-bottom: 30px;
            font-size: 2em;
            color: #5a3c2c;
        }

        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 6px;
            text-align: center;
            font-weight: bold;
            font-family: 'Noto Sans Thai', Arial, sans-serif;
        }
        .alert-success {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
        }
        .alert-danger {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }

        .form-group { margin-bottom: 20px; }
        .form-group label {
             display: block; margin-bottom: 6px; font-weight: bold;
             color: #555;
             font-family: 'Noto Sans Thai', Arial, sans-serif;
        }
        .form-group input {
            width: 100%;
            padding: 10px 16px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
            box-sizing: border-box;
            font-family: 'Noto Sans Thai', Arial, sans-serif;
        }
        .form-group input:focus {
             border-color: #00796B;
             outline: none;
             box-shadow: 0 0 6px rgba(0, 121, 107, 0.3);
        }

        .register-button {
    		width: 100%;
    		padding: 12px;
    		font-size: 18px;
    		background-color: #00796B;
    		color: white;
    		border: none;
    		border-radius: 6px;
    		cursor: pointer;
    		display: block;
    		margin: 20px auto 0;
            font-family: 'Noto Sans Thai', Arial, sans-serif;
            font-weight: bold;
            transition: background-color 0.2s;
		}
        .register-button:hover { background-color: #004D40; }

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
        
        .form-group input.input-error {
            border-color: #dc3545;
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
            .search-bar {
                margin-left: 0;
                margin-right: 0;
                flex-grow: 1;
            }
            .search-bar input {
                flex-grow: 1;
            }
            nav a {
                margin: 0 5px;
            }
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

<main class="register-container">
    <div class="register-form-card">
        <h2>ลงทะเบียน</h2>

        <c:if test="${not empty successMessage}">
            <div class="alert alert-success"><c:out value="${successMessage}"/></div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
             <div class="alert alert-danger"><c:out value="${errorMessage}"/></div>
        </c:if>
        
        <form action="<c:url value='/Register1'/>" method="post" id="register-form" novalidate>
            <div class="form-group">
                <label for="firstname">ชื่อ *</label>
                <input type="text" id="firstname" name="firstname" required value="<c:out value="${Register1.firstname}"/>">
            </div>
            <div class="form-group">
                <label for="lastname">นามสกุล *</label>
                <input type="text" id="lastname" name="lastname" required value="<c:out value="${Register1.lastname}"/>">
            </div>
            <div class="form-group">
                <label for="email">อีเมล *</label>
                <input type="email" id="email" name="email" required value="<c:out value="${Register1.email}"/>">
            </div>
            <div class="form-group">
                <label for="phone">เบอร์โทรศัพท์ *</label>
                <input type="text" id="phone" name="phone" pattern="[0-9]{10,15}" required value="<c:out value="${Register1.phone}"/>">
            </div>
            <div class="form-group">
                <label for="username">ชื่อผู้ใช้ *</label>
                <input type="text" id="username" name="username" required value="<c:out value="${Register1.username}"/>">
            </div>
            <div class="form-group">
                <label for="password">รหัสผ่าน *</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="register-button">ลงทะเบียน</button>
        </form>
    </div>
</main>

<footer class="footer"></footer>


<div class="modal-overlay" id="validationModal" style="display: none;">
    <div class="modal-content">
        <h3>ข้อมูลไม่ครบถ้วน</h3>
        <div id="modal-message">กรุณากรอกข้อมูลในช่องที่มีเครื่องหมาย * ให้ครบถ้วน</div>
        <button class="modal-close-btn" id="modal-close-btn">เข้าใจแล้ว</button>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    
    const form = document.getElementById('register-form');
    const modal = document.getElementById('validationModal');
    const modalMessage = document.getElementById('modal-message');
    const closeModalBtn = document.getElementById('modal-close-btn');

    if (form && modal && modalMessage && closeModalBtn) {
        
        form.addEventListener('submit', function(event) {
            let errors = [];
            form.querySelectorAll('.input-error').forEach(el => el.classList.remove('input-error'));
            const requiredInputs = form.querySelectorAll('input[required]');
            requiredInputs.forEach(input => {
                if (input.value.trim() === '') {
                    errors.push(input.id);
                    input.classList.add('input-error');
                }
            });

            if (errors.length > 0) {
                event.preventDefault();
                modalMessage.innerHTML = 'กรุณากรอกข้อมูลในช่องที่มีเครื่องหมาย * ให้ครบถ้วน'; 
                
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
        
        form.querySelectorAll('input[required]').forEach(field => {
            field.addEventListener('input', () => {
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
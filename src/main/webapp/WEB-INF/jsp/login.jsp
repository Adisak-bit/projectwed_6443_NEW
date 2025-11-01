<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <title>เข้าสู่ระบบ</title>
    
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
        .search-bar button:hover {
            background-color: #004D40;
        }

        nav a {
            background-color: #00796B;
            color: white;
            padding: 10px 16px;
            border-radius: 10px;
            margin-left: 10px;
            text-decoration: none;
            font-weight: bold;
            font-family: 'Noto Sans Thai', Arial, sans-serif;
            transition: background-color 0.2s;
        }
        nav a:hover {
             background-color: #004D40;
        }

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

        .forgot-password {
            margin-top: 15px;
            text-align: right;
            font-size: 14px;
        }
        .forgot-password a {
            color: #007bff;
            text-decoration: none;
        }
        .forgot-password a:hover {
            text-decoration: underline;
        }

        .admin-link {
            position: absolute;
            bottom: 15px;
            right: 15px;
            font-size: 14px;
            color: #6D4C41;
            text-decoration: underline;
            cursor: pointer;
        }
         .admin-link:hover {
             color: #4E342E;
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
            nav {
            
            }
            nav a {
                margin: 0 5px;
            }
            .menu-toggle { display: none; }
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
            <h2>เข้าสู่ระบบ</h2>
            <c:if test="${not empty param.error}">
                <div style="color:red; margin-bottom: 20px; font-weight:bold;">
                    ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง
                </div>
            </c:if>
            <c:if test="${not empty loginRequiredMessage}">
                 <div style="color:blue; margin-bottom: 20px; font-weight:bold;">
                    <c:out value="${loginRequiredMessage}"/>
                </div>
            </c:if>
            
            <form action="loginUser" method="POST" id="login-form" novalidate>
                <div class="form-group">
                    <label for="email">ชื่อผู้ใช้ / อีเมล *</label>
                    <input type="text" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="password">รหัสผ่าน *</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <button type="submit" class="login-button">เข้าสู่ระบบ</button>
                <a href="${pageContext.request.contextPath}/login-admin" class="admin-link">เข้าสู่ระบบสำหรับผู้ดูแล</a>
           </form>
           
        </div>
    </main>

    <footer class="footer"></footer>

    <div class="modal-overlay" id="validationModal" style="display: none;">
        <div class="modal-content">
            <h3>ข้อมูลไม่ครบถ้วน</h3>
            <div id="modal-message">กรุณากรอกข้อมูลให้ครบถ้วน</div>
            <button class="modal-close-btn" id="modal-close-btn">เข้าใจแล้ว</button>
        </div>
    </div>
    
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        
        const form = document.getElementById('login-form');
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
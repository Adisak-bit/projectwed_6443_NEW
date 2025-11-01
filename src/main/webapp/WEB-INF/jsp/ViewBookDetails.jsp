<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <title><c:out value="${not empty book ? book.book_title : 'รายละเอียดหนังสือ'}"/></title>

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
            flex-grow: 1; 
            display: flex; 
            justify-content: center; 
        }
        
        .navbar { 
            background-color: #4E342E; 
            padding: 10px 20px; 
            display: flex; 
            align-items: center; 
            gap: 15px;
            border-bottom: none; 
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
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

        .profile-and-menu { display: flex; align-items: center; gap: 5px; }
        .admin-menu { position: relative; }
        .admin-info { display: flex; align-items: center; gap: 10px; font-weight: bold; color: #fff; } 
        .admin-info img { width: 30px; height: 30px; border-radius: 50%; padding: 0px; margin-right: -5px;}
        .admin-menu-toggle { 
            background: none; border: none; font-size: 24px; 
            color: #FFFFFF; 
            cursor: pointer; padding: 5px; 
        }
        .admin-dropdown { 
            display: none; position: absolute; background-color: #fff; 
            box-shadow: 0 4px 12px rgba(0,0,0,0.15); z-index: 10; 
            right: 0; top: 100%; margin-top: 10px; 
            border-radius: 10px; overflow: hidden; border: 1px solid #eee; 
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
        
        .profile-container { display: flex; gap: 30px; margin-top: 25px; justify-content: center; }
        .content-card { flex-grow: 1; max-width: 900px; background-color: #FFFFFF; margin-top: 0; padding: 30px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); width: 100%; display: flex; flex-direction: column; gap: 20px; }
        .admin-sidebar { flex-shrink: 0; width: 230px; }
        .admin-sidebar-menu { list-style: none; padding: 0; margin: 0; background-color: #fff; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); overflow: hidden; }
        .admin-sidebar-menu .menu-title { padding: 15px 20px; font-weight: bold; color: #fff; background-color: #00796B; font-size: 1.1em; font-family: 'Merriweather', serif; }
        .admin-sidebar-menu .menu-content { padding: 20px; }
        .admin-sidebar-menu .form-group { margin-bottom: 15px; }
        .admin-sidebar-menu .form-group label { display: block; margin-bottom: 8px; font-weight: bold; color: #555; font-size: 0.9em; }
        .admin-sidebar-menu .form-group select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box; font-size: 0.9em; font-family: 'Noto Sans Thai', Arial, sans-serif; }
        .admin-sidebar-menu .submit-button { background-color: #00796B; color: white; padding: 10px 15px; border: none; border-radius: 5px; cursor: pointer; font-size: 0.9em; width: 100%; font-weight: bold; font-family: 'Noto Sans Thai', Arial, sans-serif; transition: background-color 0.2s; }
        .admin-sidebar-menu .submit-button:hover { background-color: #004D40; }
        .alert { padding: 10px 15px; margin-bottom: 20px; border: 1px solid transparent; border-radius: 4px; text-align: center; font-weight: bold; }
        .alert-success { color: #155724; background-color: #d4edda; border-color: #c3e6cb; }
        .alert-danger { color: #721c24; background-color: #f8d7da; border-color: #f5c6cb; }
        .book-header { display: flex; gap: 30px; }
        .book-cover img { width: 200px; height: auto; object-fit: cover; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
        .book-info { display: flex; flex-direction: column; justify-content: flex-start; flex-grow: 1;}
        .book-info h1 { font-family: 'Merriweather', serif; color: #5a3c2c; margin: 0 0 10px; font-size: 2.2em; }
        .book-info p { margin: 5px 0; color: #555; }
        .book-info .author-info { color: #333; font-weight: bold; margin-bottom: 10px;}
        .rating { margin-top: 10px; font-size: 1.2em; color: #ffc107; }
        .rating span { color: #333; font-size: 0.8em; margin-left: 5px; }
        .book-actions { margin-top: 20px; display: flex; gap: 15px; flex-wrap: wrap;}
        .book-actions a, .book-actions button { padding: 12px 25px; border: none; border-radius: 8px; cursor: pointer; font-size: 1em; font-weight: bold; text-decoration: none; display: inline-flex; align-items: center; gap: 8px; transition: background-color 0.2s; font-family: 'Noto Sans Thai', Arial, sans-serif; }
        .read-button { background-color: #00796B; color: white; } 
        .read-button:hover { background-color: #004D40; } 
        .read-button.disabled { background-color: #aaa; cursor: not-allowed; }
        .favorite-button { background-color: #A1887F; color: white; } 
        .favorite-button:hover { background-color: #6D4C41; } 
        .favorite-button.remove { background-color: #dc3545; } 
        .favorite-button.remove:hover { background-color: #c82333; }
        .book-description { margin-top: 30px; }
        .book-description h2, .comment-section h2, .comment-form-container h3 { font-family: 'Merriweather', serif; color: #5a3c2c; border-bottom: 2px solid #E0E0E0; padding-bottom: 5px; margin-bottom: 15px; }
        .comment-form-container h3 { border-bottom: none; }
        .comment-section { margin-top: 30px; }
        .comment-form-container { background-color: #F7F3E9; border: 1px solid #E0E0E0; border-radius: 8px; padding: 20px; margin-bottom: 30px; }
        .comment-form-container .form-group { margin-bottom: 15px; }
        .comment-form-container label { display: block; margin-bottom: 5px; font-weight: bold; }
        .comment-form-container textarea { width: 100%; box-sizing: border-box; padding: 10px; border: 1px solid #ccc; border-radius: 5px; resize: vertical; min-height: 80px; font-size: 1rem; font-family: 'Noto Sans Thai', Arial, sans-serif; }
        .comment-form-container .rating-input { display: flex; flex-direction: row-reverse; justify-content: flex-end; margin-bottom: 10px; }
        .comment-form-container .rating-input input[type="radio"] { display: none; }
        .comment-form-container .rating-input label { font-size: 1.5em; color: #ccc; cursor: pointer; transition: color 0.2s; margin-left: 2px; }
        .comment-form-container .rating-input input[type="radio"]:checked ~ label, .comment-form-container .rating-input label:hover, .comment-form-container .rating-input label:hover ~ label { color: #ffc107; }
        .comment-form-container .submit-comment { background-color: #00796B; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; font-size: 1em; font-weight: bold; font-family: 'Noto Sans Thai', Arial, sans-serif; transition: background-color 0.2s; }
        .comment-form-container .submit-comment:hover { background-color: #004D40; }
        .comment-list { display: flex; flex-direction: column; gap: 20px; }
        .comment-card { background-color: #F7F3E9; padding: 15px 20px; border-radius: 8px; border: 1px solid #E0E0E0; position: relative; }
        .comment-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px; padding-right: 40px; }
        .comment-header .username { font-weight: bold; color: #333; }
        .comment-header .date { font-size: 0.9em; color: #888; }
        .comment-body { line-height: 1.6; color: #555; padding-right: 30px; }
        .comment-body .rating { font-size: 1em; margin-bottom: 5px; color: #ffc107; }
        .comment-body .rating span { color: #555; font-size: 0.9em; margin-left: 5px; }
        .delete-comment-btn { position: absolute; top: 10px; right: 15px; background: none; border: none; color: #aaa; font-size: 1.1em; cursor: pointer; padding: 5px; z-index: 1; }
        .delete-comment-btn:hover { color: #dc3545; }
        .login-prompt { text-align: center; background: #FFF9C4; padding: 15px; border-radius: 5px; border: 1px solid #FFF176; }
        .login-prompt a { color: #00796B; font-weight: bold; }
        .footer { background-color: #4E342E; height: 60px; width: 100%; margin-top: auto; }
        
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
            .profile-container { flex-direction: column-reverse; } 
            .admin-sidebar { width: 100%; margin-bottom: 20px;} 
            .book-header { flex-direction: column; align-items: center; text-align: center;} 
            .book-actions { justify-content: center; } 
            
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
                margin-top: 10px;
                width: 100%;
                justify-content: flex-end; 
            }
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
                        <a href="<c:url value='/searchbook?categoryId=${cat.category_id}'/>"><c:out value="${cat.category_name}"/></a>
                    </c:forEach>
                </div>
            </div>
            <input type="text" name="query" placeholder="ค้นหาชื่อเรื่อง, ผู้แต่ง..." value="<c:out value="${searchQuery}"/>">
            <button type="submit">ค้นหา</button>
        </form>
        
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
                               <div class="desktop-menu">
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
                               </div>
                          </c:when>
                          <c:otherwise>
                               <div class="desktop-menu">
                                    <a href="<c:url value='/login'/>">เข้าสู่ระบบ</a>
                                    <a href="<c:url value='/register'/>">ลงทะเบียน</a>
                               </div>
                          </c:otherwise>
                     </c:choose>
                 </c:otherwise>
            </c:choose>
            <div id="menu-links" class="menu-links">
            </div>
        </nav>
    </header>

    <div class="container profile-container">
        
        <main class="content-card">
            <c:choose>
                <c:when test="${not empty book}">
                
                    <c:if test="${not empty successMessage}"><div class="alert alert-success"><c:out value="${successMessage}"/></div></c:if>
                    <c:if test="${not empty errorMessage}"><div class="alert alert-danger"><c:out value="${errorMessage}"/></div></c:if>
            
                    <div class="book-header">
                        <div class="book-cover">
                            <img src="<c:url value='/assets/images/covers/${book.cover_image}'/>"
                                 alt="ปก <c:out value="${book.book_title}"/>"
                                 onerror="this.onerror=null; this.src='<c:url value="/assets/images/placeholder.png"/>';">
                        </div>
                        <div class="book-info">
                            <h1><c:out value="${book.book_title}"/></h1>
                            <p class="author-info">ผู้เขียน: <c:out value="${book.author}"/></p>
                            <p>สำนักพิมพ์: <c:out value="${book.publisher}"/></p>
                            <p>หมวดหมู่: <c:out value="${book.category.category_name}"/></p>
                            <p>ปีที่พิมพ์: ${book.published_year}</p>
                            
                            <div class="rating">
                                <c:choose>
                                    <c:when test="${totalRatings > 0}">
                                        <c:forEach var="i" begin="1" end="5">
                                            <c:choose>
                                                <c:when test="${i <= averageRating}"><i class="fas fa-star"></i></c:when>
                                                <c:when test="${i - 0.5 == averageRating}"><i class="fas fa-star-half-alt"></i></c:when>
                                                <c:otherwise><i class="far fa-star"></i></c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        <span>(<fmt:formatNumber value="${averageRating}" maxFractionDigits="1"/> จาก ${totalRatings} รีวิว)</span>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach begin="1" end="5"><i class="far fa-star"></i></c:forEach> 
                                        <span>(ยังไม่มีข้อมูล)</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                            <div class="book-actions">
                                <c:choose>
                                    <c:when test="${not empty book.PDF_file}">
                                        <a href="<c:url value='/readBook/${book.id}'/>" target="_blank" class="read-button">
                                            <i class="fas fa-book-open"></i> อ่านหนังสือ
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="read-button disabled" disabled>ไม่มีไฟล์ให้อ่าน</button>
                                    </c:otherwise>
                                </c:choose>
                                
                                <c:if test="${not empty sessionScope.member}">
                                    <c:choose>
                                        <c:when test="${isFavorite}">
                                            <a href="<c:url value='/removeFavorite/${book.id}'/>" class="favorite-button remove">
                                                <i class="fas fa-trash-alt"></i> ลบจากรายการโปรด
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="<c:url value='/addFavorite/${book.id}'/>" class="favorite-button">
                                                <i class="fas fa-heart"></i> เพิ่มรายการโปรด
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <div class="book-description">
                        <h2>รายละเอียด</h2>
                        <p><c:out value="${book.description}"/></p>
                    </div>

                    <div class="comment-section">
                        <h2>ความคิดเห็น</h2>
                        
                        <c:if test="${not empty sessionScope.member}">
                           <div class="comment-form-container">
                                <h3>แสดงความคิดเห็นของคุณ</h3>
                                <form action="<c:url value='/saveComment'/>" method="post">
                                    <input type="hidden" name="book_id" value="${book.id}">
                                    <div class="form-group">
                                        <label>ให้คะแนน (Rating):</label>
                                        <div class="rating-input">
                                            <input type="radio" id="star5" name="rating" value="5" required><label for="star5" title="5 ดาว"><i class="fas fa-star"></i></label>
                                            <input type="radio" id="star4" name="rating" value="4" required><label for="star4" title="4 ดาว"><i class="fas fa-star"></i></label>
                                            <input type="radio" id="star3" name="rating" value="3" required><label for="star3" title="3 ดาว"><i class="fas fa-star"></i></label>
                                            <input type="radio" id="star2" name="rating" value="2" required><label for="star2" title="2 ดาว"><i class="fas fa-star"></i></label>
                                            <input type="radio" id="star1" name="rating" value="1" required><label for="star1" title="1 ดาว"><i class="fas fa-star"></i></label>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="comment_text">ความคิดเห็น:</label>
                                        <textarea id="comment_text" name="comment_text" rows="4" required></textarea>
                                    </div>
                                    <button type="submit" class="submit-comment">ส่งความคิดเห็น</button>
                                </form>
                            </div>
                        </c:if>
                        <c:if test="${empty sessionScope.member && empty sessionScope.admin}">
                            <p class="login-prompt">
                                <a href="<c:url value='/login'/>">เข้าสู่ระบบ</a> เพื่อแสดงความคิดเห็น
                            </p>
                        </c:if>

                        <div class="comment-list">
                            <c:choose>
                                <c:when test="${not empty commentList}">
                                    <c:forEach var="comment" items="${commentList}">
                                        <div class="comment-card">
                                            <div class="comment-header">
                                                <span class="username"><i class="fas fa-user"></i> <c:out value="${comment.member.username}"/></span>
                                                <span class="date"><fmt:formatDate value="${comment.timestamp}" pattern="dd/MM/yyyy HH:mm" /></span>
                                            </div>
                                            <div class="comment-body">
                                                <div class="rating">
                                                    <c:forEach begin="1" end="${comment.rating}"><i class="fas fa-star"></i></c:forEach>
                                                    <c:forEach begin="1" end="${5 - comment.rating}"><i class="far fa-star"></i></c:forEach>
                                                    <span>(${comment.rating}/5)</span>
                                                </div>
                                                <p><c:out value="${comment.comment_text}"/></p>
                                            </div>
                                            
                                            <c:if test="${(not empty sessionScope.admin) or (not empty sessionScope.member and sessionScope.member.id == comment.member.id)}">
                                                <a href="<c:url value='/deleteComment/${comment.comment_id}'/>" 
                                                   class="delete-comment-btn js-delete-confirm" 
                                                   title="ลบคอมเมนต์">
                                                    <i class="fas fa-trash-alt"></i>
                                                </a>
                                            </c:if>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <p style="text-align: center;"><i>ยังไม่มีความคิดเห็นสำหรับหนังสือเล่มนี้</i></p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                     <div style="text-align: center; padding: 50px; background: #fff; border-radius: 10px; margin: auto;">
                         <h2>ไม่พบข้อมูลหนังสือ</h2>
                         <p>ขออภัย ไม่พบข้อมูลหนังสือที่คุณต้องการ</p>
                         <a href="<c:url value='/searchbook'/>">กลับไปหน้าค้นหา</a>
                     </div>
                </c:otherwise>
            </c:choose>
        </main>
        
        <c:if test="${not empty sessionScope.admin}">
            <aside class="admin-sidebar">
                <ul class="admin-sidebar-menu">
                    <li class="menu-title">ตั้งค่าหนังสือ (Admin)</li>
                    <li class="menu-content">
                        <form action="<c:url value='/updateBookStatus'/>" method="post">
                            <input type="hidden" name="bookId" value="${book.id}">
                            <div class="form-group">
                                <label for="accesslevel">สถานะการเข้าถึง:</label>
                                <select name="accesslevel" id="accesslevel" class="form-control">
                                    <option value="public" <c:if test="${book.accesslevel == 'public'}">selected</c:if>>
                                        ทั่วไป (Public)
                                    </option>
                                    <option value="member" <c:if test="${book.accesslevel == 'member'}">selected</c:if>>
                                        สมาชิก (Member)
                                    </option>
                                </select>
                            </div>
                            <button type="submit" class="submit-button">บันทึก</button>
                        </form>
                    </li>
                </ul>
            </aside>
        </c:if>
    </div>

    <div class="modal-overlay" id="deleteConfirmModal" style="display: none;">
        <div class="modal-content">
            <h3>ยืนยันการลบ</h3>
            <p>คุณแน่ใจหรือไม่ว่าต้องการลบคอมเมนต์นี้?</p>
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
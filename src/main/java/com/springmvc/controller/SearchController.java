package com.springmvc.controller;

import java.util.List;
import java.util.stream.Collectors;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.model.Book;
import com.springmvc.model.BookManager;
import com.springmvc.model.Category;
import com.springmvc.model.CategoryManager;
import com.springmvc.model.Comment;
import com.springmvc.model.CommentManager;
import com.springmvc.model.FavoriteBookManager;
import com.springmvc.model.HistoryBookManager;
import com.springmvc.model.Member;
import com.springmvc.model.Librarian;
import jakarta.servlet.http.HttpSession;

@Controller
public class SearchController {
    private static final String SECURE_PDF_PATH = "D:/Users/User/OneDrive - Maejo university/Desktop/MiniProject_6443/secure_member_books/"; 
    //เมธอดสำหรับหน้าค้นหา / หน้าหลักสมาชิก
    @GetMapping({"/searchbook", "/"})
    public String searchBookPage(
            Model model, 
            HttpSession session,
            @RequestParam(name = "query", required = false) String query,
            @RequestParam(name = "categoryId", required = false) Integer categoryId
        ) {
    	
        Member loggedInMember = (Member) session.getAttribute("member");
        Librarian loggedInAdmin = (Librarian) session.getAttribute("admin"); 
        model.addAttribute("loggedInMember", loggedInMember);
        model.addAttribute("loggedInAdmin", loggedInAdmin); 

        BookManager bookManager = new BookManager();
        List<Book> allBooks = bookManager.getAllBooks();
        List<Book> filteredBooks = allBooks; 
        if (categoryId != null && categoryId > 0) {
            filteredBooks = filteredBooks.stream()
                .filter(book -> book.getCategory() != null && book.getCategory().getCategory_id() == categoryId)
                .collect(Collectors.toList());
            model.addAttribute("selectedCategoryId", categoryId);
        }
        if (query != null && !query.isEmpty()) {
            String searchQuery = query.toLowerCase().trim();
            filteredBooks = filteredBooks.stream()
                .filter(book -> 
                    (book.getBook_title() != null && book.getBook_title().toLowerCase().contains(searchQuery)) ||
                    (book.getAuthor() != null && book.getAuthor().toLowerCase().contains(searchQuery))
                )
                .collect(Collectors.toList());
            model.addAttribute("searchQuery", query);
        }

        CategoryManager catManager = new CategoryManager();
        List<Category> categories = catManager.getAllCategories();
        model.addAttribute("categories", categories);
        model.addAttribute("bookList", filteredBooks);

        return "searchbook";
    }

    //เมธอดสำหรับ View Details
    @GetMapping("/viewBookDetails/{id}")
    public String viewBookDetailsPage(
            @PathVariable("id") int bookId,
            Model model,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        BookManager bookManager = new BookManager();
        Book book = bookManager.getBookById(bookId);
        if (book == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "ไม่พบข้อมูลหนังสือ ID: " + bookId);
            if (session.getAttribute("admin") != null) {
                 return "redirect:/adminHome";
            } else {
                 return "redirect:/searchbook";
            }
        }

        Member loggedInMember = (Member) session.getAttribute("member");
        Librarian loggedInAdmin = (Librarian) session.getAttribute("admin");

        String accessLevel = book.getAccesslevel();
        boolean canAccess = false;
        if (loggedInAdmin != null) { canAccess = true; }
        else if ("public".equalsIgnoreCase(accessLevel)) { canAccess = true; }
        else if ("member".equalsIgnoreCase(accessLevel)) {
            if (loggedInMember != null) { canAccess = true; } 
            else {
                 canAccess = false;
                 redirectAttributes.addFlashAttribute("loginRequiredMessage", "หนังสือเล่มนี้สำหรับสมาชิก กรุณาเข้าสู่ระบบก่อน");
                 return "redirect:/login";
            }
        } else {
             System.err.println("Warning: Book ID " + bookId + " has unknown or null access level: " + accessLevel);
             canAccess = false;
             redirectAttributes.addFlashAttribute("errorMessage", "ไม่สามารถระบุสิทธิ์การเข้าถึงหนังสือเล่มนี้ได้");
             if (session.getAttribute("admin") != null) return "redirect:/adminHome";
             else return "redirect:/searchbook";
        }
        if (!canAccess) {
             redirectAttributes.addFlashAttribute("errorMessage", "คุณไม่มีสิทธิ์เข้าถึงหนังสือเล่มนี้");
             if (session.getAttribute("admin") != null) return "redirect:/adminHome";
             else return "redirect:/searchbook";
        }

        boolean isFavorite = false;
        if (loggedInMember != null) {
            FavoriteBookManager favManager = new FavoriteBookManager();
            isFavorite = favManager.isBookFavorite(loggedInMember.getId(), bookId);
        }
        model.addAttribute("isFavorite", isFavorite);
        
        CommentManager commentManager = new CommentManager();
        List<Comment> commentList = commentManager.getCommentsByBookId(bookId);
        model.addAttribute("commentList", commentList);
        
        double averageRatingRaw = 0.0;
        double averageRatingRounded = 0.0;
        int totalRatings = commentList.size(); 

        if (totalRatings > 0) {
             averageRatingRaw = commentList.stream()
                                  .mapToDouble(c -> Double.parseDouble(c.getRating()))
                                  .average()
                                  .orElse(0.0);
            averageRatingRounded = Math.round(averageRatingRaw * 2) / 2.0;
        }
        System.out.println("--- Debug Rating (SearchController) ---");
        System.out.println("Total Ratings: " + totalRatings);
        System.out.println("Average Rating (Raw): " + averageRatingRaw);
        System.out.println("Average Rating (Rounded): " + averageRatingRounded);
        System.out.println("---------------------------------------");
        model.addAttribute("averageRating", averageRatingRounded);
        model.addAttribute("totalRatings", totalRatings);

        CategoryManager catManager = new CategoryManager();
        List<Category> categories = catManager.getAllCategories();
        model.addAttribute("categories", categories);
        
        model.addAttribute("book", book);
        return "ViewBookDetails";
    }

    @GetMapping("/readBook/{id}")
    public ResponseEntity<Object> readBook(
            @PathVariable("id") int bookId, 
            HttpSession session, 
            RedirectAttributes redirectAttributes,
            HttpServletResponse httpResponse) throws IOException { 
        
        String contextPath = session.getServletContext().getContextPath();
        Member loggedInMember = (Member) session.getAttribute("member");
        Librarian loggedInAdmin = (Librarian) session.getAttribute("admin");
        BookManager bookManager = new BookManager();
        Book book = bookManager.getBookById(bookId);
        if (book == null || book.getPDF_file() == null || book.getPDF_file().isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "ไม่พบข้อมูลหนังสือหรือไฟล์ PDF");
            httpResponse.sendRedirect( contextPath + (session.getAttribute("admin") != null ? "/adminHome" : "/searchbook") );
            return null; 
        }

        String accessLevel = book.getAccesslevel();
        String pdfFileName = book.getPDF_file();
        if ("public".equalsIgnoreCase(accessLevel)) {
            if (loggedInMember != null) {
                HistoryBookManager historyManager = new HistoryBookManager();
                historyManager.addHistory(loggedInMember.getId(), bookId);
            }
            
            try {
                String encodedPdfFileName = URLEncoder.encode(pdfFileName, StandardCharsets.UTF_8.toString())
                                                      .replaceAll("\\+", "%20");
                HttpHeaders headers = new HttpHeaders();
                headers.add(HttpHeaders.LOCATION, contextPath + "/assets/pdfs/" + encodedPdfFileName); 
                return new ResponseEntity<>(headers, HttpStatus.FOUND);
            } catch (Exception e) {
                e.printStackTrace();
                redirectAttributes.addFlashAttribute("errorMessage", "ไม่สามารถสร้าง URL สำหรับไฟล์ PDF ได้");
                httpResponse.sendRedirect(contextPath + "/viewBookDetails/" + bookId);
                return null;
            }
        }
        else if ("member".equalsIgnoreCase(accessLevel) || loggedInAdmin != null) {
            if (loggedInMember == null && loggedInAdmin == null) {
                 redirectAttributes.addFlashAttribute("loginRequiredMessage", "หนังสือเล่มนี้สำหรับสมาชิก กรุณาเข้าสู่ระบบก่อน");
                 httpResponse.sendRedirect(contextPath + "/login");
                 return null; 
            }
            if (loggedInMember != null) {
                HistoryBookManager historyManager = new HistoryBookManager();
                historyManager.addHistory(loggedInMember.getId(), bookId);
            }
            try {
                File file = new File(SECURE_PDF_PATH + pdfFileName);

                if (!file.exists()) {
                    System.err.println("File not found at: " + SECURE_PDF_PATH + pdfFileName);
                    redirectAttributes.addFlashAttribute("errorMessage", "ขออภัย, ไม่พบไฟล์ PDF บนเซิร์ฟเวอร์ (Secure)");
                    httpResponse.sendRedirect(contextPath + "/viewBookDetails/" + bookId);
                    return null;
                }

                InputStreamResource resource = new InputStreamResource(new FileInputStream(file));
                HttpHeaders headers = new HttpHeaders();
                
                String encodedFileName = URLEncoder.encode(pdfFileName, StandardCharsets.UTF_8.toString()).replaceAll("\\+", "%20");
                headers.add(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + encodedFileName + "\"; filename*=UTF-8''" + encodedFileName);

                return ResponseEntity.ok()
                        .headers(headers)
                        .contentLength(file.length())
                        .contentType(MediaType.APPLICATION_PDF)
                        .body(resource);

            } catch (Exception e) {
                e.printStackTrace();
                redirectAttributes.addFlashAttribute("errorMessage", "เกิดข้อผิดพลาดในการอ่านไฟล์: " + e.getMessage());
                httpResponse.sendRedirect(contextPath + "/viewBookDetails/" + bookId);
                return null;
            }
        }
        else {
             redirectAttributes.addFlashAttribute("errorMessage", "คุณไม่มีสิทธิ์เข้าถึงหนังสือเล่มนี้ (Unknown Access Level)");
             httpResponse.sendRedirect( contextPath + (session.getAttribute("admin") != null ? "/adminHome" : "/searchbook") );
             return null;
        }
    }
}
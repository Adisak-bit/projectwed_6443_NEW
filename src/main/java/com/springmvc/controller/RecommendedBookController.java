package com.springmvc.controller;

import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable; // <<< Import เพิ่ม
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.model.Book;
import com.springmvc.model.BookManager;
import com.springmvc.model.Category;
import com.springmvc.model.CategoryManager;
import com.springmvc.model.Librarian; // <<< Import เพิ่ม
import com.springmvc.model.Member;
import com.springmvc.model.RecommendedBook;
import com.springmvc.model.RecommendedBookManager;
import jakarta.servlet.http.HttpSession;

@Controller
public class RecommendedBookController {

    // 1. เมธอดสำหรับแสดงหน้าฟอร์ม "แนะนำหนังสือ" (GET)
    @GetMapping("/recommendBookForm")
    public String showRecommendForm(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        
        Member loggedInMember = (Member) session.getAttribute("member");
        if (loggedInMember == null) {
            redirectAttributes.addFlashAttribute("loginRequiredMessage", "กรุณาเข้าสู่ระบบก่อนแนะนำหนังสือ");
            return "redirect:/login";
        }

        BookManager bookManager = new BookManager();
        List<Book> allBooks = bookManager.getAllBooks();
        model.addAttribute("allBooks", allBooks);

        CategoryManager catManager = new CategoryManager();
        List<Category> categories = catManager.getAllCategories();
        model.addAttribute("categories", categories);

        model.addAttribute("loggedInMember", loggedInMember);

        return "RecommendBookForm";
    }

    // 2. เมธอดสำหรับรับข้อมูลจากฟอร์ม (POST)
    @PostMapping("/saveRecommendation")
    public String saveRecommendation(
            @RequestParam("book_id") int bookId,
            @RequestParam("recommendation_reason") String reason,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Member loggedInMember = (Member) session.getAttribute("member");
        if (loggedInMember == null) {
            return "redirect:/login";
        }
        
        Book book = new Book();
        book.setId(bookId);
        Member member = new Member();
        member.setId(loggedInMember.getId());
        
        RecommendedBook recommendation = new RecommendedBook();
        recommendation.setBook(book);
        recommendation.setMember(member);
        recommendation.setRecommendation_reason(reason);

        RecommendedBookManager manager = new RecommendedBookManager();
        manager.saveRecommendation(recommendation);

        redirectAttributes.addFlashAttribute("successMessage", "ขอบคุณสำหรับการแนะนำหนังสือ!");
        return "redirect:/recommendBookForm"; 
    }

    // 3. เมธอดสำหรับแสดงหน้ารายการที่แนะนำ (GET)
    @GetMapping("/listRecommendedBooks")
    public String showRecommendedList(Model model, HttpSession session) {
        
        System.out.println("\n--- Loading ListRecommendedBooks ---");
        
        model.addAttribute("loggedInMember", session.getAttribute("member"));
        model.addAttribute("loggedInAdmin", session.getAttribute("admin"));

        CategoryManager catManager = new CategoryManager();
        List<Category> categories = catManager.getAllCategories();
        model.addAttribute("categories", categories);

        RecommendedBookManager manager = new RecommendedBookManager();
        List<RecommendedBook> recommendationList = manager.getAllRecommendations();
        System.out.println("Recommendations found: " + recommendationList.size()); 
        model.addAttribute("recommendationList", recommendationList);
        
        return "ListRecommendedBooks";
    }
    /**
     * ลบรายการแนะนำหนังสือ (สำหรับ Admin หรือเจ้าของ)
     * @param recommendationId ID ของ "รายการแนะนำ" ที่จะลบ
     */
    @GetMapping("/deleteRecommendation/{id}")
    public String deleteRecommendation(
            @PathVariable("id") int recommendationId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Member loggedInMember = (Member) session.getAttribute("member");
        Librarian loggedInAdmin = (Librarian) session.getAttribute("admin");
        if (loggedInMember == null && loggedInAdmin == null) {
            redirectAttributes.addFlashAttribute("loginRequiredMessage", "กรุณาเข้าสู่ระบบ");
            return "redirect:/login";
        }
        RecommendedBookManager manager = new RecommendedBookManager();
        RecommendedBook recommendation = manager.getRecommendationById(recommendationId);
        if (recommendation == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "ไม่พบข้อมูลที่ต้องการลบ");
            return "redirect:/listRecommendedBooks";
        }
        boolean canDelete = false;
        if (loggedInAdmin != null) {
            canDelete = true;
        } else if (loggedInMember != null && loggedInMember.getId() == recommendation.getMember().getId()) {
            canDelete = true;
        }
        if (canDelete) {
            manager.deleteRecommendation(recommendationId);
            redirectAttributes.addFlashAttribute("successMessage", "ลบรายการแนะนำเรียบร้อยแล้ว");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "คุณไม่มีสิทธิ์ลบรายการนี้");
        }

        return "redirect:/listRecommendedBooks";
    }
}
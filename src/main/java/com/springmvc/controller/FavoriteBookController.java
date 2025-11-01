package com.springmvc.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.model.Book;
import com.springmvc.model.Category;
import com.springmvc.model.CategoryManager;
import com.springmvc.model.FavoriteBookManager;
import com.springmvc.model.Member;
import jakarta.servlet.http.HttpSession;

@Controller
public class FavoriteBookController {

    /**
     * เมธอดสำหรับแสดงหน้ารายการโปรด (GET /favoriteBooks)
     */
    @GetMapping("/favoriteBooks")
    public String showFavoriteBooks(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        Member loggedInMember = (Member) session.getAttribute("member");
        if (loggedInMember == null) {
            redirectAttributes.addFlashAttribute("loginRequiredMessage", "กรุณาเข้าสู่ระบบเพื่อดูหนังสือโปรด");
            return "redirect:/login";
        }
        int memberId = loggedInMember.getId();
        System.out.println("\n----- FavoriteBookController (show) -----");
        System.out.println("Member ID from session: " + memberId);
        FavoriteBookManager favoriteBookManager = new FavoriteBookManager();
        List<Book> favoriteBookList = favoriteBookManager.getFavoriteBooksByMemberId(memberId);
        
        System.out.println("Books found by manager: " + favoriteBookList.size());
        System.out.println("--------------------------------\n");

        model.addAttribute("favoriteBookList", favoriteBookList);
        CategoryManager catManager = new CategoryManager();
        List<Category> categories = catManager.getAllCategories();
        model.addAttribute("categories", categories);
        model.addAttribute("loggedInMember", loggedInMember);

        return "ListFavoriteBooks"; 
    }

    /**
     * รับคำสั่งเพิ่มหนังสือโปรด
     * @param bookId ID ของหนังสือที่จะเพิ่ม
     * @return Redirect กลับไปหน้า ViewBookDetails
     */
    @GetMapping("/addFavorite/{id}")
    public String addFavoriteBook(@PathVariable("id") int bookId, HttpSession session, RedirectAttributes redirectAttributes) {
        
        Member loggedInMember = (Member) session.getAttribute("member");
        if (loggedInMember == null) {
            redirectAttributes.addFlashAttribute("loginRequiredMessage", "กรุณาเข้าสู่ระบบก่อน");
            return "redirect:/login";
        }
        
        FavoriteBookManager manager = new FavoriteBookManager();
        manager.addFavorite(loggedInMember.getId(), bookId);

        return "redirect:/viewBookDetails/" + bookId;
    }
    /**
     * รับคำสั่งลบหนังสือโปรด
     * @param bookId ID ของหนังสือที่จะลบ
     * @return Redirect กลับไปหน้า ViewBookDetails
     */
    @GetMapping("/removeFavorite/{id}")
    public String removeFavoriteBook(@PathVariable("id") int bookId, HttpSession session, RedirectAttributes redirectAttributes) {
        
        Member loggedInMember = (Member) session.getAttribute("member");
        if (loggedInMember == null) {
            redirectAttributes.addFlashAttribute("loginRequiredMessage", "กรุณาเข้าสู่ระบบก่อน");
            return "redirect:/login";
        }

        FavoriteBookManager manager = new FavoriteBookManager();
        manager.removeFavorite(loggedInMember.getId(), bookId);

        return "redirect:/viewBookDetails/" + bookId;
    }
}
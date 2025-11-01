package com.springmvc.controller;


import java.util.List;
import org.springframework.ui.Model;
import com.springmvc.model.Book;
import com.springmvc.model.BookManager;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.model.Librarian;
import com.springmvc.model.LibrarianManager;
import jakarta.servlet.http.HttpSession;

@Controller
public class LoginadminController {

    private LibrarianManager librarianManager = new LibrarianManager();

    @GetMapping("/login-admin")
    public String showAdminLoginPage() {
        return "login-admin";
    }

    @PostMapping("/login-admin")
    public String handleAdminLogin(@RequestParam("username") String username,
                                     @RequestParam("password") String password,
                                     HttpSession session,
                                     RedirectAttributes redirectAttributes) {

        Librarian librarian = librarianManager.loginLibrarian(username, password);

        if (librarian != null) {
            session.setAttribute("admin", librarian);
            session.setMaxInactiveInterval(30 * 60);
            return "redirect:/adminHome";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง!");
            return "redirect:/login-admin";
        }
    }

    @GetMapping("/adminHome")
    public String adminHomePage(HttpSession session, Model model) {
        if (session.getAttribute("admin") == null) {
            return "redirect:/login-admin";
        }
        
        BookManager bookManager = new BookManager();
        List<Book> bookList = bookManager.getAllBooks();
        model.addAttribute("bookList", bookList);

        return "adminHome";
    }
}
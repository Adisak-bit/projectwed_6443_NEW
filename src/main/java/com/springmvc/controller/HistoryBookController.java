package com.springmvc.controller;

import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.model.Historybooks;
import com.springmvc.model.HistoryBookManager;
import com.springmvc.model.Member;
import com.springmvc.model.Category;
import com.springmvc.model.CategoryManager;
import jakarta.servlet.http.HttpSession;

@Controller
public class HistoryBookController {

    @GetMapping("/history")
    public String showHistoryPage(HttpSession session, Model model, RedirectAttributes redirectAttributes) {

        Member loggedInMember = (Member) session.getAttribute("member");

        if (loggedInMember == null) {
            redirectAttributes.addFlashAttribute("loginRequiredMessage", "กรุณาเข้าสู่ระบบเพื่อดูประวัติการอ่าน");
            return "redirect:/login";
        }
        
        HistoryBookManager manager = new HistoryBookManager();
        List<Historybooks> historyList = manager.getHistoryByMemberId(loggedInMember.getId()); 
        model.addAttribute("historyList", historyList);
  
        CategoryManager catManager = new CategoryManager();
        List<Category> categories = catManager.getAllCategories();
        model.addAttribute("categories", categories);

        model.addAttribute("loggedInMember", loggedInMember);

        return "ListHistoryBooks";
    }
}
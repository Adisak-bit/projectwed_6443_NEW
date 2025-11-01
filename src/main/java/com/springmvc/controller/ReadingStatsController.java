package com.springmvc.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.model.Category;
import com.springmvc.model.CategoryManager;
import com.springmvc.model.HistoryBookManager;
import com.springmvc.model.Member;
import jakarta.servlet.http.HttpSession;

@Controller
public class ReadingStatsController {

    @GetMapping("/readingStats")
    public String showStatsPage(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        
        Member loggedInMember = (Member) session.getAttribute("member");
        if (loggedInMember == null) {
            redirectAttributes.addFlashAttribute("loginRequiredMessage", "กรุณาเข้าสู่ระบบเพื่อดูสถิติ");
            return "redirect:/login";
        }

        // --- ดึงข้อมูลสถิติ ---
        HistoryBookManager manager = new HistoryBookManager();
        Map<String, Long> statsMap = manager.getReadingStatsByMemberId(loggedInMember.getId());
        List<String> labels = new ArrayList<>(statsMap.keySet());
        List<Long> data = new ArrayList<>(statsMap.values());
        model.addAttribute("chartLabels", labels);
        model.addAttribute("chartData", data);     

        CategoryManager catManager = new CategoryManager();
        List<Category> categories = catManager.getAllCategories();
        model.addAttribute("categories", categories);

        model.addAttribute("loggedInMember", loggedInMember);

        return "ViewReadingStats";
    }
}
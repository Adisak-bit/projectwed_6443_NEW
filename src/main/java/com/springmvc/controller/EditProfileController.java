package com.springmvc.controller;

import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.model.Category;
import com.springmvc.model.CategoryManager;
import com.springmvc.model.Member;
import com.springmvc.model.MemberManager;
import jakarta.servlet.http.HttpSession;

@Controller
public class EditProfileController {

    // 1. เมธอดสำหรับแสดงหน้าฟอร์มแก้ไข (GET)
    @GetMapping("/editProfile")
    public String showEditProfileForm(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        Member loggedInMember = (Member) session.getAttribute("member");
        if (loggedInMember == null) {
            redirectAttributes.addFlashAttribute("loginRequiredMessage", "กรุณาเข้าสู่ระบบก่อนแก้ไขโปรไฟล์");
            return "redirect:/login";
        }
        CategoryManager catManager = new CategoryManager();
        List<Category> categories = catManager.getAllCategories();
        model.addAttribute("categories", categories);
        model.addAttribute("member", loggedInMember);

        return "editProfile";
    }

    // 2. เมธอดสำหรับรับข้อมูลที่แก้ไขแล้ว (POST)
    @PostMapping("/updateProfile")
    public String updateProfile(
            @RequestParam("id") int id, 
            @RequestParam("firstname") String firstname,
            @RequestParam("lastname") String lastname,
            @RequestParam("phone") String phone,
            @RequestParam("username") String username,
            @RequestParam("email") String email, 
            @RequestParam("password") String password,
            HttpSession session, 
            RedirectAttributes redirectAttributes) {

        Member loggedInMember = (Member) session.getAttribute("member");
        if (loggedInMember == null || loggedInMember.getId() != id) {
             redirectAttributes.addFlashAttribute("errorMessage", "เกิดข้อผิดพลาดในการอัปเดตข้อมูล");
             return "redirect:/editProfile";
        }

        MemberManager manager = new MemberManager();
        Member memberToUpdate = manager.getMemberById(id); 

        if (memberToUpdate == null) {
             redirectAttributes.addFlashAttribute("errorMessage", "ไม่พบข้อมูลสมาชิก");
             return "redirect:/editProfile";
        }
        memberToUpdate.setFirstname(firstname);
        memberToUpdate.setLastname(lastname);
        memberToUpdate.setPhone(phone);
        memberToUpdate.setUsername(username);
        manager.updateMember(memberToUpdate);
        
        session.setAttribute("member", memberToUpdate);
        redirectAttributes.addFlashAttribute("successMessage", "บันทึกข้อมูลส่วนตัวเรียบร้อยแล้ว");
        
        return "redirect:/editProfile"; 
    }
}
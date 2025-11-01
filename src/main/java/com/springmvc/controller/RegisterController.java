package com.springmvc.controller;

import com.springmvc.model.Member;
import com.springmvc.model.HibernateConnection;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.exception.ConstraintViolationException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class RegisterController {

    SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
    // 1. เมธอด GET (สำหรับแสดงฟอร์ม)
    @GetMapping("/Register1")
    public String showForm(Model model) {
        if (!model.containsAttribute("Register1")) {
            model.addAttribute("Register1", new Member());
        }
        return "Register1";
    }

    // 2. เมธอด POST (สำหรับรับข้อมูลฟอร์ม)
    @PostMapping("/Register1")
    public String submitForm(
            @ModelAttribute("Register1") Member reg,
            RedirectAttributes redirectAttributes
        ) {

        Session session = sessionFactory.openSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();
            session.save(reg);
            tx.commit();

            redirectAttributes.addFlashAttribute("successMessage", "สมัครสมาชิกเสร็จแล้ว!");

        } catch (Exception e) {
            if (tx != null) tx.rollback();

            if (e.getCause() instanceof ConstraintViolationException) {
                if(e.getCause().getMessage().contains("member.email_UNIQUE")) {
                    redirectAttributes.addFlashAttribute("errorMessage", "อีเมลนี้ถูกใช้งานแล้ว กรุณใช้อีเมลอื่น");
                } else if (e.getCause().getMessage().contains("member.username_UNIQUE")) {
                    redirectAttributes.addFlashAttribute("errorMessage", "ชื่อผู้ใช้นี้ถูกใช้งานแล้ว กรุณาใช้ชื่ออื่น");
                } else {
                    redirectAttributes.addFlashAttribute("errorMessage", "ข้อมูลไม่ถูกต้อง: " + e.getMessage());
                }
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "การลงทะเบียนล้มเหลว: " + e.getMessage());
            }
            redirectAttributes.addFlashAttribute("Register1", reg);

        } finally {
            session.close();
        }
        
        return "redirect:/Register1";
    }
}
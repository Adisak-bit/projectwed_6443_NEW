package com.springmvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.model.Member;
import com.springmvc.model.MemberManager;
import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {

    private MemberManager memberManager = new MemberManager();

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @GetMapping("/gotoregister")
    public String gotoregisterPage() {
        return "register";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    @PostMapping("/loginUser")
    public String loginUser(@RequestParam("email") String email,
                              @RequestParam("password") String password,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {

        Member member = memberManager.login(email, password);

        if (member != null) {
            session.setAttribute("member", member);
            session.setMaxInactiveInterval(15 * 60);

            return "redirect:/searchbook";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "อีเมลหรือรหัสผ่านไม่ถูกต้อง!");
            return "redirect:/login";
        }
    }
}
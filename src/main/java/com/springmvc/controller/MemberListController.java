package com.springmvc.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.springmvc.model.Member;
import com.springmvc.model.MemberListManager;

@Controller
public class MemberListController {

    @RequestMapping(value = "/memberList", method = RequestMethod.GET)
    public String showMemberList(Model model) {
        MemberListManager manager = new MemberListManager();
        List<Member> memberList = manager.getAllMembers();
        model.addAttribute("memberList", memberList);

        return "memberList";
    }
}
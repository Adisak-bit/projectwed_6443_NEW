package com.springmvc.controller;

import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.model.Book;
import com.springmvc.model.Comment;
import com.springmvc.model.CommentManager;
import com.springmvc.model.Librarian;
import com.springmvc.model.Member;
import jakarta.servlet.http.HttpSession;

@Controller
public class CommentController {

    /**
     * รับข้อมูลคอมเมนต์จากฟอร์ม แล้วบันทึกลงฐานข้อมูล
     */
    @PostMapping("/saveComment")
    public String saveComment(
            @RequestParam("book_id") int bookId,
            @RequestParam("comment_text") String commentText,
            @RequestParam("rating") String rating,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Member loggedInMember = (Member) session.getAttribute("member");
        if (loggedInMember == null) {
            redirectAttributes.addFlashAttribute("loginRequiredMessage", "กรุณาเข้าสู่ระบบก่อนแสดงความคิดเห็น");
            return "redirect:/login";
        }

        Member member = new Member();
        member.setId(loggedInMember.getId());

        Book book = new Book();
        book.setId(bookId);

        Comment newComment = new Comment();
        newComment.setMember(member);
        newComment.setBook(book);
        newComment.setComment_text(commentText);
        newComment.setRating(rating);
        newComment.setTimestamp(new Date());

        CommentManager commentManager = new CommentManager();
        commentManager.saveComment(newComment);

        return "redirect:/viewBookDetails/" + bookId;
    }
    /**
     * ลบคอมเมนต์
     * @param commentId ID ของคอมเมนต์ที่จะลบ
     */
    @GetMapping("/deleteComment/{id}")
    public String deleteComment(
            @PathVariable("id") int commentId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Member loggedInMember = (Member) session.getAttribute("member");
        Librarian loggedInAdmin = (Librarian) session.getAttribute("admin");
        if (loggedInMember == null && loggedInAdmin == null) {
            redirectAttributes.addFlashAttribute("loginRequiredMessage", "กรุณาเข้าสู่ระบบ");
            return "redirect:/login";
        }
        CommentManager manager = new CommentManager();
        Comment comment = manager.getCommentById(commentId);
        if (comment == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "ไม่พบคอมเมนต์ที่ต้องการลบ");
            return "redirect:/searchbook";
        }
        int bookId = comment.getBook().getId();
        boolean canDelete = false;
        if (loggedInAdmin != null) {
            canDelete = true;
        } else if (loggedInMember != null && loggedInMember.getId() == comment.getMember().getId()) {
            canDelete = true;
        }

        if (canDelete) {
            manager.deleteComment(commentId);
            redirectAttributes.addFlashAttribute("successMessage", "ลบคอมเมนต์เรียบร้อยแล้ว");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "คุณไม่มีสิทธิ์ลบคอมเมนต์นี้");
        }

        return "redirect:/viewBookDetails/" + bookId;
    }
}
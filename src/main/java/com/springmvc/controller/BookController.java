package com.springmvc.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.model.Book;
import com.springmvc.model.BookManager;
import com.springmvc.model.Category;
import com.springmvc.model.CategoryManager;
import com.springmvc.model.Librarian;
import jakarta.servlet.http.HttpSession;

@Controller
public class BookController {

    @Autowired
    private ServletContext servletContext;

    //เมธอดสำหรับ Add Book
    @GetMapping("/addbook-form")
    public String showAddBookForm(Model model) {
        CategoryManager categoryManager = new CategoryManager();
        List<Category> categoryList = categoryManager.getAllCategories();
        model.addAttribute("categories", categoryList);
        return "addbook-form";
    }

    @PostMapping("/saveBook")
    public String saveBook(
            @RequestParam("book_title") String title,
            @RequestParam("author") String author,
            @RequestParam("published_year") int year,
            @RequestParam("publisher") String publisher,
            @RequestParam("description") String description,
            @RequestParam("category_id") int categoryId,
            @RequestParam("accesslevel") String accessLevel, // รับค่า Access Level
            @RequestParam(name = "coverImage", required = false) MultipartFile coverImageFile,
            @RequestParam(name = "pdfFile", required = false) MultipartFile pdfFile) {

        System.out.println("\n----- saveBook Method -----");
        System.out.println("Received Title: " + title);

        Book newBook = new Book();
        newBook.setBook_title(title);
        newBook.setAuthor(author);
        newBook.setPublished_year(year);
        newBook.setPublisher(publisher);
        newBook.setDescription(description);
        newBook.setAccesslevel(accessLevel);

        //จัดการไฟล์ Cover Image
        if (coverImageFile != null && !coverImageFile.isEmpty()) {
            System.out.println("Cover Image received: " + coverImageFile.getOriginalFilename());
            String coverImageName = saveFile(coverImageFile, "/assets/images/covers/");
            System.out.println("Cover Filename returned from saveFile: " + coverImageName);
            newBook.setCover_image(coverImageName);
        } else {
             System.out.println("No Cover Image received or file is empty.");
        }

        //จัดการไฟล์ PDF
        String pdfFileName = null;
        if (pdfFile != null && !pdfFile.isEmpty()) {
            System.out.println("PDF File received: " + pdfFile.getOriginalFilename() + " (Size: " + pdfFile.getSize() + " bytes)");
            pdfFileName = saveFile(pdfFile, "/assets/pdfs/");
            System.out.println("PDF Filename returned from saveFile: " + pdfFileName);
        } else {
            System.out.println("No PDF file received or file is empty.");
        }
        newBook.setPDF_file(pdfFileName);
        System.out.println("Setting PDF_file on Book object to: " + newBook.getPDF_file());

        Category category = new Category();
        category.setCategory_id(categoryId);
        newBook.setCategory(category);
        System.out.println("Setting Category ID: " + categoryId);

        BookManager bookManager = new BookManager();
        System.out.println("Calling bookManager.saveBook()...");
        bookManager.saveBook(newBook);
        System.out.println("Finished bookManager.saveBook().");

        System.out.println("----- End of saveBook -----");
        return "redirect:/adminHome";
    }

    //เมธอดเสริมสำหรับ Save File
    private String saveFile(MultipartFile file, String relativePath) {
        if (file == null || file.isEmpty()) { return null; }
        try {
            String uploadPath = servletContext.getRealPath(relativePath);
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                boolean created = uploadDir.mkdirs();
                System.out.println("Directory " + uploadPath + " created: " + created);
            }

            String fileName = file.getOriginalFilename();
            File dest = new File(uploadDir, fileName);
            System.out.println("Attempting to save file to: " + dest.getAbsolutePath());
            file.transferTo(dest);
            System.out.println("File saved successfully: " + fileName);
            return fileName;
        } catch (IOException e) {
            System.err.println("Error saving file: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    //เมธอดสำหรับ Delete Book
    @GetMapping("/deleteBook/{id}")
    public String deleteBook(@PathVariable("id") int bookId) {
        BookManager bookManager = new BookManager();
        System.out.println("Calling bookManager.deleteBook() for ID: " + bookId);
        bookManager.deleteBook(bookId);
        System.out.println("Finished bookManager.deleteBook().");
        return "redirect:/adminHome";
    }
    /*
     * อัปเดตสถานะ (Access Level) ของหนังสือ (สำหรับ Admin)
     */
    @PostMapping("/updateBookStatus")
    public String updateBookStatus(
            @RequestParam("bookId") int bookId,
            @RequestParam("accesslevel") String accessLevel,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Librarian loggedInAdmin = (Librarian) session.getAttribute("admin");
        if (loggedInAdmin == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "คุณไม่มีสิทธิ์ดำเนินการนี้");
            return "redirect:/searchbook";
        }
        BookManager bookManager = new BookManager();
        Book bookToUpdate = bookManager.getBookById(bookId);

        if (bookToUpdate == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "ไม่พบข้อมูลหนังสือ");
            return "redirect:/adminHome";
        }
        bookToUpdate.setAccesslevel(accessLevel);
        bookManager.updateBook(bookToUpdate);
        redirectAttributes.addFlashAttribute("successMessage", "อัปเดตสถานะหนังสือเรียบร้อยแล้ว");

        return "redirect:/viewBookDetails/" + bookId;
    }
}
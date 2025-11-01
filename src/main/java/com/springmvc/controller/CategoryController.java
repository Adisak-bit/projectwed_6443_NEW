package com.springmvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springmvc.model.Category;
import com.springmvc.model.CategoryManager;

@Controller
public class CategoryController {

    // 1. เมธอดสำหรับแสดงหน้าฟอร์ม "เพิ่มหมวดหมู่"
    @GetMapping("/add-category-form")
    public String showCategoryForm() {
        return "add-category-form";
    }
    
    // 2. เมธอดสำหรับรับข้อมูลจากฟอร์ม
    @PostMapping("/saveCategory")
    public String saveCategory(@RequestParam("category_name") String categoryName) {
        Category newCategory = new Category();
        newCategory.setCategory_name(categoryName);
        CategoryManager manager = new CategoryManager();
        manager.saveCategory(newCategory);
        
        return "redirect:/addbook-form"; 
    }
}
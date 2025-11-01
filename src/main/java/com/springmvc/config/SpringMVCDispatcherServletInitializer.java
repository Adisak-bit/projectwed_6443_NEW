package com.springmvc.config;

// <<< START: เพิ่ม import 2 บรรทัดนี้เข้ามา >>>
import jakarta.servlet.MultipartConfigElement;
import jakarta.servlet.ServletRegistration;
// <<< END: เพิ่ม import 2 บรรทัดนี้เข้ามา >>>

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import jakarta.servlet.Filter;

public class SpringMVCDispatcherServletInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {
    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class[0];
    }

    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[] { WebConfig.class };
    }

    @Override
    protected String[] getServletMappings() {
        return new String[] { "/" };
    }
    
    @Override
    protected jakarta.servlet.Filter[] getServletFilters() {
        CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
        characterEncodingFilter.setEncoding("UTF-8");
        characterEncodingFilter.setForceEncoding(true);
        return new Filter[] { characterEncodingFilter };
    }
    
    // <<< START: เพิ่มเมธอดนี้เข้ามาทั้งหมด >>>
    @Override
    protected void customizeRegistration(ServletRegistration.Dynamic registration) {
        // กำหนดค่าการตั้งค่าสำหรับการอัปโหลดไฟล์
        long maxFileSize = 10485760; // 10 MB: ขนาดไฟล์สูงสุดต่อไฟล์
        long maxRequestSize = 20971520; // 20 MB: ขนาดรวมของ request ทั้งหมด
        int fileSizeThreshold = 0; // ขนาดไฟล์ที่จะเก็บในหน่วยความจำก่อนเขียนลงดิสก์

        MultipartConfigElement multipartConfig = new MultipartConfigElement(
            null, maxFileSize, maxRequestSize, fileSizeThreshold);
        
        registration.setMultipartConfig(multipartConfig);
    }
    // <<< END: เพิ่มเมธอดนี้เข้ามาทั้งหมด >>>
}
package com.springmvc.model;

import java.util.ArrayList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class CategoryManager {
    private SessionFactory sessionFactory;

    public CategoryManager() {
        this.sessionFactory = HibernateConnection.doHibernateConnection();
    }

    //เมธอดเดิมสำหรับดึงข้อมูล
    public List<Category> getAllCategories() {
        Session session = null;
        try {
            session = sessionFactory.openSession();
            String hql = "FROM Category"; 
            Query<Category> query = session.createQuery(hql, Category.class);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }
    /**
     * บันทึกหมวดหมู่ใหม่ลงฐานข้อมูล
     * @param category Object หมวดหมู่ที่จะบันทึก
     */
    public void saveCategory(Category category) {
        Session session = null;
        Transaction tx = null;
        try {
            session = sessionFactory.openSession();
            tx = session.beginTransaction();
            
            session.save(category);
            
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }
}
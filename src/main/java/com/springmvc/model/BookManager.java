package com.springmvc.model;

import java.util.ArrayList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class BookManager {

    private SessionFactory sessionFactory;

    public BookManager() {
        this.sessionFactory = HibernateConnection.doHibernateConnection();
    }

    //เมธอด saveBook
    public void saveBook(Book book) {
        Session session = null;
        Transaction tx = null;
        try {
            session = sessionFactory.openSession();
            tx = session.beginTransaction();
            session.save(book);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
    }

    //เมธอด getAllBooks
    public List<Book> getAllBooks() {
        Session session = null;
        try {
            session = sessionFactory.openSession();
            String hql = "SELECT b FROM Book b JOIN FETCH b.category ORDER BY b.id DESC";
            Query<Book> query = session.createQuery(hql, Book.class);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            if (session != null) session.close();
        }
    }

    //เมธอด deleteBook
    public void deleteBook(int bookId) {
        Session session = null;
        Transaction tx = null;
        try {
            session = sessionFactory.openSession();
            tx = session.beginTransaction();
            Book bookToDelete = session.get(Book.class, bookId);
            if (bookToDelete != null) {
                session.delete(bookToDelete);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
    }

    //เมธอด getBookById
    public Book getBookById(int bookId) {
        Session session = null;
        try {
            session = sessionFactory.openSession();
            String hql = "SELECT b FROM Book b LEFT JOIN FETCH b.category WHERE b.id = :id";
            Query<Book> query = session.createQuery(hql, Book.class);
            query.setParameter("id", bookId);
            return query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) session.close();
        }
    }

    //เมธอด updateBook
    public void updateBook(Book book) {
        Session session = null;
        Transaction tx = null;
        try {
            session = sessionFactory.openSession();
            tx = session.beginTransaction();
            session.merge(book); 
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
    }
  
}
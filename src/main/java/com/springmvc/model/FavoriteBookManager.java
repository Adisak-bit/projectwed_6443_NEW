package com.springmvc.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class FavoriteBookManager {

    private SessionFactory sessionFactory;

    public FavoriteBookManager() {
        this.sessionFactory = HibernateConnection.doHibernateConnection();
    }
    
    public List<Book> getFavoriteBooksByMemberId(int memberId) {
        Session session = null;
        try {
            session = sessionFactory.openSession();
            String hql = "SELECT b FROM Favoritebook fb " +
                         "JOIN fb.book b " + 
                         "LEFT JOIN FETCH b.category " + 
                         "WHERE fb.member.id = :memberId " + 
                         "ORDER BY fb.addedDate DESC"; 
                         
            Query<Book> query = session.createQuery(hql, Book.class);
            query.setParameter("memberId", memberId);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            if (session != null) session.close();
        }
    }

    private boolean isFavorite(Session session, int memberId, int bookId) {
        String hql = "SELECT COUNT(fb) FROM Favoritebook fb WHERE fb.member.id = :memberId AND fb.book.id = :bookId";
        Query<Long> query = session.createQuery(hql, Long.class);
        query.setParameter("memberId", memberId);
        query.setParameter("bookId", bookId);
        return query.uniqueResult() > 0;
    }

    public void addFavorite(int memberId, int bookId) {
        Session session = null;
        Transaction tx = null;
        try {
            session = sessionFactory.openSession();
            tx = session.beginTransaction();
            if (!isFavorite(session, memberId, bookId)) {
                Member member = session.getReference(Member.class, memberId);
                Book book = session.getReference(Book.class, bookId);
                Favoritebook newFavorite = new Favoritebook();
                newFavorite.setMember(member);
                newFavorite.setBook(book);
                newFavorite.setAddedDate(new Date());
                session.save(newFavorite);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
    }

    public boolean isBookFavorite(int memberId, int bookId) {
        Session session = null;
        try {
            session = sessionFactory.openSession();
            return isFavorite(session, memberId, bookId); 
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public void removeFavorite(int memberId, int bookId) {
        Session session = null;
        Transaction tx = null;
        try {
            session = sessionFactory.openSession();
            tx = session.beginTransaction();
            String hql = "DELETE FROM Favoritebook fb WHERE fb.member.id = :memberId AND fb.book.id = :bookId";
            Query query = session.createQuery(hql);
            query.setParameter("memberId", memberId);
            query.setParameter("bookId", bookId);
            
            query.executeUpdate();
            
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
    }
}
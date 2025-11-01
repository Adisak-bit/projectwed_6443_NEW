package com.springmvc.model;

import java.util.ArrayList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class RecommendedBookManager {

    private SessionFactory sessionFactory;

    public RecommendedBookManager() {
        this.sessionFactory = HibernateConnection.doHibernateConnection();
    }

    public void saveRecommendation(RecommendedBook recommendation) {
        Session session = null;
        Transaction tx = null;
        try {
            session = sessionFactory.openSession();
            tx = session.beginTransaction();
            session.save(recommendation);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
    }
    
    public List<RecommendedBook> getAllRecommendations() {
        Session session = null;
        try {
            session = sessionFactory.openSession();
            String hql = "SELECT r FROM RecommendedBook r " +
                         "LEFT JOIN FETCH r.member " +
                         "LEFT JOIN FETCH r.book b " +
                         "LEFT JOIN FETCH b.category";
            
            Query<RecommendedBook> query = session.createQuery(hql, RecommendedBook.class);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            if (session != null) session.close();
        }
    }

    public RecommendedBook getRecommendationById(int recommendationId) {
        Session session = null;
        try {
            session = sessionFactory.openSession();
            String hql = "SELECT r FROM RecommendedBook r " +
                         "JOIN FETCH r.member m " +
                         "WHERE r.recommended_book_id = :recId";
            Query<RecommendedBook> query = session.createQuery(hql, RecommendedBook.class);
            query.setParameter("recId", recommendationId);
            return query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }
    
    public void deleteRecommendation(int recommendationId) {
        Session session = null;
        Transaction tx = null;
        try {
            session = sessionFactory.openSession();
            tx = session.beginTransaction();
            RecommendedBook recToDelete = session.get(RecommendedBook.class, recommendationId);
            if (recToDelete != null) {
                session.delete(recToDelete);
            }
            
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
    }
}
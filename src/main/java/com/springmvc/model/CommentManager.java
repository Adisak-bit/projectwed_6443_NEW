package com.springmvc.model;

import java.util.ArrayList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class CommentManager {

    private SessionFactory sessionFactory;

    public CommentManager() {
        this.sessionFactory = HibernateConnection.doHibernateConnection();
    }

    public void saveComment(Comment comment) {
        Session session = null;
        Transaction tx = null;
        try {
            session = sessionFactory.openSession();
            tx = session.beginTransaction();
            session.save(comment);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
    }

    public List<Comment> getCommentsByBookId(int bookId) {
        Session session = null;
        try {
            session = sessionFactory.openSession();
            
            String hql = "SELECT c FROM Comment c " +
                         "JOIN FETCH c.member m " + 
                         "WHERE c.book.id = :bookId " +
                         "ORDER BY c.timestamp DESC"; 

            Query<Comment> query = session.createQuery(hql, Comment.class);
            query.setParameter("bookId", bookId);
            
            return query.getResultList();
            
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            if (session != null) session.close();
        }
    }

    public Comment getCommentById(int commentId) {
        Session session = null;
        try {
            session = sessionFactory.openSession();
            String hql = "SELECT c FROM Comment c " +
                         "JOIN FETCH c.member m " + 
                         "WHERE c.comment_id = :commentId";
            Query<Comment> query = session.createQuery(hql, Comment.class);
            query.setParameter("commentId", commentId);
            return query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) session.close();
        }
    }

    public void deleteComment(int commentId) {
        Session session = null;
        Transaction tx = null;
        try {
            session = sessionFactory.openSession();
            tx = session.beginTransaction();
            Comment commentToDelete = session.get(Comment.class, commentId);
            if (commentToDelete != null) {
                session.delete(commentToDelete);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
    }
    
    public Double getAverageRating(int bookId) {
        Session session = null;
        try {
            session = sessionFactory.openSession();
            String hql = "SELECT AVG(CAST(c.rating AS double)) FROM Comment c " +
                         "WHERE c.book.id = :bookId";

            Query<Double> query = session.createQuery(hql, Double.class);
            query.setParameter("bookId", bookId);
            Double average = query.uniqueResult();
            
            return (average != null) ? average : 0.0; 
            
        } catch (Exception e) {
            e.printStackTrace();
            return 0.0;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }
}
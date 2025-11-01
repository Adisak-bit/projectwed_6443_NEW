package com.springmvc.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Collectors;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class HistoryBookManager {

    private SessionFactory sessionFactory;

    public HistoryBookManager() {
        this.sessionFactory = HibernateConnection.doHibernateConnection();
    }

    private Historybooks findExistingHistory(Session session, int memberId, int bookId) {
        String hql = "FROM Historybooks h WHERE h.member.id = :memberId AND h.book.id = :bookId";
        Query<Historybooks> query = session.createQuery(hql, Historybooks.class);
        query.setParameter("memberId", memberId);
        query.setParameter("bookId", bookId);
        return query.uniqueResult(); 
    }
    
    public void addHistory(int memberId, int bookId) {
        Session session = null;
        Transaction tx = null;
        try {
            session = sessionFactory.openSession();
            tx = session.beginTransaction();
            Historybooks existingHistory = findExistingHistory(session, memberId, bookId);
            if (existingHistory != null) {
                existingHistory.setLastreadDate(new Date());
                session.update(existingHistory);
            } else {
                Member member = session.getReference(Member.class, memberId);
                Book book = session.getReference(Book.class, bookId);
                Historybooks newHistory = new Historybooks();
                newHistory.setMember(member);
                newHistory.setBook(book);
                newHistory.setLastreadDate(new Date());
                
                session.save(newHistory);
            }
            
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
    }
    
    public List<Historybooks> getHistoryByMemberId(int memberId) {
        Session session = null;
        try {
            session = sessionFactory.openSession();
            String hql = "SELECT h FROM Historybooks h " +
                         "JOIN FETCH h.book b " + 
                         "LEFT JOIN FETCH b.category " + 
                         "WHERE h.member.id = :memberId " + 
                         "ORDER BY h.lastreadDate DESC"; 
                         
            Query<Historybooks> query = session.createQuery(hql, Historybooks.class);
            query.setParameter("memberId", memberId);

            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            if (session != null) session.close();
        }
    }

    public Map<String, Long> getReadingStatsByMemberId(int memberId) {
        Session session = null;
        try {
            session = sessionFactory.openSession();
            String hql = "SELECT c.category_name, COUNT(h.book) " +
                         "FROM Historybooks h " +
                         "JOIN h.book b " +
                         "JOIN b.category c " +
                         "WHERE h.member.id = :memberId " +
                         "GROUP BY c.category_name";
            
            Query<Object[]> query = session.createQuery(hql, Object[].class);
            query.setParameter("memberId", memberId);
            
            List<Object[]> results = query.getResultList();
            
            return results.stream().collect(
                Collectors.toMap(
                    row -> (String) row[0],
                    row -> (Long) row[1]
                )
            );
            
        } catch (Exception e) {
            e.printStackTrace();
            return new HashMap<>();
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }
}
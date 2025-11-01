package com.springmvc.model;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class MemberManager {

    private SessionFactory sessionFactory;

    public MemberManager() {
        this.sessionFactory = HibernateConnection.doHibernateConnection();
    }

    //เมธอด Login
    public Member login(String email, String password) {
        Session session = null;
        try {
            session = sessionFactory.openSession();
            String hql = "FROM Member m WHERE m.email = :email AND m.password = :password";
            Query<Member> query = session.createQuery(hql, Member.class);
            query.setParameter("email", email);
            query.setParameter("password", password);
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
    public Member getMemberById(int memberId) {
        Session session = null;
        try {
            session = sessionFactory.openSession();
            return session.get(Member.class, memberId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public void updateMember(Member member) {
        Session session = null;
        Transaction tx = null;
        try {
            session = sessionFactory.openSession();
            tx = session.beginTransaction();
            session.merge(member);

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
package com.springmvc.model;

import java.util.ArrayList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

public class MemberListManager {

    private SessionFactory sessionFactory;

    public MemberListManager() {
        this.sessionFactory = HibernateConnection.doHibernateConnection();
    }

    public List<Member> getAllMembers() {
        Session session = null;
        try {
            session = sessionFactory.openSession();
            String hql = "FROM Member"; 
            Query<Member> query = session.createQuery(hql, Member.class);
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
}
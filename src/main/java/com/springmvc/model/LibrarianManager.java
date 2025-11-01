package com.springmvc.model;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

public class LibrarianManager {

    private SessionFactory sessionFactory;

    public LibrarianManager() {
        this.sessionFactory = HibernateConnection.doHibernateConnection();
    }

    public Librarian loginLibrarian(String username, String password) {
        Session session = null;
        try {
            session = sessionFactory.openSession();
            
            String hql = "FROM Librarian l WHERE l.usernameLibrarian = :username";
            Query<Librarian> query = session.createQuery(hql, Librarian.class);
            query.setParameter("username", username);
            Librarian librarian = query.uniqueResult();

            if (librarian != null) {
                if (librarian.getPasswordLibrarian().equals(password)) {
                    return librarian;
                }
            }
            return null;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }
}
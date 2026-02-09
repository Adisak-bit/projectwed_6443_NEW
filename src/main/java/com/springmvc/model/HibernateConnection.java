package com.springmvc.model;

import java.util.Properties;

import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;

public class HibernateConnection {
    public static SessionFactory sessionFactory;
    static String url = "jdbc:mysql://mysql:3306/projectweb_6443?useSSL=false&useUnicode=true&characterEncoding=UTF-8&allowPublicKeyRetrieval=true"; 
    static String uname = "root";
    static String pwd = "1234";

    public static SessionFactory doHibernateConnection() {
        Properties database = new Properties();
        database.setProperty("hibernate.hbm2ddl.auto", "update"); 
        database.setProperty("hibernate.connection.driver_class", "com.mysql.cj.jdbc.Driver");
        database.setProperty("hibernate.connection.username", uname);
        database.setProperty("hibernate.connection.password", pwd);
        database.setProperty("hibernate.connection.url", url);
        database.setProperty("hibernate.dialect", "org.hibernate.dialect.MySQL5InnoDBDialect");
        
        Configuration cfg = new Configuration()
                            .setProperties(database)
                            .addPackage("model")
                            .addAnnotatedClass(Member.class)
        					.addAnnotatedClass(Book.class)
        					.addAnnotatedClass(Category.class)
        					.addAnnotatedClass(Librarian.class)
        					.addAnnotatedClass(RecommendedBook.class)
        					.addAnnotatedClass(Historybooks.class)
        					.addAnnotatedClass(Favoritebook.class)
        					.addAnnotatedClass(Comment.class);

        StandardServiceRegistryBuilder ssrb = new StandardServiceRegistryBuilder().applySettings(cfg.getProperties());
        sessionFactory = cfg.buildSessionFactory(ssrb.build());
        return sessionFactory;
    }
}

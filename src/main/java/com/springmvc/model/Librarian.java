package com.springmvc.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "librarian")
public class Librarian {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "librarian_id")
    private int librarianId;

    @Column(name = "username_Librarian")
    private String usernameLibrarian;

    @Column(name = "password_Librarian")
    private String passwordLibrarian;

    @Column(name = "name_Librarian")
    private String nameLibrarian;

    // Getters and Setters
    public int getLibrarianId() {
        return librarianId;
    }

    public void setLibrarianId(int librarianId) {
        this.librarianId = librarianId;
    }

    public String getUsernameLibrarian() {
        return usernameLibrarian;
    }

    public void setUsernameLibrarian(String usernameLibrarian) {
        this.usernameLibrarian = usernameLibrarian;
    }

    public String getPasswordLibrarian() {
        return passwordLibrarian;
    }

    public void setPasswordLibrarian(String passwordLibrarian) {
        this.passwordLibrarian = passwordLibrarian;
    }

    public String getNameLibrarian() {
        return nameLibrarian;
    }

    public void setNameLibrarian(String nameLibrarian) {
        this.nameLibrarian = nameLibrarian;
    }
}
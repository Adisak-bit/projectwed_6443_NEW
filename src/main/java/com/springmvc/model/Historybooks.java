package com.springmvc.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "historybooks")
public class Historybooks {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int history_books_id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "book_id")
    private Book book;

    @Temporal(TemporalType.TIMESTAMP)
    private Date lastreadDate;

    public int getHistory_books_id() {
        return history_books_id;
    }

    public void setHistory_books_id(int history_books_id) {
        this.history_books_id = history_books_id;
    }

    public Member getMember() {
        return member;
    }

    public void setMember(Member member) {
        this.member = member;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    public Date getLastreadDate() {
        return lastreadDate;
    }

    public void setLastreadDate(Date lastreadDate) {
        this.lastreadDate = lastreadDate;
    }
}
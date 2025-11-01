package com.springmvc.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "recommendedbook")
public class RecommendedBook  {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int recommended_book_id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "book_id")
    private Book book;

    @Column(columnDefinition = "TEXT")
    private String recommendation_reason;

    public int getRecommended_book_id() {
        return recommended_book_id;
    }

    public void setRecommended_book_id(int recommended_book_id) {
        this.recommended_book_id = recommended_book_id;
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

    public String getRecommendation_reason() {
        return recommendation_reason;
    }

    public void setRecommendation_reason(String recommendation_reason) {
        this.recommendation_reason = recommendation_reason;
    }
}

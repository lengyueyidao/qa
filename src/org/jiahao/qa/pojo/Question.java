package org.jiahao.qa.pojo;

import java.util.Date;

public class Question {
    private Integer id;

    private String title;

    private String content;

    private Integer userid;

    private Integer views;

    private Integer answers;

    private Date date;

    private Integer isover;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public Integer getViews() {
        return views;
    }

    public void setViews(Integer views) {
        this.views = views;
    }

    public Integer getAnswers() {
        return answers;
    }

    public void setAnswers(Integer answers) {
        this.answers = answers;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Integer getIsover() {
        return isover;
    }

    public void setIsover(Integer isover) {
        this.isover = isover;
    }
}
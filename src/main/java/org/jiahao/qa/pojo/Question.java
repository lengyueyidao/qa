package org.jiahao.qa.pojo;

import org.jiahao.qa.util.DateUtil;

import java.util.Date;
import java.util.List;

public class Question {
    private String id;

    private String title;

    private String content;

    private String userid;

    private Integer views;

    private Integer answers;

    private Date date;

    private Integer isover;

    private String username;

    private List<Tag> tags;

    public String getId() {
        return id;
    }

    public void setId(String id) {
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

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
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

    public String getDate() {
        return DateUtil.format(date);
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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public List<Tag> getTags() {
        return tags;
    }

    public void setTags(List<Tag> tags) {
        this.tags = tags;
    }
}
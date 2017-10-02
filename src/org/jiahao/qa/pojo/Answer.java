package org.jiahao.qa.pojo;

import java.util.Date;

public class Answer {
    private Integer id;

    private String content;

    private Integer userid;

    private Integer questionid;

    private Date date;

    private String idpath;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public Integer getQuestionid() {
        return questionid;
    }

    public void setQuestionid(Integer questionid) {
        this.questionid = questionid;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getIdpath() {
        return idpath;
    }

    public void setIdpath(String idpath) {
        this.idpath = idpath == null ? null : idpath.trim();
    }
}
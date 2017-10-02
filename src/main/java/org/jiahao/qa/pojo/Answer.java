package org.jiahao.qa.pojo;

import org.jiahao.qa.util.DateUtil;

import java.util.Date;
import java.util.List;

/**
 * 回答实体类
 */
public class Answer {

    private String id; // 回答id

    private String content; // 回答内容

    private String userid; // 回答的用户id

    private String questionid; // 问题id

    private String parentid; // 父级id

    private Date date; // 日期

    private String idpath; // id路径

    private Integer islook; // 是否已看

    private String username; // 用户名

    private List<Answer> childs; // 儿子列表

    private String title; // 问题标题

    private String parentname; // 父亲名

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public String getQuestionid() {
        return questionid;
    }

    public void setQuestionid(String questionid) {
        this.questionid = questionid;
    }

    public String getDate() {
        return DateUtil.format(date);
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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getParentid() {
        return parentid;
    }

    public void setParentid(String parentid) {
        this.parentid = parentid;
    }

    public List<Answer> getChilds() {
        return childs;
    }

    public void setChilds(List<Answer> childs) {
        this.childs = childs;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getParentname() {
        return parentname;
    }

    public void setParentname(String parentname) {
        this.parentname = parentname;
    }

    public Integer getIslook() {
        return islook;
    }

    public void setIslook(Integer islook) {
        this.islook = islook;
    }
}
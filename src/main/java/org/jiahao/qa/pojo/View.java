package org.jiahao.qa.pojo;

import java.util.Date;

/**
 * 浏览实体类
 * Created by Alvin on 2016/11/19.
 */
public class View {

    private String userid; // 用户id
    private String questionid; // 问题id
    private Date viewtime; // 浏览时间

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

    public Date getViewtime() {
        return viewtime;
    }

    public void setViewtime(Date viewtime) {
        this.viewtime = viewtime;
    }
}

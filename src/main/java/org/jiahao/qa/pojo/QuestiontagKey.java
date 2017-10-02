package org.jiahao.qa.pojo;

/**
 * 问题标签对应实体类
 */
public class QuestiontagKey {
    private String questionid; // 问题id

    private String tagid; // 标签id

    private String tagname; // 标签名

    public String getQuestionid() {
        return questionid;
    }

    public void setQuestionid(String questionid) {
        this.questionid = questionid;
    }

    public String getTagid() {
        return tagid;
    }

    public void setTagid(String tagid) {
        this.tagid = tagid;
    }

    public String getTagname() {
        return tagname;
    }

    public void setTagname(String tagname) {
        this.tagname = tagname;
    }
}
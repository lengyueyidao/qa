package org.jiahao.qa.pojo;

import org.jiahao.qa.util.DateUtil;

import java.util.Date;

/**
 * 公告实体类
 */
public class Notice {
    private String id; // 公告id

    private String content; // 公告内容

    private Date createtime; // 创建时间

    private Date updatetime; // 修改时间

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

    public String getCreatetime() {
        return DateUtil.format(createtime);
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public String getUpdatetime() {
        return DateUtil.format(updatetime);
    }

    public void setUpdatetime(Date updatetime) {
        this.updatetime = updatetime;
    }
}
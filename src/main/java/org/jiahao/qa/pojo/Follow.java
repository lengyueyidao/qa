package org.jiahao.qa.pojo;

/**
 * 关注实体类 （userid 关注了 followuserid）
 * Created by Alvin on 2016/11/3.
 */
public class Follow {

    private String userid; // 用户id

    private String followuserid; // 被关注用户id

    private String username; // 用户名

    private String followusername; // 被关注用户名

    private String description; // 描述

    private String followdescription; // 被关注描述

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getFollowuserid() {
        return followuserid;
    }

    public void setFollowuserid(String followuserid) {
        this.followuserid = followuserid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFollowusername() {
        return followusername;
    }

    public void setFollowusername(String followusername) {
        this.followusername = followusername;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getFollowdescription() {
        return followdescription;
    }

    public void setFollowdescription(String followdescription) {
        this.followdescription = followdescription;
    }
}

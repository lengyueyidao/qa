package org.jiahao.qa.pojo;

import org.jiahao.qa.util.DateUtil;

import java.util.Date;

/**
 * 用户实体类
 */
public class User {
    private String id; // 用户id

    private String usercode; // 用户帐号

    private String username; // 用户昵称

    private String password; // 用户密码

    private String sex; // 性别

    private String address; // 地址

    private String headpath; // 头像地址

    private String description; // 描述

    private Date registertime; // 注册时间

    private Date lastlogintime; // 最近登录时间

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUsercode() {
        return usercode;
    }

    public void setUsercode(String usercode) {
        this.usercode = usercode == null ? null : usercode.trim();
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getHeadpath() {
        return headpath;
    }

    public void setHeadpath(String headpath) {
        this.headpath = headpath == null ? null : headpath.trim();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    public String getRegistertime() {
        return DateUtil.format(registertime);
    }

    public void setRegistertime(Date registertime) {
        this.registertime = registertime;
    }

    public String getLastlogintime() {
        return DateUtil.format(lastlogintime);
    }

    public void setLastlogintime(Date lastlogintime) {
        this.lastlogintime = lastlogintime;
    }
}
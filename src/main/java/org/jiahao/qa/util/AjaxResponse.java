package org.jiahao.qa.util;

import java.util.List;

/**
 * Ajax数据包装类
 * Created by Alvin on 2016/10/15.
 */
public class AjaxResponse {

    private String status; // 状态
    private String msg; // 信息
    private String data; // 字符串数据
    private List<?> list; // 列表
    private Object obj; // 对象


    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public List<?> getList() {
        return list;
    }

    public void setList(List<?> list) {
        this.list = list;
    }

    public Object getObj() {
        return obj;
    }

    public void setObj(Object obj) {
        this.obj = obj;
    }
}

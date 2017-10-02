package org.jiahao.qa.service;

import org.jiahao.qa.pojo.User;
import org.jiahao.qa.util.Page;

import java.util.List;

/**
 * Created by Alvin on 2016/10/1.
 */
public interface UserService {


    /**
     * 根据id得到User
     * @param id
     * @return
     */
    User getUserById(String id);

    /**
     * 注册
     * @param user
     * @return
     */
    int register(User user);

    /**
     * 登录
     * @param usercode
     * @param password
     * @return
     */
    User login(String usercode, String password);

    /**
     * 更新个人信息
     * @param user
     * @return
     */
    int updatePersonalInfo(User user);

    /**
     * 判断用户是否存在
     * @param usercode
     * @return
     */
    boolean isExist(String usercode, String id);

    /**
     * 修改密码
     * @param password
     * @param id
     * @return
     */
    int updatePassword(String password, String id);

    /**
     * 修改头像
     * @param headpath 头像路径
     * @param id
     * @return
     */
    int updateHeadpath(String headpath, String id);


    /**
     * 获取用户列表
     * @param page 分页器
     * @param pageNow
     * @param q
     * @return
     */
    List<User> getUserList(Page page, String pageNow, String q);

    /**
     * 获取用户总数
     */
    int getCount(String q);

    /**
     * 删除用户
     * @param id
     * @return
     */
    int deleteUser(String id);

}

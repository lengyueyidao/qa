package org.jiahao.qa.service.impl;

import org.jiahao.qa.dao.UserMapper;
import org.jiahao.qa.pojo.User;
import org.jiahao.qa.service.UserService;
import org.jiahao.qa.util.DateUtil;
import org.jiahao.qa.util.IdUtil;
import org.jiahao.qa.util.Page;
import org.jiahao.qa.util.PageUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * Created by Alvin on 2016/10/1.
 */
@Service("userService")
public class UserServiceImpl implements UserService {

    @Resource
    private UserMapper userMapper;

    public User getUserById(String id) {
        return userMapper.selectByPrimaryKey(id);
    }

    public int register(User user) {
        user.setId(IdUtil.getUUID());
        Date nowDate = DateUtil.getNowTime();
        user.setRegistertime(nowDate);
        user.setLastlogintime(nowDate);
        return userMapper.insertSelective(user);
    }

    public User login(String usercode, String password) {

        User user = userMapper.selectByUsercodeAndPassword(usercode, password);
        // 将本次登录的时间记录
        if(user != null) {
            Date nowDate = DateUtil.getNowTime();
            userMapper.updateLastLoginTime(user.getId(), nowDate);
        }
        return user;
    }

    public int updatePersonalInfo(User user) {
        return userMapper.updateByPrimaryKeySelective(user);
    }

    public boolean isExist(String usercode, String id) {

        boolean result = false;
        if(userMapper.selectByUserCode(usercode, id) != null) {
            result = true;
        }

        return result;
    }

    public int updatePassword(String password, String id) {
        return userMapper.updatePassword(password, id);
    }

    public int updateHeadpath(String headpath, String id) {
        return userMapper.updateHeadpath(headpath, id);
    }

    public List<User> getUserList(Page page, String pageNow, String q) {
        int totalcount = userMapper.selectCount(q);
        PageUtil.createPage(page, pageNow, totalcount);
        return userMapper.selectUserList(page.getStartPos(), page.getPageSize(), q);
    }

    public int getCount(String q) {
        return userMapper.selectCount(q);
    }

    public int deleteUser(String id) {
        return userMapper.deleteByPrimaryKey(id);
    }
}

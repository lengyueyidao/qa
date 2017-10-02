package org.jiahao.qa.dao;

import org.apache.ibatis.annotations.Param;
import org.jiahao.qa.pojo.User;

import java.util.Date;
import java.util.List;

public interface UserMapper {
    int deleteByPrimaryKey(String id);

    int insert(User user);

    int insertSelective(User user);

    User selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(User user);

    int updateByPrimaryKey(User user);

    User selectByUsercodeAndPassword(@Param("usercode") String usercode, @Param("password") String password);

    int updateLastLoginTime(@Param("id") String id, @Param("lastlogintime") Date lastlogintime);

    User selectByUserCode(@Param("usercode") String usercode, @Param("id") String id);

    int updatePassword(@Param("password") String password, @Param("id") String id);

    int updateHeadpath(@Param("headpath") String headpath, @Param("id") String id);

    List<User> selectUserList(@Param("startPos") int startPos, @Param("pageSize") int pageSize, @Param("q") String q);

    int selectCount(@Param("q") String q);

}
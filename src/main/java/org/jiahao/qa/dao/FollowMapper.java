package org.jiahao.qa.dao;

import org.apache.ibatis.annotations.Param;
import org.jiahao.qa.pojo.Follow;

import java.util.List;

/**
 * Created by Alvin on 2016/11/3.
 */
public interface FollowMapper {

    int insertFollow(@Param("userid") String userid, @Param("followuserid") String followuserid);

    int deleteFollow(@Param("userid") String userid, @Param("followuserid") String followuserid);

    List<Follow> selectFollowing(@Param("userid") String userid);

    List<Follow> selectFollowed(@Param("followuserid") String followuserid);

    int selectFollowingCount(@Param("userid") String userid);

    int selectFollowedCount(@Param("followuserid") String followuserid);

    Follow selectIsFollowed(@Param("userid") String userid, @Param("followuserid") String followuserid);

    List<Follow> selectFollowList(@Param("q") String q, @Param("startPos") int startPos, @Param("pageSize") int pageSize);

    int selectCount(@Param("q") String q);
}

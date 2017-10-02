package org.jiahao.qa.service;

import org.apache.ibatis.annotations.Param;
import org.jiahao.qa.pojo.Follow;
import org.jiahao.qa.util.Page;

import java.util.List;

/**
 * Created by Alvin on 2016/11/3.
 */
public interface FollowService {

    int insertFollow(String userid, String followuserid);

    int deleteFollow(String userid, String followuserid);

    List<Follow> getFollowing(String userid);

    List<Follow> getFollowed(String followuserid);

    int getFollowingCount(String userid);

    int getFollowedCount(String followuserid);

    Follow isFollowed(String userid, String followuserid);

    List<Follow> getFollows(Page page, String pageNow, String q);
}

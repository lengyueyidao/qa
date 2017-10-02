package org.jiahao.qa.service.impl;

import org.jiahao.qa.dao.FollowMapper;
import org.jiahao.qa.pojo.Follow;
import org.jiahao.qa.service.FollowService;
import org.jiahao.qa.util.Page;
import org.jiahao.qa.util.PageUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Alvin on 2016/11/3.
 */
@Service("followService")
public class FollowServiceImpl implements FollowService {

    @Resource
    private FollowMapper followMapper;

    public int insertFollow(String userid, String followuserid) {
        return followMapper.insertFollow(userid, followuserid);
    }

    public int deleteFollow(String userid, String followuserid) {
        return followMapper.deleteFollow(userid, followuserid);
    }

    public List<Follow> getFollowing(String userid) {
        return followMapper.selectFollowing(userid);
    }

    public List<Follow> getFollowed(String followuserid) {
        return followMapper.selectFollowed(followuserid);
    }

    public int getFollowingCount(String userid) {
        return followMapper.selectFollowingCount(userid);
    }

    public int getFollowedCount(String followuserid) {
        return followMapper.selectFollowedCount(followuserid);
    }

    public Follow isFollowed(String userid, String followuserid) {
        return followMapper.selectIsFollowed(userid, followuserid);
    }

    public List<Follow> getFollows(Page page, String pageNow, String q) {

        int totalCount = followMapper.selectCount(q);
        PageUtil.createPage(page, pageNow, totalCount);
        return followMapper.selectFollowList(q, page.getStartPos(), page.getPageSize());
    }
}

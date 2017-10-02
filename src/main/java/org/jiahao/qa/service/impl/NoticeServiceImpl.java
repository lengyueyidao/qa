package org.jiahao.qa.service.impl;

import org.jiahao.qa.dao.NoticeMapper;
import org.jiahao.qa.pojo.Notice;
import org.jiahao.qa.service.NoticeService;
import org.jiahao.qa.util.Page;
import org.jiahao.qa.util.PageUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Alvin on 2016/11/8.
 */
@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {

    @Resource
    private NoticeMapper noticeMapper;

    public Notice getLatestNotice() {
        return noticeMapper.selectLatestNotice();
    }

    public int addNotice(Notice notice) {
        return noticeMapper.insert(notice);
    }

    public int deleteNotice(String id) {
        return noticeMapper.deleteByPrimaryKey(id);
    }

    public int updateNotice(Notice notice) {
        return noticeMapper.updateByPrimaryKeySelective(notice);
    }

    public List<Notice> getNotices(Page page, String pageNow, String q) {

        int totalCount = noticeMapper.selectNoticeCount(q);
        PageUtil.createPage(page, pageNow, totalCount);
        return noticeMapper.selectNoticeList(q, page.getStartPos(), page.getPageSize());
    }

    public int getTotal(String q) {
        return noticeMapper.selectNoticeCount(q);
    }
}

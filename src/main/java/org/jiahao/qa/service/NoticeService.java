package org.jiahao.qa.service;

import org.jiahao.qa.pojo.Notice;
import org.jiahao.qa.util.Page;

import java.util.List;

/**
 * Created by Alvin on 2016/11/8.
 */
public interface NoticeService {

    /**
     * 获取最新公告
     * @return
     */
    Notice getLatestNotice();

    /**
     * 新增公告
     * @param notice
     * @return
     */
    int addNotice(Notice notice);

    /**
     * 删除公告
     * @param id
     * @return
     */
    int deleteNotice(String id);

    /**
     * 更新公告
     * @param notice
     * @return
     */
    int updateNotice(Notice notice);

    /**
     * 获取公告列表
     * @param page
     * @param pageNow
     * @param q
     * @return
     */
    List<Notice> getNotices(Page page, String pageNow, String q);

    /**
     * 获取综述
     * @param q
     * @return
     */
    int getTotal(String q);

}

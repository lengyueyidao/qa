package org.jiahao.qa.dao;

import org.apache.ibatis.annotations.Param;
import org.jiahao.qa.pojo.Notice;

import java.util.List;

public interface NoticeMapper {
    int deleteByPrimaryKey(String id);

    int insert(Notice record);

    int insertSelective(Notice record);

    Notice selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Notice record);

    int updateByPrimaryKey(Notice record);

    Notice selectLatestNotice();

    int selectNoticeCount(@Param("q") String q);

    List<Notice> selectNoticeList(@Param("q") String q, @Param("startPos") int startPos, @Param("pageSize") int pageSize);
}
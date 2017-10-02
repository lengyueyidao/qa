package org.jiahao.qa.dao;

import org.apache.ibatis.annotations.Param;
import org.jiahao.qa.pojo.Tag;

import java.util.List;

public interface TagMapper {
    int deleteByPrimaryKey(String id);

    int insert(Tag record);

    int insertSelective(Tag record);

    Tag selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Tag record);

    int updateByPrimaryKey(Tag record);

    int insertOne(String tag);

    int insertList(List<String> tags);

    List<Tag> selectTagList(@Param("startPage") Integer startPage, @Param("pageSize") Integer pageSize, @Param("q") String q);

    List<Tag> selectTagsByQuestionId(@Param("questionid") String questionid);

    Tag selectByName(@Param("name") String name);

    int selectTagCount(@Param("q") String q);

    Tag selectTagByName(@Param("name") String name);
}
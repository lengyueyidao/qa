package org.jiahao.qa.dao;

import org.jiahao.qa.pojo.Question;

public interface QuestionMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Question record);

    int insertSelective(Question record);

    Question selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Question record);

    int updateByPrimaryKey(Question record);
}
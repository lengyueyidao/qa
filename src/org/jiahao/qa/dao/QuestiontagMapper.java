package org.jiahao.qa.dao;

import org.jiahao.qa.pojo.QuestiontagKey;

public interface QuestiontagMapper {
    int deleteByPrimaryKey(QuestiontagKey key);

    int insert(QuestiontagKey record);

    int insertSelective(QuestiontagKey record);
}
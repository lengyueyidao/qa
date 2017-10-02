package org.jiahao.qa.dao;

import org.apache.ibatis.annotations.Param;
import org.jiahao.qa.pojo.QuestiontagKey;
import org.jiahao.qa.pojo.Tag;

import java.util.List;

public interface QuestiontagMapper {
    int deleteByPrimaryKey(QuestiontagKey key);

    int insert(QuestiontagKey record);

    int insertSelective(QuestiontagKey record);

    int selectTagCountForQuestion(String id);

    QuestiontagKey selectQuestionTagByQT(@Param("qid") String qid, @Param("tid") String tid);

    int deleteTagsByQuestionId(@Param("questionid") String questionid);

    int deleteTagsByTagId(@Param("tagid") String tagid);
}
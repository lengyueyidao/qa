package org.jiahao.qa.dao;

import org.apache.ibatis.annotations.Param;
import org.jiahao.qa.pojo.Answer;

import java.util.List;

public interface AnswerMapper {
    int deleteByPrimaryKey(String id);

    int insert(Answer record);

    int insertSelective(Answer record);

    Answer selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Answer record);

    int updateByPrimaryKey(Answer record);

    List<Answer> selectByQuestionId(String id);

    List<Answer> selectTop5Answers();

    List<Answer> selectByUserId(@Param("userId") String userId, @Param("startPos") int startPos, @Param("pageSize") int pageSize, @Param("q") String q);

    int selectAnswerCntByQid(String id);

    List<Answer> selectUnLookAnswers(String id);

    int updateAnswerLook(String id);

    List<Answer> selectAnswerList(@Param("startPos") int startPos, @Param("pageSize") int pageSize, @Param("q") String q);

    int selectCount(@Param("q") String q);

    int selectCountByUserId(@Param("userId") String userId, @Param("q") String q);
}
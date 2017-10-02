package org.jiahao.qa.dao;

import org.apache.ibatis.annotations.Param;
import org.jiahao.qa.pojo.Question;

import java.util.List;

public interface QuestionMapper {
    int deleteByPrimaryKey(String id);

    int insert(Question record);

    int insertSelective(Question record);

    Question selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Question record);

    int updateByPrimaryKey(Question record);

    List<Question> selectQuestionList(@Param("isover") Integer isover, @Param("startPos") int startPos, @Param("pageSize") int pageSize, @Param("qList") List<String> qList);

    Question selectQuestion(String id);

    List<Question> selectQuestionListByTag(@Param("tagid") String tagid, @Param("startPos") int startPos, @Param("pageSize") int pageSize,  @Param("qList") List<String> qList);

    List<Question> selectQuestionListByUserId(@Param("isover") Integer isover, @Param("userid") String userid, @Param("q") String q, @Param("startPos") Integer startPos, @Param("pageSize") Integer pageSize);

    int selectQuestionCountByUserId(@Param("isover") Integer isover, @Param("userid") String userid, @Param("q") String q);

    List<Question> selectTop5Questions();

    int selectQuestionCount(@Param("isover") Integer isover, @Param("qList") List<String> qList);

    int selectQuestionCountByTag(@Param("tagid") String tagid, @Param("qList") List<String> qList);

    List<Question> selectDynamics(@Param("id") String id, @Param("startPos") int startPos, @Param("pageSize") int pageSize);

    int selectDynamicsCount(String id);

    int overQuestion(@Param("id") String id, @Param("isover") Integer isover);

    int selectViews(@Param("id") String id);

    int updateViews(@Param("id") String id);

    List<Question> selectQuestions();
}
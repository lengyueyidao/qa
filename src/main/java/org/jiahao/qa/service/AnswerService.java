package org.jiahao.qa.service;

import org.jiahao.qa.pojo.Answer;
import org.jiahao.qa.util.Page;

import java.util.List;

/**
 * Created by Alvin on 2016/10/4.
 */
public interface AnswerService {

    /**
     * 根据问题的ID查找对应的回答列表
     * @param questionId
     * @return
     */
    List<Answer> getAnswerListByQuestionId(String questionId);

    /**
     * 查找用户回答的问题
     * @param userId
     * @return
     */
    List<Answer> getAnswerListByUserId(String userId, Page page, String pageNow, String q);

    /**
     * 根据id删除对应的回答
     * @param id
     * @return
     */
    int deleteAnswer(String id);

    /**
     * 回答对应的问题
     * @param answer
     * @return
     */
    int addAnswer(Answer answer);

    /**
     * 获得最近的5个回答
     * @return
     */
    List<Answer> getTop5Answers();

    /**
     * 根据id找回答
     * @param id
     * @return
     */
    Answer getAnswerById(String id);

    /**
     * 根据问题id找回答数
     * @param id
     * @return
     */
    int getAnswerCntByQid(String id);

    /**
     * 根据用户id找未读回答
     * @param id
     * @return
     */
    List<Answer> getUnLookAnswers(String id);

    /**
     * 已看回复
     * @param aid
     */
    void lookAnswer(String aid);

    List<Answer> getAnswerList(Page page, String pageNow, String q);
}

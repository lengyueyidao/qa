package org.jiahao.qa.service;

import org.jiahao.qa.pojo.Tag;

import java.util.List;

/**
 * Created by Alvin on 2016/10/26.
 */
public interface QuestionTagService {

    /**
     * 根据问题id删除对应的tag关联
     * @param questionid
     * @return
     */
    int deleteTagsByQuestionId(String questionid);

    /**
     * 根据标签id删除对应的tag关联
     * @param tagid
     * @return
     */
    int deleteTagsByTagId(String tagid);

}

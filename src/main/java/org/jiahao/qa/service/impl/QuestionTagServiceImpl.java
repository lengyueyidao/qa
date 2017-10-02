package org.jiahao.qa.service.impl;

import org.jiahao.qa.dao.QuestionMapper;
import org.jiahao.qa.dao.QuestiontagMapper;
import org.jiahao.qa.pojo.Tag;
import org.jiahao.qa.service.QuestionTagService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Alvin on 2016/10/26.
 */
@Service("questionTagService")
public class QuestionTagServiceImpl implements QuestionTagService {

    @Resource
    private QuestiontagMapper questiontagMapper;

    public int deleteTagsByQuestionId(String questionid) {
        return questiontagMapper.deleteTagsByQuestionId(questionid);
    }

    public int deleteTagsByTagId(String tagid) {
        return questiontagMapper.deleteTagsByTagId(tagid);
    }
}

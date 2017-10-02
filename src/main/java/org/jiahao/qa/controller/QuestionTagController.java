package org.jiahao.qa.controller;

import org.jiahao.qa.pojo.Question;
import org.jiahao.qa.pojo.Tag;
import org.jiahao.qa.service.QuestionService;
import org.jiahao.qa.service.QuestionTagService;
import org.jiahao.qa.service.TagService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Alvin on 2016/10/26.
 */
@Controller
public class QuestionTagController {

    @Resource
    private QuestionService questionService;

    @Resource
    private TagService tagService;



}

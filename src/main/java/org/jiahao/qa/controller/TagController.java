package org.jiahao.qa.controller;

import org.jiahao.qa.pojo.Tag;
import org.jiahao.qa.service.TagService;
import org.jiahao.qa.util.AjaxResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * 标签控制器
 * query 查询前20个标签列表
 * Created by Alvin on 2016/10/18.
 */
@Controller
public class TagController {

    @Resource
    private TagService tagService;

    @RequestMapping("/querytags")
    @ResponseBody
    private AjaxResponse query() {

        List<Tag> tags = tagService.getTags(0, 20, null);

        AjaxResponse ajaxResponse = new AjaxResponse();
        ajaxResponse.setStatus("ok");
        ajaxResponse.setList(tags);
        return ajaxResponse;
    }

}

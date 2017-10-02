package org.jiahao.qa.controller.admin;

import org.jiahao.qa.pojo.Tag;
import org.jiahao.qa.service.QuestionTagService;
import org.jiahao.qa.service.TagService;
import org.jiahao.qa.util.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * toTagMgmt 访问管理员中标签管理界面
 * add 新增标签
 * upd 修改标签
 * del 删除标签
 * Created by Alvin on 2016/12/8.
 */
@Controller
public class TagMgmtController {

    @Resource
    private TagService tagService;

    @Resource
    private QuestionTagService questionTagService;

    @RequestMapping("/admintag")
    public String toTagMgmt(String q, String pageNow, Model model) {

        Page page = new Page();
        int totalCount = tagService.getTagCount("".equals(q)?null:q);
        PageUtil.createPage(page, pageNow, totalCount);
        List<Tag> tagList = tagService.getTags(page.getStartPos(), page.getPageSize(), "".equals(q)?null:q);
        model.addAttribute("tags", tagList);
        model.addAttribute("page", page);
        model.addAttribute("q", q);
        return "admin/tagmgmt";
    }

    @RequestMapping("/admintagadd")
    @ResponseBody
    public AjaxResponse add(String name) {

        AjaxResponse ajaxResponse = new AjaxResponse();

        String id = IdUtil.getUUID();
        Tag tag = new Tag();
        tag.setId(id);
        tag.setName(name);

        int r = tagService.addTag(tag);
        if(r > 0) {
            ajaxResponse.setStatus("ok");
            ajaxResponse.setMsg("新增成功！");
        }
        else {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("新增失败！");
        }
        return ajaxResponse;
    }

    @RequestMapping("/admintagupdate")
    @ResponseBody
    public AjaxResponse upd(String id, String name) {

        AjaxResponse ajaxResponse = new AjaxResponse();

        // 判断该标签是否存在
        int isExist = tagService.isExistTag(name);
        if(isExist > 0) {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("修改失败，该标签名已存在！");
            return ajaxResponse;
        }

        Tag tag = new Tag();
        tag.setId(id);
        tag.setName(name);

        int r = tagService.updateTag(tag);
        if(r > 0) {
            ajaxResponse.setStatus("ok");
            ajaxResponse.setMsg("修改成功！");
        }
        else {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("修改失败！");
        }
        return ajaxResponse;
    }

    @RequestMapping("/admintagdelete")
    @ResponseBody
    public AjaxResponse del(String id) {

        AjaxResponse ajaxResponse = new AjaxResponse();

        int r = tagService.deleteTag(id);

        if(r > 0) {
            // 删除标签时，把对应问题关联删除
            questionTagService.deleteTagsByTagId(id);
        }

        if(r > 0) {
            ajaxResponse.setStatus("ok");
            ajaxResponse.setMsg("删除成功！");
        }
        else {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("删除失败！");
        }
        return ajaxResponse;
    }

}

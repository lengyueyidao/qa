package org.jiahao.qa.controller;

import org.jiahao.qa.pojo.Answer;
import org.jiahao.qa.pojo.User;
import org.jiahao.qa.service.AnswerService;
import org.jiahao.qa.util.AjaxResponse;
import org.jiahao.qa.util.IdUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 * 问题控制器
 * query 查询最新发布的前5个问题
 * delete 删除问题
 * reply 回复问题
 * Created by Alvin on 2016/10/24.
 */
@Controller
public class AnswerController {

    @Resource
    private AnswerService answerService;

    @RequestMapping("/query")
    @ResponseBody
    public AjaxResponse query() {
        List<Answer> answerList = answerService.getTop5Answers();
        AjaxResponse ajaxResponse = new AjaxResponse();
        ajaxResponse.setStatus("ok");
        ajaxResponse.setList(answerList);
        return ajaxResponse;
    }

    @RequestMapping("/deleteanswer")
    @ResponseBody
    public AjaxResponse delete(String id) {
        int re = answerService.deleteAnswer(id);
        AjaxResponse ajaxResponse = new AjaxResponse();
        if(re == 1) {
            ajaxResponse.setStatus("ok");
            ajaxResponse.setMsg("删除成功！");
        }
        else {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("删除失败！");
        }
        return ajaxResponse;
    }

    @RequestMapping("/replyanswer")
    @ResponseBody
    public AjaxResponse reply(String pid, String qid, String content, HttpSession session) {

        // 前台传过来为"null"的字符串而不是null，所以转换一下
        if("null".equals(pid)) {
            pid = null;
        }

        AjaxResponse ajaxResponse = new AjaxResponse();

        User user = (User) session.getAttribute("user");
        if(user == null) {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("请先登录！");
            return ajaxResponse;
        }

        Answer answer = new Answer();
        String aid = IdUtil.getUUID();
        answer.setId(aid);
        answer.setContent(content);
        answer.setUserid(user.getId());
        answer.setQuestionid(qid);
        answer.setParentid(pid);
        answer.setDate(new Date());

        if(pid != null && !"".equals(pid)) {
            // 根据parentid查询对应的回答
            Answer pa = answerService.getAnswerById(pid);
            answer.setIdpath(pa.getIdpath() + "/" + aid);
        }else {
            answer.setIdpath(aid);
        }

        int re = answerService.addAnswer(answer);

        if(re == 1) {
            ajaxResponse.setStatus("ok");
            ajaxResponse.setMsg("回复成功！");
        }
        else {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("回复失败！");
        }
        return ajaxResponse;
    }
}

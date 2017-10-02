package org.jiahao.qa.controller.admin;

import org.jiahao.qa.pojo.Answer;
import org.jiahao.qa.pojo.User;
import org.jiahao.qa.service.AnswerService;
import org.jiahao.qa.util.AjaxResponse;
import org.jiahao.qa.util.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * toAnswerMgmt 访问管理员中回答管理界面
 * del 删除回答
 * Created by Alvin on 2016/12/10.
 */
@Controller
public class AnswerMgmtController {

    @Resource
    private AnswerService answerService;

    @RequestMapping("/adminanswer")
    public String toAnswerMgmt(String pageNow, String q, Model model) {
        Page page = new Page();
        List<Answer> answerList = answerService.getAnswerList(page, pageNow, q);
        model.addAttribute("answers", answerList);
        model.addAttribute("page", page);
        model.addAttribute("q", q);
        return "admin/answermgmt";
    }

    @RequestMapping("/adminanswerdelete")
    @ResponseBody
    public AjaxResponse del(String id) {
        AjaxResponse ajaxResponse = new AjaxResponse();
        int r = answerService.deleteAnswer(id);
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

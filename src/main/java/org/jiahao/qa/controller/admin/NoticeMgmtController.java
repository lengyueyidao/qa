package org.jiahao.qa.controller.admin;

import com.sun.xml.internal.bind.v2.model.core.ID;
import org.jiahao.qa.pojo.Notice;
import org.jiahao.qa.service.NoticeService;
import org.jiahao.qa.util.AjaxResponse;
import org.jiahao.qa.util.DateUtil;
import org.jiahao.qa.util.IdUtil;
import org.jiahao.qa.util.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * toNoticeMgmt 访问管理员中公告管理界面
 * add 新增公告
 * upd 修改公告
 * del 删除公告
 * Created by Alvin on 2016/12/8.
 */
@Controller
public class NoticeMgmtController {

    @Resource
    private NoticeService noticeService;

    @RequestMapping("/adminnotice")
    public String toNoticeMgmt(String q, String pageNow, Model model) {

        Page page = new Page();
        List<Notice> noticeList = noticeService.getNotices(page, pageNow, "".equals(q)?null:q);
        model.addAttribute("notices", noticeList);
        model.addAttribute("page", page);
        model.addAttribute("q", q);
        return "admin/noticemgmt";
    }

    @RequestMapping("/adminnoticeadd")
    @ResponseBody
    public AjaxResponse add(String content) {

        AjaxResponse ajaxResponse = new AjaxResponse();

        String id = IdUtil.getUUID();
        Notice notice = new Notice();
        notice.setId(id);
        notice.setContent(content);

        // 获取当前时间 Date类型
        Date date = DateUtil.getNowTime();

        notice.setCreatetime(date);
        notice.setUpdatetime(date);

        int r = noticeService.addNotice(notice);
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

    @RequestMapping("/adminnoticeupdate")
    @ResponseBody
    public AjaxResponse upd(String id, String content) {

        AjaxResponse ajaxResponse = new AjaxResponse();

        Notice notice = new Notice();
        notice.setId(id);
        notice.setContent(content);

        int r = noticeService.updateNotice(notice);
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

    @RequestMapping("/adminnoticedelete")
    @ResponseBody
    public AjaxResponse del(String id) {

        AjaxResponse ajaxResponse = new AjaxResponse();

        int r = noticeService.deleteNotice(id);
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

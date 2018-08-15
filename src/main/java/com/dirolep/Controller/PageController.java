package com.dirolep.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * Created by Administrator on 2018\4\29 0029.
 */
@Controller
public class PageController {

    // 跳转到管理主页
    @GetMapping("/")
    public String indexManage(HttpServletRequest request, Model model){
        HttpSession session = request.getSession();
        model.addAttribute("sessionId", session.getId());
        model.addAttribute("servletContext", session.getServletContext());
        return "manage/index_manage";
    }

    /* 会员管理 */
    /* 打印会员消费单 */
    @GetMapping("/page/search_person_print")
    public String searchPerson(String nameOrPhoneOrCardNum, Model model){
        model.addAttribute("nameOrPhoneOrCardNum", nameOrPhoneOrCardNum);
        return "manage/search_person_print";
    }
    /* 会员管理页面 */
    @GetMapping("/page/person_manage")
    public String person_list(String nameOrPhoneOrCardNum, Model model, Integer page, Integer limit){
        model.addAttribute("nameOrPhoneOrCardNum", nameOrPhoneOrCardNum);
        model.addAttribute("page", page);
        model.addAttribute("limit", limit);
        return "manage/person_manage";
    }
    /* 搜索会员消费历史页面 */
    @GetMapping("/page/personSpending")
    public String searchPersonConsumptionHistory(Integer personId, Model model){
        model.addAttribute("personId", personId);
        return "manage/personSpending";
    }
    /* 添加会员页面 */
    @GetMapping("/page/add_person")
    public String addPerson(Integer page, Integer limit, Model model){
        model.addAttribute("page", page);
        model.addAttribute("limit", limit);
        return "manage/add_person";
    }
    /* 会员个人信息页面 */
    @GetMapping("/page/person_info")
    public String person_info(Integer personId, Integer page, Integer limit, Model model){
        model.addAttribute("personId", personId);
        model.addAttribute("page", page);
        model.addAttribute("limit", limit);
        return "manage/person_info";
    }
    /* 修改会员信息页面 */
    @GetMapping("/page/edit_person")
    public String editPerson(Integer personId, Integer page, Integer limit, Model model){
        model.addAttribute("personId", personId);
        model.addAttribute("page", page);
        model.addAttribute("limit", limit);
        return "manage/edit_person";
    }

    /* 基础数据管理 */
    /* 添加会员级别页面 */
    @GetMapping("/page/add_level")
    public String addLevel(){
        return "manage/add_level";
    }
}

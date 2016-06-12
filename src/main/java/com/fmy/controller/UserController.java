package com.fmy.controller;

import com.fmy.core.mybatis.dto.PageInfo;
import com.fmy.pojo.User;
import com.fmy.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Desc:    用户控制器
 * Author: joe
 * Date:    2016/6/10
 */
@Controller
@RequestMapping("user")
public class UserController extends BaseController {
    @Autowired
    private UserService userService;
    /**
     * 首页
     * @return 视图名
     */
    @RequestMapping("/")
    public String index(){
        return "user";
    }

    /**
     * 查询用户分页
     * @param user 查询条件
     * @return 用户分页
     */
    @RequestMapping("find")
    @ResponseBody
    public PageInfo<User> find(User user){
        return userService.findPage(user);
    }
}

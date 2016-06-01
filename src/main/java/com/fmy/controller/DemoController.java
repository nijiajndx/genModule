package com.fmy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by njoe on 2016/5/31.
 */
@Controller
@RequestMapping("/demo")
public class DemoController extends BaseController {
    @RequestMapping("/")
    public String index(){
        return "index";
    }

    @RequestMapping("welcome.htm")
    public String welcome(){
        return "welcome";
    }
}

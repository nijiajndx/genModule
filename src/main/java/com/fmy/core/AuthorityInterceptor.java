package com.fmy.core;

import com.fmy.pojo.Code;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @Author njoe
 * @Date 2016/5/31 15:37
 * @Description 权限拦截器
 */
public class AuthorityInterceptor extends HandlerInterceptorAdapter {

    /**
     权限拦截器，如果用户未登录，则跳转到登录页面，
     如果用户没权限，则跳转到403页面
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        return true;
    }


    /**
     *添加一些公共的信息，如：应用名
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        String ctx = request.getContextPath();
        if(modelAndView != null){
            modelAndView.addObject("ctx",ctx);
            modelAndView.addObject("name","joe");
            modelAndView.addObject("codeLists",getCodeList());
        }
        super.postHandle(request, response, handler, modelAndView);
    }

    private Map<String,List<Code>> getCodeList(){
        Map<String,List<Code>> maps = Maps.newHashMap();

        ArrayList<Code> codes = Lists.newArrayList(
                new Code("1", "joe", 1),
                new Code("2", "peter", 2),
                new Code("3", "mike", 3)
        );

        maps.put("name",codes);

        return maps;

    }
}

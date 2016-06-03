package com.fmy.core.freemarker.directive;

import freemarker.core.Environment;
import freemarker.template.*;

import java.io.IOException;
import java.io.Writer;
import java.util.Map;

/**
 * @Author njoe
 * @Date 2016/6/1 17:43
 * @Description 判断当前用户是否拥有该按钮的访问权限，如果没有则隐藏按钮
 */
public class Button implements TemplateDirectiveModel {
    @Override
    public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
        preCheck(env,params,loopVars,body);

        SimpleScalar urlObj = (SimpleScalar) params.get("url");
        //有权限，则输出按钮，否则什么也不输出
        if(hasPermission(urlObj.getAsString())){
            if(!"auth".equals(urlObj.getAsString())){
                StringBuilder ct = new StringBuilder("<button type=\"button\" ");

                //id属性
                Object idObj = params.get("id");
                if(idObj != null){
                    ct.append(" id=\"").append(((SimpleScalar)idObj).getAsString()).append("\" ");
                }

                //class属性
                SimpleScalar classOjb = (SimpleScalar)  params.get("class");
                //如果class为空，则默认为btn
                if(classOjb != null && !"".equals(classOjb.getAsString())){
                    ct.append("class=\"btn ").append(((SimpleScalar)classOjb).getAsString()).append("\" ");
                }else{
                    ct.append("class=\"btn\" ");
                }

                //name属性
                String btnName = ((SimpleScalar) params.get("name")).getAsString();
                ct.append(">").append(btnName).append("</button>\r");

                Writer out = env.getOut();
                out.write(ct.toString());
            }
        }

    }

    //前置检查
    public void preCheck(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateModelException {
        // 指令内容体必须为空
        if (body != null) {
            throw new RuntimeException("This directive doesn't allow body");
        }

        //按钮名不能为空
        Object name = params.get("name");
        if(name==null){
            throw new RuntimeException("missing name attribute");
        }else if(!(name instanceof SimpleScalar)){
            throw new RuntimeException("attribute name should be string");
        }else if("".equals(((SimpleScalar)name).getAsString())){
            throw new RuntimeException("attribute name should not be blank");
        }

        //id属性如果存在，则必须为字符串
        Object id = params.get("id");
        if(id != null && !(id instanceof SimpleScalar)){
            throw new RuntimeException("attribute id should be string");
        }
        //url属性如果存在，则必须为字符串
        Object url = params.get("url");
        if(url != null && !(url instanceof SimpleScalar)){
            throw new RuntimeException("attribute url should be string");
        }
    }

    /**
     * 判断当前登录人是否有请求地址的权限
     * @param url 请求地址
     * @return 是否有请求地址的访问权限
     */
    public boolean hasPermission(String url){
        return true;
    }
}

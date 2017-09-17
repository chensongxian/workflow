package com.csx.workflow.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * 单点登录的权限系统认证
 */
@Controller
public class AuthController {
    @RequestMapping("")
    public String home(){
    	return "redirect:index";
    }
    
    @RequestMapping("index")
    public String index(HttpServletRequest request,HttpServletResponse response) {
       
        return "jsp/index";
    }



  
}

package com.csx.workflow.web.process;


import com.csx.workflow.model.SimpleResult;
import com.csx.workflow.utils.UUIDutils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by wyp on 2017/3/9.
 */
@RequestMapping("/openapi/process")
@Controller
public class ProcessAPIController {

    private static final transient Logger logger = LoggerFactory.getLogger(ProcessAPIController.class);
    @RequestMapping("produceUUID")
    @ResponseBody
    public SimpleResult produceUUID(){
        SimpleResult simpleResult = new SimpleResult();
        simpleResult.setMessage(UUIDutils.createUUID());
        simpleResult.setSuccess(true);
          return simpleResult;
    }
    /**
     * 流程模型创建 页面调用
     *
     * @param systemId
     * @return
     */
    @RequestMapping(value = "create")
    public String create(String systemId, Model model) {
        if (systemId == null) {
            //返回参数
            model.addAttribute("systemId", "系统id systemId");
            return "jsp/error";
        }
        //过滤
        model.addAttribute("systemId", systemId);
        return "jsp/processManager/processDefManager";
    }


   


}

package com.csx.workflow.web.process;

import com.csx.workflow.model.SimpleResult;
import com.csx.workflow.service.ProcessModelManagerService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;



/**
 * 流程模型部署
 */
@Controller
@RequestMapping("processModelManager")
public class ProcessModelManagerController {

    //日志打印
    private static  final transient Logger log = Logger.getLogger(ProcessModelManagerController .class);

    @Autowired
    private ProcessModelManagerService processModelManagerService;

    /**
     * 流程模型启动
     * @param modelId
     */
    @RequestMapping("processModelStart")
    @ResponseBody
    public SimpleResult processModelStart(String modelId){
        SimpleResult simpleResult = new SimpleResult();
        try {
            processModelManagerService.processModelStart(modelId);
            simpleResult.setSuccess(true);
            simpleResult.setMessage("发布成功");
        } catch (Exception e) {
            simpleResult.setSuccess(false);
            simpleResult.setMessage("发动失败");
            e.printStackTrace();
             log.error("流程部署失败"+e);
        }finally {
            return simpleResult;
        }

    }

}

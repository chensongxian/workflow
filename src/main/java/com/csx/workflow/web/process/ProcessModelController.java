package com.csx.workflow.web.process;


import com.csx.workflow.model.Page;
import com.csx.workflow.model.ProcessModel;
import com.csx.workflow.model.SimpleResult;
import com.csx.workflow.service.ProcessModelService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;



/**
 * 流程模型controller
 */
@Controller
@RequestMapping("processModel")
public class ProcessModelController {

    private static final transient Logger logger = LoggerFactory.getLogger(ProcessModelController.class);


    @Autowired
    private ProcessModelService processModelService;

    /**
     * 分页查询流程模型
     * @param model
     * @param page
     * @param pageSize
     * @return
     */
    @RequestMapping(value = "queryPage",method = RequestMethod.POST)
    @ResponseBody
    public Page queryPage(ProcessModel model, Integer page, Integer pageSize ){
        return processModelService.queryPage(model,page,pageSize);
    }

    /**
     * 复制模板
     * @param id
     * @return
     */
    @RequestMapping(value = "copyModel",method = RequestMethod.POST)
    @ResponseBody
    public SimpleResult copyModel(String id){
        SimpleResult simpleResult = new SimpleResult();
        try{
            boolean flag = false;
            simpleResult.setSuccess(flag);
            simpleResult.setMessage("复制成功");
        }catch (RuntimeException e){
            simpleResult.setSuccess(false);
            simpleResult.setMessage("复制失败");
            if(logger.isErrorEnabled()){
                logger.error("processModel.copyModel {}",e);
            }
        }finally {
            return simpleResult;
        }

    }

}

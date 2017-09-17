package com.csx.workflow.web.process;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.csx.workflow.model.SimpleResult;
import org.activiti.engine.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@RequestMapping("task")
@Controller
public class TaskController {
	  @Autowired
	    private TaskService taskService;
    /**
     * 完成审批
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "doTask" , method = RequestMethod.POST)
    @ResponseBody
    public SimpleResult doTask(HttpServletRequest request){
        SimpleResult result = new SimpleResult();
        Map<String,String[]> input_parms = request.getParameterMap();
        //{checkForm=[Ljava.lang.String;@23eec7a9, dataForm=[Ljava.lang.String;@2375c356}
        Map<String,Object> parms = new HashMap<String, Object>();
        for (String key:input_parms.keySet()) {
            String[] values = input_parms.get(key);
            if(values.length > 1){
                result.setMessage(key+"的值重复！");
                return result;
            }
            parms.put(key,values[0]);
        }
        SimpleResult simpleResult = new SimpleResult();
        try {
            simpleResult.setSuccess(true);
            simpleResult.setMessage("处理成功");
            taskService.complete(parms.get("taskId").toString(),parms);
        }catch (RuntimeException e){
            simpleResult.setSuccess(false);
            simpleResult.setMessage("处理失败");
        }finally {
            return simpleResult;
        }

    }
}

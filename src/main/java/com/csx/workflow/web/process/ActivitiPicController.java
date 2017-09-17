package com.csx.workflow.web.process;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.csx.workflow.service.ActivitiPicService;
import com.csx.workflow.utils.ProcessInstanceUtils;
import org.activiti.engine.ProcessEngine;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;




/**   
 * Created by Administrator on 2016/10/28.
 * 图片controller层
 */
@RequestMapping("activitiPic")
@Controller
public class ActivitiPicController {
    private static final  Logger logger = LoggerFactory.getLogger(ActivitiPicController.class);

    @Autowired
    private ActivitiPicService activitiPicService;
    @Autowired
    private ProcessEngine processEngine;
	/**
	 * 获取图片
	 * 
	 * @param processId
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("activitPic")
	public void queryPic2(String processId, HttpServletResponse response, Integer method) throws IOException {
		InputStream in = null;
		OutputStream out = response.getOutputStream();
		in = activitiPicService.createCustomeActivitiPicByProcessId(processId);
		copyPic(in, out);
	}


    /**
     * 跳转到流程图页面
     * @param
     * @param model
     * @return
     */
    @RequestMapping("lookPicBeforeStart")
    public String lookPicBeforeStart(String  key,Model model){
        model.addAttribute("key",key);
        return "jsp/activitiPicBeforeStart";
    }


    /**
     * 跳转到流程图页面
     * @param processId
     * @param model
     * @return
     */
    @RequestMapping("lookMakePic")
    public String lookMakePic(String  processId,Model model,Integer method){
        model.addAttribute("processId",processId);
        model.addAttribute("method",method);
        return "jsp/activitiPic";
    }
    /**
     * 未发起的流程图
     * @param response
     * @param key
     * @throws IOException
     */
    @RequestMapping("queryPicBeforeStart")
    public void queryPicBeforeStart(HttpServletResponse response, HttpServletRequest request,String key)throws IOException{
        InputStream in =  activitiPicService.getActivitiPicByProcessDefKey(key);
        OutputStream out= response.getOutputStream();
        copyPic(in,out);
    }
    private void copyPic(InputStream in,OutputStream out){
        try {
            IOUtils.copy(in,out);
        }catch (IOException e){
            e.printStackTrace();
        }finally {
            IOUtils.closeQuietly(in);
            IOUtils.closeQuietly(out);
        }
    }
    
    /**
     * 跳转到流程图页面
     * @param processId
     * @param model
     * @return
     */
    @RequestMapping("lookPic")
    public String lookPic(String  processId,Integer method,Model model){
        model.addAttribute("processId",processId);
        //如果终止的话直接是时序图就行
        if(ProcessInstanceUtils.isStop(processEngine,processId)){
            model.addAttribute("method",3);
            return "jsp/activitiPic";
        }
      /*  if(!ProcessInstanceUtils.isStop(processEngine,processId)){
            //如果等于2的未完成分成两种情况
            ActCreationEx actCreationEx = new ActCreationEx();
            actCreationEx.setProcessInstanceId(processId);
            actCreationEx.setState(0);
            List<ActCreationEx> list =  actCreationServiceEx.query(actCreationEx);
            if(list!=null&&list.size()>0){
                //有加签功能
                return "jsp/processTotalPic";
            }
        }*/
        model.addAttribute("method",0);
        return "jsp/activitiPic";

    }

}

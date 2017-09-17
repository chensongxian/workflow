package com.csx.workflow.web.process;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.csx.workflow.model.Page;
import com.csx.workflow.model.TaskAPIData;
import com.csx.workflow.service.TaskServiceEx;
import com.csx.workflow.utils.ProcessInstanceUtils;
import com.csx.workflow.utils.TestApiConstants;
import org.activiti.engine.HistoryService;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageInfo;

/**
 * 查询流程相关的
 */
@Controller
@RequestMapping("query")
public class QueryController {
	//日志打印
	private static  final  Logger log = Logger.getLogger(QueryController .class);



	@Autowired
	private TaskService taskService;
	@Autowired
	private HistoryService historyService;


	@Autowired
	private TaskServiceEx taskServiceEx;
    /**
     * 分页已办事项
     * @return
     */
    @RequestMapping(value = "checkedTaskAuth",method = RequestMethod.POST)
    @ResponseBody
    public Page queryTaskCompletedByAuthId(HttpServletRequest request, Integer page, Integer pageSize, String userId){
        Page pageJson = new Page();
        TaskAPIData taskAPIData = new TaskAPIData();
        taskAPIData.setHanderId(String.valueOf(userId));
        PageInfo pageInfo =taskServiceEx.TaskCompletedList(taskAPIData,page,pageSize);
        pageJson.setTotalPage(pageInfo.getPages());
        pageJson.setTotal(pageInfo.getTotal());
        pageJson.setRows(pageInfo.getList());
        pageJson.setPage(page);
        return  pageJson;
    }
	/**
	 * 跳转审批页面
	 * @param processId
	 * @param taskId
	 * @param model
	 * @return
     */
	@RequestMapping("/taskInfo")
		public String gotoTaskInfo( String processId,String taskId,String taskKey,String processDefId,Model model,HttpServletRequest request) {
		Task task =taskService.createTaskQuery().taskId(taskId).singleResult();
		model.addAttribute("processId",processId);
		model.addAttribute("taskId",taskId);
		//任务类型的属性
		 //int priority =task.getPriority();
		String formKey =task.getFormKey();
		//代表是知会节点
		if("2".equals(formKey)){
			//不唤醒
			model.addAttribute("notify",false);
		}else {
			//不是
			model.addAttribute("notify",true);
		}
		
		String val = String.valueOf(ProcessInstanceUtils.getHistoryVar(historyService,processId, TestApiConstants.FORM_DATA_TEST));
		 //String val =  String.valueOf(runtimeService.getVariable(task1.getExecutionId(),"fomrData_test"));
		//流程相关变量审核表
		//表单数据
		if(JSONObject.parseObject(val)==null){
			model.addAttribute("formDataInfo",null);

		}else {
			model.addAttribute("formDataInfo",JSONObject.parseObject(val));
		}
		return "jsp/checkPage";
	}

	

	/**
	 * 分页查询当前用户的所有信息
	 * @param page
	 * @param pageSize
	 * @param request
     * @return
     */
	@RequestMapping(value = "taskListPage",produces = "application/json",method = RequestMethod.POST)
	@ResponseBody
	public Page taskListPage(Integer page, Integer pageSize,String userId, HttpServletRequest request){
		
		Page pageJson = new Page();
		TaskAPIData taskAPIData = new TaskAPIData();
		taskAPIData.setHanderId(userId);
		PageInfo pageInfo =taskServiceEx.TaskList(taskAPIData,page,pageSize);
		pageJson.setTotalPage(pageInfo.getPages());
		pageJson.setTotal(pageInfo.getTotal());
		pageJson.setRows(pageInfo.getList());
		pageJson.setPage(page);
		return  pageJson;
	}












	

}

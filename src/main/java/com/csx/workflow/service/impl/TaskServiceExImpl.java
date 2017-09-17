package com.csx.workflow.service.impl;

import java.util.List;
import java.util.Map;

import com.csx.workflow.dao.HistoricTaskInstanceExDao;
import com.csx.workflow.dao.HistoryCheckedTaskDao;
import com.csx.workflow.dao.TaskDao;
import com.csx.workflow.model.HistoryCheckedTask;
import com.csx.workflow.model.TaskAPIData;
import com.csx.workflow.model.TaskData;
import com.csx.workflow.service.TaskServiceEx;
import com.csx.workflow.utils.ImaGegenerateUtils;
import org.activiti.engine.HistoryService;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;



/**
 * Created by wyp on 2017/3/10.
 */
@Service
public class TaskServiceExImpl implements TaskServiceEx {

	@Autowired
	private TaskService taskService;

	@Autowired
	private TaskDao taskDao;
	@Autowired
	private HistoryCheckedTaskDao historyCheckedTaskDao;
	@Autowired
	private HistoryService historyService;
	@Autowired
	private RuntimeService runtimeService;
	@Autowired
	private ProcessEngine processEngine;

	@Autowired
	private RepositoryService repositoryService;
	@Autowired
	private HistoricTaskInstanceExDao historicTaskInstanceExDao;

	/**
	 * 分页查询待办事项
	 *
	 * @param taskAPIData
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	@Override
	public PageInfo<TaskData> TaskList(TaskAPIData taskAPIData, Integer pageNo, Integer pageSize) {
		PageHelper.startPage(pageNo, pageSize);
		HistoryCheckedTask historyCheckedTask=new HistoryCheckedTask();
		historyCheckedTask.setTaskAssigin(taskAPIData.getHanderId());
		List<TaskData> list = taskDao.queryByUserIdList(taskAPIData.getHanderId());
		PageInfo pageInfo = new PageInfo(list);
		return pageInfo;
	}

	@Override
	public String doTask(String systemId, String userId, String taskId, JSONObject parameter) {
		return null;
	}

	@Override
	public Boolean isProcessStop(String taskId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PageInfo<HistoryCheckedTask> TaskCompletedList(TaskAPIData taskAPIDataParam, Integer pageNo, Integer pageSize) {
		PageHelper.startPage(pageNo, pageSize);
		HistoryCheckedTask historyCheckedTask=new HistoryCheckedTask();
		historyCheckedTask.setTaskAssigin(taskAPIDataParam.getHanderId());
		// TaskAPIData taskAPIData1 = new TaskAPIData();
		List<HistoryCheckedTask> list = historyCheckedTaskDao.queryPage(historyCheckedTask);
		PageInfo pageInfo = new PageInfo(list);
		return pageInfo;
	}

	@Override
	public List<ImaGegenerateUtils.UserTaskInfo> queryTaskInfoByProcessInstanceId(String processInstanceId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> handleCheckedCompletedData(Map<String, Object> completeData) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ImaGegenerateUtils.UserTaskInfo> handleSkipNode(String systemId, String userId, String taskId, JSONObject parameter,
																String type) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PageInfo<TaskAPIData> taskDistinctCompletedList(TaskAPIData taskAPIDataParam, Integer pageNo,
			Integer pageSize) {
		// TODO Auto-generated method stub
		return null;
	}

}

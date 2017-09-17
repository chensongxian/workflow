package com.csx.workflow.service;

import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.csx.workflow.model.HistoryCheckedTask;
import com.csx.workflow.model.TaskAPIData;
import com.csx.workflow.model.TaskData;
import com.csx.workflow.utils.ImaGegenerateUtils;
import com.github.pagehelper.PageInfo;



/**
 * Created by wyp on 2017/3/10.
 * 针对引擎的taskService的扩展
 */
public interface TaskServiceEx {

    /**
     * 完成任务 返回流程实例id
     * @param systemId
     * @param userId
     * @param taskId
     * @param parameter
     */
    String doTask(String systemId, String userId, String taskId, JSONObject parameter);

    /**
     * 通过任务节点判定流程是否结束
     * @param taskId
     * @return
     */
    public Boolean isProcessStop(String taskId);

    /**
     * 分页查询代办事项
     * @param taskAPIData
     * @param pageSize
     * @return
     */
    PageInfo<TaskData> TaskList(TaskAPIData taskAPIData, Integer pageNo, Integer pageSize);


    /**
     * 已办事项
     * @param taskAPIDataParam
     * @param pageNo
     * @param pageSize
     * @return
     */
    PageInfo<HistoryCheckedTask> TaskCompletedList(TaskAPIData taskAPIDataParam, Integer pageNo, Integer pageSize);

    /**
     * 根据流程实例id获取流程当前运行节点情况
     * @param processInstanceId
     * @return
     */
    public List<ImaGegenerateUtils.UserTaskInfo>  queryTaskInfoByProcessInstanceId(String processInstanceId);

    /**
     * 对请求的数据进行处理
     * @return
     */
    public Map<String,Object> handleCheckedCompletedData(Map<String, Object> completeData);

    /**
     * 执行跳转的节点
     * @param systemId
     * @param userId
     * @param taskId
     * @param parameter
     * @return
     */
    public List<ImaGegenerateUtils.UserTaskInfo>  handleSkipNode(String systemId, String userId, String taskId, JSONObject parameter, String type);


    /**
     * 去掉重复审核的任务节点
     * @param taskAPIDataParam
     * @param pageNo
     * @param pageSize
     * @return
     */
    PageInfo<TaskAPIData> taskDistinctCompletedList(TaskAPIData taskAPIDataParam, Integer pageNo, Integer pageSize);
}

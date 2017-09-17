package com.csx.workflow.dao;

import com.csx.workflow.model.HistoricTaskInstanceEx;

import java.util.List;



/**
 * Created by wyp on 2017/4/8.
 * 任务历史查询
 */
public interface HistoricTaskInstanceExDao {

    List<HistoricTaskInstanceEx> queryHistoricTaskByProcessInstanceId(HistoricTaskInstanceEx historicTaskInstanceEx);

    /**
     * 通过任务节点 获取历史任务
     * @return
     */
    List<HistoricTaskInstanceEx> queryHistoryTasksByTaskId(HistoricTaskInstanceEx historicTaskInstanceEx);

}

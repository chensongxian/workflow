package com.csx.workflow.dao;


import com.csx.workflow.model.HistoryCheckedTask;

import java.util.List;


/**
 * 历史所有审批节点
 */
public interface HistoryCheckedTaskDao {
    /**
     * 分页查询历史审批的信息
     * @param historyCheckedTask
     * @return
     */
    List<HistoryCheckedTask>  queryPage(HistoryCheckedTask historyCheckedTask);

}

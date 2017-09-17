package com.csx.workflow.dao;

import com.csx.workflow.model.TaskAPIData;
import com.csx.workflow.model.TaskData;

import java.util.List;



/**
 * Created by wyp on 2017/3/6.
 * 人工任务dao
 */
public interface TaskDao {
    /**
     * 通过登录人id查询当前用户的待办事项
     * @return
     */
    List<TaskData> queryByUserIdList(String userId);


    /**
     * 查询代办
     * @param taskAPIData
     * @return
     */
    List<TaskAPIData> queryByUserIdAndSystemIdList(TaskAPIData taskAPIData);

    /**
     * 查询已办事项
     * @param taskAPIData
     * @return
     */
    List<TaskAPIData> queryByUserIdAndSystemIdChecked(TaskAPIData taskAPIData);

    /**
     * 已审核的流程去重
     * @param taskAPIData
     * @return
     */
    List<TaskAPIData> queryDistinctProcessByUserIdAndSystemIdChecked(TaskAPIData taskAPIData);
}

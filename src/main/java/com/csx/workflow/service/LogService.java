package com.csx.workflow.service;

import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.csx.workflow.model.CheckData;


/**
 * Created by wyp on 2017/4/11.
 */
public interface LogService {

    /**
     * 查看流程操作日志
     * @param processInstanceId
     * @return
     */
    List<CheckData> queryHandleLogByProcessInstanceId(String processInstanceId);

    /**
     * 查询审核日志
     * @param processInstanceId
     * @return
     */
    List<JSONObject> queryCheckLogByProcessInstanceId(String processInstanceId, String type);
}

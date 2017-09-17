package com.csx.workflow.service;

import com.csx.workflow.model.UserTaskNodeInfo;

import java.io.InputStream;
import java.util.List;
import java.util.Map;



/**
 * Created by Administrator on 2016/10/19.
 * 高亮显示流程图
 */
public interface ActivitiPicService {

    /**
     * 查询各个节点信息 已经发起的或者已经完成的
     * @param processId 根据流程实例id
     * @return
     */
    public List<UserTaskNodeInfo> queryActivitis(String processId);


    /**
     * 未发起的流程图节点信息
     * @param processDefKey 流程定义key
     * @return
     */
    public List<Map<String, Object>> queryActivitisByDefKey(String processDefKey);

    /**
     * 根据流程定义key获取流程图 流程未开始的
     * @param processDefKey
     * @return
     */
    public InputStream getActivitiPicByProcessDefKey(String processDefKey);


    /**
     * 已经开启流程的或者完成高亮显示流程图
     * @param processId 流程实例id
     * @return
     */
    public   InputStream getActivitiPicModelByProcessId(String processId);

    /**
     * 获取自动生成的
     * @param processId
     * @return
     */
    public InputStream createCustomeActivitiPicByProcessId(String processId);

    /**
     * 获取已完成的节点信息
     * @param processId
     * @return
     */
    public List<UserTaskNodeInfo> getUserTaskNodeInfos(String processId);

}

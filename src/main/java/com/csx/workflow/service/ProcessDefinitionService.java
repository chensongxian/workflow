package com.csx.workflow.service;

import java.util.List;

import com.csx.workflow.model.Page;
import com.csx.workflow.model.ProcessDefEntity;
import com.github.pagehelper.PageInfo;



/**
 * Created by Administrator on 2016/12/27.
 */
public interface ProcessDefinitionService {

    public List<ProcessDefEntity> queryProcessDefList();

    /**
     * 分页查询所有的
     * @param startResult
     * @param maxResult
     * @return
     */
    public Page queryProcessDefPage(Integer startResult, Integer maxResult);


    /**
     * 分页查询所有的流程
     * @param processDefEntity
     * @return
     */
    public PageInfo<ProcessDefEntity> queryPageAllProcess(ProcessDefEntity processDefEntity, Integer start, Integer max);


    /**
     * 根据流程key查询流程实体
     * @param processKey
     * @return
     */
    public ProcessDefEntity queryProcessByKey(String processKey);
}

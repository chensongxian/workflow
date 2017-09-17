package com.csx.workflow.service;

/**
 * 流程模型管理
 */
public interface ProcessModelManagerService {

    /**
     * 流程模型启动变为流程定义
     * @param modelId
     */
    void processModelStart(String modelId)throws Exception;




}

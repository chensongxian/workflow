package com.csx.workflow.service.impl;

import java.util.ArrayList;
import java.util.List;

import com.csx.workflow.dao.ProcessDao;
import com.csx.workflow.model.Page;
import com.csx.workflow.model.ProcessDefEntity;
import com.csx.workflow.service.ProcessDefinitionService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.ProcessDefinition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;



/**
 * Created by Administrator on 2016/12/27.
 */
@Service
public class ProcessDefinitionServiceImpl  implements ProcessDefinitionService {


    @Autowired
    private RepositoryService repositoryService;

    @Autowired
    private ProcessDao processDao;

    /**
     * 不分页查询所有的流程
     * @return
     */
    public List<ProcessDefEntity> queryProcessDefList() {
        List<ProcessDefinition> processDefinitionList =repositoryService.createProcessDefinitionQuery().latestVersion().list();
        List<ProcessDefEntity> list = new ArrayList<>();
        for(ProcessDefinition processDefinition:processDefinitionList){
            ProcessDefEntity processDefEntity = new ProcessDefEntity();
            //processDefEntity.setId(processDefinition.getDeploymentId());
            processDefEntity.setDefKey(processDefinition.getKey());
            processDefEntity.setProcessDefName(processDefinition.getName());
            list.add(processDefEntity);
        }
        return list;
    }

    /**
     * 分页查询所有的流程
     * @param processDefEntity
     * @return
     */
    public PageInfo<ProcessDefEntity> queryPageAllProcess(ProcessDefEntity processDefEntity, Integer start, Integer max){
        PageHelper.startPage(start,max);
        List<ProcessDefEntity> list= processDao.queryPageAllProcess(processDefEntity);
        PageInfo<ProcessDefEntity> pageInfo = new PageInfo<>(list);
        return pageInfo;

    }

    /**
     * 根据流程key查询流程实体
     * @param processKey
     * @return
     */
    public ProcessDefEntity queryProcessByKey(String processKey){
         return processDao.queryProcessByKey(processKey);
    }


    /**
     * 分页查询所有的
     * @param startResult
     * @param maxResult
     * @return
     */
    public Page queryProcessDefPage(Integer startResult, Integer maxResult){
        Page page = new Page();
        List<ProcessDefinition> processDefinitionList =repositoryService.createProcessDefinitionQuery().latestVersion().listPage(startResult,maxResult);
        List<ProcessDefEntity> list = new ArrayList<>();
        for(ProcessDefinition processDefinition:processDefinitionList){
            ProcessDefEntity processDefEntity = new ProcessDefEntity();
            processDefEntity.setDefKey(processDefinition.getKey());
            processDefEntity.setProcessDefName(processDefinition.getName());
            list.add(processDefEntity);
        }
        page.setRows(list);
        page.setPage(startResult);
        page.setTotal(activityCount());
        return page;
    }



    private Long activityCount(){
        return  repositoryService.createProcessDefinitionQuery().latestVersion().count();
    }


}

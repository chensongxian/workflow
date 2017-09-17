package com.csx.workflow.utils;

import java.util.List;

import org.activiti.engine.HistoryService;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricVariableInstance;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;

/**
 * Created by wyp on 2017/4/26.
 * 流程实例utils
 */
public class ProcessInstanceUtils {
    /**
     * 判定当前实例是否已经结束
     * @param processEngine
     * @param processInstanceId
     * @return
     */
    public static boolean isStop(ProcessEngine processEngine,String processInstanceId){
        List<ProcessInstance> list = processEngine.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).list();
        if(list==null || list.size()==0){
            return true;
        }
        return false;
    }

    /**
     * 获取历史流程变量
     * @param processId
     * @param valName
     * @return
     */
    public static Object getHistoryVar(HistoryService historyService, String processId, String valName){
        if(processId==null||processId.equals("")){
            return null;
        }
        List<HistoricVariableInstance> variableInstances = historyService.createHistoricVariableInstanceQuery().processInstanceId(processId).variableName(valName).list();
        if(variableInstances==null || variableInstances.size()==0){
            return null;
        }
        return variableInstances.get(variableInstances.size()-1).getValue();
    }

    /**
     * 获取运行中的变量
     * @param runtimeService
     * @param processId
     * @param varName
     * @return
     */
    public static <T> T getRuntimeVar(RuntimeService runtimeService,String processId,String varName,Class<T> variableClass){
        if(ObjectCheckUtils.isEmptyString(processId)){
            return null;
        }
       return variableClass.cast(runtimeService.getVariable(processId,varName));

    }

    /**
     * 通过流程实例id获取流程定义信息
     * @param processInstanceId
     * @return
     */
    public static ProcessDefinition getProcessDefByProcessInstanceId(ProcessEngine processEngine,String processInstanceId){
       List<HistoricProcessInstance> historicProcessInstances =   processEngine.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).list();
        if(historicProcessInstances!=null&& historicProcessInstances.size()>0){
            HistoricProcessInstance historicProcessInstance = historicProcessInstances.get(0);
            ProcessDefinition processDefinition = processEngine.getRepositoryService().createProcessDefinitionQuery().processDefinitionId(historicProcessInstance.getProcessDefinitionId()).singleResult();
            return processDefinition;
        }
        return null;
    }






}

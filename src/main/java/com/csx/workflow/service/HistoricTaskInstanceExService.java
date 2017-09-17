package com.csx.workflow.service;


import com.csx.workflow.model.HistoricTaskInstanceEx;
import com.csx.workflow.model.HistoricTaskInstanceType;

/**
 * Created by wyp on 2017/4/8.
 */
public interface HistoricTaskInstanceExService {

    public HistoricTaskInstanceType queryHistoricTaskByProcessInstanceId(HistoricTaskInstanceEx historicTaskInstanceEx);



}

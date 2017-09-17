package com.csx.workflow.service;

import com.csx.workflow.model.ProcessType;

import java.util.List;




public interface ProcessTypeService {

    List<ProcessType> queryList(ProcessType processType);

    ProcessType queryById(String id);
}

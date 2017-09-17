package com.csx.workflow.dao;

import com.csx.workflow.model.ProcessType;

import java.util.List;



/**
 * Created by wyp on 2017/4/18.
 */
public interface ProcessTypeDao {

    List<ProcessType> queryList(ProcessType processType);

    ProcessType queryById(String codeId);

 }

package com.csx.workflow.service;


import com.csx.workflow.model.Page;
import com.csx.workflow.model.ProcessModel;


/**
 * Created by Administrator on 2017/1/18.
 */
public interface ProcessModelService {

    Page queryPage(ProcessModel model, Integer start, Integer max);
    
    ProcessModel selectOneById(String id);

	boolean copyModel(String id);
    
}

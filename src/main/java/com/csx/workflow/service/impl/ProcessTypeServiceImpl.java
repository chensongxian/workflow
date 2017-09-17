package com.csx.workflow.service.impl;

import java.util.List;

import com.csx.workflow.dao.ProcessTypeDao;
import com.csx.workflow.model.ProcessType;
import com.csx.workflow.service.ProcessTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;




@Service
public class ProcessTypeServiceImpl implements ProcessTypeService {
    @Autowired
    private ProcessTypeDao processTypeDao;


    @Override
    public List<ProcessType> queryList(ProcessType processType) {
        return processTypeDao.queryList(processType);
    }

    @Override
    public ProcessType queryById(String id) {
        return processTypeDao.queryById(id);
    }
}

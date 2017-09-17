package com.csx.workflow.service.impl;

import java.util.List;

import com.csx.workflow.dao.ActCreationDaoEx;
import com.csx.workflow.model.ActCreationEx;
import com.csx.workflow.service.ActCreationServiceEx;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by wyp on 2017/4/13.
 */
@Service
public class ActCreationServiceExImpl implements ActCreationServiceEx {
    @Autowired
    private ActCreationDaoEx actCreationDaoEx;

    @Override
    public List<ActCreationEx> query(ActCreationEx actCreationEx) {
        return  actCreationDaoEx.query(actCreationEx);
    }

    @Override
    @Transactional
    public void updateByProcessInstanceId(String processInstanceId) {
        actCreationDaoEx.update(processInstanceId);
    }


}

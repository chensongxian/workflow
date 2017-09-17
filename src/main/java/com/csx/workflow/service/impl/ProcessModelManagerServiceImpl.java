package com.csx.workflow.service.impl;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.Date;

import com.csx.workflow.service.ProcessModelManagerService;
import org.activiti.bpmn.converter.BpmnXMLConverter;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.editor.language.json.converter.BpmnJsonConverter;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.DeploymentBuilder;
import org.activiti.engine.repository.Model;
import org.activiti.engine.repository.ProcessDefinition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;




/**
 * Created by Administrator on 2017/1/17.
 */
@Service
public class ProcessModelManagerServiceImpl implements ProcessModelManagerService {

    @Autowired
    private RepositoryService repositoryService;
    /**
     * 流程定义部署
     * @param modelId
     * @throws IOException
     */
    @Override
    @Transactional
    public void processModelStart(String modelId) throws Exception {
        byte[] bpmnBytes = null;
        String filename = null;
        JsonNode editorNode = new ObjectMapper().readTree(repositoryService.getModelEditorSource(modelId));
        BpmnJsonConverter jsonConverter = new BpmnJsonConverter();
        BpmnModel model = jsonConverter.convertToBpmnModel(editorNode);
       //filename = model.getMainProcess().getId() + ".bpmn20.xml";
        filename = model.getMainProcess().getName()+new Date().getTime()+".bpmn20.xml";
        bpmnBytes = new BpmnXMLConverter().convertToXML(model);
        System.out.println(new String(bpmnBytes));
        ByteArrayInputStream in = new ByteArrayInputStream(bpmnBytes);
        DeploymentBuilder deploymentBuilder = repositoryService.createDeployment();
        Model model1 = repositoryService.getModel(modelId);
        //部署进去后
        deploymentBuilder.addInputStream(filename,in);
        deploymentBuilder.tenantId(model1.getTenantId());
        Deployment deployment = deploymentBuilder.deploy();
        //发布
       ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().deploymentId(deployment.getId()).singleResult();
        model1.setDeploymentId(deployment.getId());
        repositoryService.saveModel(model1);
    }




}

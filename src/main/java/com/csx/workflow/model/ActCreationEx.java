package com.csx.workflow.model;

/**
 * 节点创建扩展model
 */
public class ActCreationEx {

    private Integer id;
    private String factoryName;
    private String processDefinitionId;
    private String doUserId;
    private String actId;
    private String processInstanceId;
    private String processText;
    private Integer state;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFactoryName() {
        return factoryName;
    }

    public void setFactoryName(String factoryName) {
        this.factoryName = factoryName;
    }

    public String getProcessDefinitionId() {
        return processDefinitionId;
    }

    public void setProcessDefinitionId(String processDefinitionId) {
        this.processDefinitionId = processDefinitionId;
    }

    public String getDoUserId() {
        return doUserId;
    }

    public void setDoUserId(String doUserId) {
        this.doUserId = doUserId;
    }

    public String getActId() {
        return actId;
    }

    public void setActId(String actId) {
        this.actId = actId;
    }

    public String getProcessInstanceId() {
        return processInstanceId;
    }

    public void setProcessInstanceId(String processInstanceId) {
        this.processInstanceId = processInstanceId;
    }

    public String getProcessText() {
        return processText;
    }
    public String getProcessTextjson() {
    	
    	return processText;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public void setProcessText(String processText) {
        this.processText = processText;
    }

    @Override
    public String toString() {
        return "ActCreationEx{" +
                "id=" + id +
                ", factoryName='" + factoryName + '\'' +
                ", processDefinitionId='" + processDefinitionId + '\'' +
                ", doUserId='" + doUserId + '\'' +
                ", actId='" + actId + '\'' +
                ", processInstanceId='" + processInstanceId + '\'' +
                ", processText='" + processText + '\'' +
                ", state=" + state +
                '}';
    }
}

package com.csx.workflow.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 流程定义模型
 */
public class ProcessModel implements Serializable{
    private static final long serialVersionUID = 1L;

    //模型id
    private String modelId;
    private String modelName;
    //模型key
    private String modelKey;
    //流程部署id
    private String deployId;


    //模型版本
    private Integer version;
    //模型创建时间
    private Date createTime;
    protected String editorSourceValueId;
    protected String editorSourceExtraValueId;
    private Date updateTime;
    //流程部署时间
    private Date deployTime;
    //流程定义key
    private String processDefKey;

    //流程定义名称
    private String processName;
    //流程定义版本
    private Integer processDefVersion;

    private String systemId;

    public String getModelId() {
        return modelId;
    }

    public void setModelId(String modelId) {
        this.modelId = modelId;
    }

    public String getModelKey() {
        return modelKey;
    }

    public void setModelKey(String modelKey) {
        this.modelKey = modelKey;
    }

    public String getDeployId() {
        return deployId;
    }

    public void setDeployId(String deployId) {
        this.deployId = deployId;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Date getDeployTime() {
        return deployTime;
    }

    public void setDeployTime(Date deployTime) {
        this.deployTime = deployTime;
    }

    public String getProcessDefKey() {
        return processDefKey;
    }

    public void setProcessDefKey(String processDefKey) {
        this.processDefKey = processDefKey;
    }

    public String getProcessName() {
        return processName;
    }

    public void setProcessName(String processName) {
        this.processName = processName;
    }

    public String getModelName() {
        return modelName;
    }

    public void setModelName(String modelName) {
        this.modelName = modelName;
    }

    public Integer getProcessDefVersion() {
        return processDefVersion;
    }

    public void setProcessDefVersion(Integer processDefVersion) {
        this.processDefVersion = processDefVersion;
    }

    public String getSystemId() {
        return systemId;
    }

    public void setSystemId(String systemId) {
        this.systemId = systemId;
    }

	public String getEditorSourceValueId() {
		return editorSourceValueId;
	}

	public void setEditorSourceValueId(String editorSourceValueId) {
		this.editorSourceValueId = editorSourceValueId;
	}

	public String getEditorSourceExtraValueId() {
		return editorSourceExtraValueId;
	}

	public void setEditorSourceExtraValueId(String editorSourceExtraValueId) {
		this.editorSourceExtraValueId = editorSourceExtraValueId;
	}

	@Override
	public String toString() {
		return "ProcessModel [modelId=" + modelId + ", modelName=" + modelName
				+ ", modelKey=" + modelKey + ", deployId=" + deployId
				+ ", version=" + version + ", createTime=" + createTime
				+ ", editorSourceValueId=" + editorSourceValueId
				+ ", editorSourceExtraValueId=" + editorSourceExtraValueId
				+ ", updateTime=" + updateTime + ", deployTime=" + deployTime
				+ ", processDefKey=" + processDefKey + ", processName="
				+ processName + ", processDefVersion=" + processDefVersion
				+ ", systemId=" + systemId + "]";
	}

    
}

package com.csx.workflow.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 历史节点数据
 */
public class HistoricTaskInstanceEx implements Serializable {
    private static final long serialVersionUID = 1L;
    //执行id
    private String processDefinitionId;
    private String processInstanceId;
    private String name;
    private String owner;
    private String assignee;
    private String taskKey;
    private String formKey;
    private Integer priority;
    //删除原因需要扩展
    private String deleteReason;
    //系统id
    private String tenantId;
    private Date startTime;
    private Date endTime;
    private Date dueDate;

    private String taskId;


    public String getProcessDefinitionId() {
        return processDefinitionId;
    }

    public void setProcessDefinitionId(String processDefinitionId) {
        this.processDefinitionId = processDefinitionId;
    }

    public String getProcessInstanceId() {
        return processInstanceId;
    }

    public void setProcessInstanceId(String processInstanceId) {
        this.processInstanceId = processInstanceId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public String getAssignee() {
        return assignee;
    }

    public void setAssignee(String assignee) {
        this.assignee = assignee;
    }

    public String getTaskKey() {
        return taskKey;
    }

    public void setTaskKey(String taskKey) {
        this.taskKey = taskKey;
    }

    public String getFormKey() {
        return formKey;
    }

    public void setFormKey(String formKey) {
        this.formKey = formKey;
    }

    public Integer getPriority() {
        return priority;
    }

    public void setPriority(Integer priority) {
        this.priority = priority;
    }

    public String getDeleteReason() {
        return deleteReason;
    }

    public void setDeleteReason(String deleteReason) {
        this.deleteReason = deleteReason;
    }

    public String getTenantId() {
        return tenantId;
    }

    public void setTenantId(String tenantId) {
        this.tenantId = tenantId;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        HistoricTaskInstanceEx that = (HistoricTaskInstanceEx) o;

        return taskKey.equals(that.taskKey);

    }

    @Override
    public int hashCode() {
        return taskKey.hashCode();
    }

    public String getTaskId() {
        return taskId;
    }

    public void setTaskId(String taskId) {
        this.taskId = taskId;
    }

    @Override
    public String toString() {
        return "HistoricTaskInstanceEx{" +
                "processDefinitionId='" + processDefinitionId + '\'' +
                ", processInstanceId='" + processInstanceId + '\'' +
                ", name='" + name + '\'' +
                ", owner='" + owner + '\'' +
                ", assignee='" + assignee + '\'' +
                ", taskKey='" + taskKey + '\'' +
                ", formKey='" + formKey + '\'' +
                ", priority=" + priority +
                ", deleteReason='" + deleteReason + '\'' +
                ", tenantId='" + tenantId + '\'' +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", dueDate=" + dueDate +
                ", taskId='" + taskId + '\'' +
                '}';
    }
}

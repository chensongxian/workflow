package com.csx.workflow.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 已审批数据
 */
public class HistoryCheckedTask implements Serializable{

    private static final long serialVersionUID = 1L;
    //任务id
    private String taskId;
    //任务名称节点名称
    private String taskName;
    //流程实例id
    private String processId;
    //任务类型
    private String taskType;

    private Date startTime;
    //任务操作人
    private String taskAssigin;
    private String endTime;
    //任务发起人
    private String applayName;
    //result是否可以撤回
    private boolean result;

    private String taskKey;

    public String getTaskId() {
        return taskId;
    }

    public void setTaskId(String taskId) {
        this.taskId = taskId;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public String getProcessId() {
        return processId;
    }

    public void setProcessId(String processId) {
        this.processId = processId;
    }

    public String getTaskType() {
        return taskType;
    }

    public void setTaskType(String taskType) {
        this.taskType = taskType;
    }

    public String getTaskAssigin() {
        return taskAssigin;
    }

    public void setTaskAssigin(String taskAssigin) {
        this.taskAssigin = taskAssigin;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getApplayName() {
        return applayName;
    }

    public void setApplayName(String applayName) {
        this.applayName = applayName;
    }

    public boolean isResult() {
        return result;
    }

    public void setResult(boolean result) {
        this.result = result;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    @Override
    public String toString() {
        return "HistoryCheckedTask{" +
                "taskId='" + taskId + '\'' +
                ", taskName='" + taskName + '\'' +
                ", processId='" + processId + '\'' +
                ", taskType='" + taskType + '\'' +
                ", startTime=" + startTime +
                ", taskAssigin='" + taskAssigin + '\'' +
                ", endTime='" + endTime + '\'' +
                ", applayName='" + applayName + '\'' +
                ", result=" + result +
                '}';
    }
}

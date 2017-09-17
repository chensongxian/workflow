package com.csx.workflow.model;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang3.time.DateUtils;

/**
 * 审批数据
 */
public class CheckInfo implements Serializable{

    private static final long serialVersionUID = 1L;
    //任务名称
    private String taskName;
    private String taskKey;
    //处理结果
    private Boolean result;
    //审批备注
    private String remark;
    private String branchName;
    private String departmentName;
    private String roleName;
    private String userName;
    private Date doTime ;

    public String getTaskName() {
        return taskName;
    }

    public Date getDoTime() {
        return doTime;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public void setDoTime(Date doTime) {
        this.doTime = doTime;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public String getTaskKey() {
        return taskKey;
    }

    public void setTaskKey(String taskKey) {
        this.taskKey = taskKey;
    }

    public Boolean getResult() {
        return result;
    }

    public void setResult(Boolean result) {
        this.result = result;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Override
    public String toString() {
        return "CheckInfo{" +
                "taskName='" + taskName + '\'' +
                ", taskKey='" + taskKey + '\'' +
                ", result=" + result +
                ", remark='" + remark + '\'' +
                ", departmentName='" + departmentName + '\'' +
                ", roleName='" + roleName + '\'' +
                ", userName='" + userName + '\'' +
                ", doTime=" + doTime +
                '}';
    }
}

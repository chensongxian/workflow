package com.csx.workflow.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 审批数据
 */
public class CheckData implements Serializable{

    private static final long serialVersionUID = 1L;
    //任务名称
    private String taskName;
    //审批人
    private String checkUser;

    public String getDoWhat() {
        return doWhat;
    }

    public void setDoWhat(String doWhat) {
        this.doWhat = doWhat;
    }
    //操作
    private String doWhat;
    //审批的结果
    private String checkResult;
    //审批备注
    private String remark;
    private Date doTime;



    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public String getCheckUser() {
        return checkUser;
    }

    public void setCheckUser(String checkUser) {
        this.checkUser = checkUser;
    }

    public String getCheckResult() {
        return checkResult;
    }

    public void setCheckResult(String checkResult) {
        this.checkResult = checkResult;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Date getDoTime() {
        return doTime;
    }

    public void setDoTime(Date doTime) {
        this.doTime = doTime;
    }

    @Override
    public String toString() {
        return "CheckData{" +
                "taskName='" + taskName + '\'' +
                ", checkUser='" + checkUser + '\'' +
                ", doWhat='" + doWhat + '\'' +
                ", checkResult='" + checkResult + '\'' +
                ", remark='" + remark + '\'' +
                ", doTime=" + doTime +
                '}';
    }
}

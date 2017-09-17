package com.csx.workflow.model;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by wyp on 2017/4/10.
 * 操作日志
 */
public class HandlerLog implements Serializable{
    private static final long serialVersionUID = 1L;
    private String handleUser;
    private Date handleTime;
    //备注
    private String remark;
/*  1代表正常审核
    2.代表不通过
    3.代表填写表单
    4 代表回退 回退原因（跳转）
    5.代表重复通过
    6代表加节点
    7.代表终止流程*/
    private String type;

    public String getHandleUser() {
        return handleUser;
    }

    public void setHandleUser(String handleUser) {
        this.handleUser = handleUser;
    }

    public Date getHandleTime() {
        return handleTime;
    }

    public void setHandleTime(Date handleTime) {
        this.handleTime = handleTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "HandlerLog{" +
                "handleUser='" + handleUser + '\'' +
                ", handleTime=" + handleTime +
                ", remark='" + remark + '\'' +
                ", type=" + type +
                '}';
    }
}

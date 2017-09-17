package com.csx.workflow.model;

import java.io.Serializable;


/**
 * 流程类型
 */
public class ProcessType implements Serializable{

    private static final long serialVersionUID = 1L;

    private Integer id;
    //类别id
    private String codeId;

    private Integer pid;

    private Integer state;
    //分类名称
    private String name;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCodeId() {
        return codeId;
    }

    public void setCodeId(String codeId) {
        this.codeId = codeId;
    }

    @Override
    public String toString() {
        return "ProcessType{" +
                "id=" + id +
                ", pid=" + pid +
                ", state=" + state +
                ", name='" + name + '\'' +
                '}';
    }
}

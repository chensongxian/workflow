package com.csx.workflow.model;

import java.io.Serializable;
import java.util.List;

/**
 * 查询历史信息
 */
public class HistoricTaskInstanceType implements Serializable{


    private static final long serialVersionUID = 1L;

    private List<HistoricTaskInstanceEx> historicTaskInstanceEx;
    //0代表未完成 1代表流程已结束
    private Integer type;
    //原始节点活动节点
    private String currentId;
    //高亮显示的节点
    private List<String> hignNodeIds;







    public List<HistoricTaskInstanceEx> getHistoricTaskInstanceEx() {
        return historicTaskInstanceEx;
    }

    public void setHistoricTaskInstanceEx(List<HistoricTaskInstanceEx> historicTaskInstanceEx) {
        this.historicTaskInstanceEx = historicTaskInstanceEx;
    }


    public List<String> getHignNodeIds() {
        return hignNodeIds;
    }

    public void setHignNodeIds(List<String> hignNodeIds) {
        this.hignNodeIds = hignNodeIds;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getCurrentId() {
        return currentId;
    }

    public void setCurrentId(String currentId) {
        this.currentId = currentId;
    }

    @Override
    public String toString() {
        return "HistoricTaskInstanceType{" +
                "historicTaskInstanceEx=" + historicTaskInstanceEx +
                ", type='" + type + '\'' +
                ", currentId='" + currentId + '\'' +
                ", hignNodeIds=" + hignNodeIds +
                '}';
    }
}

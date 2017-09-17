package com.csx.workflow.model;

import java.io.Serializable;
import java.util.List;

/**
 * Created by wyp on 2017/4/17.
 */
public class UserTaskNodeInfo implements Serializable{

    private static final long serialVersionUID = 1L;

    private double width;
    private double height;
    private double x;
    private double y;
    private String taskKey;
    private String name;
    private List<CheckInfo> checkInfoList;


    public double getWidth() {
        return width;
    }

    public void setWidth(double width) {
        this.width = width;
    }

    public double getHeight() {
        return height;
    }

    public void setHeight(double height) {
        this.height = height;
    }

    public double getX() {
        return x;
    }

    public void setX(double x) {
        this.x = x;
    }

    public double getY() {
        return y;
    }

    public void setY(double y) {
        this.y = y;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<CheckInfo> getCheckInfoList() {
        return checkInfoList;
    }

    public void setCheckInfoList(List<CheckInfo> checkInfoList) {
        this.checkInfoList = checkInfoList;
    }

    public String getTaskKey() {
        return taskKey;
    }

    public void setTaskKey(String taskKey) {
        this.taskKey = taskKey;
    }

    @Override
    public String toString() {
        return "UserTaskNodeInfo{" +
                "width=" + width +
                ", height=" + height +
                ", x=" + x +
                ", y=" + y +
                ", taskKey='" + taskKey + '\'' +
                ", name='" + name + '\'' +
                ", checkInfoList=" + checkInfoList +
                '}';
    }
}

package com.csx.workflow.utils;

/**
 * Created by wyp on 2017/4/10.
 * 节点状态记录
 */
public interface NodeHandleType {
    //任务节点通过
    public static final String NODE_PASS = "1";
    //任务节点不通过
    public static final String NODE_NO_PASS = "2";
    //节点提交
    public static final String NODE_SUBMIT = "3";
    //节点回退
    public static final String NODE_BACK = "4";
    //节点重复直接跳过
    public static final String NODE_REPEART = "5";
    //删除之后的节点
    public static final String ADD_NODE_DELETE = "6";
    //终止流程
    public static final String PROCESS_DELETE = "7";
    //多实例并行节点删除
    public static final String NODE_PARALLEL_DELETE = "8";
    //知会节点自动通过
    public static final String INFORM_NODE_COMPLETE = "9";
    //无人自动跳过
    public static final String NO_HANDLE_SKILLP = "10";

    //节点回退过程中删除当前运行的节点
    public static final String NODE_BACK_DELETE = "11";


}

package com.csx.workflow.utils;

/**
 * 内置的流程变量字典
 */
public interface InnerActivitiVarConstants {
    //流程的上一步处理人id变量
    public static final String HM_ACITVITI_PRE_HANDLER_ID = "HM_ACITVITI_PRE_HANDLER_ID";
    //流程处理审核人

    //流程审核处理结果变量
    public static final String HM_ACITVITI_PROCESS_RESULT = "HM_ACITVITI_PROCESS_RESULT";

    public static final String HM_ACITVITI_CHECK_ADVICE_INFO ="HM_ACITVITI_CHECK_ADVICE_INFO";
    //发起人的所属公司
    public static final String HM_ACTIVITI_START_BRANCH_ID = "HM_ACTIVITI_START_BRANCH_ID";

    //发起人的部门id
    public static final String HM_ACTIVITI_START_DEPARTMENT_ID = "HM_ACTIVITI_START_DEPARTMENT_ID";
    //发起人的层级结构
    public static final String HM_ACTIVTI_START_ORGIN_LAY = "HM_ACTIVTI_START_ORGIN_LAY";
}

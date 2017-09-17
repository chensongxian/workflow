package com.csx.workflow.utils;

/**
 * 审批中各节点处理事件的操作用于日志输出的
 */
public interface InnerBusinessVarConstants {
    //操作类型
    public static final String DO_WHAT ="doWhat";

    //节点同意不同意的信息
    public static final String TASK_RESULT ="result";
    //节点意见
    public static  final  String TASK_REMARK = "remark";


    //流程实例名称
    public static final String PROCESS_INSTANCE_NAME = "processInstanceName";

    //流程key
    public static final String PROCESS_KEY = "key";

    //用户信息
    //公司id
    public static final String BRANCH_ID = "branchId";
    //公司名称
    public static final String BRANCH_NAME = "branchName";

    public static final String ORG_LEVEL ="orgLayer";

    public static final String DEPARTMETN_LEVEL ="departmentLevel";

    //部门id
    public static final String DEPARTMENT_ID = "departmentId";

    //部门名称
    public static final String DEPARTMENT_NAME = "departmentName";
    //调岗之后的部门层级关系
    public static final String AFTER_ORG_LAYER = "afterOrgLayer";
    //获取调岗之后部门级别
    public static final String AFTER_DEPARTMETN_LEVEL= "afterDepartmentLevel";

    //岗位id
    public static final String ROLE_ID = "roleId";
    //岗位名称
    public static final String ROLE_NAME = "roleName";

    //员工id
    public static final String USER_ID = "userId";
    //员工名称
    public static final String USER_NAME = "userName";

    //发起人id
    public static final String START_ID = "startUserId";
    //发起人名称
    public static final String STARTER_NAME = "starterName";

    //上传文件地址
    public static final String  FILE_URL_PATH = "fileUrlPath";
    //业务key
    public static final String  BUSINESS_KEY = "businessKey";


















}

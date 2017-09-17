#创建流程任务变量池表
DROP TABLE IF EXISTS act_task_var_pool;
CREATE TABLE act_task_var_pool(
  id INT(11)  NOT NULL AUTO_INCREMENT COMMENT '主键',
  process_key VARCHAR(64) NOT NULL COMMENT '流程key',
  process_def_id VARCHAR(64) COMMENT '流程定义id 未发布之前没有流程定义id',
  user_task_var_info TEXT   COMMENT '流程任务节点变量池',
  type_ TINYINT COMMENT '1.节点相关变量 2.表单绑定的变量',
  PRIMARY KEY (id),
  INDEX (process_key,type_)
)engine=innodb CHARSET ="utf8" AUTO_INCREMENT=1 COMMENT '流程任务变量池';


DROP TABLE IF EXISTS act_inform_process;
CREATE TABLE `act_inform_process` (
  `id_` int(11) NOT NULL AUTO_INCREMENT,
  `process_instance_id` varchar(64) NOT NULL COMMENT '流程实例id',
  `task_id` varchar(64) NOT NULL  COMMENT '任务id',
  `state_` tinyint(4) NOT NULL DEFAULT '0' COMMENT '知会状态',
  `type_` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1代表自动完成 2代表知会不自动完成，任务知会',
  `inform_person_id` int(11) NOT NULL COMMENT '知会人id',
  `operate_person_id` int(11) DEFAULT NULL COMMENT '操作人id',
  `create_time` datetime NOT NULL COMMENT '知会时间',
  PRIMARY KEY (`id_`),
  INDEX(process_instance_Id,task_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='知会流程';



/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50536
Source Host           : localhost:3306
Source Database       : activiti

Target Server Type    : MYSQL
Target Server Version : 50536
File Encoding         : 65001

Date: 2017-03-01 15:39:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for act_state
-- ----------------------------
DROP TABLE IF EXISTS `act_state`;
CREATE TABLE `act_state` (
  `processId` VARCHAR(64) NOT NULL,
  `state` TINYINT(4) DEFAULT '0' COMMENT '状态 0普通 1催办',
  PRIMARY KEY (`processId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for hm_act_creation
-- ----------------------------
DROP TABLE IF EXISTS `hm_act_creation`;
DROP TABLE IF EXISTS `hm_act_creation`;
CREATE TABLE `hm_act_creation` (
  ID INT(11) NOT NULL AUTO_INCREMENT,
  FACTORY_NAME VARCHAR(255) DEFAULT NULL COMMENT '保存工厂名称',
  PROCESS_DEFINITION_ID VARCHAR(255) NOT NULL COMMENT '流程定义id',
  DOUSERID VARCHAR(20) DEFAULT NULL COMMENT '操作人id',
  ACT_ID VARCHAR(64) DEFAULT NULL,
  PROCESS_INSTANCE_ID VARCHAR(255) NOT NULL COMMENT '流程实例id',
  PROPERTIES_TEXT VARCHAR(2000) DEFAULT NULL COMMENT '参数',
  STATE_ TINYINT(4) DEFAULT 0 COMMENT '0为有效，1为无效',
  PRIMARY KEY (ID),
  INDEX (PROCESS_INSTANCE_ID)
) ENGINE=INNODB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='临时创建活动节点';

-- ----------------------------
-- Table structure for hm_act_replace
-- ----------------------------
DROP TABLE IF EXISTS `hm_act_replace`;
CREATE TABLE `hm_act_replace` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `processKey` varchar(64) DEFAULT NULL COMMENT '流程key',
  `checkPerson` varchar(20) DEFAULT NULL COMMENT '审批人',
  `changePerson` varchar(20) DEFAULT NULL COMMENT '代签人',
  `startTime` datetime DEFAULT NULL COMMENT '代理开始时间',
  `endTime` datetime DEFAULT NULL COMMENT '代理结束时间',
  `agree` tinyint(4) DEFAULT '0' COMMENT '是否同意 默认是0 等待同意 1 代表 同意  2不同意',
  `state` tinyint(4) DEFAULT '1' COMMENT '代签状态 1 代表使用 2 代表不使用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程审批代理人';

-- ----------------------------
-- Table structure for hm_act_skipactiviti
-- ----------------------------
DROP TABLE IF EXISTS `hm_act_skipactiviti`;
CREATE TABLE `hm_act_skipactiviti` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `processId` varchar(64) NOT NULL COMMENT '流程实例id',
  `processDef` varchar(64) DEFAULT NULL COMMENT '流程定义id',
  `activityKey` varchar(64) NOT NULL COMMENT '活动key',
  `userId` int(11) DEFAULT NULL COMMENT '操作人id',
  `activityType` tinyint(4) DEFAULT NULL,
  `state` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for hm_flow_diagram_form_model
-- ----------------------------
DROP TABLE IF EXISTS `hm_flow_diagram_form_model`;
CREATE TABLE `hm_flow_diagram_form_model` (
  `formid` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `parseform` text,
  `formtype` varchar(255) DEFAULT NULL,
  `state` int(255) DEFAULT '0',
  `createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`formid`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;



-- ----------------------------
-- Table structure for inform_act
-- ----------------------------
DROP TABLE IF EXISTS `inform_act`;
CREATE TABLE `inform_act` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `processId` varchar(64) NOT NULL COMMENT '流程实例id',
  `state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 为不需要知会的 1需要知会的流程',
  `informPersonId` int(11) NOT NULL COMMENT '知会人id',
  `opertPersonName` varchar(20) NOT NULL COMMENT '操作人名称',
  `opertPersonId` int(11) NOT NULL COMMENT '操作人id',
  `createTime` datetime NOT NULL COMMENT '通知时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='知会流程';

-- ----------------------------
-- Table structure for process_role
-- ----------------------------
DROP TABLE IF EXISTS `process_role`;
CREATE TABLE `process_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adminid` int(11) DEFAULT NULL COMMENT '员工id',
  `departmentid` int(11) DEFAULT NULL COMMENT '部门id',
  `roleid` int(11) DEFAULT NULL COMMENT '岗位id',
  `branchid` int(11) DEFAULT NULL COMMENT '分公司id',
  `createtime` datetime NOT NULL,
  `updatetime` datetime DEFAULT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0:无效，1有效',
  `creatorid` int(11) NOT NULL COMMENT '创建者',
  `processId` varchar(64) DEFAULT NULL COMMENT '流程实例id',
  `taskId` varchar(64) DEFAULT NULL COMMENT '任务id',
  `processDefKey` varchar(64) DEFAULT NULL COMMENT '流程key',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程_岗位表';


DROP TABLE IF EXISTS act_process_type;
CREATE TABLE `act_process_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code_id` varchar(10) NOT NULL COMMENT '类别id',
  `name_` varchar(20) NOT NULL COMMENT '类型名称',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '分类的上级id',
  `state_` bigint(4) NOT NULL DEFAULT '0' COMMENT '有效性',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_` (`name_`),
  KEY `code_id` (`code_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='流程分类';



DROP TABLE IF EXISTS hm_process_priority;
CREATE TABLE `hm_process_priority` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `proc_inst_id` varchar(255) NOT NULL COMMENT '流程实例的id',
  `priority` int(11) NOT NULL DEFAULT '0' COMMENT '任务优先级',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `hand_time` tinyint(4) DEFAULT NULL COMMENT '流程整个处理时间（单位为小时）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='催办的流程实例';
package com.csx.workflow.utils;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.csx.workflow.model.UserTaskNodeInfo;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.bpmn.model.EndEvent;
import org.activiti.bpmn.model.FlowElement;
import org.activiti.bpmn.model.GraphicInfo;
import org.activiti.bpmn.model.Process;
import org.activiti.bpmn.model.SequenceFlow;
import org.activiti.bpmn.model.StartEvent;
import org.activiti.bpmn.model.UserTask;
import org.activiti.engine.ProcessEngine;


public class ImaGegenerateUtils {
    public static final String startEvent = "startEvent";
    public static final String endEvent = "endEvent";
    public static final String parallelGateway = "parallelGateway";
    public static final String userTask = "userTask";
    public static final String sequenceFlow = "sequenceFlow";
    public static final String serviceTask = "serviceTask";
    public static final String exclusiveGateway = "exclusiveGateway";
    public static final double startEvent_X = 50D;
    public static final double startEvent_Y = 75D;
    public static final double userTask_Y = 50D;
    public static final double startEvent_HEIGHT = 30D;
    public static final double startEvent_WIDTH = 30D;
    public static final double userTask_HEIGHT = 100D;
    public static final double userTask_WIDTH = 80D;
    // 偏移量
    public static final double userTask_OFFSET = 200D;
    static List<String> ids = new ArrayList<>();

    /**
     * 动态生成图片信息
     *
     * @param userTasks
     * @param currentNode
     * @param activeActivityIds
     * @param highLightedFlows
     * @param processEngine
     * @param processDefinitionId
     * @param type
     * @return
     */
    public static InputStream gegenerate(List<UserTaskInfo> userTasks, String currentNode, List<String> activeActivityIds,
                                         List<String> highLightedFlows, ProcessEngine processEngine, String processDefinitionId, int type
    ) {
        BpmnModel bpmnModel = null;
        List<UserTaskNodeInfo> list = null;
        if (activeActivityIds == null) {
            activeActivityIds = new ArrayList<>();
            activeActivityIds.add(currentNode);
        }
        if (highLightedFlows == null) {
            highLightedFlows = new ArrayList<>();
        }
        InputStream in = null;
        bpmnModel = new BpmnModel();
        Process process = new Process();
        bpmnModel.addProcess(process);
        gegenerateCore(userTasks, bpmnModel, type);
        // 代表生成图片
        in = new HMProcessDiagramGenerator().generateDiagram(bpmnModel, "png", activeActivityIds, highLightedFlows,
                "宋体", "宋体", "宋体", null, 1.0);
        return in;
    }

    /**
     * 构建bpmnModel 获取节点信息
     * @param userTasks
     * @param bpmnModel
     * @param type
     * @return
     */
    public static List<UserTaskNodeInfo> gegenerateCore(List<UserTaskInfo> userTasks, BpmnModel bpmnModel,
                                                         int type) {
            // 生成开始节点
            StartEvent gegenerateStartEvent = gegenerateStartEvent(startEvent, startEvent, bpmnModel);
            // 生成任务节点
            List<UserTask> gegenerateUserTasks = gegenerateUserTask(userTasks, bpmnModel);
            SequenceFlow startSequenceFlow = gegenerateSequenceFlow(
                    gegenerateStartEvent.getId() + userTasks.get(0).getId(), "", gegenerateStartEvent.getId(),
                    userTasks.get(0).getId(), bpmnModel);
            startToUserTask(getUserTaskInfoIds(userTasks), bpmnModel, gegenerateStartEvent, gegenerateUserTasks,
                    startSequenceFlow);
            //代表已经完成
            if(type == 1){
                EndEvent generateendEvent = gegenerateEndEvent(endEvent, endEvent, bpmnModel, gegenerateUserTasks.size());
                SequenceFlow endSequenceFlow = gegenerateSequenceFlow(userTasks.get(userTasks.size() - 1).getId() + generateendEvent.getId(), "", gegenerateUserTasks.get(gegenerateUserTasks.size() - 1).getId(), generateendEvent.getId(), bpmnModel);
                lastUserTaskToEnd(getUserTaskInfoIds(userTasks), bpmnModel, generateendEvent, gegenerateUserTasks, endSequenceFlow);
            }
            Map<String, GraphicInfo> map = bpmnModel.getLocationMap();
            List<UserTaskNodeInfo> list = getUserTaskNodes(map, userTasks);
            return list;
    }







    /**
     * 获取所有的运行过的节点的坐标
     *
     * @param map
     * @return
     */
    public static List<UserTaskNodeInfo> getUserTaskNodes(Map<String, GraphicInfo> map,
                                                          List<UserTaskInfo> userTaskInfos) {
        List<UserTaskNodeInfo> list = new ArrayList<>();
        for (UserTaskInfo userTaskInfo : userTaskInfos) {
            UserTaskNodeInfo userTaskNodeInfo = new UserTaskNodeInfo();
            String key = userTaskInfo.getId();
            userTaskNodeInfo.setTaskKey(key);
            userTaskNodeInfo.setName(key);
            GraphicInfo graphicInfo = map.get(key);
            userTaskNodeInfo.setX(graphicInfo.getX());
            userTaskNodeInfo.setY(graphicInfo.getY());
            userTaskNodeInfo.setHeight(graphicInfo.getHeight());
            userTaskNodeInfo.setWidth(graphicInfo.getWidth());
            list.add(userTaskNodeInfo);
        }
        return list;
    }

    private static List<String> getUserTaskInfoIds(List<UserTaskInfo> userTasks) {
        List<String> ids = new ArrayList<>();
        for (UserTaskInfo UserTaskInfo : userTasks) {
            ids.add(UserTaskInfo.getId());
        }
        return ids;
    }





    private static void lastUserTaskToEnd(List<String> userTasks, BpmnModel bpmnModel, EndEvent endEvent,
                                          List<UserTask> gegenerateUserTasks, SequenceFlow endSequenceFlow) {
        List<SequenceFlow> endEventOutgoingFlows = new ArrayList<>();
        endEventOutgoingFlows.add(endSequenceFlow);
        endEvent.setIncomingFlows(endEventOutgoingFlows);
        UserTask lastUserTask = gegenerateUserTasks.get(userTasks.size() - 1);
        lastUserTask.setOutgoingFlows(endEventOutgoingFlows);
        GraphicInfo graphicInfo1 = gegenerateGraphicInfo(getLastUserTaskX(gegenerateUserTasks.size()), 50L, 30L, 30L);
        GraphicInfo graphicInfo2 = gegenerateGraphicInfo(getEndEventX(gegenerateUserTasks.size()), 50L, 30L, 30L);
        List<GraphicInfo> graphicInfoList = new ArrayList<>();
        graphicInfoList.add(graphicInfo1);
        graphicInfoList.add(graphicInfo2);
        bpmnModel.addFlowGraphicInfoList(userTasks.get(userTasks.size() - 1) + endEvent.getId(), graphicInfoList);
    }

    private static void startToUserTask(List<String> userTasks, BpmnModel bpmnModel, StartEvent gegenerateStartEvent,
                                        List<UserTask> gegenerateUserTasks, SequenceFlow startSequenceFlow) {
        List<SequenceFlow> startEventOutgoingFlows = new ArrayList<>();
        startEventOutgoingFlows.add(startSequenceFlow);
        gegenerateStartEvent.setOutgoingFlows(startEventOutgoingFlows);
        gegenerateUserTasks.get(0).setIncomingFlows(startEventOutgoingFlows);
        GraphicInfo graphicInfo1 = gegenerateGraphicInfo(50L, 50L, 30L, 30L);
        GraphicInfo graphicInfo2 = gegenerateGraphicInfo(userTask_OFFSET * 1, 50L, 30L, 30L);
        List<GraphicInfo> graphicInfoList = new ArrayList<>();
        graphicInfoList.add(graphicInfo1);
        graphicInfoList.add(graphicInfo2);
        bpmnModel.addFlowGraphicInfoList(gegenerateStartEvent.getId() + userTasks.get(0), graphicInfoList);
    }

    private static List<UserTask> gegenerateUserTask(List<UserTaskInfo> userTasks, BpmnModel bpmnModel) {
        List<UserTask> result = new ArrayList<>();
        for (int i = 0; i < userTasks.size(); i++) {
            UserTask userTask = gegenerateUserTask(userTasks.get(i).getId(), userTasks.get(i).getName(), bpmnModel,
                    userTask_OFFSET * (i + 1), userTask_Y);
            result.add(userTask);
        }
        // 关联创建任务节点的连线信息
        gegenerateUserTaskAndSequence(result, userTasks, bpmnModel);
        return result;

    }

    private static void gegenerateUserTaskAndSequence(List<UserTask> UserTaskModels, List<UserTaskInfo> userTasks,
                                                      BpmnModel bpmnModel) {
        for (int i = 0; i < userTasks.size(); i++) {
            // 设置出线
            if (i < userTasks.size() - 1) {
                UserTask userTask = UserTaskModels.get(i);
                String userTaskId = userTasks.get(i).getId();
                SequenceFlow sequenceFlow = gegenerateSequenceFlow(userTaskId + userTasks.get(i + 1).getId(), "",
                        userTaskId, userTasks.get(i + 1).getId(), bpmnModel, userTask_OFFSET);
                List<SequenceFlow> outgoingFlows = new ArrayList<SequenceFlow>();
                // 添加入线以及出线
                outgoingFlows.add(sequenceFlow);
                userTask.setOutgoingFlows(outgoingFlows);
            }
        }
    }

    private static SequenceFlow gegenerateSequenceFlow(String id, String name, String sourceRef, String targetRef,
                                                       BpmnModel bpmnModel) {
        SequenceFlow sequenceFlow = new SequenceFlow();
        sequenceFlow.setId(id);
        sequenceFlow.setName(name);
        sequenceFlow.setSourceRef(sourceRef);
        sequenceFlow.setTargetRef(targetRef);
        addFlowElement(bpmnModel, sequenceFlow);
        return sequenceFlow;

    }

    private static SequenceFlow gegenerateSequenceFlow(String id, String name, String sourceRef, String targetRef,
                                                       BpmnModel bpmnModel, double x) {
        SequenceFlow sequenceFlow = new SequenceFlow();
        sequenceFlow.setId(id);
        sequenceFlow.setName(name);
        sequenceFlow.setSourceRef(sourceRef);
        sequenceFlow.setTargetRef(targetRef);
        GraphicInfo graphicInfo3 = gegenerateGraphicInfo(x * 1 + 2, 50L, 30L, 30L);
        GraphicInfo graphicInfo4 = gegenerateGraphicInfo(x * 2, 50L, 30L, 30L);
        List<GraphicInfo> graphicInfoList = new ArrayList<>();
        graphicInfoList.add(graphicInfo3);
        graphicInfoList.add(graphicInfo4);
        bpmnModel.addFlowGraphicInfoList(id, graphicInfoList);
        addFlowElement(bpmnModel, sequenceFlow);
        return sequenceFlow;

    }

    private static StartEvent gegenerateStartEvent(String id, String name, BpmnModel bpmnModel) {
        StartEvent startEvent = new StartEvent();
        startEvent.setId(id);
        startEvent.setName(name);
        GraphicInfo graphicInfo = gegenerateGraphicInfo(startEvent_X, startEvent_Y, startEvent_WIDTH,
                startEvent_HEIGHT);
        bpmnModel.addGraphicInfo(id, graphicInfo);
        System.out.println(graphicInfo.getX());
        addFlowElement(bpmnModel, startEvent);
        return startEvent;
    }

    private static EndEvent gegenerateEndEvent(String id, String name, BpmnModel bpmnModel, int nodeNum) {
        EndEvent startEvent = new EndEvent();
        startEvent.setId(id);
        startEvent.setName(name);
        GraphicInfo graphicInfo = gegenerateGraphicInfo(getEndEventX(nodeNum), startEvent_Y, startEvent_WIDTH,
                startEvent_HEIGHT);
        bpmnModel.addGraphicInfo(id, graphicInfo);
        addFlowElement(bpmnModel, startEvent);
        return startEvent;
    }

    private static double getEndEventX(int nodeNum) {
        return startEvent_X + userTask_OFFSET * (nodeNum + 1);
    }

    private static double getLastUserTaskX(int nodeNum) {
        return startEvent_X + userTask_OFFSET * (nodeNum);
    }

    private static void addFlowElement(BpmnModel bpmnModel, FlowElement flowElement) {
        bpmnModel.getProcesses().get(0).addFlowElement(flowElement);
    }

    private static UserTask gegenerateUserTask(String id, String name, BpmnModel bpmnModel, double x, double y) {
        UserTask userTask = new UserTask();
        userTask.setId(id);
        userTask.setName(name.equals("") ? "加签" : name);
        GraphicInfo graphicInfo = gegenerateGraphicInfo(x, y, userTask_HEIGHT, userTask_WIDTH);
        bpmnModel.addGraphicInfo(id, graphicInfo);
        addFlowElement(bpmnModel, userTask);
        return userTask;
    }

    private static GraphicInfo gegenerateGraphicInfo(double x, double y, double width, double height) {
        GraphicInfo graphicInfo1 = new GraphicInfo();
        graphicInfo1.setWidth(width);
        graphicInfo1.setHeight(height);
        graphicInfo1.setX(x);
        graphicInfo1.setY(y);
        return graphicInfo1;
    }

    public static class UserTaskInfo {
        private String id;
        private String name;

        public UserTaskInfo(String id, String name) {
            super();
            this.id = id;
            this.name = name;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof UserTaskInfo)) return false;

            UserTaskInfo that = (UserTaskInfo) o;

            return id.equals(that.id);

        }

        @Override
        public int hashCode() {
            return id.hashCode();
        }

        public UserTaskInfo() {
            super();
        }

        public String getId() {
            return id;
        }

        public void setId(String id) {
            this.id = id;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

    }
}

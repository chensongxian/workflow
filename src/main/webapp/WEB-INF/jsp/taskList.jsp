<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  <script type="text/javascript"  src="${ctx}/js/jquery.min.js"></script>
    <script type="text/javascript"  src="${ctx}/js/tree.js"></script>
   
       <script type="text/javascript"  src="${ctx}/plugs/zTree/jquery.ztree.all.min.js"></script>
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <!-- Bootstrap -->
    <jsp:include page="common/header.jsp"/>
    <style>
        body table {
            font-family: "Microsoft YaHei", SimSun, Arial, Helvetica, sans-serif;
            font-size: 12px
        }

        .table thead {
            background-color: #d8d8d8;
        }

        .table tbody tr {
            height: 10px;
        }

        .table tbody tr th {
            vertical-align: middle;
        }
    </style>
</head>
<body>
<%--<jsp:include page="header.jsp"/>--%>
<%--<div class="panel">--%>
    <div style="width: 250px;background: #000000;float: left;">
        <!-- 树begin -->
        <td style="width:30%;height:80%" valign="top">
            <ul id="tree" class="ztree" style="border: 1px black solid;background-color: #F5F5F5;"></ul>
        </td>
        <!-- 树end -->
    </div>
<div class="container" style="width: 99%;margin: 10px auto">
    <div class="panel-body">
        <!-- 是一个表格  添加一种效果-->
        <table class="table table-striped table-bordered " id="tb_taskLisk">
        </table>
    </div>
</div>

<div class="modal" id="goBackHandle">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title">流程图</h4>
            </div>
            <div class="modal-body">

            </div>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp"/>

</body>

<script>
var paramId="";
  var url="${ctx}/user/query";
  var id="id";
 var paramId="";
  function refreshTable(){
	    $("#tb_taskLisk").bootstrapTable({
            url: '${ctx}/query/taskListPage',
            striped: true,
            dataType: 'json',
            pagination: true,
            contentType: "application/x-www-form-urlencoded",
            method: 'post',
            width: 80,
            pageList: [3, 5, 20],
            pageSize: 10,
            pageNumber: 1,
            queryParamsType: "",//这里只是选择适合我后台的逻辑，可以选择传入页数和显示数量
            queryParams: queryParams,
            sidePagination: 'server',//设置为服务器端分页
            columns: [
                {
                    title: '节点名称',
                    field: 'taskName',
                    align: 'center'
                },
                {
                    title: '接收时间',
                    field: 'startTime',
                    align: 'center',
                    formatter:function(val,row,index){
                        return new Date(val).Format("yyyy-MM-dd hh:mm:ss");
                    }
                },
                {
                    title: '处理期限',
                    field: 'dueDate',
                    align: 'center',
                    formatter:function(val,row,index){
                        if (val == null || val == "") {
                            return "无";
                        }else{
                            return new Date(val).Format("yyyy-MM-dd hh:mm:ss");
                        }
                    }
                },

                {
                    title: '紧急程度',
                    field: 'priority',
                    align: 'center',
                    formatter:function(val,row,index){
                        if (val == 50 ) {
                            return "正常";
                        }
                        if (val == 100 ) {
                            return "紧急";
                        }
                        if (val == 150 ) {
                            return "特别紧急";
                        }
                    }
                },
                {
                    title: '流程状态',
                    field: 'state',
                    align: 'center',
                    formatter: function (data, row, index) {
                        if(data == 0){
                            return "待处理";
                        }
                        if(data == 1){
                            return "流转中";
                        }
                        if(data == 2){
                            return "已挂体";
                        }
                        if(data == 3){
                            return "已完成";
                        }
                    }
                },
                {
                    title: '操作',
                    field: 'taskId',
                    align: 'center',
                    formatter: function (value, row, index) {
                            return '<button class="btn btn-xs btn-danger"  onclick="doTask(\'' + row.taskId + '\',\'' + row.processId + '\',\'' + row.processDefId + '\',\'' + row.taskKey + '\')">办理</button>';
                    }
                },
                {
                    title: '流程图',
                    field: 'processId',
                    align: 'center',
                    formatter: function (value, row, index) {
                        return '<button class="btn btn-xs btn-success" onclick="showPicWindow(\'' + row.processId + '\')">流程图</button>';
                    }

                }
            ]
        });
  }
  //前端提交的数据
  function queryParams(params) {
      return {
          pageSize: params.pageSize,//键就是自己后台的参数
          page: params.pageNumber,
          userId:paramId
      };
  }

    function showPicWindow(processId) {
        url = "${ctx}/activitiPic/lookPic?processId=" + processId,
                art.dialog.open(url, {
                    title: "流程图",
                    id: 'detail',
                    width: 1300,
                    height: 500,
                    lock: true,
                    opacity: 0.3
                });

    }

    //执行任务之前
    function doTask(taskId, processId,processDefId,taskKey) {
        window.location.href = "${ctx}/query/taskInfo?taskId=" + taskId + "&processId=" + processId+"&processDefId="+processDefId+"&taskKey="+taskKey;
    }

    function lookLog(processId) {
        url = "${ctx}/doLog/goToLog?processId=" + processId,
                art.dialog.open(url, {
                    title: "日志",
                    id: 'detail',
                    width: 800,
                    height: 400,
                    lock: true,
                    opacity: 0.3
                });

    }
    function taskInfo(processId) {
        //varurl = "${ctx}/goBack1/lookPic.html?processId="+processId,
        var detailurl = "${ctx}/startActivity/inviteForm?processId="+processId;
        //alert(detailurl);
        art.dialog.open(detailurl, {
            title: "审批详情",
            id: 'detail',
            width: 800,
            height: 600,
            lock: true,
            opacity: 0.3
        });

    }

    //重新激活流程
    function startProcess(processId) {

        $.ajax({
            url: "${ctx}/process/processStart?processId=" + processId,
            dataType: "json",
            success: function (data) {
                alert(data.message)
                if (data.success) {
                    $("#tb_taskLisk").bootstrapTable("refresh");
                }
            }
        })
    }


</script>


</html>



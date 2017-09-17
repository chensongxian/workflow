<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <title>流程申请</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
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

<div style="margin-left: 20px">
    <form id="searchForm">
        <tr>
            <td><span style="font-weight: bold;font-size: 12px">流程类型:</span>
                <input type="text" name="processName" id="processName">
            </td>
            <button type="button" class="btn btn-sm btn-success" onclick="searchfn()">搜索</button>
            <button type="button" onclick="clearForm()">清空</button>
        </tr>
    </form>
</div>

<div class="container" style="width: 99%;margin: 10px auto">

    <div class="panel-body">
        <table class="table table-striped table-bordered " id="tb_taskLisk">
        </table>
    </div>


</div>
<jsp:include page="common/footer.jsp"/>
</body>

<script>
    var queryParam = "";
    var processId = "";
    var taskId = "";

    $(function () {
        $("#tb_taskLisk").bootstrapTable({
            url: '${ctx}/query/applyProcess',
            striped: true,
            dataType: 'json',
            contentType: "application/x-www-form-urlencoded",
            pagination: true,
            width: 80,
            pageList: [3, 5, 10, 15, 20],
            pageSize: 15,
            pageNumber: 1,
            queryParamsType: "",//这里只是选择适合我后台的逻辑，可以选择传入页数和显示数量
            queryParams: queryParams,
            method: 'post',
            sidePagination: 'server',//设置为服务器端分页
            columns: [
                {
                    field: 'chick',
                    checkbox: true
                },
                {
                    title: '流程名称',
                    field: 'processDefName',
                    align: 'center'
                },
                {
                    title: '流程类别',
                    field: 'processCategory',
                    align: 'center',
                    formatter:function(val,row,index){
                        if (val == 1 ) {
                            return "人事";
                        }
                        if (val == 2 ) {
                            return "资产";
                        }
                        return "";
                    }
                },
                /*,
                 {
                 title: '发起人',
                 field: 'applayId',
                 align: 'center'
                 },*/
                {
                    title: '开始时间',
                    field: 'applyTime',
                    align: 'center',
                    formatter: function (data, row, index) {
                        return new Date(data).Format("yyyy-MM-dd hh:mm:ss");
                    }
                },
                {
                    title: '结束时间',
                    field: 'stopTime',
                    align: 'center',
                    formatter: function (data, row, index) {
                        if (data == null || data == "") {
                            return "";
                        }
                        return new Date(data).Format("yyyy-MM-dd hh:mm:ss");
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
                    title: '当前活动节点',
                    field: 'currentTaskName',
                    align: 'center',
                    formatter: function (data, row, index) {
                        if (row.endTime == null || row.endTime == "") {
                            return data;
                        } else {
                            return "<font color='blue'>已结束</font>";
                        }
                    }
                },

                /*{
                    title: '当前活动节点',
                    field: 'currentTaskName',
                    align: 'center',
                    formatter: function (data, row, index) {
                        if (row.endTime == null || row.endTime == "") {
                            return data;
                        } else {
                            return "<font color='blue'>已结束</font>";
                        }
                    }
                },
               /* {
                    title: '当前代办人',
                    field: 'nextCheck',
                    align: 'center',
                    formatter: function (data, row, index) {
                        if (row.endTime == null || row.endTime == "") {
                            return '<button class="btn btn-xs btn-success"  onclick="look(\'' + row.processInstanceId + '\')" style="margin-right: 3px">查看</button>';
                        } else {
                            return "<font color='blue'>已结束</font>";
                        }
                    }

                },*!/*/
                /*{
                    title: '审批结果',
                    field: 'result',
                    align: 'center',
                    formatter: function (value, row, index) {

                        if (row.endTime == null || row.endTime == "") {
                            return "<font color='gray'>未结束</font>";
                        } else {
                            if (value == true) {
                                return "<font color='blue'>通过</font>"
                            } else {
                                return "<font color='red'>不通过</font>"
                            }
                        }

                    }

                },*/
                {
                    title: '当前代办人',
                    field: 'nextCheck',
                    align: 'center',
                    formatter: function (data, row, index) {
                        if (row.endTime == null || row.endTime == "") {
                            return '<button class="btn btn-xs btn-success"  onclick="look(\'' + row.processInstanceId + '\')" style="margin-right: 3px">查看</button>';
                        } else {
                            return "<font color='blue'>已结束</font>";
                        }
                    }

                },
                {
                    title: '操作',
                    field: 'detailUrl',
                    align: 'center',
                    formatter: function (value, row, index) {
                        if (row.endTime == null || row.endTime == "") {
                            return '<button class="btn btn-xs btn-success" onclick="urge(\'' + row.processInstanceId + '\')">催办</button>';
                        }else {
                            return "<font color='blue'>已结束</font>"
                        }
                    }
                },

                {
                    title: '详情',
                    field: 'processInstanceId',
                    align: 'center',
                    formatter: function (value, row, index) {
                        return '<button class="btn btn-xs btn-warning" onclick="taskInfo(\'' + row.processInstanceId + '\')">表单</button>' +
                                '<button class="btn btn-xs btn-danger" onclick="showPicWindow(\'' + row.processInstanceId + '\')">流程图</button>';

                    }

                },
                {
                    title: '日志',
                    field: 'processInstanceId',
                    align: 'center',
                    formatter: function (value, row, index) {
                        return '<button class="btn btn-xs btn-default"  onclick="lookLog(\'' + value + '\')">日志</button>';
                    }
                },

            ]
        });
        //前端提交的数据
        function queryParams(params) {
            return {
                pageSize: params.pageSize,//键就是自己后台的参数
                page: params.pageNumber,
                processName: $("#processName").val(),
            };
        }


    });


    function searchfn() {
        $("#tb_taskLisk").bootstrapTable('refresh');

    }
    function clearForm() {
        $("#processName").val("");
        $("#tb_taskLisk").bootstrapTable('refresh');
    }

    function taskInfo(processId) {
        //varurl = "${ctx}/goBack1/lookPic.html?processId="+processId,
        var detailurl = "${ctx}/startActivity/inviteForm?processId=" + processId;
        art.dialog.open(detailurl, {
            title: "审批详情",
            id: 'detail',
            width: 800,
            height: 600,
            lock: true,
            opacity: 0.3
        });

    }
    //催办
    function urge(processInstanceId) {
        if (confirm("确定要催办吗")) {
            $.ajax({
                url: "${ctx}/openapi/task/taskUrge",
                type: "post",
                data: {'systemId': 1, 'processInstanceId': processInstanceId, 'userId': '17102'},
                success: function (data) {
                    alert(data.message);
                }
            })
        }

    }

    function lookLog(processId) {
        url = "${ctx}/doLog/goToLog?processId="+ processId,
                art.dialog.open(url, {
                    title: "日志",
                    id: 'detail',
                    width: 800,
                    height: 400,
                    lock: true,
                    opacity: 0.3
                });

    }

    /**
     * 查看当前活动的审核人
     * @param processId
     */
    function look(processId) {
        url = "${ctx}/query/goToCurrentUserInfo?processInstanceId=" + processId + "&type=1";
        art.dialog.open(url, {
            title: "查看",
            id: 'detail',
            width: 500,
            height: 500,
            lock: true,
            opacity: 0.3,
        });
    }


    function showPicWindow(processId) {
        console.info(processId);
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


</script>


</html>



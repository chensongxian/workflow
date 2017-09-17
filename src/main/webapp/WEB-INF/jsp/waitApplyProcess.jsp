<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <title>待发事项</title>
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
            url: '${ctx}/waitApplyProcess/waitPageapplyProcess',
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
            method:'post',
            sidePagination: 'server',//设置为服务器端分页
            columns: [
                {
                    field: 'chick',
                    checkbox: true
                },
                {
                    title: '流程类型',
                    field: 'processName',
                    align: 'center'
                },
                {
                    title: '开始时间',
                    field: 'startTime',
                    align: 'center',
                    formatter: function (data, row, index) {
                        return new Date(data).Format("yyyy-MM-dd hh:mm:ss");
                    }
                },
                {
                    title: '申请详情',
                    field: 'detail',
                    align: 'center',
                    formatter: function (value, row, index) {
                        return '<button class="btn btn-xs btn-warning" onclick="taskInfo(\'' + row.processInstanceId + '\')">详情</button>';
                    }
                },

                {
                    title: '重新发起',
                    field: 'processId',
                    align: 'center',
                    formatter: function (value, row, index) {
                        return '<button class="btn btn-xs btn-success" onclick="applayAgain(\'' + row.taskId + '\',\'' + row.processInstanceId + '\')">重新发起</button>';
                    }
                },

                {
                    title: '流程图',
                    field: 'processId',
                    align: 'center',
                    formatter:function(value,row,index){
                        return '<button class="btn btn-xs btn-danger" onclick="showPicWindow(\''+row.processInstanceId+'\')">流程图</button>';}

                },
                {
                    title: '日志',
                    field: 'processInstanceId',
                    align: 'center',
                    formatter: function (value, row, index) {
                        return '<button class="btn btn-xs btn-default"  onclick="lookLog(/' + value + '/)">日志</button>';
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
    function applayAgain(taskId,processId) {
        window.location.href="${ctx}/waitApplyProcess/applayAgainProcess?taskId="+taskId+"&processId="+processId;
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






    function showPicWindow(processId) {
        url = "${ctx}/activitiPic/lookPic?processId="+processId,
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



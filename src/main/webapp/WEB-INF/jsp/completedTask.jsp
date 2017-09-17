<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <!-- Bootstrap -->
  <script type="text/javascript"  src="${ctx}/js/jquery.min.js"></script>
    <script type="text/javascript"  src="${ctx}/js/tree.js"></script>
   
       <script type="text/javascript"  src="${ctx}/plugs/zTree/jquery.ztree.all.min.js"></script>
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
<%--<div class="panel">--%>
<div class="container" style="width: 99%;margin: 10px auto">
    <div class="panel-body">
        <!-- 是一个表格  添加一种效果-->
        <table class="table table-striped table-bordered " id="tb_taskLisk">
        </table>
    </div>

</div>


<jsp:include page="common/footer.jsp"/>

</body>

<script>

    $(function () {
        //访问地址

        $("#tb_taskLisk").bootstrapTable({
            url: '${ctx}/query/taskCompleted',
            striped: true,
            dataType: 'json',
            contentType: "application/x-www-form-urlencoded",
            pagination: true,
            method:'post',
            width: 80,
            pageList: [3, 5, 20],
            pageSize: 10,
            pageNumber: 1,
            queryParamsType: "",//这里只是选择适合我后台的逻辑，可以选择传入页数和显示数量
            queryParams: queryParams,
            sidePagination: 'server',//设置为服务器端分页
            columns: [
                {
                    title: '申请类型',
                    field: 'taskType',
                    align: 'center'
                },
                {
                    title: '开始时间',
                    field: 'startTime',
                    align: 'center'
                },
                {
                    title: '结束时间',
                    field: 'endTime',
                    align: 'center'
                },
                {
                    title: '审批结果',
                    field: 'result',
                    align: 'center',
                    formatter: function (value, row, index) {
                        if (value == true) {
                            return "通过"
                        } else {
                            return "不通过"
                        }
                    }

                },
                {
                    title: '详情',
                    field: 'detailUrl',
                    align: 'center',
                    formatter: function (value, row, index) {
                        return '<button class="btn btn-xs btn-danger" onclick="taskInfo(/' + row.processId + '/)">详情</button>' +
                                '<button class="btn btn-xs btn-success" onclick="showPicWindow(/' + row.processId + '/)">流程图</button>';
                    }
                },
                {
                    title: '日志',
                    field: 'processId',
                    align: 'center',
                    formatter: function (value, row, index) {
                        return '<button class="btn btn-xs btn-default"  onclick="lookLog(/' + value + '/)">日志</button>';
                    }
                }


            ]
        });
        //前端提交的数据
        function queryParams(params) {
            return {
                pageSize: params.pageSize,//键就是自己后台的参数
                page: params.pageNumber
            };
        }


    })
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
        var detailurl = "${ctx}/query/afterTask.html?processId=" + processId;
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
    function showPicWindow(processId) {

        url = "${ctx}/activitiPic/lookPic.html?processId=" + processId,
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



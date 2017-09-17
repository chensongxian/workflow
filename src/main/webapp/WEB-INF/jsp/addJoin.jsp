<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>会签</title>
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
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

        form {
            font-family: "Microsoft YaHei", SimSun, Arial, Helvetica, sans-serif;
            font-size: 12px
        }
    </style>
</head>
<body>

<div class="panel panel-info" style="height:80%;width: 99%;">
    <div class="panel-heading">
        <button class="btn-success" data-toggle="modal" data-target="#adminSelect">添加</button>
    </div>
    <div class="panel-body" style="height:100%;">
        <form id="changeForm" class="form-horizontal">
            <!-- BEGIN FORM-->
            <table class="table table-bordered" id="table">
                <tr>
                    <th>公司部门</th>
                    <th>岗位</th>
                    <th>姓名</th>
                </tr>
                <c:forEach items="${sessionScope.adminIds}" var="admin">
                    <tr>
                        <td>${admin.departmentname}</td>
                        <td>${admin.specrolename}</td>
                        <td>${admin.adminname}</td>
                    </tr>
                    <input type="hidden" name="userCode" value="${admin.adminid}">
                </c:forEach>

            </table>
            <input type="hidden" name="processId" value="${processId}">
            <input type="hidden" name="taskId" value="${taskId}">
        </form>
    </div>
    <div class="panel-footer">
        <center>
            <button type="button" class="btn btn-sm btn-primary" style="margin-right: 20px" onclick="submitbtn()">
                会签
            </button>
            <a class="btn btn-sm  btn-danger" href="javascript:mif.closeForm();" id="btnDelete"><i
                    class="fa fa-times"></i>取消</a>
        </center>
    </div>
</div>

<div class="modal" id="adminSelect">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 700px">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title">选择人</h4>
            </div>
            <div class="modal-body">
                <form id="addForm" class="form-horizontal">
                    <div class="form-group">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">人员设置:</label>
                            <div class="col-sm-8" style="width:600px;">
                                <input  id="adminid"  autocomplete="off" class="form-control"  style="width: 400px;" type="text" placeholder="请输入要设置为节点审核的人员" data-provide="typeahead">
                            </div>
                            <input type="hidden" name="adminid" id="admin">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="submitAdd()">提交</button>
            </div>
        </div>
    </div>
</div>


</body>
<jsp:include page="common/footer.jsp"/>

<script>
    $(function () {

        $("#adminid").typeahead({
            source: function (query, process) {
                $.ajax({
                    url:"${ctx}/adminRole/getUserByUserLoginOrUserName",
                    type: 'post',
                    data: {userName: query},
                    dataType: 'json',
                    async:false,
                    success: function (result) {
                        process(result);
                    }
                });
            },
            autoSelect: true,
            updater:function(data){
                console.info(data);
                //更新的时候
                $("#admin").val(data.id);
                return data;
            },
            delay:10,
            items:30
        })


        $('#adminSelect').on('hidden.bs.modal', function () {
        })

    })


    function submitAdd() {
        var admin =$("#admin").val();
        if(admin==null || admin==""){
            alert("请选择要添加会签的人");
            return;
        }

        $.ajax({
            url: "${ctx}/tempActivityChange/addPerson",
            dataType: "json",
            data: $("#addForm").serialize(),
            type: "post",
            success: function (data) {
                if (data.success) {
                    $("#adminSelect").modal("hide");
                    document.location.reload();
                }
            }

        })
    }
    //执行回退操作
    function submitbtn() {
        url = "${ctx}/tempActivityChange/joinProcess";
        $.ajax({
            url: url,
            data: $("#changeForm").serialize(),
            type:"post",
            dataType: 'json',
            success: function (data) {
                alert(data.message);
                if (data.success) {
                    mif.closeForm();
                }
            }
        })

    }


</script>
</html>

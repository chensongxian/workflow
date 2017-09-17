<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>减签</title>
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
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
    <div class="panel-body" style="height:100%;">
        <form id="changeForm" class="form-horizontal">
            <!-- BEGIN FORM-->
            <table class="table table-bordered" id="table">
                <tr>
                    <td><input type="checkbox" id="checkAll"></td>
                    <th>顺序</th>
                    <th>节点名称</th>
                    <th>分公司</th>
                    <th>部门</th>
                    <th>岗位</th>
                    <th>姓名</th>
                </tr>
                <c:forEach items="${sessionScope.oldAddActivity}" var="admin" varStatus="vs">
                    <tr>
                        <td><input type="checkbox" name="index" value="${vs.count-1}"></td>
                        <td>${vs.count}</td>
                        <td>${admin.remark}</td>
                        <td>${admin.branchname}</td>
                        <td>${admin.departmentname}</td>
                        <td>${admin.specrolename}</td>
                        <td>${admin.adminname}</td>
                    </tr>
                </c:forEach>
                <tr>
                    <c:if test="${sessionScope.oldAddActivity.size() ne 0}">
                    <td style="text-align: center">加签类型</td>
                    <c:if test="${type eq 1}">
                        <td colspan="7" style="text-align: center"> 串行</td>
                    </c:if>
                    <c:if test="${type eq 2}">
                        <td colspan="7" style="text-align: center">并行</td>
                    </c:if>
                    </td>
                </tr>
                </c:if>
            </table>
            <input type="hidden" name="type" value="${type}">
            <input type="hidden" name="processId" value="${processId}">
            <input type="hidden" name="taskId" value="${taskId}">
        </form>
    </div>
    <div class="panel-footer">
        <center>
            <button type="button" class="btn btn-sm btn-primary" style="margin-right: 20px" onclick="submitbtn()">
                减签
            </button>
            <a class="btn btn-sm  btn-danger" href="javascript:mif.closeForm();" id="btnDelete"><i
                    class="fa fa-times"></i>取消</a>
        </center>
    </div>
</div>

</body>
<jsp:include page="common/footer.jsp"/>

<script>
    //全选
    $(function(){
        $("#checkAll").click(function () {
                    //如果是被选中
                    if($("#checkAll").is(":checked")){
                        $("[name='index']").prop("checked",true);//全选
                    }else{
                        //不被选中
                        $("[name='index']").prop("checked",false);//取消全选
                    }
                }

        )
    });

    //执行加签操作
    function submitbtn() {
        var indexs = new Array();
        //勾选 不勾选而已
           $("[name='index']").each(function(){
              //不勾选的
               if($(this).is(":checked")){
                }else {
                   //这里添加所有的没被选中的
                   indexs.push($(this).val());
               }
           });
        $.ajax({
            url: "${ctx}/tempActivityChange/cutCurrentActivity",
            dataType: "json",
            data: {'type':${type},'processId':'${processId}','taskId':'${taskId}','index':indexs.join(",")},
            type:'post',
            success: function (data) {
                //如果成功
                alert(data.message);
                if (data.success) {
                    mif.closeForm();
                }
            }
        })
    }


</script>
</html>

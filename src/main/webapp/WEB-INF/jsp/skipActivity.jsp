<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>跳签</title>
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
    <div class="panel-body" style="height:100%;">
        <form id="changeForm" class="form-horizontal">
            <!-- BEGIN FORM-->
            <table class="table table-bordered" id="table">
               <%-- <tr>
                    <th>活动节点</th>
                    <th>选择</th>

                </tr>
                <c:forEach items="${activitiName}" var="name">
                    <tr>
                        <td>${name.taskName}</td>
                        <td><input type="checkbox" name="taskId" value="${name.taskId}"></td>
                    </tr>
                </c:forEach>--%>
            </table>
            <input hidden name="processId" value="${processId}">
        </form>
    </div>
    <div class="panel-footer">
        <center>
            <button type="button" class="btn btn-sm btn-primary" style="margin-right: 20px" onclick="submitbtn()">
                跳过
            </button>
            <a class="btn btn-sm  btn-danger" href="javascript:mif.closeForm();" id="btnDelete"><i
                    class="fa fa-times"></i>取消</a>
        </center>
    </div>
</div>

</body>
<jsp:include page="common/footer.jsp"/>

<script>
    $(function () {
        var jsonMap = JSON.parse('${activitiName}');
        var s ="";
        s +="<tr> <th>活动节点</th> <th>选择</th> </tr>";
        $("#table").html("");
        for(var key in jsonMap){
            var ss ="<tr><td>"+jsonMap[key]+"</td> <td><input type='checkbox' name='activityKey' value='"+key+"'></td></tr>";
            //ss =jsonMap[key]+"<input type='checkbox' name='taskId' value='"+key+"'>";
            s += ss;
        }
        $("#table").html(s);
    })


    //执行回退操作
    function submitbtn() {
        url = "${ctx}/adminDo/skipActiviy";
        $.ajax({
            url: url,
            data: $("#changeForm").serialize(),
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

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>当前节点审核人</title>
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
        <!-- BEGIN FORM-->
        <c:forEach items="${checkUser}" var="json" varStatus="vs">
            <table class="table table-bordered" id="table">
                <tr>
                    <td>活动节点：</td>
                    <td>${json.taskName}</td>
                </tr>
                <tr>
                    <td>审核人：</td>
                    <td>
                        <c:forEach items="${json.handlers}" var="admin">
                            ${admin}
                            <br>
                        </c:forEach>
                    </td>

                </tr>
            </table>
        </c:forEach>
    </div>


</div>
</body>
<jsp:include page="common/footer.jsp"/>

<script>
    console.info(JSON.stringify(${checkUser}))

</script>
</html>

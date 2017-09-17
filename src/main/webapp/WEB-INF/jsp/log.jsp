<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>操作记录界面</title>
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <!-- Bootstrap -->
    <jsp:include page="common/header.jsp"/>
    <style>
        body table {
            font-family: "Microsoft YaHei",SimSun,Arial,Helvetica,sans-serif;
            font-size: 12px
        }
        form{
            font-family: "Microsoft YaHei",SimSun,Arial,Helvetica,sans-serif;
            font-size: 12px
        }
    </style>
</head>
<body>

<table class="table table-bordered">
    <c:if test="${historyList!= null}">
        <tr>
            <th>任务名称</th>
            <th>审批人</th>
            <th>操作</th>
            <th>时间</th>
            <th>审核</th>
            <th>意见</th>
        </tr>
        <c:forEach items="${historyList}" var="historyTask">
            <c:if test="${historyTask.checkUser !=null}">
                <tr>
                    <td>${historyTask.taskName}</td>
                    <td>${historyTask.checkUser}</td>
                    <td>${historyTask.doWhat}</td>
                    <td>
                        <fmt:formatDate value="${historyTask.doTime}" pattern="yyyy-MM-dd HH:mm"/> </span>
                    </td>
                    <td>${historyTask.checkResult}</td>
                    <td>${historyTask.remark}</td>
                </tr>
            </c:if>
        </c:forEach>
    </c:if>
</table>
</body>
<jsp:include page="common/footer.jsp"/>
<script>

</script>
</html>

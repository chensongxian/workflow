<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>EHR流程菜单</title>
    <c:set var="ctx" value="${pageContext.request.contextPath}" />
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <jsp:include page="common/header.jsp"/>
</head>
<body>
<div class="navbar navbar-default"  style="background-color:#3c8dbc;">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li>
                    <a href="${ctx}/page/taskList" class="dropdown-toggle active"   aria-haspopup="true" aria-expanded="false" target="main"><small><strong style="color: white">待办事项</strong></small></a>
                </li>
                <li>
                    <a href="${ctx}/page/checkedTask" class="dropdown-toggle"   aria-haspopup="true" aria-expanded="false" target="main"><small><strong  style="color: white">已办事项</strong></small></a>
                </li>
                <li>
                    <a href="${ctx}/page/completingTask" class="dropdown-toggle"   aria-haspopup="true" aria-expanded="false" target="main"><small><strong  style="color: white">已发处理中</strong></small></a>
                </li>
                <li>
                    <a href="${ctx}/page/completedTask" class="dropdown-toggle"   aria-haspopup="true" aria-expanded="false" target="main"><small><strong style="color: white">已发处理结果</strong></small></a>

                </li>
                <li>
                    <a href="${ctx}/page/startActivity" class="dropdown-toggle active"   aria-haspopup="true" aria-expanded="false" target="main"><small ><strong style="color: white">发流程</strong></small></a>
                </li>
            </ul>
        </div>
    </div>
</div>
</body>
<jsp:include page="common/footer.jsp" />
<script>
    $(function () {
        $("ul li").click(function () {
            $(this).addClass("active");
            $(this).siblings().removeClass("active");
        });
    });
</script>
</body><%--</noframes>--%>
</html>

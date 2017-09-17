<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>流程系统</title>
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <jsp:include page="common/header.jsp"/>
</head>
<body>
<div class="navbar navbar-default"  style="background-color:#f2f2f2;">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">

                <li>
                    <a href="${ctx}/openapi/process/create?systemId=1" class="dropdown-toggle active"   aria-haspopup="true" aria-expanded="false" target="main"><small><strong>流程管理</strong></small></a>
                </li>
                <li>
                    <a href="${ctx}/page/taskList" class="dropdown-toggle active"   aria-haspopup="true" aria-expanded="false" target="main"><small><strong>待办事项</strong></small></a>
                </li>
                <li>
                    <a href="${ctx}/page/historyCheckedTask" class="dropdown-toggle"   aria-haspopup="true" aria-expanded="false" target="main"><small><strong >已办事项</strong></small></a>
                </li>
    <li>
        <a href="${ctx}/page/applyProcess" class="dropdown-toggle"   aria-haspopup="true" aria-expanded="false" target="main"><small><strong >已发事项</strong></small></a>
    </li>

                <li>
                    <a href="${ctx}/page/startActivity" class="dropdown-toggle active"   aria-haspopup="true" aria-expanded="false" target="main"><small><strong>发流程</strong></small></a>
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

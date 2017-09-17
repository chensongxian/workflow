<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>请求错误页面</title>

</head>
<body>

<%--    <c:if test="${systemId ne null}">
        <h3>请求页面失败</h3>

    </c:if>--%>
    <c:if test="${systemId ne null}">
       <h1>因缺少请求参数:<span>${systemId}</span>  导致请求页面失败</h1>

    </c:if>

</body>

</html>

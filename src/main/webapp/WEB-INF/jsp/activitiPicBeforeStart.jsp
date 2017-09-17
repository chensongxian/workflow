<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/10/31
  Time: 14:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <c:set var="ctx" value="${pageContext.request.contextPath}/hmprocess"/>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <!-- Bootstrap -->
    <jsp:include page="common/header.jsp"/>
</head>
<style type="text/css">
    .activity-attr {
        border-radius: 10px;
        border: 3px solid green;
        transition: ease-out 0.5s;
        box-shadow: 0px 0px 9px red;
    }

    /* #processKey{color: red;}*/
    #flowImageAndRect {
        position: relative;
        width: 50%
    }

    body, html {
        margin: 0px;
        padding: 0px;
    }
</style>

</head>
<body>
<div id="main">


    <div id="flowImageAndRect">

    </div>

    </div>

</div>
</body>
<jsp:include page="common/footer.jsp"/>
<script type="text/javascript">
    $(function () {
        var wfKey = '${param.wfKey}'; // 流程定义的key
        var $flowImageAndRect = $('#flowImageAndRect');
        //$('#processKey').html('流程定义的key --> ' + wfKey);
        // 加载流程图片
        loadProcessImage(wfKey, $flowImageAndRect);
        // 加载各节点信息，最终实现，在点击图片上的各节点时，出现高亮


        var $revClickRect = null; // 上次点击的图形
        // 绑定click事件，点击实现，只有点击的不是同一个时，才显示红色的边框（如果多次点击同一个，红色的边框只出现一次）
        $('#flowImageAndRect').off('click').on('click', '.activity-attr', function (e) {
            var $this = $(this);
            var prevFlag = false; // 是上一个图形，避免多次点击同一个
            if ($revClickRect) { // 说明不是第一次点击
                prevFlag = ($revClickRect.attr('actId') != $this.attr('actId')) ? false : true;// 说明2次点击的不是同一个
                if (!prevFlag)
                    $revClickRect.css('opacity', '0');
            }
            if (!prevFlag) { // 此处可以请求后台，加载相关的数据（多次点击同一个，下方可确保只执行一次）
                $this.css('opacity', '1'); // 显示当前的
                $revClickRect = $this; // 将当前设置为上次点击的

                //$('#info').html('节点ID --> ' + $this.attr('actId') + "  |  " + "节点名称 --> " + $this.attr('name'));
                  $("#nodeId").html($this.attr('actId'));
                  $("#nodeName").html($this.attr('name'));
                $("#nodeType").html($this.attr('type'));
                $("#assignee").html($this.attr('assignee'));

            }
        });
    });

    /**
     * 加载图片
     */
    function loadProcessImage(wfKey, $flowImageAndRect) {
        var imageUrl = '${pageContext.request.contextPath}/activitiPic/queryPicBeforeStart?key=${key}';
        // 加载图片
        $('<img />', {
            "src": imageUrl,
            "alt": ''
        }).appendTo($flowImageAndRect);
    }

</script>


</html>

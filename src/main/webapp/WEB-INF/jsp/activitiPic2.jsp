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



    <div class="modal" id="nodeInfo">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span
                            class="sr-only">Close</span></button>
                    <h6 class="modal-title" style="font-weight: bold;color: white">查看节点属性</h6>
                </div>
                <div class="modal-body" id="modalBody">
                    <table class="table text-center" id="table">

                    </table>

                </div>
            </div>

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
        setTimeout(function () {
            loadProcessTrace(wfKey, $flowImageAndRect);
        }, 200);
        $('#nodeInfo').on('hide.bs.modal', function () {
           $("#table").empty();
        })
        var $revClickRect = null; // 上次点击的图形
        // 绑定click事件，点击实现，只有点击的不是同一个时，才显示红色的边框（如果多次点击同一个，红色的边框只出现一次）
        $('#flowImageAndRect').off('click').on('click', '.activity-attr', function (e) {
            var $this = $(this);
            var prevFlag = false; // 是上一个图形，避免多次点击同一个
            if ($revClickRect) { // 说明不是第一次点击
                prevFlag = ($revClickRect.attr('taskKey') != $this.attr('taskKey')) ? false : true;// 说明2次点击的不是同一个
                if (!prevFlag)
                    $revClickRect.css('opacity', '0');
            }
            if (!prevFlag) { // 此处可以请求后台，加载相关的数据（多次点击同一个，下方可确保只执行一次）
                $this.css('opacity', '1'); // 显示当前的
                $revClickRect = $this; // 将当前设置为上次点击的
                //$('#info').html('节点ID --> ' + $this.attr('taskKey') + "  |  " + "节点名称 --> " + $this.attr('name'));
                $("#nodeId").html($this.attr('taskKey'));
                console.info($this);
                $("#nodeName").html($this.attr('name'));
                var remark = $this.attr("remark");
                var s  = JSON.parse(remark);
                var s1 = "<tr><td>审批人</td><td>";
                var s3 = "<tr><td>操作时间</td><td>";
                var s2 = "<tr><td>审批意见</td><td>";
                if(s!=null){
                    var a = "";
                    for(var i=0;i<s.length;i++){
                         a = a+s1+s[i].roleName+"-"+s[i].userName+"</td></tr>";
                        $("#table").append(a);
                        a = "";
                        a = a+s3+s[i].doTime+"</td></tr>";
                        $("#table").append(a);
                        a = "";
                        a = a+s2+s[i].remark+"</td></tr>";
                        $("#table").append(a);
                        a= "";
                    }
                }
                $("#nodeInfo").modal({
                    show:true,
                    backdrop: 'static'
                })
            }
        });
    });

    /**
     * 加载图片
     */
    function loadProcessImage(wfKey, $flowImageAndRect) {
        var imageUrl = '${pageContext.request.contextPath}/activitiPic/activitPic?processId=${processId}&method=0';
        // 加载图片
        $('<img />', {
            "src": imageUrl,
            "alt": ''
        }).appendTo($flowImageAndRect);

    }

    /**
     * 加载流程中各节点的信息
     * @param wfKey : 流程定义的key
     * @param $flowImageAndRect
     */
    function loadProcessTrace(wfKey, $flowImageAndRect) {
        var traceUrl = '${pageContext.request.contextPath}/activitiPic/queryActivitis1?processId=${processId}';
        $.getJSON(traceUrl, function (infos) {
            var html = "";
            $.each(infos, function (i, v) {
                // 矩形的div
                var json = JSON.stringify(v.checkInfoList);

                var $div = $('<div/>', {
                    'class': 'activity-attr'
                }).css({
                    position: 'absolute',
                    left: v.x,
                    top: v.y,
                    width: v.width,
                    height: v.height,
                    opacity: 0,
                    zIndex: 100,
                    cursor: 'pointer'
                }).attr({'taskKey': v.taskKey, 'name': v.name,'remark':json});
                html += $div.prop("outerHTML");
            });
            $('<div />', {'id': 'processRect'}).html(html).appendTo($flowImageAndRect);
        });
    }
</script>


</html>

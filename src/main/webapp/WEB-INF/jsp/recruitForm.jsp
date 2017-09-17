<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/12/5
  Time: 20:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <c:set var="ctx" value="${pageContext.request.contextPath}" />
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
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
<body style="height:120%;">
<div class="panel-body" id="div_applyInfo" style="width: 800px; margin: auto">
    <h1 align="center">招聘申请单</h1>
        <form id="myform">
            <table class="table-bordered  text-center "
           style="width: 99%;margin:0 auto; WORD-WRAP: break-word;BORDER-TOP: medium none;BORDER-BOTTOM: medium none;BORDER-LEFT: medium none; border:1px;"
           id="tb_applyInfo">
                <!--展示-->
                <c:if test="${show eq true}">
        <tr style='font-weight: bold;text-align: center;background-color: #a6c2b2;font-family: Microsoft YaHei;'><td colspan='6'>基本信息</td></tr>
        <tr > <td style='text-align: center; vertical-align: middle; width:15%;' data-field="adminname">申请人</td>
            <td><input id="adminname" name="adminname" value="${applayInfo.adminname}" style="color: #0e90d2" disabled></td>
            <%--<td style="color: #0e90d2">${userInfo.adminname}</td>--%>
            <td style='text-align: center; vertical-align: middle; width:15%;' data-field="userDeparment" >申请部门</td>
            <td><input id="applyerdepartmentid"  value="${applayInfo.departmentname}" style="color: #0e90d2" disabled/></td>
            <%--<td style="color: #0e90d2">${userInfo.departmentname}</td>--%>
            <td style='text-align: center; vertical-align: middle; width:15%;' data-field="userBranch">申请人所在公司</td>
            <td><input id="applyerbranchid"  value="${applayInfo.branchname}" style="color: #0e90d2" disabled/></td>

        <%--<td style="color: #0e90d2">${userInfo.branchname}</td>--%>
        </tr>
        <tr >
            <td style='text-align: center; vertical-align: middle; width:15%;' data-field="departmentName">招聘岗位</td>
            <td><input id="roleid" name="roleid" value="${activitParam.roleName}" style="color: #0e90d2" disabled/></td>

        <%--<td style="color: #0e90d2">${activitParam.roleName}</td>--%>
            <td style='text-align: center; vertical-align: middle; width:15%;' data-field="departmentName">任职部门</td>
            <td><input id="departmentid" name="departmentid" value="${activitParam.departmentName}" style="color: #0e90d2" disabled/></td>

        <%--<td style="color: #0e90d2">${activitParam.departmentName}</td>--%>
            <td style='text-align: center; vertical-align: middle; width:15%;' data-field="branchName">任职公司</td>
            <td><input id="branchid" name="branchid" value="${activitParam.branchName}" style="color: #0e90d2" disabled/></td>

            <%--<td style="color: #0e90d2">${activitParam.branchName}</td>--%>

        </tr>
        <tr > <td style='text-align: center; vertical-align: middle; width:15%;' data-field="preparenum">编制人数</td>
            <td><input id="preparenum" name="preparenum" value="${activitParam.preparenum}" style="color: #0e90d2" readonly/></td>

        <%--<td style="color: #0e90d2">${activitParam.preparenum}</td>--%>
            <td style='text-align: center; vertical-align: middle; width:15%;' data-field="needsnum">需求人数</td>
            <td><input id="needsnum" name="needsnum" value="${activitParam.needsnum}" style="color: #0e90d2" readonly/></td>
        <%--<td style="color: #0e90d2">${activitParam.needsnum}</td>--%>
            <td style='text-align: center; vertical-align: middle; width:15%;' data-field="workaddress">工作地点</td>
            <td><input id="workaddress" name="workaddress" value="${activitParam.workaddress}" style="color: #0e90d2" readonly/></td>
        <%--<td style="color: #0e90d2">${activitParam.workaddress}</td>--%>
        </tr>
        <tr > <td style='text-align: center; vertical-align: middle; width:15%;' data-field="wage">薪资</td>
            <td><input id="wage" name="wage" value="${activitParam.wage}" style="color: #0e90d2" readonly/></td>
        <%--<td style="color: #0e90d2">${activitParam.wage}</td>--%>
            <td style='text-align: center; vertical-align: middle; width:15%;' data-field="arriveldate">期望到岗时间</td>
            <td><input id="arriveldate" name="arriveldate" value="${activitParam.arriveldate}" style="color: #0e90d2" readonly/></td>
            </c:if>
            <!--不适用于展示的--->
            <c:if test="${show ne true}">
                <tr style='font-weight: bold;text-align: center;background-color: #a6c2b2;font-family: Microsoft YaHei;'><td colspan='6'>基本信息</td></tr>
                <tr > <td style='text-align: center; vertical-align: middle; width:15%;' data-field="adminname">申请人</td>
                    <td><input id="adminname1" name="adminname" value="${userInfo.adminname}" disabled style="color: #0e90d2" ></td>
                        <%--<td style="color: #0e90d2">${userInfo.adminname}</td>--%>
                    <td style='text-align: center; vertical-align: middle; width:15%;' data-field="userDeparment">申请部门</td>
                    <td><input id="applyerdepartmentid1"  value="${userInfo.departmentname}" style="color: #0e90d2" disabled/></td>
                        <%--<td style="color: #0e90d2">${userInfo.departmentname}</td>--%>
                    <td style='text-align: center; vertical-align: middle; width:15%;' data-field="userBranch">申请人所在公司</td>
                    <td><input id="applyerbranchid1" value="${userInfo.branchname}" style="color: #0e90d2"  disabled/></td>

                </tr>
                <tr >
                    <td style='text-align: center; vertical-align: middle; width:15%;' data-field="departmentName">招聘岗位</td>
                    <td><select id="roleid1" name="roleid" value="${activitParam.roleid}" style="color: #0e90d2;width: 135px;">
                    </select></td>

                        <%--<td style="color: #0e90d2">${activitParam.roleName}</td>--%>
                    <td style='text-align: center; vertical-align: middle; width:15%;' data-field="departmentName">任职部门</td>
                    <td><select id="departmentid1" name="departmentid" value="${activitParam.departmentid}" style="color: #0e90d2;width: 135px;" onchange="getRole()">

                    </select>
                    </td>

                        <%--<td style="color: #0e90d2">${activitParam.departmentName}</td>--%>
                    <td style='text-align: center; vertical-align: middle; width:15%;' data-field="branchName">任职公司</td>
                    <td><select id="branchid1" name="branchid" value="${activitParam.branchid}" style="color: #0e90d2;width: 135px;" onchange="getDeparment()">
                   <option></option>
                    </select></td>


                </tr>
                <tr > <td style='text-align: center; vertical-align: middle; width:15%;' data-field="preparenum">编制人数</td>
                    <td><input id="preparenum1" name="preparenum" value="${activitParam.preparenum}" style="color: #0e90d2" /></td>
                        <%--<td style="color: #0e90d2">${activitParam.preparenum}</td>--%>
                    <td style='text-align: center; vertical-align: middle; width:15%;' data-field="needsnum">需求人数</td>
                    <td><input id="needsnum1" name="needsnum" value="${activitParam.needsnum}" style="color: #0e90d2" /></td>
                        <%--<td style="color: #0e90d2">${activitParam.needsnum}</td>--%>
                    <td style='text-align: center; vertical-align: middle; width:15%;' data-field="workaddress">工作地点</td>
                    <td><input id="workaddress1" name="workaddress" value="${activitParam.workaddress}" style="color: #0e90d2" /></td>

                </tr>
                <tr > <td style='text-align: center; vertical-align: middle; width:15%;' data-field="wage">薪资</td>
                    <td><input id="wage1" name="wage" value="${activitParam.wage}" style="color: #0e90d2" /></td>
                    <td style='text-align: center; vertical-align: middle; width:15%;' data-field="arriveldate">期望到岗时间</td>
                    <td><input class="m-wrap m-ctrl-medium date-picker" id="arriveldate1" name="arriveldate" value="${activitParam.arriveldate}" style="color: #0e90d2" readonly/></td>
            </c:if>
            <td colspan="6">
                <div align="left">新增岗位：
                                <span id="field0021_span" style="width: auto; margin-right: auto; margin-left: 30px;background-color: rgb(252, 221, 139);">
                                    <label>
                                        <input style="margin-top: 0px; width: auto; height: auto; background-color: rgb(252, 221, 139);"
                                               name="state" value="0"  type="radio">是</label>
                                    <label  style="width: auto; margin-right: auto; margin-left: auto; background-color: rgb(252, 221, 139);">
                                        <input style="margin-top: 0px; width: 14px; height: auto; background-color: rgb(252, 221, 139);"
                                               name="state"
                                               value="1"
                                               type="radio" checked="checked">否</label>
                                </span>

                </div>
            </td>
        </tr>
        <tr style='font-weight: bold;text-align: center;background-color: #a6c2b2;font-family: Microsoft YaHei;'><td colspan='6'>审批意见</td></tr>
        <tr>
            <td>岗位职责：（上传附件，《岗位说明书》）</td>
            <td colspan='5'><textarea style="width: 700px; height: 80px;" name="roleduty" >${activitParam.roleduty}</textarea></td>
        </tr>
        <tr>
            <td>任职资格</td>
            <td colspan='5'><textarea style="width: 700px; height: 80px;" name="postqualification">${activitParam.postqualification}</textarea></td>
        </tr>
        <tr>
            <td>申请原因说明</td>
            <td colspan='5'><textarea style="width: 700px; height: 80px;" name="recruitreason">${activitParam.recruitreason}</textarea></td>
        </tr>
                <c:if test="${historyAdviceList!= null}">
                    <c:forEach items="${historyAdviceList}" var="historyTask">
                        <c:if test="${historyTask.checkResult eq true}">
                            <tr style="height: 80px">
                                <td>${historyTask.taskName}意见</td>
                                <td colspan='3'>
                                    <span style="color: #0e90d2">[同意]</span>
                                    <span style="margin-left: 3px">${historyTask.remark}</span>
                                </td>
                                <td colspan='2'>
                                    <span>签字：${historyTask.checkUser} </span>
                                    <br>
                                    <span>日期：<fmt:formatDate value="${historyTask.checkDate}" pattern="yyyy-MM-dd HH:mm"/> </span>
                                </td>
                            </tr>
                        </c:if>
                        <c:if test="${historyTask.checkResult eq false}">
                            <tr style="height: 80px">
                                <td>${historyTask.taskName}意见</td>
                                <td colspan='3'>
                                    <span style="color: #0e90d2">[不同意]</span>
                                    <span style="margin-left: 3px">${historyTask.remark}</span>
                                </td>
                                <td colspan='2'>
                                    <span>签字：${historyTask.checkUser} </span>
                                    <br>
                                    <span>日期：
                                    <fmt:formatDate value="${historyTask.checkDate}" pattern="yyyy-MM-dd HH:mm"/>
                                     </span>
                                </td>
                            </tr>
                        </c:if>

                        </c:forEach>
                    </c:if>


    </table>

            <c:if test="${userInfo.branchid ne 1}">
                <input hidden name="childHr" value="64">
            </c:if>
            <input hidden name="hrManager" value="1|63|59">
            <c:if test="${userInfo.branchid ne 1}">
                <input hidden name="childCeo" value="-3,40">
            </c:if>

            <input hidden name="ceo" value="1|-2|312">
            <input hidden name="departmentLeader" value="${departmentLeader}">
            <input hidden name="hrOrganization" value="1|165|259">
            <input hidden name="id" value="${activitParam.id}">
            <input hidden name="key" value="${key}">
            <!-- 申请人的部门-->
            <input hidden name="applyerdepartmentid" value="${userInfo.departmentid}">
            <input hidden name="applyerbranchid" value="${userInfo.branchid}">
            <input hidden name="creatorid" value="${userInfo.adminid}">
            <input hidden name="processI", value="${processId}">
            <input hidden name="taskI", id="taskI" value="${taskId}">
        </form>
    </div>
<!-- 不展示-->
<c:if test="${show ne true}">
<div>
    <center>
    <button id="addSubmit" class="btn btn-xs btn-danger" type="button">发起</button>
    </center>
</div>
</body>
</c:if>
    <jsp:include page="common/footer.jsp" />
    <script language='javascript' type="text/javascript">
        $(function(){
            var branchid = "${activitParam.branchid}";
            if(branchid!=""){
//                $("#branchid1   option[value='"+branchid+"']").attr("selected",true);
                $("#branchid1").val(branchid);
                $("#branchid1").find("option[value=branchid]").attr("selected",true);
            }
            $("#arriveldate1").datepicker({language: 'zh',formatType : "standard",format : 'yyyy-mm-dd'});
            var url = '${ctx}/queryParam/getBranchList';
            mif.ajax(url, null, afterBrahch);

            $("#addSubmit").bind("click",function () {
                $(this).unbind("click");
                add();
            })

        })


        function getRole(){
            $(".role").remove();
            var r_Did = $("#departmentid1").val()
            var url = '${ctx}/queryParam/getRole?r_Did='+r_Did;
            mif.ajax(url, null, afterRole);
        }
        function getDeparment(){
            $(".deparment").remove();
            $(".role").remove();
           var branchId =  $("#branchid1").val();
            var url = '${ctx}/queryParam/getDeparment?branchId='+branchId;
            mif.ajax(url, null, afterDeparment);
        }
        function afterRole(robj){
            var str="";
            $.each(robj, function (i, item) {
                str +="<option class='role' value=" + item.r_id + ">" + item.r_name + "</option>";
            })
            $("#roleid1").append(str);
        }
        function afterDeparment(robj){
            var str="";
            $.each(robj, function (i, item) {
                str += "<option class='deparment' value=" + item.id + ">" + item.name + "</option>";
            })
            $("#departmentid1").append(str);
        }
        function afterBrahch(robj){
            var str="";
            $.each(robj, function (i, item) {
                str += "<option class='branch' value=" + item.branch_Id + ">" + item.branch_Name + "</option>";
            })
            $("#branchid1").append(str);

        }
        function add() {
            $.ajax({
                url:"${ctx}/startActivity/start",
                type:"post",
                data:$("#myform").serialize(),
                dataType:"json",
                success:function (data) {
                    alert(data.message);
                    if(data.success){
                       if(confirm("需要设置为催办事项吗")){
                        addActState(data.processId);
                       }else{
                           window.location.href="${ctx}/page/startActivity"
                       }
                    }
                }
            })
        }
            function addActState(processId) {
                $.ajax({
                    url:"${ctx}/actState/insert?processId="+processId,
                    dataType:"json",
                    success:function (data) {
                        alert(data.message);
                        if(data.success){
                            window.location.href="${ctx}/page/startActivity"
                        }
                    }
                })
            }


        </script>


</html>

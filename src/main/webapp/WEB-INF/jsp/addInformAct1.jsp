<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>知会</title>
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




    <div class="panel-footer">
        <center>
            <button type="button" class="btn btn-sm btn-primary" style="margin-right: 20px" onclick="submitbtn()">
                提交
            </button>
            <a class="btn btn-sm  btn-danger" href="javascript:mif.closeForm();" id="btnDelete"><i class="fa fa-times"></i>取消</a>
        </center>
    </div>
</div>

</body>
<jsp:include page="common/footer.jsp"/>

<script>
      $(function(){
          var branchUrl = '${ctx}/queryParam/getBranchList';
          $.ajax({
              url:branchUrl,
              type:"POST",
              dataType:"json",
              success:function (data) {
                  afterBrahch(data);
              }
          })

      })
    function afterBrahch(robj){
        var str="";
        $.each(robj, function (i, item) {
            str += "<option class='branch' value=" + item.branch_Id + ">" + item.branch_Name + "</option>";
        })
        $("#branchid").append(str);
    }
    function getRole(){
        $(".role").remove();
        $(".admin").remove();
        var r_Did = $("#departmentid").val();
        if(r_Did!="null"){
        var url = '${ctx}/queryParam/getRole?r_Did='+r_Did;
        mif.ajax(url, null, afterRole);
        }
    }

     function getDeparment(){
        $(".deparment").remove();
        $(".role").remove();
        $(".admin").remove();
        var branchId =  $("#branchid").val();
         if(branchId!="null"){
             var url = '${ctx}/queryParam/getDeparment?branchId='+branchId;
             mif.ajax(url, null, afterDeparment);
         }

    }
      function getAdmin(){
          var deparmentid = $("#departmentid").val();
          var branchid1 = $("#branchid").val();
          var roleid1 = $("#roleid").val();
            $(".admin").remove();
            if(deparmentid!="null" || branchid1!="null" || roleid1!="null"){
                var url = '${ctx}/queryParam/getEmployeeRole?departmentid='+deparmentid+"&roleid="+roleid1+"&branchid="+branchid1;
                mif.ajax(url, null, afterAdmin);
            }
      }
      function afterAdmin(robj) {
          var str="";
          $.each(robj, function (i, item) {
              str +="<option class='admin' value=" + item.adminid + ">" + item.adminname + "</option>";
          })
          $("#admin").append(str);
      }
    function afterRole(robj){
        var str="";
        $.each(robj, function (i, item) {
            str +="<option class='role' value=" + item.r_id + ">" + item.r_name + "</option>";
        })
        $("#roleid").append(str);
    }
    function afterDeparment(robj){
        var str="";
        $.each(robj, function (i, item) {
            str += "<option class='deparment' value=" + item.id + ">" + item.name + "</option>";
        })
        $("#departmentid").append(str);
    }
    //执行回退操作
    function submitbtn() {
        url="${ctx}/informProcess/insertProcessRole";
        $.ajax({
            url:url,
            data:$("#changeForm").serialize(),
            dataType:'json',
            success:function(data){
                alert(data.message);
                if(data.success){
                    mif.closeForm();
                }
            }
        })

    }


</script>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>委托</title>
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
<body style="width: 80%;height: 99%;">
        <form id="changeForm" class="form-horizontal">

            <div class="form-group">

                <label class="col-sm-2 control-label">人员搜索:</label>

                    <%--<input type="text" id="disc_branch" name="disc_branch" placeholder="所属分公司" class="form-control" value="${disciplined.disc_branch}" style="width: 400px;" />--%>
                        <div class="col-sm-8" style="width:450px;">
                            <input  id="adminid"  autocomplete="off" class="form-control"  style="width: 400px;" type="text" placeholder="请输入要设置委托的人员" data-provide="typeahead">
                        </div>


            </div>
            
            <div class="form-group" >
                <label class="col-sm-2 control-label">开始时间:</label>
                <div class="col-sm-8" style="width:300px;">
                    <input type="text" class="date"  style="width:250px;height: 34px;font-size: 14px" name="startTime" id="in_startTime" value="" readonly>
                    <span class="add-on"><i class="icon-th"></i></span>
                </div>
                <label class="col-sm-2 control-label">结束时间:</label>
                <div class="col-sm-8" style="width:300px;">
                    <input  type="text" class="date" name="endTime" style="width:250px;height: 34px;font-size: 14px" value="" readonly>
                    <span class="add-on"><i class="icon-th"></i></span>
                </div>
            </div>
            <input type="hidden" name="changePerson" id="admin">
            <input name="processKey" value="" type="hidden" id="id">
        </form>
        <hr>
        <h4>选择委托流程</h4>
        <div style="margin-left: 50px">
                <table class="table table-striped table-bordered" id="tb_taskLisk">
                </table>
        </div>
        <center>
            <button type="button" class="btn btn-sm btn-primary" style="margin-right: 20px" onclick="submitbtn()">
                委托
            </button>
            <a class="btn btn-sm  btn-danger" href="javascript:mif.closeForm();" id="btnDelete"><i class="fa fa-times"></i>取消</a>
        </center>

</body>
<jsp:include page="common/footer.jsp"/>
<script src="${ctx}/js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script src="${ctx}/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>

<script>
    $(function () {
        $('.date').datetimepicker({language : "zh-CN",
            format: 'yyyy-mm-dd hh:ii:ss'
        });
    })
    $(function () {
        //使用typehead模糊查询
        $("#adminid").typeahead({
            source: function (query, process) {
                $.ajax({
                    url:"${ctx}/adminRole/getUserByUserLoginOrUserName",
                    type: 'post',
                    data: {userName: query},
                    dataType: 'json',
                    async:false,
                    success: function (result) {
                        process(result);
                    }
                });
            },
            items:20,
            autoSelect: true,


            updater:function(data){
                console.info(data);
                //更新的时候
                $("#admin").val(data.id);
                return data;
            }

        })
    })
      $(function(){
          $("#tb_taskLisk").bootstrapTable({
              url:'${ctx}/processDefinition/processDefPage',
              striped : true,
              dataType: 'json',
              pagination : true,
              singleSelect: false,
              clickToSelect: true,
              width:	80,
              pageList : [ 3, 5, 20 ],
              pageSize : 5,
              pageNumber : 1,
              queryParamsType: "",//这里只是选择适合我后台的逻辑，可以选择传入页数和显示数量
              queryParams : queryParams,
              sidePagination : 'server',//设置为服务器端分页
              columns: [{
                  field: 'chick',
                  checkbox: true
                    },
                  {
                      title: '名称',
                      field: 'name',
                      align: 'center'
                  },
                  {
                      title: '版本',
                      field: 'level',
                      align: 'center'
                  }
              ]
          });
          //前端提交的数据
          function queryParams(params) {
              return {
                  pageSize : params.pageSize,//键就是自己后台的参数
                  page : params.pageNumber
              };
          }



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

        var ids = "";
        var rows = $("#tb_taskLisk").bootstrapTable('getSelections');
        for (var i = 0; i < rows.length; i++) {
            //var key = "/"+rows[i].key+"/";

            if(i==rows.length-1){
                ids += rows[i].defKey;
            }else {
                ids += rows[i].defKey + '|';
            }
        }
        if(ids==""){
            alert("选择要委托的流程");
            return;
        }
        $("#id").val(ids);
        url="${ctx}/replace/insert";
        $.ajax({
            url:url,
            data:$("#changeForm").serialize(),
            type:"post",
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

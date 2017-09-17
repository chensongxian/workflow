/**
 * Created by Administrator on 2017/6/29.
 */
var $treeId = "";
var zTree;
var id="";
var pid="";

$(function () {
	refreshTable();
	
    var setting = {
        view : {
            dblClickExpand : false,	// 双击自动展开父节点的标识
            showLine : true,		// 显示节点之间的连线
            selectedMulti : false	// 是否容许同时选中多个节点
        },
        data : {
            simpleData : {
                enable : true,
                idKey : id,
                pIdKey : pid,
                rootPId : ""
            }
        },
        callback : {
            beforeClick : function(treeId, treeNode) {
                zTree = $.fn.zTree.getZTreeObj("tree");
                console.info(treeNode);
                paramId = treeNode.id;
                zTree.expandNode(treeNode);	// 展开节点
                //左变表格
               // refreshTable();
               $("#tb_taskLisk").bootstrapTable('refresh');
                return true;
            }
        },
        async : {
            enable : true,
            url : url,
            type : "post"
        }
    };
    $.fn.zTree.init($("#tree"), setting);
})

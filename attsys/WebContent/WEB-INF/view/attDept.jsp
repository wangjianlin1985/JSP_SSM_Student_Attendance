<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/common.jsp"%>
<!DOCTYPE html>
<html>
  <head>
<script type="text/javascript">
var setting = {
		async: {    
            enable: true,    
            url:"${path}/dept/loadAllStuDept.htm"
        },
		
	view: {
		dblClickExpand: false,
		showLine: true,
		showIcon : true,
		selectedMulti: false
	},
	data: {
		simpleData: {
			enable:true,
			idKey: "id",
		    pIdKey: "pid",
			rootPId: "0"
		}
	},
	callback: {
		beforeClick: function(treeId, treeNode) {
			$("#hidePid").val(treeNode.id);
			searchAtt();
			// if(treeNode.children){// 只有当选中叶子节点时才查询，即选中班级，而不是年级}else {}
		}
	}
	
};

 

var zNodes =[];
		
		
		
$(document).ready(function(){
	var t = $("#treeDemo");
	t = $.fn.zTree.init(t, setting, zNodes);
	setTimeout("expendAll()",60);
	
});

function expendAll(){
	var zTree1 = $.fn.zTree.getZTreeObj("treeDemo");
	zTree1.expandAll(true); 
}

function searchAtt(){
	$('#dg').datagrid('load',{
		deptid:$('#hidePid').val(),
		start:$('#s_start').datebox('getValue'),
		end:$('#s_end').datebox('getValue')
	});
}

function showAttChart(){
	var deptid = $('#hidePid').val();
	var start = $('#s_start').datebox('getValue');
	var end = $('#s_end').datebox('getValue');
	$("#chartImg").attr("src","${path}/stats/deptAttPie.htm?deptid="+deptid+"&start="+start+"&end="+end);
	$("#dlg").dialog("open").dialog("setTitle","考勤统计");
}


</script>
  </head>
 
<body class="easyui-layout" >

<input  type="hidden" id="hidePid"  value="0" />
<div region="center">
<table  id="dg" class="easyui-datagrid" fitColumns="true"
   				rownumbers="true" url="deptAttList.htm" fit="true" toolbar="#tb">
        <thead>
            	<tr>
                	<th field="result" width="60" align="center"  >状态</th>
                	<th field="total" width="60" align="center"    >人数</th>
            	</tr>
        </thead>
</table>
</div>
<div id="tb" >
	<div class="updownInterval"> </div>
	<div>
		开始日期：<input class="easyui-datebox"   id="s_start"/>
		结束日期：<input class="easyui-datebox"   id="s_end"/>
		<a href="javascript:searchAtt()" class="easyui-linkbutton" iconCls="icon-search" >搜索</a>
		&nbsp;&nbsp;&nbsp;
		<a href="javascript:showAttChart()" class="easyui-linkbutton" iconCls="icon-edit" >饼状图显示</a>
	</div>
	<div class="updownInterval"> </div>
</div>

	

<div region="west" style="width: 160px;padding: 5px;" title="部门班级" split="true">
		<ul id="treeDemo" class="ztree"></ul>
</div>


<div id="dlg" class="easyui-dialog" style="width: 570px;height: 350px;padding: 5px 10px"  closed="true" >
	<img id="chartImg" >
</div>		

</body>
</html>
s
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
		keyword:$("#s_keyword").val(),
		start:$('#s_start').datebox('getValue'),
		end:$('#s_end').datebox('getValue'),
		result:$("#s_result").val()
	});
}



</script>
  </head>
 
<body class="easyui-layout" >

<input  type="hidden" id="hidePid"  value="0" />
<div region="center">
<table  id="dg" class="easyui-datagrid" fitColumns="true"
   				 pagination="true" rownumbers="true" url="schoolAttList.htm" fit="true" toolbar="#tb">
        <thead>
            	<tr>
            		<th data-options="field:'ck',checkbox:true"></th>
            		<th data-options="field:'id',hidden:'true'">
                	<th field="deptname" width="60" align="center"   formatter="formatDept" >班级</th>
                	<th field="periodid" width="60" align="center"   formatter="formatPeriod" >节次</th>
                	<th field="date" width="60" align="center" >日期</th>
                	<th field="studentname" width="60" align="center"   formatter="formatName" >姓名</th>
                	<th field="teachername" width="60" align="center"   formatter="formatTName" >教师姓名</th>
                	<th field="result" width="60" align="center" >考勤结果</th>
            	</tr>
        </thead>
        <script>
        	function formatDept(value,row,index){
        		return row.grade.name + ""+row.dept.name;
        	}
        	function formatPeriod(value,row,index){
        		return row.period.name;
        	}
        	function formatName(value,row,index){
        		return row.student.realName;
        	}
        	function formatTName(value,row,index){
        		return row.teacher.realName;
        	}
        </script>
</table>
</div>
<div id="tb" >
	<div class="updownInterval"> </div>
	<div>
		姓名：&nbsp;<input type="text" name="s_keyword" id="s_keyword" size="20" onkeydown="if(event.keyCode==13) searchAtt()"/>
		考勤结果：&nbsp;
		<select id="s_result">
			<option value="">全部</option>
			<option value="正常">正常</option>
			<option value="迟到">迟到</option>
			<option value="早退">早退</option>
			<option value="旷课">旷课</option>
			<option value="请假">请假</option>
		</select>
		开始日期：<input class="easyui-datebox"   id="s_start"/>
		结束日期：<input class="easyui-datebox"   id="s_end"/>
		<a href="javascript:searchAtt()" class="easyui-linkbutton" iconCls="icon-search" >搜索</a>
	</div>
	<div class="updownInterval"> </div>
</div>

	

<div region="west" style="width: 160px;padding: 5px;" title="部门班级" split="true">
		<ul id="treeDemo" class="ztree"></ul>
</div>


		

</body>
</html>

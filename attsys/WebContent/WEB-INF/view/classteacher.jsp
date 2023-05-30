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
			$("#HIDDENPID").val(treeNode.id);
			searchCT();
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

function searchCT(){
	$('#dg').datagrid('load',{
		deptid:$('#hidePid').val()
	});
}


var ctUrl;
function openCTAddDialog(){
	$("#dlg").dialog("open").dialog("setTitle","添加绑定信息");
	ctUrl ="reserve.htm";
	initTree2();
}


function openCTUpdateDialog(){
	var selectedRows=$("#dg").datagrid('getSelections');
	if(selectedRows.length!=1){
		$.messager.alert('系统提示','请选择一条要编辑的数据！');
		return;
	}
	var row=selectedRows[0];
	$("#dlg").dialog("open").dialog("setTitle","修改绑定信息");
	$("#fm").form("load",row);
	$("#courseid").combobox("setValue",row.course.id);
	$("#userid").combobox("setValue",row.user.userId);
	ctUrl="reserve.htm?id="+row.id;
	initTree2();
}

function reserveCT(){
	$("#fm").form("submit",{
		url:ctUrl,
		onSubmit:function(){
			return $(this).form("validate");
		},
		success:function(result){
			var result=eval('('+result+')');
			if(result.errorMsg){
				$.messager.alert('系统提示',"<font color=red>"+result.errorMsg+"</font>");
				return;
			}else{
				$.messager.alert('系统提示','保存成功');
				closeCTDialog();
				$("#dg").datagrid("reload");
			}
		}
	});
}

function closeCTDialog(){
	$("#fm").form('clear');
	$("#dlg").dialog("close");
}


function deleteCT(){
	var selectedRows=$("#dg").datagrid('getSelections');
	if(selectedRows.length!=1){
		$.messager.alert('系统提示','请选择一条要删除的数据！');
		return;
	}
	var id =selectedRows[0].id;
	$.messager.confirm("系统提示","您确认要删除这条数据吗？",function(r){
		if(r){
			$.post("delete.htm",{id:id},function(result){
				if(result.success){
					$.messager.alert('系统提示',"您已成功删除数据！");
					$("#dg").datagrid("reload");
				}else{
					$.messager.alert('系统提示',result.errorMsg);
				}
			},"json");
		}
	});
}


</script>
  </head>
 
<body class="easyui-layout" >

<input  type="hidden" id="hidePid"  value="0" />
<div region="center">
		<table  id="dg" class="easyui-datagrid" fitColumns="true"
   				 pagination="true" rownumbers="true" url="list.htm" fit="true" toolbar="#tb">
        <thead>
            	<tr>
            		<th data-options="field:'ck',checkbox:true"></th>
            		<th data-options="field:'id'">
                	<th field="deptname" width="60" align="center"  formatter="formatDept" > 班级</th>
                	<th field="coursename" width="60" align="center"   formatter="formatCourse" >课程</th>
                	<th field="username" width="60" align="center"  formatter="formatUser" >教师</th>
                	<th field="islead" width="60" align="center"   formatter="formatLead" >是否班主任</th>
            	</tr>
        </thead>
</table>
<script type="text/javascript">
	function  formatDept(val,row,index){
		if(row.dept!=null){
			return row.dept.name;
		}
	}
	
	function  formatCourse(val,row,index){
		if(row.course!=null){
			return row.course.name;
		}
	}
	
	function  formatUser(val,row,index){
		if(row.user!=null){
			return row.user.realName;
		}
	}
	
	function  formatLead(val,row,index){
		if("0"==val){
			return "否";
		} else {
			return "是";
		}
	}
</script>
</div>
<div id="tb" >
	<div class="updownInterval"> </div>
	<div>
		<privilege:operation operationId="10022" clazz="easyui-linkbutton" onClick="openCTAddDialog()" name="添加"  iconCls="icon-add" ></privilege:operation>
		<privilege:operation operationId="10023" clazz="easyui-linkbutton" onClick="openCTUpdateDialog()" name="修改"  iconCls="icon-edit" ></privilege:operation>
		<privilege:operation operationId="10024" clazz="easyui-linkbutton" onClick="deleteCT()" name="删除"  iconCls="icon-remove" ></privilege:operation>
	</div>
	<div class="updownInterval"> </div>
</div>

	

<div region="west" style="width: 160px;padding: 5px;" title="绑定班级" split="true">
		<ul id="treeDemo" class="ztree"></ul>
</div>

			
<!-- 新增和修改对话框 -->
<div id="dlg" class="easyui-dialog" style="text-align:right;width: 320px;height: 420px;padding: 10px 20px"
  closed="true" buttons="#dlg-buttons">
 <form id="fm" method="post">
 	<table cellspacing="5px;">
 	
 		<tr>
  			<td>班级：</td>
  				<input type="hidden"  value="0"  name="dept.id" id="HIDDENPID" />
  			<td>
  				<ul id="treeDemo2" class="ztree"></ul>
  			</td>
  		</tr>
 	
 		<tr>
  			<td>课程：</td>
  			<td><input class="easyui-combobox"  id="courseid"  name="course.id"  size="20" data-options="editable:false,panelHeight:'auto',valueField:'id',textField:'name',url:'${path }/course/loadAllCourse.htm'"/></td>
  		</tr>
  		
  		<tr>
  			<td>教师：</td>
  			<td><input class="easyui-combobox"   id="userid"  name="user.userId"  size="20" data-options="editable:false,panelHeight:'auto',valueField:'userId',textField:'realName',url:'${path }/user/loadAllTeacher.htm'"/></td>
  		</tr>
 	
 		<tr>
  			<td>班主任：</td>
  			<td><select name="islead">
  				<option value="0">否</option>
  				<option value="1">是</option>
  			</select></td>
  		</tr>
  		
  	</table>
 </form>
</div>
<div id="dlg-buttons" style="text-align:center">
	<a href="javascript:reserveCT()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeCTDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
		
<script type="text/javascript">
var setting2 = {
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
  	 check : {
          enable : true,
          chkStyle : "checkbox",   
          chkboxType : {
              "Y" : "",
              "N" : ""
          }
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
  			// 设置隐藏deptcode
  			$("#HIDDENPID").val(treeNode.id);
  			// 只能单选
  			var treeObj = $.fn.zTree.getZTreeObj('treeDemo2');
  			treeObj.checkAllNodes(false);
  			treeObj.selectNode(treeNode,true); 
  		},
  		onCheck:function(event,treeId,treeNode){
  			// 设置隐藏deptcode
  			$("#HIDDENPID").val(treeNode.id);
  			// 只能单选
  			var treeObj = $.fn.zTree.getZTreeObj('treeDemo2');
  			treeObj.checkAllNodes(false);
  			// 设置选中
  			treeObj.checkNode(treeNode, true, true);
  		}
  	}
  	
  };
  var zNodes2 =[];

 function initTree2(){
	 var t = $("#treeDemo2");
	  	t = $.fn.zTree.init(t, setting2, zNodes2);
	  	setTimeout("a()",300);
 }
  
function a(){
	var a = $("#hidePid").val();
  	var treeObjx = $.fn.zTree.getZTreeObj('treeDemo2');
  	var node = treeObjx.getNodeByParam("id",a);
  	treeObjx.checkNode(node, true, true);
}
</script>
</body>
</html>

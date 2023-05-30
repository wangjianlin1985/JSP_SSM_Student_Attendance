<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/common.jsp"%>

<!DOCTYPE html>
<html>
  <head>
    <title>课程主页</title>
    
    <script type="text/javascript">

		var url;

		// 打开新增用户信息对话框
        function openCourseAddDialog(){
			$("#dlg").dialog("open").dialog("setTitle","添加课程信息");
        	url = 'reserveCourse.htm';
        	
        }

		// 打开修改用户信息对话框
        function openCourseUpdateDialog(){
    		var selectedRows=$("#dg").datagrid('getSelections');
    		if(selectedRows.length!=1){
    			$.messager.alert('系统提示','请选择一条要编辑的数据！');
    			return;
    		}
    		var row=selectedRows[0];
    		$("#dlg").dialog("open").dialog("setTitle","修改课程信息");
    		$("#fm").form("load",row);
    		url="reserveCourse.htm?id="+row.id;
    	}

        // 保存用户信息
        function reserveCourse(){
        	$("#fm").form("submit",{
    			url:url,
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
    					closeCourseDialog();
    					$("#dg").datagrid("reload");
    				}
    			}
    		});
        }

        // 关闭添加修改角色对话框
        function closeCourseDialog(){
        	$("#fm").form('clear');
        	$("#dlg").dialog("close");
        }

		
    	function deleteCourse(){
    		var selectedRows=$("#dg").datagrid('getSelections');
    		if(selectedRows.length==0){
    			$.messager.alert('系统提示','请选择要删除的数据！');
    			return;
    		}
    		var strIds=[];
    		for(var i=0;i<selectedRows.length;i++){
    			strIds.push(selectedRows[i].userId);
    		}
    		var ids=strIds.join(","); 
    		$.messager.confirm("系统提示","您确认要删除这些数据吗？",function(r){
    			if(r){
    				$.post("deleteCourse.htm",{ids:ids},function(result){
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
 
 
<body style="margin:1px">



<!-- 加载数据表格 -->
<table  id="dg" class="easyui-datagrid" fitColumns="true"
   				 pagination="true" rownumbers="true" url="list.htm" fit="true" toolbar="#tb">
        <thead>
            	<tr>
            		<th data-options="field:'ck',checkbox:true"></th>
                	<th field="id" width="60" align="center">课程编号</th>  
                	<th field="name" width="60" align="center" >课程名称</th>
            	</tr>
        </thead>
</table>
   	
<!-- 数据表格上的搜索和添加等操作按钮 -->
<div id="tb" >
	<div class="updownInterval"> </div>
	<div>
		<privilege:operation operationId="10019" clazz="easyui-linkbutton" onClick="openCourseAddDialog()" name="添加"  iconCls="icon-add" ></privilege:operation>
		<privilege:operation operationId="10020" clazz="easyui-linkbutton" onClick="openCourseUpdateDialog()" name="修改"  iconCls="icon-edit" ></privilege:operation>
		<privilege:operation operationId="10021" clazz="easyui-linkbutton" onClick="deleteCourse()" name="删除"  iconCls="icon-remove" ></privilege:operation>
	</div>
	<div class="updownInterval"> </div>
</div>




<!-- 新增和修改对话框 -->
<div id="dlg" class="easyui-dialog" style="text-align:right;width: 620px;height: 320px;padding: 10px 20px"
  closed="true" buttons="#dlg-buttons">
 <form id="fm" method="post">
 	<table cellspacing="5px;">
  		<tr>
  			<td>名称：</td>
  			<td><input type="text" id="name" name="name" class="easyui-validatebox" required="true"/></td>
  		</tr>
  	</table>
 </form>
</div>
<div id="dlg-buttons" style="text-align:center">
	<a href="javascript:reserveCourse()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeCourseDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>

</body>
</html>

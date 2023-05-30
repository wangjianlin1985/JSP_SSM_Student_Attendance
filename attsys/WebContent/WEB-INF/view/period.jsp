<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/common.jsp"%>

<!DOCTYPE html>
<html>
  <head>
    <title>节次主页</title>
    
    <script type="text/javascript">

		var url;

		// 打开新增用户信息对话框
        function openPeriodAddDialog(){
			$("#dlg").dialog("open").dialog("setTitle","添加节次信息");
        	url = 'reservePeriod.htm';
        	
        }

		// 打开修改用户信息对话框
        function openPeriodUpdateDialog(){
    		var selectedRows=$("#dg").datagrid('getSelections');
    		if(selectedRows.length!=1){
    			$.messager.alert('系统提示','请选择一条要编辑的数据！');
    			return;
    		}
    		var row=selectedRows[0];
    		$("#dlg").dialog("open").dialog("setTitle","修改节次信息");
    		$("#fm").form("load",row);
    		url="reservePeriod.htm?id="+row.id;
    	}

        // 保存用户信息
        function reservePeriod(){
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
    					closePeriodDialog();
    					$("#dg").datagrid("reload");
    				}
    			}
    		});
        }

        // 关闭添加修改角色对话框
        function closePeriodDialog(){
        	$("#fm").form('clear');
        	$("#dlg").dialog("close");
        }

		
    	function deletePeriod(){
    		var selectedRows=$("#dg").datagrid('getSelections');
    		if(selectedRows.length==0){
    			$.messager.alert('系统提示','请选择要删除的数据！');
    			return;
    		}
    		var strIds=[];
    		for(var i=0;i<selectedRows.length;i++){
    			strIds.push(selectedRows[i].id);
    		}
    		var ids=strIds.join(","); 
    		$.messager.confirm("系统提示","您确认要删除这些数据吗？",function(r){
    			if(r){
    				$.post("deletePeriod.htm",{ids:ids},function(result){
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
                	<th field="id" width="60" align="center">节次编号</th>  
                	<th field="name" width="60" align="center" >节次名称</th>
                	<th field="start" width="60" align="center" >开始时间</th>
                	<th field="end" width="60" align="center" >结束时间</th>
            	</tr>
        </thead>
</table>
   	
<!-- 数据表格上的搜索和添加等操作按钮 -->
<div id="tb" >
	<div class="updownInterval"> </div>
	<div>
		<privilege:operation operationId="10025" clazz="easyui-linkbutton" onClick="openPeriodAddDialog()" name="添加"  iconCls="icon-add" ></privilege:operation>
		<privilege:operation operationId="10026" clazz="easyui-linkbutton" onClick="openPeriodUpdateDialog()" name="修改"  iconCls="icon-edit" ></privilege:operation>
		<privilege:operation operationId="10027" clazz="easyui-linkbutton" onClick="deletePeriod()" name="删除"  iconCls="icon-remove" ></privilege:operation>
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
  		<tr>
  			<td>开始时间：</td>
  			<td><input type="text"  name="start" class="easyui-timespinner"    required="true"/></td>
  		</tr>
  		<tr>
  			<td>结束时间：</td>
  			<td><input type="text" name="end" class="easyui-timespinner"  required="true"/></td>
  		</tr>
  	</table>
 </form>
</div>
<div id="dlg-buttons" style="text-align:center">
	<a href="javascript:reservePeriod()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closePeriodDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>




</body>
</html>

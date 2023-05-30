<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/common.jsp"%>

<!DOCTYPE html>
<html>
  <head>
    <title>学生考勤</title>
    
    <script type="text/javascript">
	

    	
	function searchAtt(){
		$('#dg').datagrid('load',{
			keyword:$("#s_keyword").val(),
			start:$('#s_start').datebox('getValue'),
			end:$('#s_end').datebox('getValue'),
			result:$("#s_result").val()
		});
	}
	
	var url="";
	function openAttUpdateDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert('系统提示','请选择一条要编辑的数据！');
			return;
		}
		var row=selectedRows[0];
		url="updateResult.htm?id="+row.id;
		$("#dlg").dialog("open").dialog("setTitle","修改考勤状态");
	}
	
	
	function reserveAtt(){
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
					closeAttDialog();
					$("#dg").datagrid("reload");
				}
			}
		});
	}

	function closeAttDialog(){
		$("#dlg").dialog("close");
	}
    </script>
    </head>
 
 
<body style="margin:1px">



<!-- 加载数据表格 -->
<table  id="dg" class="easyui-datagrid" fitColumns="true"
   				 pagination="true" rownumbers="true" url="teacherLeadAttList.htm" fit="true" toolbar="#tb">
        <thead>
            	<tr>
            		<th data-options="field:'ck',checkbox:true"></th>
            		<th data-options="field:'id',hidden:'true'">
                	<th field="deptname" width="60" align="center"   formatter="formatDept" >班级</th>
                	<th field="periodid" width="60" align="center"   formatter="formatPeriod" >节次</th>
                	<th field="date" width="60" align="center" >日期</th>
                	<th field="studentname" width="60" align="center"   formatter="formatName" >姓名</th>
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
        	
        </script>
</table>
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
		
		<privilege:operation operationId="10031" clazz="easyui-linkbutton" onClick="openAttUpdateDialog()" name="修改考勤"  iconCls="icon-edit" ></privilege:operation>
	</div>
	<div class="updownInterval"> </div>
</div>


<div id="dlg" class="easyui-dialog" style="text-align:right;width: 320px;height: 420px;padding: 10px 20px"
  closed="true" buttons="#dlg-buttons">
 <form id="fm" method="post">
 	<table cellspacing="5px;">
  		<tr>
  			<td>状态：</td>
  			<td>
  				<select  name="result" >
					<option value="正常">正常</option>
					<option value="迟到">迟到</option>
					<option value="早退">早退</option>
					<option value="旷课">旷课</option>
					<option value="请假">请假</option>
			</select>
  			</td>
  		</tr>
  		
  	</table>
 </form>
</div>
<div id="dlg-buttons" style="text-align:center">
	<a href="javascript:reserveAtt()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeAttDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>


</body>
</html>

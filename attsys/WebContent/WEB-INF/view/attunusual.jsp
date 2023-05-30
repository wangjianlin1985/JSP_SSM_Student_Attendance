<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/common.jsp"%>
<!DOCTYPE html>
<html>
  <head>
<script type="text/javascript">

function searchUnusualAtt(){
	$('#dg').datagrid('load',{
		keyword:$("#s_keyword").val(),
		start:$('#s_start').datebox('getValue'),
		end:$('#s_end').datebox('getValue'),
		total:$("#s_total").val(),
		result:$("#s_result").val()
	});
}



</script>
  </head>
 
<body >

<table  id="dg" class="easyui-datagrid" fitColumns="true"
   				 pagination="true" rownumbers="true" url="unusualAttList.htm" fit="true" toolbar="#tb">
        <thead>
            	<tr>
                	<th field="deptname" width="60" align="center"   formatter="formatDept" >班级</th>
                	<th field="studentname" width="60" align="center"   formatter="formatName" >姓名</th>
                	<th field="totalcount" width="60" align="center" >次数</th>
            	</tr>
        </thead>
        <script>
        	function formatDept(value,row,index){
        		return row.grade.name + ""+row.dept.name;
        	}
        	function formatName(value,row,index){
        		return row.student.realName;
        	}
        </script>
</table>

<div id="tb" >
	<div class="updownInterval"> </div>
	<div>
		姓名：&nbsp;<input type="text" name="s_keyword" id="s_keyword" size="20" onkeydown="if(event.keyCode==13) searchUnusualAtt()"/>
		&nbsp;&nbsp;考勤结果：
		<select id="s_result">
			<option value="正常">正常</option>
			<option value="迟到">迟到</option>
			<option value="早退">早退</option>
			<option value="旷课">旷课</option>
			<option value="请假">请假</option>
		</select>
		超过<input  value="3" id="s_total"  style="width:30px" />次&nbsp;&nbsp;
		开始日期：<input class="easyui-datebox"   id="s_start"/>&nbsp;
		结束日期：<input class="easyui-datebox"   id="s_end"/>&nbsp;&nbsp;
		<a href="javascript:searchUnusualAtt()" class="easyui-linkbutton" iconCls="icon-search" >搜索</a>
	</div>
	<div class="updownInterval"> </div>
</div>


</body>
</html>

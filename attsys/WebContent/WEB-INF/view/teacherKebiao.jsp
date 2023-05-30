<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/common.jsp"%>
<!DOCTYPE html>
<html>
  <head>
 <style type="text/css">
table.gridtable {
	font-family: verdana,arial,sans-serif;
	font-size:11px;
	color:#333333;
	border-width: 1px;
	border-color: #666666;
	border-collapse: collapse;
}
table.gridtable th {
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #666666;
	background-color: #dedede;
}
table.gridtable td {
	border-width: 1px;
	width:90px;
	padding: 8px;
	border-style: solid;
	border-color: #666666;
	background-color: #ffffff;
}

.cont {
	text-align:center;
	align:center;
	
}

table.xx {
	font-family: verdana,arial,sans-serif;
	font-size:11px;
	color:#333333;
	width:100%;
	border-width: 1px;
	border-color: #666666;
	border-collapse: collapse;
}
table.xx th {
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #666666;
	background-color: #dedede;
}
table.xx td {
	border-width: 1px;
	padding: 2px;
	border-style: solid;
	border-color: #666666;
	background-color: #ffffff;
}


</style>
<script type="text/javascript">

function searchSchedular(){
		$.ajax({
			url :'${path}/schedular/teacherList.htm',
			dataType:'json',
			type:'post',
			async:false,
			success:function(data){
				var d = data.rows;
				var p = data.periodList;
				var deptids = data.dl;
				var str = "<tr><td>星期节次</td><td>周一</td><td>周二</td><td>周三</td><td>周四</td><td>周五</td></tr>";
				for(var i=0;i<d.length;i++){
					var x = d[i].split(",");
					var z = deptids[i].split(",");
					str += "<tr><td>"+p[i].name+"<br/>"+p[i].start+"-"+p[i].end+"</td>";
					 for(var y = 0;y<x.length;y++){
							if(z[y].length==0){
								str += "<td class='cont'   onclick='openStuDialog(\""+0+","+p[i].id+y+"\")'  >" + x[y]+"</td>";
							} else {
								str += "<td class='cont'   onclick='openStuDialog(\""+z[y]+","+p[i].id+y+"\")'  >" + x[y]+"</td>";	
							}
				     }
					str +="</tr>";
				}  
				$("#dg").html(str);
			}
		});
		
}


$(function(){
	searchSchedular();
});

var userids="";
var jieci="";
function openStuDialog(a){
	var deptid = a.split(",")[0];
	if(deptid=="0"){ // 没有排课不用管			
	} else {
		 var periodid = a.split(",")[1].charAt(0); // 节次
		 var xingqi = a.split(",")[1].charAt(1);
		 jieci = periodid;
		 $.ajax({
			 	url : "${path}/att/dianming.htm",
				dataType:'json',
				type:'post',
				data:{
					deptid:deptid,
					xingqi:xingqi,
					periodid:periodid
				},
				async:false,
				success:function(data){
					if(data.errorMsg){
						$.messager.alert('系统提示',"<font color=red>"+data.errorMsg+"</font>");
						return;
					} 
					var a = data.rows;
					var str = "<tr><td>姓名</td><td>结果</td></tr>";
					for(var i=0;i<a.length;i++){
						var u = a[i];
						var userId = u.userId;
						userids+=(userId+",");
						var n = userId+"attvalue";
						str += "<tr><td>"+u.realName+"</td><td>";
						str += "<input  type='radio' name='"+n+"' checked  value='正常' >正常";
						str += "<input  type='radio' name='"+n+"'  value='迟到' >迟到";
						str += "<input  type='radio' name='"+n+"'  value='早退' >早退";
						str += "<input  type='radio' name='"+n+"'  value='旷课' >旷课";
						str +="</td></tr>";
					}
					$("#dg2").html(str);
					$("#dlg2").dialog("open").dialog("setTitle","学生考勤");
				}
		 });
	}
}

var studentId=[];
var studentAtt=[];
function saveAtt(){
	if(userids.length>1){
		userids = userids.substring(0,userids.length-1);
		var xxxx = userids.split(",");
		for(var i=0;i<xxxx.length;i++){
			var uid = xxxx[i];
			var uvalue = $("input[name='"+uid+"attvalue']:checked").val();
			studentId.push(uid);
			studentAtt.push(uvalue);
		}
	}
	var studentIds=studentId.join(",");
	var studentAtts=studentAtt.join(",");
	$.ajax({
		url : "${path}/att/add.htm",
		dataType:'json',
		type:'post',
		data:{
			studentIds:studentIds,
			studentAtts:studentAtts,
			periodid:jieci
		},
		async:false,
		success:function(data){
			if(data.success){
				$.messager.alert('系统提示',"保存成功");
				closeAttDialog();
				return;
			} else {
				$.messager.alert('系统提示',"<font color=red>"+data.errorMsg+"</font>");
			}
		}
		
	});
}

function closeAttDialog(){
	$("#dg2").html("");
	$("#dlg2").dialog("close");
}
</script>
  </head>
 
<body >

<div >
		<table  id="dg"     class="gridtable">
        	
		</table>
</div>






<!-- 学生列表 -->
<div id="dlg2" class="easyui-dialog" iconCls="icon-search" style="width: 500px;height: 420px;padding: 10px 20px"
  closed="true" buttons="#dlg2-buttons">
  <div style="height: 400px;">
  	<table id="dg2"   class="xx" >
    	
	</table>
  </div>
</div>

<div id="dlg2-buttons">
	<a href="javascript:saveAtt()" class="easyui-linkbutton" iconCls="icon-ok" >保存</a>
	<a href="javascript:closeAttDialog()" class="easyui-linkbutton" iconCls="icon-cancel" >关闭</a>
</div>




			


</body>
</html>

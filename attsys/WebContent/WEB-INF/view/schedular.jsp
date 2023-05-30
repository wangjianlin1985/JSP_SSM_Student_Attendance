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
</style>
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
			searchSchedular();
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

function searchSchedular(){
		$.ajax({
			url :'${path}/schedular/loadOneDeptSchedular.htm',
			data:{
				deptid:$('#hidePid').val()		
			},
			dataType:'json',
			type:'post',
			async:false,
			success:function(data){
				var d = data.rows;
				var p = data.periodList;
				var str = "<tr><td>星期节次</td><td>周一</td><td>周二</td><td>周三</td><td>周四</td><td>周五</td></tr>";
				for(var i=0;i<d.length;i++){
					var x = d[i].split(",");
					str += "<tr><td>"+p[i].name+"<br/>"+p[i].start+"-"+p[i].end+"</td>";
					 for(var y = 0;y<x.length;y++){
			        		str += "<td class='cont'  onmousedown='whichButton(event,"+p[i].id+y+")'      onclick='openShedular(\""+p[i].id+y+"\")'  >" + x[y]+"</td>";
				     }
					str +="</tr>";
				}  
				$("#dg").html(str);
			}
		});
		
}

var xurl;
function openShedular(a){
	var periodid = a.charAt(0);
	var x = parseInt(a.charAt(1));
	var xingqi = "";
	if(x=="0"){
		xingqi = "周一";
	} else if(x=="1"){
		xingqi = "周二";
	}else if(x=="2"){
		xingqi = "周三";
	}else if(x=="3"){
		xingqi = "周四";
	}else if(x=="4"){
		xingqi = "周五";
	}
	
	$.ajax({
		url:'loadCourseByDeptid.htm', // 加载给该班级分配的课程和教师
		data:{
			deptid:$("#hidePid").val()
		},
		dataType:'json',
		type:'post',
		async:false,
		success:function(data){
			var d = data.rows;
			var str = "";
			for(var i=0;i<d.length;i++){
				var c = d[i].course; // 课程
				var t = d[i].user;     // 教师
				str += "<option  value='"+d[i].id+"'>"+c.name+" "+t.realName+"</option>";
				//<option value="1">语文 教师1</option>
			}
			$("#sct").html(str);
		}
		
	});
	
	$.ajax({
		url:'searchIfExist.htm',
		data:{
			periodid:periodid,
			xingqi:xingqi,
			deptid:$("#hidePid").val()
		},
		dataType:'json',
		type:'post',
		async:false,
		success:function(data){
			$("#sweek").val(xingqi);
			$("#speriodid").combobox("setValue",periodid);
			 if(data.update){ // 更新
				var schedular = data.schedular;
				xurl="reserve.htm?deptid="+$("#hidePid").val()+"&id="+schedular.id;
				var v = schedular.ct.id;
				$("#sct").val(v);
			} else {
				xurl="reserve.htm?deptid="+$("#hidePid").val();
			}
		}
	});
	$("#dlg").dialog("open").dialog("setTitle","课程安排");
}


function reserveSchedular(){
	$("#fm").form("submit",{
		url:xurl,
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
				closeSchedularDialog();
				searchSchedular();
			}
		}
	});
}

function closeSchedularDialog(){
	$("#fm").form('clear');
	$("#dlg").dialog("close");
}

function whichButton(event,a){
	var btnNum = event.button;
	if(btnNum==1){  // 鼠标中键		
		deleteSchedular(a);
	}
}

function deleteSchedular(a){
	a = a+"";
	var periodid = a.charAt(0);
	var x = parseInt(a.charAt(1));
	var xingqi = "";
	if(x=="0"){
		xingqi = "周一";
	} else if(x=="1"){
		xingqi = "周二";
	}else if(x=="2"){
		xingqi = "周三";
	}else if(x=="3"){
		xingqi = "周四";
	}else if(x=="4"){
		xingqi = "周五";
	}
	
	
	$.ajax({
		url:'searchIfExist.htm',
		data:{
			periodid:periodid,
			xingqi:xingqi,
			deptid:$("#hidePid").val()
		},
		dataType:'json',
		type:'post',
		async:false,
		success:function(data){
			 if(data.update){ // 更新有值说明是删除
				var schedularid = data.schedular.id;
				$.messager.confirm("系统提示","您确认要删除这条数据吗？",function(r){
					if(r){
						$.post("delete.htm",{id:schedularid},function(result){
							if(result.success){
								$.messager.alert('系统提示',"删除成功！");
								searchSchedular();
							}else{
								$.messager.alert('系统提示',result.errorMsg);
							}
						},"json");
					}
				});
				
			} else {  // 空值不需操作 
				
			}
		}
	});
	
}


</script>
  </head>
 
<body class="easyui-layout" >

<input  type="hidden" id="hidePid"  value="0" />

<div region="center">
		<div >
	<div class="updownInterval"> </div>
	<div style="color:red">说明：单机框新增或修改该节课程，中键删除该课程安排</div>
	<div class="updownInterval"> </div>
</div>
		<table  id="dg"     class="gridtable">
        
		</table>
</div>


	

<div region="west" style="width: 160px;padding: 5px;" title="班级" split="true">
		<ul id="treeDemo" class="ztree"></ul>
</div>

			
<!-- 新增和修改对话框 -->
<div id="dlg" class="easyui-dialog" style="text-align:right;width: 320px;height: 420px;padding: 10px 20px"
  closed="true" buttons="#dlg-buttons">
 <form id="fm" method="post">
 	<table cellspacing="5px;">
 		<tr>
  			<td>课程教师：</td>
  			<td>
  				<select id="sct"  name="ct.id">
  				
  				</select>
  			</td>
  		</tr>
  		
  		<tr>
  			<td>星期：</td>
  			<td >
  						<select id="sweek" name="week">
  							<option value="周一">周一</option>
  							<option value="周二">周二</option>
  							<option value="周三">周三</option>
  							<option value="周四">周四</option>
  							<option value="周五">周五</option>
  					  </select>
  			</td>
  		</tr>
 	
 		<tr>
  			<td>节次：</td>
  			<td><input class="easyui-combobox"   id="speriodid"  name="period.id"  size="20" data-options="editable:false,panelHeight:'auto',valueField:'id',textField:'name',url:'${path }/period/loadAllPeriod.htm'"/></td>
  		</tr>
  		
  	</table>
 </form>
</div>
<div id="dlg-buttons" style="text-align:center">
	<a href="javascript:reserveSchedular()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeSchedularDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>

</body>
</html>

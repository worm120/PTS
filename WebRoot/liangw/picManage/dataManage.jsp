<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,liangw.PicManage,liangw.PicManageBean"%>
<jsp:useBean id="pic" class="liangw.PicManageBean" scope="session"></jsp:useBean>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
	<head>
		<title>图像与温度安全监测管理系统</title>
		<meta content="text/html; charset=utf-8" http-equiv=content-type>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<link href="../css/font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css">  
        <link  rel="stylesheet" type="text/css" href="../css/add.css">  
		<script type='text/javascript' src='/PTS/dwr/interface/dataManage.js'></script>
		<script type='text/javascript' src='/PTS/dwr/engine.js'></script>
		<script type='text/javascript' src='/PTS/dwr/util.js'></script>
		<script language="javascript">

var photoPage;
// 查看图像
function view(location,name) {
	document.getElementById("viewpic").src = location;
	document.getElementById("photoview").innerHTML = name;
}

function callView(data) {
	for (var j = 1; j < 10; j++) {
		document.getElementById(j).checked = false;
	}
	for (var i = 0; i < data.length; i++) {
		if (data[i] == 0) {
			document.getElementById(i + 1).checked = false;
		} else {
			document.getElementById(i + 1).checked = true;
		}
	}
}

// 修改用户现有的权限
function change(cid) {
	id=cid;
	dataManage.findRight(cid, callChange);
}

function callChange(data) {
	for (var j = 1; j < 10; j++) {
		document.getElementById("c" + j).checked = false;
	}
	for (var i = 1; i < data.length + 1; i++) {
		if (data[i - 1] == 0) {
			document.getElementById("c" + i).checked = false;
		} else {
			document.getElementById("c" + i).checked = true;
		}
	}
}

// 当全选按钮被选中时所有复选框被选中，再次点击时取消全选
function selAll() {
	var selAll = document.all['selAll'];
	var selOne = document.all['selOne'];
	if (selAll.checked) {
		if (selOne.length) {
			for (var i = 0; i < selOne.length; i++) {
				selOne[i].checked = true;
			}
		} else {
			selOne.checked = true;
		}
	} else {
		if (selOne.length) {
			for (var i = 0; i < selOne.length; i++) {
				selOne[i].checked = false;
			}
		} else {
			selOne.checked = false;
		}
	}
}

// 当所有复选框被选中时，全选按钮被选中;但若至少有一个没被选中，全选按钮不被选中
function selOne() {
	var selAll = document.all['selAll'];
	var selOne = document.all['selOne'];
	var sel = 0;
	var unsel = 0;
	for (var i = 0; i < selOne.length; i++) {
		if (selOne[i].checked == true) {
			sel++;
		}
		if (selOne[i].checked == false) {
			unsel++;
		}
		if (sel == selOne.length) {
			selAll.checked = true;
		}
		if (unsel > 0) {
			selAll.checked = false;
		}
	}
}

// 删除单张图像
function deletePic(id) {
	var sure = window.confirm("确定要删除吗？")
	if (sure == 1) {
		dataManage.deleOne(id, callDelete);
	}
}
function callDelete(data) {
	if (data == true) {
		alert("图像删除成功！");
		var substation = '<%=request.getParameter("sid")%>';
		var device = '<%=request.getParameter("nodeid")%>';
		var sample = document.getElementById("sample").value;
		dataManage.inquerySample(sample, substation, device, callGetInfer);
		//location.reload();
	} else {
		alert("图像删除失败！");
		var substation = '<%=request.getParameter("sid")%>';
		var device = '<%=request.getParameter("nodeid")%>';
		var sample = document.getElementById("sample").value;
		dataManage.inquerySample(sample, substation, device, callGetInfer);
		//location.reload();
	}
}

// 批量删除操作
function dele() {
	var sure = window.confirm('真的要删除么?');
	var selOne = document.all['selOne'];
	//var selll = document.getElementById("selOne").value;
	var ids = "i";
	if (sure == 1) {
		if (typeof(selOne.length) == "undefined") {
			if (document.getElementById("selOne").checked == true) {
				ids = document.getElementById("selOne").value;
			}
		} else {
			for (var i = 0; i < selOne.length; i++) {
				if (selOne[i].checked == true) {
					ids = ids + "," + selOne[i].value;
				}
			}
			ids = ids.substr(2, ids.length);
		}
		if (ids == "" || ids == "i") {
			alert("请先勾选记录再删除！");
			return;
		}
		dataManage.delePic(ids, deleback);
	} else
		window.location.reload();
}

function deleback(data) {
	if (data == 0) {
		alert("记录删除失败！");
		var substation = '<%=request.getParameter("sid")%>';
		var device = '<%=request.getParameter("nodeid")%>';
		var sample = document.getElementById("sample").value;
		dataManage.inquerySample(sample, substation, device, callGetInfer);
		//location.reload();
	}
	if (data == 1) {
		alert("记录删除成功！");
		var substation = '<%=request.getParameter("sid")%>';
		var device = '<%=request.getParameter("nodeid")%>';
		var sample = document.getElementById("sample").value;
		dataManage.inquerySample(sample, substation, device, callGetInfer);
		//location.reload();
	}
}



//查询操作
function inquery() {
	var substation = '<%=request.getParameter("sid")%>';
	var device = '<%=request.getParameter("nodeid")%>';
	//var substation = '<%=request.getParameter("sid")%>';
	//var device = document.getElementById("device").value;
	var sampleid = document.getElementById("sample").value;
	//if (substation=="-1") {
	//	alert("请先选择变电所")
	//	document.getElementById("substation").focus();
	//} else 
	//if (device=="-1") {
	//	dataManage.inquerySub(substation,callGetInfer);
	//}
	if (sampleid=="-1") {
		inqueryAll();
	} else {
		var pageDiv = document.getElementById("checkPage");
    	pageDiv.style.display="block";
    	first();
		//dataManage.inquerySample(sampleid,substation,device,0,callGetInfer);
	}
}

//查询所有采样点的图像
function inqueryAll() {
    var pageDiv = document.getElementById("checkPage");
    pageDiv.style.display="block";
	first();
}

// 根据开关柜自动加载该开关柜下的所有采样点
function getSample() {
	var sid = '<%=request.getParameter("sid")%>';
	var nodeid = '<%=request.getParameter("nodeid")%>';
	//var sample = document.getElementById("sample").value;
	document.getElementById("sample").style.display="";
	dataManage.getSample(sid, nodeid, callGetSample);
}
function callGetSample(data) {
	document.getElementById("sample").options.length = 0;
	document.getElementById("sample").add(new Option("请选择采样点", "-1"));
	var sample = document.getElementById("sample");
	for (var i = 0; i < data.length; i++) {
		sample.add(new Option(data[i].sname, data[i].sid));
	}
}
function callGetInfer(data) {
	//alert(data[0].photophotoid);
	var table = document.getElementById("table");
	//var sample = document.getElementById("sample").value;
	var tr = new Array();
	var td = new Array();
	//var div = new Array();
	while (table.childNodes.length > 0) {
		table.removeChild(table.childNodes[0]);
	}
	var r = table.insertRow(-1);
	var d7 = r.insertCell();
	var d6 = r.insertCell();
	var d5 = r.insertCell();
	var d4 = r.insertCell();
	var d3 = r.insertCell();
	var d2 = r.insertCell();
	var d1 = r.insertCell();
	d7.innerHTML = "选择";
	d7.className = "table-style-th";
	d7.style = "width:10px;text-align:center;";
	d6.innerHTML = "所在开关柜名称";
	d6.className = "table-style-th";
	d5.innerHTML = "采样点名称";
	d5.className = "table-style-th";
	d4.innerHTML = "图像名称";
	d4.className = "table-style-th";
	d3.innerHTML = "采样时间";
	d3.className = "table-style-th";
	d2.innerHTML = "备注";
	d2.className = "table-style-th";
	d1.innerHTML = "操作";
	d1.className = "table-style-th";
	for (var i = 0; i < data.length; i++) {
		tr[i] = table.insertRow(-1);
		td[i + "7"] = tr[i].insertCell();
		td[i + "6"] = tr[i].insertCell();
		td[i + "5"] = tr[i].insertCell();
		td[i + "4"] = tr[i].insertCell();
		td[i + "3"] = tr[i].insertCell();
		td[i + "2"] = tr[i].insertCell();
		td[i + "1"] = tr[i].insertCell();

		td[i + "7"].className = "table-style-th1";
		td[i + "7"].style = "width:3%;text-align:center;";
		td[i + "7"].innerHTML = "<input type='checkbox' id='selOne' value='"
				+ data[i].photophotoid + "' onclick='selOne()';>";

		td[i + "6"].className = "table-style-td";
		td[i + "6"].style = "width:13%;";
		td[i + "6"].innerHTML = data[i].dname;

		td[i + "5"].className = "table-style-td";
		td[i + "5"].style = "width:13%;";
		td[i + "5"].innerHTML = data[i].photosname;

		td[i + "4"].className = "table-style-td";
		td[i + "4"].style = "width:13%;";
		td[i + "4"].innerHTML = data[i].photopname;

		td[i + "3"].className = "table-style-td";
		td[i + "3"].style = "width:18%;";
		td[i + "3"].innerHTML = data[i].photopdate;

		td[i + "2"].className = "table-style-td";
		td[i + "2"].style = "width:20%;";
		td[i + "2"].innerHTML = data[i].photoprem;

		td[i + "1"].className = "table-style-td";
		td[i + "1"].style = "width:20%;";
		td[i + "1"].innerHTML = "<div id ='div0' class='caozuo1'>"
				+ "<button id='view' class='btn-del' onclick=\"document.getElementById('showView').style.display='block';"
				+ "view('"
				+ data[i].photoplocation
				+ "','"
				+ data[i].photopname
				+ "');"
				+ "document.getElementById('fade').style.display='block';\">查看</button>"
				+ "<button id='change" + i
				+ "' class='btn-del' onclick=\"deletePic('"
				+ data[i].photophotoid + "');\">删除</button>" + "</div>";
		// var setbtn = document.getElementById("change" + i);
		// if (had[i] == "1") {
		// setbtn.innerHTML = "设置";
		// setbtn.disabled = "true";
		// setbtn.style.background = "#eeeeee";
		// setbtn.style.color = "#999999";
		/*
		 * setbtn.onclick = function() { //alert(sample)
		 * picSet.cancelInfer(sample,callCancelInfer); // setbtn.style.display =
		 * "none"; }
		 */
	}
}

function getAllPhotoNumber()
{
	dwr.engine.setAsync(false);
	dataManage.getPicNum(callPhotoNumber);
	dwr.engine.setAsync(true);
}

function getSamplePhotoNumber(sampleid)
{
	dwr.engine.setAsync(false);
	//alert(sampleid);
	dataManage.getSamplePicNum(sampleid,callPhotoNumber);
	dwr.engine.setAsync(true);
}

function callPhotoNumber(data)
{
	//alert(data);
	var photoNumber = data;
	//alert(data);
	if(photoNumber%12==0)
		photoPage=photoNumber/12;
	else
		photoPage=parseInt(photoNumber/12+1);
	//alert(photoPage);
}

function first()
{
	var substation = '<%=request.getParameter("sid")%>';
	var nodeid = '<%=request.getParameter("nodeid")%>';
	var sampleid = document.getElementById("sample").value;
	if(sampleid=="-1")
		getAllPhotoNumber();	
	else
		getSamplePhotoNumber(sampleid);
	 
	//alert(photoPage);
	
	var pageIndex = 0;
	var showPageIndex = pageIndex+1;
	document.getElementById("truePage").innerHTML=pageIndex;
	document.getElementById("pageIndex").innerHTML="第"+showPageIndex+"页";
	document.getElementById("pages").innerHTML="共"+photoPage+"页";
	dataManage.inqueryDevice(nodeid,substation,pageIndex,callGetInfer);
}
function pre()
{	
	var substation = '<%=request.getParameter("sid")%>';
	var nodeid = '<%=request.getParameter("nodeid")%>';
	var sampleid = document.getElementById("sample").value;
	if(sampleid=="-1")
		getAllPhotoNumber();	
	else
		getSamplePhotoNumber(sampleid);
	
	var pageIndex=parseInt(document.getElementById("truePage").innerHTML);
	
	if(pageIndex<=0)first();
	else
	{
		pageIndex=pageIndex-1;
		var showPageIndex = pageIndex+1;
		document.getElementById("truePage").innerHTML=pageIndex;
		document.getElementById("pageIndex").innerHTML="第"+showPageIndex+"页";
		document.getElementById("pages").innerHTML="共"+photoPage+"页";
	}
	dataManage.inqueryDevice(nodeid,substation,pageIndex,callGetInfer);
		
}
function next()
{
	var substation = '<%=request.getParameter("sid")%>';
	var nodeid = '<%=request.getParameter("nodeid")%>';
	var sampleid = document.getElementById("sample").value;
	if(sampleid=="-1")
		getAllPhotoNumber();	
	else
		getSamplePhotoNumber(sampleid);
	
	var pageIndex=parseInt(document.getElementById("truePage").innerHTML);
	
	if(pageIndex>=photoPage)last();
	else
	{
		pageIndex=pageIndex+1;
		document.getElementById("truePage").innerHTML=pageIndex;
		var showPageIndex = pageIndex+1;
		document.getElementById("pageIndex").innerHTML="第"+showPageIndex+"页";
		document.getElementById("pages").innerHTML="共"+photoPage+"页";
	}
	dataManage.inqueryDevice(nodeid,substation,pageIndex,callGetInfer);
}
function last()
{
	var substation = '<%=request.getParameter("sid")%>';
	var nodeid = '<%=request.getParameter("nodeid")%>';
	
	var sampleid = document.getElementById("sample").value;
	if(sampleid=="-1")
		getAllPhotoNumber();	
	else
		getSamplePhotoNumber(sampleid);
	 
	//alert(photoPage);
	
	var pageIndex = photoPage-1;
	var showPageIndex = pageIndex+1;
	document.getElementById("truePage").innerHTML=pageIndex;
	document.getElementById("pageIndex").innerHTML="第"+showPageIndex+"页";
	document.getElementById("pages").innerHTML="共"+photoPage+"页";
	dataManage.inqueryDevice(nodeid,substation,pageIndex,callGetInfer);
}

</script>

<style>
.black_overlay {
	display: none;
	position: absolute;
	top: 0%;
	left: 0%;
	width: 100%;
	height: 100%;
	background-color: #EEEEEE;
	z-index: 1001;
	-moz-opacity: 0.8;
	opacity: .80;
	filter: alpha(opacity = 80);
}
.white_content {
	display: none;
	position: absolute;
	top: 15%;
	left: 20%;
	width: 50%;
	height: 55%;
	padding: 16px;
	border: 16px solid orange;
	background-color: white;
	z-index: 1002;
	overflow: auto;
}
.view_content {
	display: none;
	position: absolute;
	top: 5%;
	left: 12%;
	width: 67%;
	height: 85%;
	padding: 10px;
	border: 10px solid orange;
	background-color: white;
	z-index: 1002;
	overflow: auto;
}
</style>
	</head>
	<body onload="getSample();">
		<!--content start-->
    <div id="content" style="overflow: auto;" class="box-content">
        <div id="content-header">
            <div id="content-header-leader">
                <a class="tip-button">
                    <i class="icon icon-home"></i>
                   	 首页
                </a>
                <a class="current" href="#">
                   	 图像
                </a>
				 <select id="sample" onchange="inquery()" class="selected"
						style="display:none;" ">
						<option selected value=-1>
							请选择采样点
						</option>
				 </select>
            </div>
        </div>
        <div id="content-field">
            <div class="box-title">
                <div class="checkall"><input name="selAll" id="selAll" type="checkbox" onclick="selAll()"></div>
                <div class="quanxuan">全选</div>
                 <div class="mycaozuo">
                    &nbsp;&nbsp;&nbsp;&nbsp;<i class="icon-remove-sign"></i>
                    <button id="delete" class="btn-iqr" onclick="dele()">批量删除</button>
                    <button id="inqueryAll" class="btn-iqr" onclick="inqueryAll()">查看图片</button>
                    <!--
                    <button id="inquery" class="btn-del" onclick="inquery()">查询</button>
                    -->
                </div>
            </div>
            <div>
                <table class="table-style" id="table">
				</table>
			</div>
			<div id="checkPage" style="display:none;background: #efefef;">
				<p align="right">
				<button id="inqueryAll" id="first" onClick="first()" style="width:50px;height:30px;">首页</button>
				<button id="inqueryAll" id="pre" onClick="pre()" style="width:50px;height:30px;">上一页</button>
				<button id="inqueryAll" id="next" onClick="next()" style="width:50px;height:30px;">下一页</button>
				<button id="inqueryAll" id="last" onClick="last()" style="width:50px;height:30px;">尾页</button>
				<font id="pageIndex">0</font>
				/
				<font id="pages">共1页</font>
				<input type="hidden" name="cp" value="0"><font style="display:none" id="truePage">0</font>
				</p>
			</div>
		</div>
	</div>
		<div id="showView" class="view_content">
			<table border=0 width=100% align=center id="picture">
				<tr>
					<td align="center"  valign="middle" width=90%>
						&nbsp;&nbsp;<span id="photoview"></span>
					</td>
					<td align="left" valign="middle" width=10%>
						<a href = "javascript:void(0)" onclick = "document.getElementById('showView').style.display='none';
		                   document.getElementById('fade').style.display='none'">关闭</a>
					</td>
				</tr>
				<tr><td height=15></td></tr>
				<tr>
					<td align=center>
						<img id="viewpic" src="" style="Z-index: 0; left: 125px; width: 70%; position: absolute; top: 50px; height: 88%"/>
					</td>
				</tr>
			</table>
		</div>
		<div id="fade" class="black_overlay"></div>
	</body>
</html>
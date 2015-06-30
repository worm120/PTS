<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,liangw.PicManage,liangw.PicManageBean"%>
<jsp:useBean id="pic" class="liangw.PicManageBean" scope="session"></jsp:useBean>
<!DOCTYPE html>
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
		<link href="../css/font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css">  
        <link  rel="stylesheet" type="text/css" href="../css/add.css">  
		<script type='text/javascript' src='/PTS/dwr/interface/picSet.js'></script>
		<script type='text/javascript' src='/PTS/dwr/engine.js'></script>
		<script type='text/javascript' src='/PTS/dwr/util.js'></script>
		<script language="javascript">
//定义全局变量
var plocation = new Array();
var	pname = new Array();

// 根据变电所和开关柜自动加载其下所有采样点
function getSample() {
	var sid = '<%=request.getParameter("sid")%>';
	var nodeid = '<%=request.getParameter("nodeid")%>';
	//var sample = document.getElementById("sample").value;
	document.getElementById("sample").style.display="";
	picSet.getSample(sid, nodeid, callGetSample);
}
function callGetSample(data) {
	document.getElementById("sample").options.length = 0;
	document.getElementById("sample").add(new Option("请选择采样点", "-1"));
	var sample = document.getElementById("sample");
	for (var i = 0; i < data.length; i++) {
		sample.add(new Option(data[i].sname, data[i].sid));
	}
}
// 根据所选择的采样点自动加载所有图像列表
function getPicTime() {
    var sample = document.getElementById("sample").value;
	picSet.getInfer(sample, callGetInfer);
}
function callGetInfer(data) {
	var sample = document.getElementById("sample").value;
	if (data == null)
	pid="";
	else pid=data;
	picSet.getPicTime(sample, callGetPicTime);
}
function callGetPicTime(data) {
	had = new Array();
	have = "0";
	// document.getElementById("content-field").style.display="";
	var table = document.getElementById("table");
	var sample = document.getElementById("sample").value;
	var tr = new Array();
	var td = new Array();
	var div = new Array();
	while (table.childNodes.length > 0) {
		table.removeChild(table.childNodes[0]);
	}
	var r = table.insertRow(-1);
	var d5 = r.insertCell();
	var d4 = r.insertCell();
	var d3 = r.insertCell();
	var d2 = r.insertCell();
	var d1 = r.insertCell();
	d5.innerHTML = "图像名称";
	d5.className = "table-style-th";
	d4.innerHTML = "采样时间";
	d4.className = "table-style-th";
	d3.innerHTML = "是否参照图像";
	d3.className = "table-style-th";
	d2.innerHTML = "备注";
	d2.className = "table-style-th";
	d1.innerHTML = "操作";
	d1.className = "table-style-th";
	for (var i = 0; i < data.length; i++) {
		tr[i] = table.insertRow(-1);
		td[i + "5"] = tr[i].insertCell();
		td[i + "4"] = tr[i].insertCell();
		td[i + "3"] = tr[i].insertCell();
		td[i + "2"] = tr[i].insertCell();
		td[i + "1"] = tr[i].insertCell();
		td[i + "5"].className = "table-style-td";
		td[i + "5"].style = "width:15%";
		td[i + "5"].innerHTML = data[i].pname;

		td[i + "4"].className = "table-style-td";
		td[i + "4"].style = "width:25%";
		td[i + "4"].innerHTML = data[i].pdate;
		if (data[i].photoid == pid) {
			var phoid = "是";
			had[i] = "1";
			have = "1";
		} else {
			var phoid = "否";
			had[i] = "0";
		}
		td[i + "3"].className = "table-style-td";
		td[i + "3"].style = "width:10%";
		td[i + "3"].innerHTML = phoid;

		td[i + "2"].className = "table-style-td";
		td[i + "2"].style = "width:25%";
		td[i + "2"].innerHTML = data[i].prem;

		td[i + "1"].className = "table-style-td";
		td[i + "1"].style = "width:25%";
		td[i + "1"].innerHTML = "<div id ='div0' class='caozuo1'>"
				+ "<button id='view' class='btn-del' onclick=\"document.getElementById('showView').style.display='block';"
				+ "view('"
				+ data[i].plocation
				+ "','"
				+ data[i].pname
				+ "');"
				+ "document.getElementById('fade').style.display='block';\">预览</button>"
				+ "<button id='change" + i
				+ "' class='btn-del' onclick=\"set('" + sample + "','"
				+ data[i].photoid + "','" + data[i].pname + "','"
				+ data[i].plocation + "','" + data[i].pdate
				+ "');\">设置</button>" + "</div>";
		var setbtn = document.getElementById("change" + i);
		if (had[i] == "1") {
			setbtn.innerHTML = "设置";
			setbtn.disabled="true";
			setbtn.style.background="#eeeeee";
			setbtn.style.color="#999999";
			/*setbtn.onclick = function() {
				//alert(sample)
				 picSet.cancelInfer(sample,callCancelInfer);
				// setbtn.style.display = "none";
			}*/
		}
	}
}
// 查看图像
function view(location,name) {
	document.getElementById("viewpic").src = location;
	document.getElementById("photoview").innerHTML = name;
}
// 设为参照图像
function set(sid, pid, pname, plocation, pdate) {
	var sure = window.confirm('设为参照图像?');
	if (sure == 1) {
		if (have == "1") {
			picSet.setInfer(sid, pid, pname, plocation, pdate, "1", callInfer);
		} else {
			//alert(sid+"??"+pid+"??"+pname+"??"+plocation+"??"+pdate)
			picSet.setInfer(sid, pid, pname, plocation, pdate, "0", callInfer);
		}
	} else
		getPicTime();
}

function callInfer(data) {
	if (data == 1) {
		alert("设置成功！");
		getPicTime();
		//window.location.reload();
	}
	if (data == 0) {
		alert("设置失败！");
		getPicTime();
		//window.location.reload();
	}
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
    <div id="content" style="overflow: auto; " class="box-content">
        <div id="content-header">
            <div id="content-header-leader">
                <a class="tip-button">
                    <i class="icon icon-home"></i>
                   	 首页
                </a>
                <a class="current" href="#">
                   	 图像
                </a>
				 <select id="sample" onchange="getPicTime()" class="selected"
						style="display:none;">
						<option selected value=-1>
							请选择采样点
						</option>
				 </select>
            </div>
        </div>
        <div id="content-field"  >
            <div class="box-content" >
                <table class="table-style" id="table">
			</table>
		</div></div></div>
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
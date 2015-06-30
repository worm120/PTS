<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*,liangw.PicManage,liangw.PicManageBean"%>
<jsp:useBean id="picBean" class="liangw.PicManageBean"
	scope="session"></jsp:useBean>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>图像与温度安全监测管理系统</title>
		<meta content="text/html; charset=utf-8" http-equiv=content-type>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="../font-awesome/css/font-awesome.css" rel="stylesheet"
			type="text/css">
		<link rel="stylesheet" type="text/css" href="../css/add.css">

		<link rel="stylesheet" type="text/css"
			href="../jquery/css/imgareaselect-default.css" />

		<script type="text/javascript" src="../jquery/scripts/jquery.min.js"></script>
		<script type="text/javascript"
			src="../jquery/scripts/jquery.imgareaselect.pack.js"></script>

		<script type='text/javascript' src='/PTS/dwr/interface/picSet.js'></script>
		<script type='text/javascript' src='/PTS/dwr/interface/picCut.js'></script>
		<script type='text/javascript' src='/PTS/dwr/engine.js'></script>
		<script type='text/javascript' src='/PTS/dwr/util.js'></script>
	</head>
	<!--自动加载所有变电所名称-->
	<body onload="getSubstation();">
		<style>
div.preview_div {
	overflow: hidden;
	margin: auto;
}

div.p_photo_l {
	width: 230px;
	height: 210px;
}

div.sel1 {
	overflow: hidden;
	margin: auto;
}

div.psell {
	width: 230px;
	height: 210px;
}

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
	left: 20%;
	width: 47%;
	height: 75%;
	padding: 16px;
	border: 16px solid orange;
	background-color: white;
	z-index: 1002;
	overflow: auto;
}
</style>
		<div>
			<script type="text/javascript">
//全局变量，图像的ID
var picid=new Array();
var x;
var y;
var w;
var h;

//全局变量，图像的存储路径
var piclocation=new Array();

//$(document).ready(function() {
function pic() {
	imgAreaSelectApi = $('#img_origin').imgAreaSelect({
		persistent : false,	// true，选区以外点击不会启用一个新选区（只能移动/调整现有选区）
		instance : true, // true，返回一个imgAreaSelect绑定到的图像的实例，可以使用api方法
		onSelectChange : preview, // 改变选区时的回调函数
		show : true,	// 选区会显示
		handles : true, // true，调整手柄则会显示在选择区域内
		resizable : true,	// true， 选区面积可调整大小
		aspectRatio : 'img_origin.width:img_origin.height' // 选区的显示比率
	});
	
	//加载时触发的默认选区
	//$('#img_origin').load(function(){
	//});

	function preview(img, selection) {
		var picture = document.getElementById("picture").value;
		//alert(piclocation[picture]);
		$('div.preview_div img').attr('src', piclocation[picture]);
		//$('div.preview_div img').attr('src', "../images/0000.jpg");
		//$('div.sel1 img').attr('src', "../images/0000.jpg");
		document.getElementById("x1").value = selection.x1;
		document.getElementById("y1").value = selection.y1;
		document.getElementById("x2").value = selection.x2;
		document.getElementById("y2").value = selection.y2;
		document.getElementById("width").value = selection.x2 - selection.x1;
		document.getElementById("height").value = selection.y2 - selection.y1;
		//preview_photo('p_photo_l', selection);
		//preview_photo('psel1', selection);
	}
}
//});

function imgload() {
		var form = $('#coordinates_form');
		//获取 x、y、w、h的值
		//var left = parseInt(form.children('.x').val());	
		//var top = parseInt(form.children('.y').val());
		//var width = parseInt(form.children('.w').val());
		//var height = parseInt(form.children('.h').val());
		var left = x;	
		var top=y;
		var width = w;
		var height = h;
		
		//imgAreaSelectApi 就是图像img_origin的实例上边instance已解释
		//setSelection(),设置选区的坐标
		//update(),更新
		imgAreaSelectApi.setSelection(left, top, parseInt(left)+parseInt(width), parseInt(top)+parseInt(height));
		imgAreaSelectApi.update();
	}
// 自动加载所有变电所名称
function getSubstation() {
	picSet.getSubstation(callSubstation);
}

// 返回函数
function callSubstation(data) {
	var substation = document.getElementById("substation");
	for (var i = 0; i < data.length; i++) {
		substation.add(new Option(data[i].subname, data[i].subid));
	}
}
// 根据所选择的变电所自动加载该变电所下所有开关柜
function getDevice() {
	var substation = document.getElementById("substation").value;
	var device = document.getElementById("device").value;
	if (substation == "-1") {
		document.getElementById("device").options.length = 0;
		document.getElementById("device").add(new Option("请选择开关柜", "-1"));
	} else {
		document.getElementById("device").style.display="";
		picSet.getDevice(substation, callGetDevice);
	}
}
function callGetDevice(data) {
	document.getElementById("device").options.length = 0;
	document.getElementById("device").add(new Option("请选择开关柜", "-1"));
	var device = document.getElementById("device");
	for (var i = 0; i < data.length; i++) {
		device.add(new Option(data[i].dname, data[i].deviceid));
	}
}

// 根据所选择的开关柜自动加载该开关柜下所有采样点
function getSample() {
	var device = document.getElementById("device").value;
	var sample = document.getElementById("sample").value;
	if (device == "-1") {
		document.getElementById("sample").options.length = 0;
		document.getElementById("sample").add(new Option("请选择采样点", "-1"));
	} else {
		document.getElementById("sample").style.display="";
		picSet.getSample(device, callGetSample);
	}
}
function callGetSample(data) {
	document.getElementById("sample").options.length = 0;
	document.getElementById("sample").add(new Option("请选择采样点", "-1"));
	var sample = document.getElementById("sample");
	for (var i = 0; i < data.length; i++) {
		sample.add(new Option(data[i].sname, data[i].sid));
	}
}
// 设置先选择变电所才能选择相应变电所下的开关柜
function clickDevice() {
	var substation = document.getElementById("substation").value;
	if (substation == "-1") {
		alert("请先选择变电所！");
		document.getElementById("substation").focus();
	}
}
// 设置先选择开关柜才能选择相应变电所下的采样点
function clickSample() {
	var device = document.getElementById("device").value;
	if (device == "-1") {
		alert("请先选择开关柜！");
		document.getElementById("device").focus();
	}
}
// 根据所选择的采样点显示相应的参照图片
function getReferPic() {
	var sample = document.getElementById("sample").value;
	picSet.getReferPic(sample, callGetReferPic);
	
	//document.getElementById("div1").style.display="";
	//document.getElementById("table").style.display="";
}
function callGetReferPic(data) {
	var picid = document.getElementById("img_origin");
	var tb = document.getElementById("table");
	if (data.length==0) {
		tb.style.display="none";
		//picid.src="";
		alert("该采样点未设置参照图像！")
		return;
	} else {
	tb.style.display="";
	pid = data[0].photoid;
	var piclocation = data[0].plocation;
	picSet.getSelect(pid,callGetSelect);
	picid.style.display="";
	picid.src=piclocation;
	}
}
function callGetSelect(data) {
	if (data == "") {
		flag = 0;
		// document.getElementsByName("x").value = "0";
		// document.getElementsByName("y").value = "0";
		// document.getElementsByName("w").value = "300";
		// document.getElementsByName("h").value = "240";
		x = "0";
		y = "0";
		w = "320";
		h = "240";
		document.getElementById("x1").value = "0";
		document.getElementById("y1").value = "0";
		document.getElementById("x2").value = "320";
		document.getElementById("y2").value = "240";
		document.getElementById("width").value = "320";
		document.getElementById("height").value = "240";
		pic();
		imgload();
		//alert(document.getElementsByName("h").value)
	} else {
		flag = 1;
		// document.getElementsByName("x").value = data[0].x1;
		// document.getElementsByName("y").value = data[0].y1;
		// document.getElementsByName("w").value = data[0].width;
		// document.getElementsByName("h").value = data[0].height;
		//x=129;
		//y=71;
		//w=83;
		//h=119;
		x = data[0].x1;
		y = data[0].y1;
		w = data[0].width;
		h = data[0].height;
		//alert(data[0].x1)
		//alert(y)
		//alert(w)
		//alert(h)
		document.getElementById("x1").value = x;
		document.getElementById("y1").value = y;
		document.getElementById("x2").value = parseInt(x) + parseInt(w);
		document.getElementById("y2").value = parseInt(y) + parseInt(h);
		document.getElementById("width").value = w;
		document.getElementById("height").value = h;
		pic();
		imgload();
	}
}

// 保存选区
function save() {
	var sampleid = document.getElementById("sample").value;
	var x1 = document.getElementById("x1").value;
	var x2 = document.getElementById("x2").value;
	var y1 = document.getElementById("y1").value;
	var y2 = document.getElementById("y2").value;
	var width = document.getElementById("width").value;
	var height = document.getElementById("height").value;
		var sure = window.confirm('设为选区？');
		if (sure == 1){
			if (flag == 1) {
				//alert(x1+"??"+x2+"??"+y1+"??"+y2+"??"+width+"??"+height+"??"+sampleid+"??"+pid)
				picSet.updateSel(x1,y1,x2,y2,width,height,sampleid,pid,callSel);
		} 
			if (flag == 0) {
				//alert(x1+"??"+x2+"??"+y1+"??"+y2+"??"+width+"??"+height+"??"+sampleid+"??"+pid)
				picSet.insertSel(x1,y1,x2,y2,width,height,sampleid,pid,callSel)
		}
	}
}
function callSel(data) {
	if (data == true) {
		alert("选区设置成功！")
		getReferPic();
	} else {
		alert("选区设置失败！")
		getReferPic();
	}
}

// 删除选区
function dele() {
	var sampleid = document.getElementById("sample").value;
		var sure = window.confirm('删除选区？');
		if (sure == 1){
			if (flag == 1) {
				//alert(x1+"??"+x2+"??"+y1+"??"+y2+"??"+width+"??"+height+"??"+sampleid+"??"+pid)
				picSet.deleSel(sampleid,callDeleSel);
		} 
			if (flag == 0) {
				alert("删除成功！")
		}
	}
}
function callDeleSel(data) {
	if (data == true) {
		alert("选区删除成功！")
		getReferPic();
	} else {
		alert("选区删除失败！")
		getReferPic();
	}
}

</script>
		</div>
		<div id="content" style="overflow: auto; height: 490px;"
			class="box-content">
			<div id="content-header">
				<div id="content-header-leader">
					<a class="tip-button"> <i class="icon icon-home"></i> 首页 </a>
					<a class="current" href="#"> 图像 </a>
					<select id="substation" onchange="getDevice()" class="selected">
						<option selected value=-1>
							请选择变电所
						</option>
					</select>
					<select id="device" onchange="getSample()" class="selected"
						style="display: none;" onclick="clickDevice()">
						<option selected value=-1>
							请选择开关柜
						</option>
					</select>
					<select id="sample" onchange="getReferPic()" class="selected"
						style="display: none;" onclick="clickSample()">
						<option selected value=-1>
							请选择采样点
						</option>
					</select>
				</div>
			</div>
			<div id="content-field">
				<div class="box-content">
					<table class="table-style" id="table" style="display:none;">
						<tr><td height=20></td></tr>
						<tr>
							<td class='table-style-tdsel' align=center valign="top" style="border:none;height: 40px">
								<a class="current" href="#" style='font-size:20px;'> 请调整鼠标选出理想的区域  </a>
								<!-- <span class="pl20px">请在选择图像后拖动鼠标左键选出想要的区域 </span> -->
							</td>
						</tr>
						<tr>
							<td class='table-style-tdsel' rowspan=6
								style='height: 320px; width: 60%;border:none;'>
								<img id='img_origin' src="../images/001.jpg" />
							</td>
							<td class='table-style-tdsel' style='width: 40%; height: 40px;border:none;text-align:left;'>
								<a class="current" href="#" style='font-size:17px;'> 坐标 </a>
							</td>
						</tr>
						<tr>
							<td class='table-style-tdsel' style='height: 50px;border:none;text-align:left;'>
								<label class="span">
									X1
								</label>
								<input type="text" id="x1" style="width:50px" readonly=true>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<label class="span">
									Y1
								</label>
								<input type="text" id="y1" style="width:50px" readonly=true>
							</td>
						</tr>
						<tr>
							<td class='table-style-tdsel' style='height: 50px;border:none;text-align:left;'>
								<label class="span">
									X2
								</label>
								<input type="text" id="x2" style="width:50px" readonly=true>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<label class="span">
									Y2
								</label>
								<input type="text" id="y2" style="width:50px" readonly=true>
							</td>
						</tr>
						<tr><td height=20></td></tr>
						<tr>
							<td class='table-style-tdsel' style='width: 40%; height: 40px;border:none;text-align:left;'>
								<a class="current" href="#" style='font-size:17px;'> 尺寸 </a>
							</td>
						</tr>
						<tr>
							<td class='table-style-tdsel' style='height: 50px;border:none;text-align:left;'>
								<label class="span">
									宽
								</label>
								<input type="text" id="width" style="width:50px" readonly=true>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<label class="span">
									高
								</label>
								<input type="text" id="height" style="width:50px" readonly=true>
							</td>
						</tr>
						<tr>
							<td class='table-style-tdsel' style='height: 80px;border:none;text-align:center;' colspan=2>
								<input type="button" class="input-button" value="保存" id="save" onclick="save()"/>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="button" class="input-button" value="删除" id="dele" onclick="dele()"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>

		<div id="showView" class="view_content">
			<table border=0 width=100% align=center id="picture">
				<tr>
					<td align="center" valign="middle" width=90%>
						&nbsp;&nbsp;
						<span id="photoview"></span>
					</td>
					<td align="left" valign="middle" width=10%>
						<a href="javascript:void(0)" onclick="document.getElementById('showView').style.display='none';
						document.getElementById('fade').style.display='none';">关闭</a>
					</td>
				</tr>
				<tr>
					<td height=20></td>
				</tr>
			</table>
		</div>
		<div id="fade" class="black_overlay"></div>
								
	</body>
</html>
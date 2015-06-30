<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,liangw.UserManage,liangw.UserManageBean"%>
<jsp:useBean id="user" class="liangw.UserManageBean" scope="session"></jsp:useBean>
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
		<link href="../css/font-awesome/css/font-awesome.css" rel="stylesheet"
			type="text/css">
		<link rel="stylesheet" type="text/css" href="../css/add.css">
		<script type='text/javascript' src='/PTS/dwr/interface/rightAllo.js'></script>
		<script type='text/javascript' src='/PTS/dwr/engine.js'></script>
		<script type='text/javascript' src='/PTS/dwr/util.js'></script>

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
	top: 0;
	left: 20%;
	width: 50%;
	height: 85%;
	padding: 16px;
	border: 10px solid orange;
	background-color: white;
	z-index: 1002;
	overflow: auto;
}

.add {
	display: none;
	position: absolute;
	top: 12%;
	left: 22%;
	width: 450;
	height: 230;
	padding: 16px;
	border: 10px solid orange;
	background-color: white;
	z-index: 1002;
	overflow: auto;
}

.sel{ 
background: url(../images/check.png) no-repeat center bottom; 
float:left; 
margin-left:40px;
width:15px; 
height:15px;
border:none; 
color:#FFF; 
}
.nosel{ 
background: url(../images/nocheck.png) no-repeat center bottom; 
float:left; 
width:15px; 
margin-left:40px;
height:15px;
border:none;
color:#FFF; 
} 
</style>


		<script language="javascript">		

//全局变量
var subid = new Array();
var asid = "a";
var sid = null;
var resultData = "0";
var userid = null;

// 查看用户现有的权限
function view(id) {
	rightAllo.findRight(id, callView);
}

function callView(data) {
	var viewRight = document.getElementById("viewRight");
	while (viewRight.childNodes.length > 0) {
		viewRight.removeChild(viewRight.childNodes[0]);
	}
	var tr0 = viewRight.insertRow(-1);
	var td01 = tr0.insertCell();
	var td02 = tr0.insertCell();
	var tr1 = viewRight.insertRow(-1);
	var td11 = tr1.insertCell();

	td01.innerHTML = "用户权限查看";
	td01.align = 'center';
	td01.colSpan = '3';
	td02.innerHTML = "<a href = 'javascript:void(0)' id='closes' onclick = ''>关闭</a>";
	document.getElementById("closes").onclick = function() {
		document.getElementById("showView").style.display = "none";
		document.getElementById("fade").style.display = "none";
	};
	td11.height = '20';
	for (var i = 0; i < data.length; i++) {
		var tr = new Array();
		var td = new Array();
		tr[i + "0"] = viewRight.insertRow(-1);
		td[i + "01"] = tr[i + "0"].insertCell();
		tr[i + "1"] = viewRight.insertRow(-1);
		td[i + "11"] = tr[i + "1"].insertCell();
		tr[i + "2"] = viewRight.insertRow(-1);
		td[i + "21"] = tr[i + "2"].insertCell();
		td[i + "22"] = tr[i + "2"].insertCell();
		td[i + "23"] = tr[i + "2"].insertCell();
		tr[i + "3"] = viewRight.insertRow(-1);
		td[i + "31"] = tr[i + "3"].insertCell();
		td[i + "32"] = tr[i + "3"].insertCell();
		td[i + "33"] = tr[i + "3"].insertCell();
		tr[i + "4"] = viewRight.insertRow(-1);
		td[i + "41"] = tr[i + "4"].insertCell();
		td[i + "42"] = tr[i + "4"].insertCell();
		td[i + "43"] = tr[i + "4"].insertCell();
		tr[i + "5"] = viewRight.insertRow(-1);
		td[i + "51"] = tr[i + "5"].insertCell();

		td[i + "01"].innerHTML = "&nbsp;&nbsp;&nbsp;" + data[i].subname;
		td[i + "11"].height = '7'
		td[i + "21"].innerHTML = "&nbsp;<checkbox id='" + i
				+ "00' disabled class='sel'></checkbox>变电所";
		td[i + "21"].align = 'left';
		td[i + "22"].innerHTML = "&nbsp;<checkbox id='" + i
				+ "01' disabled class='sel'></checkbox>系统设置";
		td[i + "22"].align = 'left';
		td[i + "23"].innerHTML = "&nbsp;<checkbox id='" + i
				+ "02' disabled class='sel'></checkbox>用户管理";
		td[i + "23"].align = 'left';
		td[i + "31"].innerHTML = "&nbsp;<checkbox id='" + i
				+ "03' disabled class='sel'></checkbox>设备管理";
		td[i + "31"].align = 'left';
		td[i + "32"].innerHTML = "&nbsp;<checkbox id='" + i
				+ "04' disabled class='sel'></checkbox>接线图管理";
		td[i + "32"].align = 'left';
		td[i + "33"].innerHTML = "&nbsp;<checkbox id='" + i
				+ "05' disabled class='sel'></checkbox>接口设置";
		td[i + "33"].align = 'left';
		td[i + "41"].innerHTML = "&nbsp;<checkbox id='" + i
				+ "06' disabled class='sel'></checkbox>在线巡检";
		td[i + "41"].align = 'left';
		td[i + "42"].innerHTML = "&nbsp;<checkbox id='" + i
				+ "07' disabled class='sel'></checkbox>日志管理";
		td[i + "42"].align = 'left';
		td[i + "43"].innerHTML = "&nbsp;<checkbox id='" + i
				+ "08' disabled class='sel'></checkbox>历史记录";
		td[i + "43"].align = 'left';
		td[i + "51"].height = '5';
		for (j = 0; j < data[i].right.length; j++) {
			// for (j = 0; j < 3; j++) {
			var id = i + "0" + j;
			var sel = document.getElementById(id);
			if (data[i].right[j] == 0) {
				sel.style.background = "url(../images/nocheck.png) no-repeat center center";
				// document.getElementById(id).style.backgroud =
				// 'url(../images/nocheck.png) no-repeat center bottom';
				// document.getElementById(id).checked = false;
			} else {
				sel.style.background = "url(../images/check.png) no-repeat center bottom";
				// document.getElementById(id).checked = true;
			}
		}
	}
}
	

// 修改用户现有的权限
function change(cid) {
	id=cid;
	rightAllo.findRight(cid, callChange);
}

function callChange(data) {
	changedata = data;
	var changeRight = document.getElementById("changeRight");
	while (changeRight.childNodes.length > 0) {
		changeRight.removeChild(changeRight.childNodes[0]);
	}
	var trc0 = changeRight.insertRow(-1);
	var tdc01 = trc0.insertCell();
	var tdc02 = trc0.insertCell();
	var trc1 = changeRight.insertRow(-1);
	var tdc11 = trc1.insertCell();

	tdc01.innerHTML = "用户权限修改";
	tdc01.align = 'center';
	tdc01.colSpan = '3';
	tdc02.innerHTML = "<a href = 'javascript:void(0)' id='changeclose'>关闭</a>";
	document.getElementById("changeclose").onclick = function() {
		document.getElementById("showChange").style.display = "none";
		document.getElementById("fade").style.display = "none";
	};
	tdc11.height = '20';
	for (var i = 0; i < data.length; i++) {
		var trc = new Array();
		var tdc = new Array();
		trc[i + "0"] = changeRight.insertRow(-1);
		tdc[i + "01"] = trc[i + "0"].insertCell();
		trc[i + "1"] = changeRight.insertRow(-1);
		tdc[i + "11"] = trc[i + "1"].insertCell();
		trc[i + "2"] = changeRight.insertRow(-1);
		tdc[i + "21"] = trc[i + "2"].insertCell();
		tdc[i + "22"] = trc[i + "2"].insertCell();
		tdc[i + "23"] = trc[i + "2"].insertCell();
		trc[i + "3"] = changeRight.insertRow(-1);
		tdc[i + "31"] = trc[i + "3"].insertCell();
		tdc[i + "32"] = trc[i + "3"].insertCell();
		tdc[i + "33"] = trc[i + "3"].insertCell();
		trc[i + "4"] = changeRight.insertRow(-1);
		tdc[i + "41"] = trc[i + "4"].insertCell();
		tdc[i + "42"] = trc[i + "4"].insertCell();
		tdc[i + "43"] = trc[i + "4"].insertCell();
		trc[i + "5"] = changeRight.insertRow(-1);
		tdc[i + "51"] = trc[i + "5"].insertCell();

		subid[i] = data[i].subid;
		tdc[i + "01"].innerHTML = data[i].subname
		tdc[i + "11"].height = '7'
		tdc[i + "21"].innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='checkbox' id='"
				+ "c"
				+ i
				+ "00'   />&nbsp;<label class='span' for='"
				+ "c"
				+ i
				+ "00'>变电所</label>";
		tdc[i + "21"].align = 'left';
		tdc[i + "22"].innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='checkbox' id='"
				+ "c"
				+ i
				+ "01'   />&nbsp;<label class='span' for='"
				+ "c"
				+ i
				+ "01'>系统设置</label>";
		tdc[i + "22"].align = 'left';
		tdc[i + "23"].innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='checkbox' id='"
				+ "c"
				+ i
				+ "02'   />&nbsp;<label class='span' for='"
				+ "c"
				+ i
				+ "02'>用户管理</label>";
		tdc[i + "23"].align = 'left';
		tdc[i + "31"].innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='checkbox' id='"
				+ "c"
				+ i
				+ "03'   />&nbsp;<label class='span' for='"
				+ "c"
				+ i
				+ "03'>设备管理</label>";
		tdc[i + "31"].align = 'left';
		tdc[i + "32"].innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='checkbox' id='"
				+ "c"
				+ i
				+ "04'   />&nbsp;<label class='span' for='"
				+ "c"
				+ i
				+ "04'>接线图管理</label>";
		tdc[i + "32"].align = 'left';
		tdc[i + "33"].innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='checkbox' id='"
				+ "c"
				+ i
				+ "05'   />&nbsp;<label class='span' for='"
				+ "c"
				+ i
				+ "05'>接口设置</label>";
		tdc[i + "33"].align = 'left';
		tdc[i + "41"].innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='checkbox' id='"
				+ "c"
				+ i
				+ "06'   />&nbsp;<label class='span' for='"
				+ "c"
				+ i
				+ "06'>在线巡检</label>";
		tdc[i + "41"].align = 'left';
		tdc[i + "42"].innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='checkbox' id='"
				+ "c"
				+ i
				+ "07'   />&nbsp;<label class='span' for='"
				+ "c"
				+ i
				+ "07'>日志管理</label>";
		tdc[i + "42"].align = 'left';
		tdc[i + "43"].innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='checkbox' id='"
				+ "c"
				+ i
				+ "08'   />&nbsp;<label class='span' for='"
				+ "c"
				+ i
				+ "08'>历史记录</label>";
		tdc[i + "43"].align = 'left';
		tdc[i + "51"].height = '5';
		for (j = 0; j < data[i].right.length; j++) {
			// for (j = 0; j < 3; j++) {
			var id = "c" + i + "0" + j;
			if (data[i].right[j] == 0) {
				document.getElementById(id).checked = false;
			} else {
				document.getElementById(id).checked = true;
			}
		}
	}
	
	var cr1 = changeRight.insertRow(-1);
	var cd11 = cr1.insertCell();
	cd11.innerHTML = "<div id='vidv' style='left:50% bottom:10;'> <input id='sure' type='button' "
			+ "class='input-button' value='确定' onclick = 'sure()'> </div>";
	cd11.align = 'center';
	cd11.colSpan = '3';
	var cr2 = changeRight.insertRow(-1);
	var cd21 = cr2.insertCell();
	cd21.height = "15px";
	cd21.align = 'center';
	cd21.colSpan = '3';
	// document.getElementById("vdiv").style.position="absolute";
	// document.getElementById("vdiv").style.left="47%";
	// document.getElementById("vdiv").style.bottom="10";
	// document.getElementById("sure").style.size="18px";
}

// 提交权限修改数据
function sure() {
	//设置为同步调用，以便于数据传输的顺序执行
	dwr.engine.setAsync(false);
	for (var i = 0; i < changedata.length; i++) {
		var sel = 0;
		for (var j = 0; j < 9; j++) {
			if (document.getElementById("c" + i + "0" + j).checked == true) {
				sel = sel + "1";
			}
			if (document.getElementById("c" + i + "0" + j).checked == false) {
				sel = sel + "0";
			}
		}
		sel = sel.substr(1, sel.length);
		//alert(subid[i])
		rightAllo.changeRight(sel, id, subid[i], callSure);
	}
	dwr.engine.setAsync(true);
}
function callSure(data) {
	if (data == true) {
		resultData += "1";
		// alert("修改成功！");
		// window.location.reload();
	} else {
		resultData += "0";
		window.location.reload();
	}
	if (resultData.length - 1 == changedata.length) {
		for (var i = 1; i < resultData.length; i++) {
			if (resultData.substring(i, i + 1) == "0") {
				alert("修改失败！");
				window.location.reload();
			}
		}
		alert("修改成功！");
		window.location.reload();
	}
}

</script>

	</head>
	<body>
		<!--content start-->
		<div id="content" style="overflow: auto; height: 490px;"
			class="box-content">
			<div id="content-header">
				<div id="content-header-leader">
					<a class="tip-button"> <i class="icon icon-home"></i> 首页 </a>
					<a class="current" href="#"> 用户 </a>
				</div>
			</div>
			<div id="content-field">
				<div class="box-content">
					<table class="table-style" id="listtable">
						<tr>
							<td class="table-style-th">
								用户ID
							</td>
							<td class="table-style-th">
								用户姓名
							</td>
							<td class="table-style-th">
								登录名
							</td>
							<td class="table-style-th">
								开始时间
							</td>
							<td class="table-style-th">
								结束时间
							</td>
							<td class="table-style-th">
								用户状态
							</td>
							<td class="table-style-th">
								备注
							</td>
							<td class="table-style-th">
								权限分配
							</td>
						</tr>
						<%
					List<UserManage> list = user.getUserInfo();
					for (UserManage u : list) {
				%>
						<tr>
							<td class='table-style-td' style='width: 7%;'><%=u.getId()%></td>
							<td class='table-style-td' style='width: 11%;'><%=u.getName()%></td>
							<td class='table-style-td' style='width: 11%;'><%=u.getLogin()%></td>
							<td class='table-style-td' style='width: 14%;'><%=u.getBegindate()%></td>
							<td class='table-style-td' style='width: 14%;'>
								<%
							if (null == u.getEnddate())
									out.println("");
								else
									out.println(u.getEnddate());
						%>
							</td>
							<td class='table-style-td' style='width: 8%;'>
								<%
							if ("1".equals(u.getLock()))
									out.println("解锁");
								else if ("0".equals(u.getLock()))
									out.println("锁定");
								else out.println("");
						%>
							</td>
							<td class='table-style-td' style='width: 17%;'>
								<%
							if (null == u.getRemark())
									out.println("");
								else
									out.println(u.getRemark());
						%>
							</td>
							<td class='table-style-td' style='width: 18%;'>
								<div class="caozuo1">
									<button id="view" class="btn-del"
										onclick="document.getElementById('showView').style.display='block'; view(<%=u.getId()%>);
							         document.getElementById('fade').style.display='block';" />
										查看
									</button>
									<button id="change" class="btn-del"
										onclick="document.getElementById('showChange').style.display='block';change(<%=u.getId()%>);
							         document.getElementById('fade').style.display='block';" />
										修改
									</button>
								</div>
							</td>
						</tr>
						<%
					}
				%>
					</table>
				</div>
			</div>
		</div>
		<div id="showView" class="white_content">
			<table border=0 width=100% align=center id="viewRight">
			</table>
		</div>
		<div id="showChange" class="white_content">
			<table border=0 width=100% align=center id="changeRight">
			</table>
		</div>
		<div id="fade" class="black_overlay"></div>
	</body>
</html>
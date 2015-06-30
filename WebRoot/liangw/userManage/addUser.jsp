<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

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
		<!-- 
		<link rel="stylesheet" type="text/css" href="styles.css">
		 -->
		<link rel="stylesheet" type="text/css" href="../css/addUser.css"/>
		<script type='text/javascript' src='/PTS/dwr/interface/addUser.js'></script>
		<script type='text/javascript' src='/PTS/dwr/engine.js'></script>
		<script type='text/javascript' src='/PTS/dwr/util.js'></script>
		<script language="javascript">

//全局变量
var subid = new Array();
var changedata= null;
var resultData = "0";

// 用户登录名的唯一性检查
function check() {
	var loginname = document.getElementById("loginname").value;
	if (loginname == "") {
		alert("请输入登录名");
		document.getElementById("loginname").focus();
	} else
		addUser.findUser(loginname, callFindUser);
}
function callFindUser(data) {
	if (data == true) {
		alert("该登录名已被注册，请重新填写");
		document.getElementById("loginname").focus();
	} else
		alert("恭喜您，登录名可用");
}
var clicRight="0";
// 为用户分配权限
function right() {
	clicRight = "1";
	addUser.getSubstation(callSubstation);
}

function callSubstation(data) {
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

	tdc01.innerHTML = "用户权限分配";
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
	}

	var cr1 = changeRight.insertRow(-1);
	var cd11 = cr1.insertCell();
	cd11.innerHTML = "<div id='vidv' style='left:50% bottom:10;'> <input id='sureRight' type='button'"
			+ "class='input-button' value='确定' > </div>";
	document.getElementById("vidv").onclick = function() {
		document.getElementById("showChange").style.display = "none";
		document.getElementById("fade").style.display = "none";
	};
	cd11.align = 'center';
	cd11.colSpan = '3';
	var cr2 = changeRight.insertRow(-1);
	var cd21 = cr2.insertCell();
	cd21.height = "15px";
	cd21.align = 'center';
	cd21.colSpan = '3';
}

function sure() {
	// 点击“确定”按钮时，提交设置数据
	name = document.getElementById("name").value;
	loginname = document.getElementById("loginname").value;
	pwd = document.getElementById("pwd").value;
	confirm = document.getElementById("confirm").value;
	remark = document.getElementById("remark").value;
	if (loginname.trim() == "") {
		alert("请填写登录名");
		document.getElementById("loginname").focus();
	} else if (pwd.trim() == "") {
		alert("请填写登录密码");
		document.getElementById("pwd").focus();
	} else if (confirm.trim() == "") {
		alert("请确认密码");
		document.getElementById("confirm").focus();
	} else if (pwd.trim() != confirm.trim()) {
		alert("两次输入的密码不一致");
		document.getElementById("confirm").focus();
	} else if (clicRight == "0"){
		right();
		addUser.findUser(loginname, callBack);
	} else {
		addUser.findUser(loginname, callBack);
	}
}

function callBack(data) {
	if (data == true) {
		alert("该登录名已被注册，请重新填写");
		document.getElementById("loginname").focus();
	} else {
		addUser.insertAddUser(name, loginname, pwd, "1", remark, callSure);
	}
}

// 提交后对返回的数据进行判断
function callSure(data) {
	if (data == 1) {
		addUser.findUserId(loginname,callFindUserId);
	}
	if (data == 0) {
		alert("用户添加失败！");
		location.reload();
	}
}
function sureRight() {

}
function callFindUserId(data) {
     //设置为同步调用，以便数据传输的顺序执行
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
		addUser.insertRight(data, subid[i], sel, callRight);
	}
	dwr.engine.setAsync(true);
    //addUser.insertRight(data,substation,right,callRight);
}
function callRight(data) {
   if(data==true) {
   		resultData += "1";
   } else {
		resultData += "0";
		location.reload();
	}
	if (resultData.length - 1 == changedata.length) {
		var dat1=0;
		for (var i = 1; i < resultData.length; i++) {
			if (resultData.substring(i, i + 1) == "1") {
				dat1++;
			}
		}
		if (dat1==resultData.length-1) {
			alert("用户添加成功！");
			location.reload();
		} else {
			alert("用户添加失败！");
			location.reload();
		}
		
	}
}

//按“取消”按钮则清空数据，重新填写
function cancle() {
  document.getElementById("name").value="";
  document.getElementById("loginname").value="";
  document.getElementById("pwd").value="";
  document.getElementById("confirm").value="";
  document.getElementById("substation").value=0;
  document.getElementById("remark").value="";
  document.getElementById("name").focus();
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
	top: 0;
	left: 20%;
	width: 50%;
	height: 90%;
	padding: 16px;
	border: 10px solid orange;
	background-color: white;
	z-index: 1002;
	overflow: auto;
}
</style>
	</head>
	<body>
		<table border=0 cellSpacing=0 cellPadding=0 width=100% align=center>
			<tr>
				<td>
					<table border=0 cellSpacing=10 cellPadding=0 width=100%
						align=center>
						<tr>
							<td height="18"></td>
						</tr>
						<tr>
							<td align=right width=40%>
								<ol id="need">
									<li>
										<label class="span">
											用户姓名：
										</label>
									</li>
								</ol>
							</td>
							<td align=left width=60%>
								<ol id="need">
									<li>
										<input type="text" id="name" title="五个汉字以内">
									</li>
								</ol>
							</td>
						</tr>
						<tr>
							<td align=right>
								<ol id="need">
									<li>
										<label class="span">
											登&nbsp;&nbsp;录&nbsp;&nbsp;名：
										</label>
									</li>
								</ol>
							</td>
							<td align=left>
								<ol id="need">
									<li>
										<input type="text" id="loginname" class="input" title="五个汉字以内">
										<button id="check" onclick="check()">唯一性检查</button>
									</li>
								</ol>
							</td>
						</tr>
						<tr>
							<td align=right>
								<ol id="need">
									<li>
										<label class="span">
											登录密码：
										</label>
									</li>
								</ol>
							</td>
							<td align=left>
								<ol id="need">
									<li>
										<input type="password" id="pwd" title="10个字符以内 ">
									</li>
								</ol>
							</td>
						</tr>
						<tr>
							<td align=right>
								<ol id="need">
									<li>
										<label class="span">
											确认密码：
										</label>
									</li>
								</ol>
							</td>
							<td align=left>
								<ol id="need">
									<li>
										<input type="password" id="confirm">
									</li>
								</ol>
							</td>
						</tr>
						
						<tr>
							<td align=right>
								<ol id="need">
									<li>
										<label class="span">
											用户权限：
										</label>
									</li>
								</ol>
							</td>
							<td align=left>
								<ol id="need">
									<li>
										<button id="right" onclick="document.getElementById('showChange').style.display='block';right();
							         document.getElementById('fade').style.display='block';">分配</button>
									</li>
								</ol>
							</td>
						</tr>
						<tr>
							<td align=right valign="middle">
								<ol id="need1">
									<li>
										<label class="spanrem">
											</br>备注信息：
										</label>
									</li>
								</ol>
							</td>
							<td align=left>
								<ol id="need1">
									<li>
										<textarea id="remark" rows=6 style="width:40%"
											title="100汉字以内"></textarea>
									</li>
								</ol>
							</td>
						</tr>
						<tr>
							<td height=25 colspan=2>
							</td>
						<tr>
							<td align="right">
								<input type="button" class="input-button" value="确定" id="sure" onclick="sure()"/>
							</td>
							<td align="left">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="button" class="input-button" value="取消" id="cancle" onclick="cancle()"/>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<div id="showView" class="white_content">
			<table border=0 width=100% align=center id="user">
				<tr>
					<td align="left" colspan=3 valign="middle">
						&nbsp;&nbsp;用户权限分配
					</td>
					<td align="right" colspan=4 valign="middle">
						<a href="javascript:void(0)" onclick="document.getElementById('showView').style.display='none';
	                       document.getElementById('fade').style.display='none';">关闭</a>
					</td>
				</tr>
				<tr>
					<td height=15></td>
				</tr>
				<tr>
					<td align=left>
						&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="c0" id="c0" />
						变电所
					</td>
					<td align=left width=10>
					</td>
					<td align=left>
						&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="c1" id="c1" />
						系统设置
					</td>
					<td align=left width=10>
					</td>
					<td align=left>
						&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="c2" id="c2" />
						用户管理
					</td>
				</tr>
				<tr>
					<td align=left>
						&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="c3" id="c3" />
						设备管理
					</td>
					<td align=left width=10>
					</td>
					<td align=left>
						&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="c4" id="c4" />
						接线图管理
					</td>
					<td align=left width=10>
					</td>
					<td align=left>
						&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="c5" id="c5" />
						接口设置
					</td>
				</tr>
				<tr>
					<td align=left>
						&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="c6" id="c6" />
						在线巡检
					</td>
					<td align=left width=10>
					</td>
					<td align=left>
						&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="c7" id="c7" />
						日志管理
					</td>
					<td align=left width=10>
					</td>
					<td align=left>
						&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="c8" id="c8" />
						历史记录
					</td>
				</tr>
				<tr>
					<td align="center" colspan=3 valign="middle">
						<div style="position: absolute; left: 47%; bottom: 10;">
							<input id="sureRight" type="button" value="确定"
								class="input-button" style="font-size: 18px" onclick="sureRight()"/>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div id="fade" class="black_overlay"></div>
		
		<div id="showChange" class="white_content">
			<table border=0 width=100% align=center id="changeRight">
			</table>
		</div>
	</body>
</html>
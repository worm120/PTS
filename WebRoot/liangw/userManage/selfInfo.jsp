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
		<link href="../font-awesome/css/font-awesome.css" rel="stylesheet"
			type="text/css">
		<link rel="stylesheet" type="text/css" href="../css/add.css">
		<script type='text/javascript' src='/PTS/dwr/interface/selfInfo.js'></script>
		<script type='text/javascript' src='/PTS/dwr/engine.js'></script>
		<script type='text/javascript' src='/PTS/dwr/util.js'></script>
		<script language="javascript">

// 从1到解锁和从0到锁定的变换
function getLock(a) {
	if (a == "1") {
		a = "解锁";
	}
	if (a == "0") {
		a = "锁定";
	}
	return a;
}

// 查看用户信息
function view(id) {
	 selfInfo.findUserInfo(id, callView);
}
function callView(data) {
	document.getElementById("name").innerHTML=data[0].name;
	document.getElementById("login").innerHTML=data[0].login;
	document.getElementById("begin").innerHTML=data[0].begindate;
	document.getElementById("end").innerHTML=data[0].enddate;
	//document.getElementById("substation").innerHTML=data[0].subname;
	document.getElementById("status").innerHTML=getLock(data[0].lock);
	document.getElementById("remark").innerHTML=data[0].remark;
}

// 修改用户信息
function change(cid,cname) {
	//设置为同步调用，以便于数据传输的顺序执行
	dwr.engine.setAsync(false);
	loginname=cname;
	userid=cid;
	document.getElementById("cpwd").value="";
	document.getElementById("cnewpwd").value="";
	selfInfo.findUserInfo(cid, callChange);
}

function callChange(data) {
	//getSubstation();
	//设置为异步调用
	dwr.engine.setAsync(true);
	var cstatus = document.getElementById("cstatus");
	//var csubstation = document.getElementById("csubstation");
	document.getElementById("cname").value = data[0].name;
	document.getElementById("clogin").value = data[0].login;
	/*document.getElementById("cpwd").value = data[0].pwd;
	for (var i = 0; i < csubstation.options.length; i++) {
		if (csubstation.options[i].value == data[0].subid) {
			csubstation.options[i].selected = true;
		}
	}*/
	for (var i = 0; i < cstatus.options.length; i++) {
		if (cstatus.options[i].value == data[0].lock) {
			cstatus.options[i].selected = true;
		}
	}
	document.getElementById("cremark").value = data[0].remark;
}

/*function getSubstation() {
	selfInfo.getSubstation(callGetSubstation);
}
function callGetSubstation(data) {
	var csubstation = document.getElementById("csubstation");
	document.getElementById("csubstation").options.length = 0;
	for (var i = 0; i < data.length; i++) {
		csubstation.add(new Option(data[i].subname, data[i].subid));
	}
}*/
// 用户登录名的唯一性检查
function check() {
	var login = document.getElementById("clogin").value;
	if (login == "") {
		alert("请输入登录名");
		document.getElementById("clogin").focus();
	} else
		selfInfo.findUser0(login, loginname, callFindUser);
}
function callFindUser(data) {
	if (data == true) {
		alert("该登录名已被注册，请重新填写");
		document.getElementById("clogin").focus();
	} else
		alert("恭喜您，登录名可用");
}
// 结束当前用户
function over() {
	selfInfo.endUserInfo(userid, callEnd);
}
function callEnd(data) {
	if (data == 1) {
		alert("结束用户成功！");
		location.reload();
	}
	if (data == 0) {
		alert("结束用户失败！");
		location.reload();
	}
}
// 提交修改后的数据
//全局变量
var status;
function sure() {
//dwr.engine.setAsync(false);
	// 点击“确定修改”按钮时，提交所修改的数据
	name = document.getElementById("cname").value;
	clogin = document.getElementById("clogin").value;
	pwd = document.getElementById("cpwd").value;
	newpwd = document.getElementById("cnewpwd").value;
	status = document.getElementById("cstatus").value;
	remark = document.getElementById("cremark").value;
	if (loginname.trim() == "") {
		alert("请填写登录名");
		document.getElementById("clogin").focus();
	} else if (newpwd.trim() != "" && pwd.trim() == "") {
		alert("请输入原始密码!");
		document.getElementById("cpwd").focus();
	} else if (newpwd.trim() != "") {
		selfInfo.findPwd(userid, callPwd);
	} else {
		selfInfo.findUser0(clogin, loginname, callCheck);
	}
}
function callPwd(data) {
	if (data != pwd) {
		alert("原始密码不正确！");
		document.getElementById("cpwd").focus();
	} else {
		selfInfo.findUser0(clogin, loginname, callCheck);
	}
}
function callCheck(data) {
	if (data == true) {
		alert("该登录名已被注册，请重新填写");
		document.getElementById("clogin").focus();
		alert(newpwd)
	} else if (newpwd.trim() != ""){
		selfInfo.changeUserInfo(userid, name, clogin, newpwd, status,
				remark, callSure);
	} else {
		selfInfo.changeUserInfoNopwd(userid, name, clogin, status,
				remark, callSure);
	}
}

// 提交后对返回的数据进行判断
function callSure(data) {
	if (data == 1) {
		alert("信息修改成功！");
		location.reload();
	}
	if (data == 0) {
		alert("信息修改失败！");
		location.reload();
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
	filter: alpha(opacity =   80);
}

.white_content {
	display: none;
	position: absolute;
	top: 12%;
	left: 30%;
	width: 450px;
	height: 350px;
	padding: 10px;
	border: 9px solid orange;
	background-color: white;
	z-index: 1002;
	overflow: auto;
}

.white_content1 {
	display: none;
	position: absolute;
	top: 4%;
	left: 30%;
	width: 580px;
	height: 500px;
	padding: 12px;
	border: 9px solid orange;
	background-color: white;
	z-index: 1002;
	overflow: auto;
}
</style>
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
								操作
							</td>
						</tr>
						<%
					List<UserManage> list = user.getUserInfo();
					for (UserManage u : list) {
				%>
						<tr>
							<td class='table-style-td' style='width: 7%;'><%=u.getId()%></td>
							<td class='table-style-td' style='width: 9%;'><%=u.getName()%></td>
							<td class='table-style-td' style='width: 9%;'><%=u.getLogin()%></td>
							<td class='table-style-td' style='width: 18%;'><%=u.getBegindate()%></td>
							<td class='table-style-td' style='width: 18%;'>
								<%
							if (null == u.getEnddate())
									out.println("");
								else
									out.println(u.getEnddate());
						%>
							</td>
							<td class='table-style-td' style='width: 7%;'>
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
							<td class='table-style-td' style='width: 15%;'>
								<div class="caozuo1">
									<button id="view" class="btn-del"
										onclick="document.getElementById('showView').style.display='block'; 
							view(<%=u.getId()%>); document.getElementById('fade').style.display='block';">
										查看
									</button>
									<button id="change" class="btn-del"
										onclick="document.getElementById('showChange').style.display='block';
							change(<%=u.getId()%>,'<%=u.getLogin()%>');document.getElementById('fade').style.display='block';">
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
			<div id="showView" class="white_content">
				<table border=0 width=100% align=center id="user"
					style="font-size: 30px; line-height: 130%"
					style="word-wrap: break-word; word-break: break-all;">
					<tr>
						<td align="left" colspan=1 valign="middle" style="font-size: 20px;">
							&nbsp;&nbsp;信息查看
						</td>
						<td align="right" colspan=1 valign="middle">
							<a href="javascript:void(0)"
								onclick="document.getElementById('showView').style.display='none';
		                   document.getElementById('fade').style.display='none'" style="font-size: 18px;">关闭</a>
						</td>
					</tr>
					<tr>
						<td height=15></td>
					</tr>
					<tr>
						<td width=40% align=right>
							<span style="FLOAT: right; font-size:18px;">用户姓名：</span>
						</td>
						<td width=60% align=left id="name" style="font-size: 18px;">
						</td>
					</tr>
					<tr>
						<td width=40% align=right>
							<span style="FLOAT: right;font-size: 18px;">登&nbsp;录&nbsp;名：</span>
						</td>
						<td width=60% align=left id="login" style="font-size: 18px;">
						</td>
					</tr>
					<tr>
						<td width=40% align=right>
							<span style="FLOAT: right;font-size: 18px;">开始时间：</span>
						</td>
						<td width=60% align=left id="begin" style="font-size: 18px;">
						</td>
					</tr>
					<tr>
						<td width=40% align=right>
							<span style="FLOAT: right;font-size: 18px;">结束时间：</span>
						</td>
						<td width=60% align=left id="end" style="font-size: 18px;">
						</td>
					</tr>
					<tr>
						<td width=40% align=right>
							<span style="FLOAT: right;font-size: 18px;">用户状态：</span>
						</td>
						<td width=60% align=left id="status" style="font-size: 18px;">
						</td>
					</tr>
					<tr>
						<td width=40% align=right valign=top>
							<span style="FLOAT: right;font-size: 18px;">备注信息：</span>
						</td>
						<td width=60% align=left id="remark" style="font-size: 18px;">
						</td>
					</tr>
				</table>
			</div>
			<div id="showChange" class="white_content1">
				<table border=0 cellSpacing=10 cellPadding=0 width=100% align=center
					style="font-size: 30px; line-height: 130%" id="user">
					<tr>
						<td align="left" colspan=1 valign="middle" style="font-size: 20px;">
							&nbsp;&nbsp;信息修改
						</td>
						<td align="right" colspan=1 valign="middle">
							<a href="javascript:void(0)"
								onclick="document.getElementById('showChange').style.display='none';
		                   document.getElementById('fade').style.display='none'" style="font-size: 18px;">关闭</a>
						</td>
					</tr>
					<tr>
						<td height=8></td>
					</tr>
					<tr>
						<td width=40% align=right>
							<span style="FLOAT: right;font-size: 18px;">用户姓名：</span>
						</td>
						<td width=60% align=left >
							<input type="text" id="cname" style="font-size: 15px;padding:2px;"/>
						</td>
					</tr>
					<tr>
						<td width=40% align=right>
							<span style="FLOAT: right;font-size: 18px;">登&nbsp;录&nbsp;名：</span>
						</td>
						<td width=60% align=left>
							<input type="text" id="clogin" style="WIDTH: 30%;font-size: 15px;padding:2px;"/>
							<input type="button" id="check" name="check" value="唯一性检查"
								style="font-size: 11px; padding:2px;"  onclick="check()" />
						</td>
					</tr>
					<tr>
						<td width=40% align=right >
							<span style="FLOAT: right;font-size: 18px;">原始密码：</span>
						</td>
						<td width=60% align=left style="font-size: 18px;">
							<input type="password" id="cpwd" style="WIDTH: 30%;font-size:15px;padding:2px;" />
						</td>
					</tr>
					<tr>
						<td width=40% align=right>
							<span style="FLOAT: right;font-size: 18px;">新&nbsp;密&nbsp;码：</span>
						</td>
						<td width=60% align=left style="font-size: 18px;">
							<input type="password" id="cnewpwd" style="WIDTH: 30%;font-size:15px;padding:2px;" />
						</td>
					</tr>
					<tr>
						<td width=40% align=right>
							<span style="FLOAT: right;font-size: 18px;">用户状态：</span>
						</td>
						<td width=60% align=left style="font-size: 18px;">
							<select style="WIDTH: 25%;font-size:15px;padding:2px;" id="cstatus" >
								<option value="1">
									解锁
								</option>
								<option value="0">
									锁定
								</option>
							</select>
						</td>
					</tr>
					<tr>
						<td width=40% align=right>
							<span style="FLOAT: right;font-size: 18px;">备注信息：</span>
						</td>
						<td width=60% align=left style="font-size: 18px;">
							<textarea id="cremark" rows="4" style="width:70%;font-size:15px;padding:4px;"
											title="100汉字以内"></textarea>
						</td>
					</tr>
					<tr>
						<td height=3></td>
					</tr>
					<tr>
						<td align=center colspan=2>
							<input id="sure" name="sure" type="button" value="确定修改"
								class="input-button" style="font-size: 12px" onclick="sure()">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input id="over" name="over" type="button" value="结束用户"
								class="input-button" style="font-size: 12px" onclick="over()">
						</td>
					</tr>
				</table>
			</div>
			<div id="fade" class="black_overlay"></div>
	</body>
</html>
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
<link href="../font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css">  
<link  rel="stylesheet" type="text/css" href="../css/add.css">   
<script type='text/javascript' src='/PTS/dwr/interface/deleteUser.js'></script>
<script type='text/javascript' src='/PTS/dwr/engine.js'></script>
<script type='text/javascript' src='/PTS/dwr/util.js'></script>
<script language="javascript">
	// 当全选按钮被选中时所有复选框被选中，再次点击时取消全选
	function selAll() {
		var selAll = document.all['selAll'];
		var selOne = document.all['selOne'];
		if (selAll.checked) {
			if (selOne.length) {
				for ( var i = 0; i < selOne.length; i++) {
					selOne[i].checked = true;
				}
			} else {
				selOne.checked = true;
			}
		} else {
			if (selOne.length) {
				for ( var i = 0; i < selOne.length; i++) {
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
		for ( var i = 0; i < selOne.length; i++) {
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

	// 批量删除操作
function dele() {
	var sure = window.confirm('真的要删除么?');
	var selOne = document.all['selOne'];
	var selll = document.getElementById("selOne").value;
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
		// alert(ids);
		deleteUser.deleteUser(ids, deleback);
	} else
		window.location.reload();
}

	function deleback(data) {
		if (data == 0) {
			alert("记录删除失败！");
			window.location.reload();
		}
		if (data == 1) {
			alert("记录删除成功！");
			window.location.reload();
		}
	}

	//按“取消”按钮则清空数据，重新设置
	function cancle() {
		document.getElementById("sampleTime").value = "";
		document.getElementById("checkTime").value = "";
		document.getElementById("saveTime").value = "";
		document.getElementById("sampleTime").focus();
	}
</script>
</head>
<body>
	<!--content start-->
    <div id="content" style="overflow: auto; height: 490px;" class="box-content">
        <div id="content-header">
            <div id="content-header-leader">
                <a class="tip-button">
                    <i class="icon icon-home"></i>
                   	 首页
                </a>
                <a class="current" href="#">
                   	 用户
                </a>
            </div>
        </div>
        <div id="content-field">
            <div class="box-title">
                <div class="checkall"><input name="selAll" id="selAll" type="checkbox" onclick="selAll()"></div>
                <div class="quanxuan">全选</div>
                 <div class="mycaozuo">
                    &nbsp;&nbsp;&nbsp;&nbsp;<i class="icon-remove-sign"></i>
                    <button id="delete" name="delete" class="btn-del" onclick="dele()">删除</button>
                </div>
            </div>
            <div class="box-content">
                <table class="table-style" id="listtable">
			<tr>
				<td class="table-style-th" style="width:10px;text-align:center;">选择</td>
				<td class="table-style-th">用户姓名</td>
				<td class="table-style-th">登录名</td>
				<td class="table-style-th">开始时间</td>
				<td class="table-style-th">结束时间</td>
				<td class="table-style-th">用户状态</td>
				<td class="table-style-th">备注</td>
			</tr>
			<%
				List<UserManage> list = user.getUserInfo();
				for (UserManage u : list) {
			%>
			<tr>
				<td class='table-style-th1' style="width:10px;text-align:center;"><input type='checkbox' id='selOne' 
				    value='<%=u.getId()%>' onclick='selOne()';></td>
				<td class='table-style-td' style='width:100px;'><%=u.getName()%></td>
				<td class='table-style-td' style='width:100px;'><%=u.getLogin()%></td>
				<td class='table-style-td' style='width:100px;'><%=u.getBegindate()%></td>
				<td class='table-style-td' style='width:100px;'>
					<%
						if (null == u.getEnddate())
								out.println("");
							else
								out.println(u.getEnddate());
					%>
				</td>
				<td class='table-style-td' style='width:100px;'>
					<%
						if ("1".equals(u.getLock()))
								out.println("解锁");
							else if ("0".equals(u.getLock()))
								out.println("锁定");
							else
								out.println("");
					%>
				</td>
				<td class='table-style-td' style='width:100px;'>
					<%
						if (null == u.getRemark())
								out.println("");
							else
								out.println(u.getRemark());
					%>
				</td>
			</tr>

			<%
				}
			%>
		</table>
	</div>
</div>
</div>
</body>
</html>
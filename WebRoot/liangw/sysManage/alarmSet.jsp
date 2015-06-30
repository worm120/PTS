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
		<link rel="stylesheet" type="text/css" href="../css/alarmSet.css">

		<script type='text/javascript' src='/PTS/dwr/interface/alarmSet.js'></script>
		<script type='text/javascript' src='/PTS/dwr/engine.js'></script>
		<script type='text/javascript' src='/PTS/dwr/util.js'></script>
		<script language="javascript">

// 初始显示原来设置的数据
function getSrcData() {
	var id='<%=request.getParameter("sid")%>';
	//var id = "001";
	alarmSet.getSrcData(id, callSrcData);
}
function callSrcData(data) {
	if (data == true) {
		var id='<%=request.getParameter("sid")%>';
		//var id = "001";
		alarmSet.findBy(id, callFindBy);
	}
}
function callFindBy(data) {
	//document.getElementById("substation").innerHTML="报警设置："+data[0].name;
	document.getElementById("continueTime").value = data[0].alarmtime;
	if (data[0].voice == null)
		data[0].voice = 0;
	document.getElementById("voiceSet").value = data[0].voice;
	if (data[0].message != null || data[0].port != null) {
		var port = document.getElementById("port");
		var smNum = document.getElementById("smNum");
		document.getElementById("shortMessage").checked = true;
		smNum.disabled = "";
		port.disabled = false;
		smNum.value = data[0].message;
		port.selectedIndex = data[0].port;
	}
	document.getElementById("alarm").checked = getTrue(data[0].alarmframe);
	document.getElementById("preAlarm").checked = getTrue(data[0].preframe);
	document.getElementById("voice").checked = getTrue(data[0].voiceframe);
	document.getElementById("sm").checked = getTrue(data[0].messageframe);
}
// 将数据库里的0或1转为假或真
function getTrue(str) {
	if (str == 0) {
		str = false;
	}
	if (str == 1) {
		str = true;
	}
	return str;
}
//测试报警提示音
function test() {
    var num = document.getElementById('voiceSet').value;
    var div = document.getElementById('div1');
    div.innerHTML = '<embed src="../alarm/'+num+'.wav" loop="0" autostart="true" hidden="true"></embed>';
    var emb = document.getElementsByTagName('EMBED')[0];
    if (emb) { 
      //div = document.getElementById('div2');
      //div.innerHTML = 'loading: '+emb.src;
      //sef.disabled = true;
      setTimeout(function(){div.innerHTML='';},1000);
    }
}

// 选中“加载GSM短信设备”时，可设置“短信中心号码”和“GSM通信端口”
function shortMsg() {
	var smNum = document.getElementById("smNum");
	var port = document.getElementById("port");
	var shortMessage = document.getElementById("shortMessage");
	if (shortMessage.class=="sel") {
	   shortMessage.style.background="url(../images/checked.png) no-repeat center center";
	   shortMessage.class="";
	} else {
	   shortMessage.style.background="url(../images/unchecked.png) no-repeat center center";
	   shortMessage.class="sel" 
	}
	if (shortMessage.checked) {
		smNum.disabled = "";
		port.disabled = false;
	} else {
		smNum.disabled = true;
		port.disabled = true;
	}
}

// 在“发出报警语音”被选中之前判断是否选择“报警语音设置”
function onvoice() {
	var voiceSet = document.getElementById("voiceSet").value;
	var voice = document.getElementById("voice");
	if (voice.checked) {
		if (voiceSet == 0) {
			alert("请先设置报警语音");
			voice.checked = false;
			document.getElementById("voiceSet").focus();
		}
	}
}

// 在“发出报警短信”被选中之前判断是否对短信功能进行设置
function smsg() {
	var shortMessage = document.getElementById("shortMessage");
	var smNum = document.getElementById("smNum").value;
	var port = document.getElementById("port").value;
	var sm = document.getElementById("sm");
	// 如果选中“发出报警短信”
	if (sm.checked) {
		// 判断“加载GSM短信设备”是否被选中,如果选中且“短信中心号码”没有填写，则提示并聚焦到其上
		if (shortMessage.checked) {
			if (smNum.trim() == "") {
				alert("请先填写短信中心号码");
				sm.checked = false;
				document.getElementById("smNum").focus();
			} else
			// 如果“GSM通信端口”没选择，则提示并聚焦到其上
			if (port == 0) {
				alert("请选择GSM通信端口");
				sm.checked = false;
				document.getElementById("port").focus();
			}
		}
		// 判断“加载GSM短信设备”是否被选中，如果没有则设置为选中并聚焦到“短信中心号码”的填写上
		else {
			alert("请先选择加载GSM短信设备");
			sm.checked = false;
			shortMessage.checked = true;
			document.getElementById("smNum").disabled = "";
			document.getElementById("port").disabled = false;
			// document.getElementById("smNum").focus();
		}
	}
}

function sure() {
	// 点击“确定”按钮时，提交设置数据
	var id='<%=request.getParameter("sid")%>';
	//var id="001";
	alarmSet.getSrcData(id,callSure);
}
function callSure(data) {
	var subid='<%=request.getParameter("sid")%>';
	//subid = "001";
	var continueTime = document.getElementById("continueTime").value;
	var voiceSet = document.getElementById("voiceSet").value;
	if (voiceSet == 0)
		voiceSet = "";
	var shortMessage = document.getElementById("shortMessage");
	var smNum = document.getElementById("smNum").value;
	var port = document.getElementById("port").value;
	if (port == 0)
		port = "";
	if (shortMessage.checked == false) {
		smNum = "";
		port = "";
	}
	var alarm = getChecked(document.getElementById("alarm"));
	var preAlarm = getChecked(document.getElementById("preAlarm"));
	var voice = getChecked(document.getElementById("voice"));
	var sm = getChecked(document.getElementById("sm"));
	
	var re1 = /^[1-9]+[0-9]*]*$/;
	if (!re1.test(continueTime) && continueTime!="") {
        alert("请输入正整数！");
        document.getElementById("continueTime").focus();
        return;
     }	 
	if (continueTime.trim() == "" && voiceSet == 0 && smNum.trim() == ""
			&& port == 0 && alarm == 0 && voice == 0 && sm == 0
			&& preAlarm == 0) {
		alert("未设置任何参数");
		document.getElementById("continueTime").focus();
	} else if (parseFloat(continueTime) <= 0) {
		alert("请输入正确的数字");
		document.getElementById("continueTime").value = null;
		document.getElementById("continueTime").focus();
	} else if (smNum.trim() != "" && smNum.trim().length != 14) {
		alert("请输入14位格式号码，如：+8613800000000");
		document.getElementById("smNum").focus();
	} else if (data == true) {
		alarmSet.updateAlarmSet(continueTime, voiceSet, smNum, port, alarm,
				preAlarm, voice, sm, subid, callUpdate);
	} else {
		alarmSet.insertAlarmSet(continueTime, voiceSet, smNum, port, alarm,
				preAlarm, voice, sm, subid, callInsert);
	}
}

function getChecked(str) {
	if (str.checked == true)
		str = 1;
	else
		str = 0;
	return str;
}

// 提交后对返回的数据进行判断
function callUpdate(data) {
	if (data == 1) {
		alert("设置成功！");
		location.reload();
	}
	if (data == 0) {
		alert("设置失败！");
	}
}
// 提交后对返回的数据进行判断
function callInsert(data) {
	if (data == 1) {
		alert("设置成功！");
		location.reload();
	}
	if (data == 0) {
		alert("设置失败！");
	}
}

//按“取消”按钮则清空数据，重新设置
function cancle() {
  document.getElementById("continueTime").value="";
  document.getElementById("voiceSet").value=0;
  document.getElementById("shortMessage").checked = false;
  document.getElementById("smNum").value = "";
  document.getElementById("port").value = 0;
  document.getElementById("smNum").disabled = true;
  document.getElementById("port").disabled = true;
  document.getElementById("alarm").checked = false;
  document.getElementById("preAlarm").checked = false;
  document.getElementById("voice").checked = false;
  document.getElementById("sm").checked = false;
  document.getElementById("continueTime").focus();
}
</script>
	</head>
	<body onload="getSrcData();">
		<table border=0 cellSpacing=0 cellPadding=0 width=100% align=center>
			<tr>
				<td>
					<table border=0px cellSpacing=10 cellPadding=0 width=100%
						align=center>
						<tr>
							<td height="15" colspan=2></td>
						</tr>
						<tr>
							<td width=50% align=right>
								<ol id="need">
									<li>
										<label class="span">
											报警声音信号持续时间：
										</label>
									</li>
								</ol>
							</td>
							<td width=50% align=left>
								<ol id="need">
									<li>
										<input type="text" id="continueTime" title="（s/秒）">
									</li>
								</ol>
							</td>
						</tr>
						<tr>
							<td width=50% align=right>
								<ol id="need">
									<li>
										<label class="span">
											报警语音设置：
										</label>
									</li>
								</ol>
							</td>
							<td width=50% align=left>
								<div id="div1"></div>
								<ol id="need">
									<li>
										<select id="voiceSet" name="voiceSet" onblur="voice()">
											<option selected value=0>
												请选择
											</option>
											<option value="1">
												报警音01
											</option>
											<option value="2">
												报警音02
											</option>
											<option value="3">
												报警音03
											</option>
											<option value="4">
												报警音04
											</option>
											<option value="5">
												报警音05
											</option>
											<option value="6">
												报警音06
											</option>
										</select>
										<button id="test" onclick="test()" class="button">
											测试
										</button>
									</li>
								</ol>
								<div id="div2"></div>
							</td>
						</tr>
						<tr>
							<td width=50% align=right>
								<ol id="need">
									<li>
										<input type="checkbox" id="shortMessage" value="0" style="height:15px;width:15px;;vertical-align:middle;margin-right:4px;"
											onclick="shortMsg()"/>
										<label class="span" for="shortMessage">
											加载GSM短信设备
										</label>
									</li>
								</ol>
							</td>
						</tr>
						<tr>
							<td width=50% align=right>
								<ol id="need">
									<li>
										<label class="span">
											短信中心号码：
										</label>
									</li>
								</ol>
							</td>
							<td width=50% align=left>
								<ol id="need">
									<li>
										<input type="text" id="smNum" style="width: 120px" 
											title="请输入14位号码，如：+8613800000000" disabled>
									</li>
								</ol>
							</td>
						</tr>
						<tr>
							<td width=50% align=right>
								<ol id="need">
									<li>
										<label class="span">
											GSM通信端口：
										</label>
									</li>
								</ol>
							</td>
							<td width=50% align=left>
								<ol id="need">
									<li>
										<select id="port" onblur="voice()" disabled>
											<option selected value=0>
												请选择
											</option>
											<option value="1">
												端口01
											</option>
											<option value="2">
												端口02
											</option>
											<option value="3">
												端口03
											</option>
											<option value="4">
												端口04
											</option>
											<option value="5">
												端口05
											</option>
											<option value="6">
												端口06
											</option>
										</select>
									</li>
								</ol>
							</td>
						</tr>
						<tr>
							<td width=50% align=right>
								<ol id="need">
									<li>
										<input type="checkbox" id="alarm" value="0" style="height:15px;width:15px;;vertical-align:middle;margin-right:4px;"
											onclick="onalarm()" />
										<label class="span" for="alarm">
											显示报警对话框
										</label>
									</li>
								</ol>
							</td>
						</tr>
						<tr>
							<td width=50% align=right>
								<ol id="need">
									<li>
										<input type="checkbox" id="preAlarm" value="0" style="height:15px;width:15px;;vertical-align:middle;margin-right:4px;"
											onclick="onpreAlarm()" />
										<label class="span" for="preAlarm">
											显示预警对话框
										</label>
									</li>
								</ol>
							</td>
							<td width=50%></td>
						</tr>
						<tr>
							<td width=50% align=right>
								<ol id="need">
									<li>
										<input type="checkbox" id="voice" value="0" style="height:15px;width:15px;;vertical-align:middle;margin-right:4px;"
											onclick="onvoice()" />
										<label class="span" for="voice">
											发出报警语音&nbsp;&nbsp;&nbsp;&nbsp;
										</label>
									</li>
								</ol>
							</td>
							<td width=50%></td>
						</tr>
						<tr>
							<td width=50% align=right>
								<ol id="need">
									<li>
										<input type="checkbox" id="sm" value="0" style="height:15px;width:15px;;vertical-align:middle;margin-right:4px;" onclick="smsg()" />
										<label class="span" for="sm">
											发送报警短信&nbsp;&nbsp;&nbsp;&nbsp;
										</label>
									</li>
								</ol>
							</td>
							<td width=50%></td>
						</tr>
						<tr>
							<td height="20px" colspan=2></td>
						</tr>
						<tr>
							<td align="center" width=50% colspan=2>
								<!-- <input type="button" value="Button" class="btn5" />-->
								<input type="button" class="input-button" value="确定" id="sure"
									onclick="sure()" />
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="button" class="input-button" value="取消" id="cancle"
									onclick="cancle()" />
								<!--<input type="image" id="sure" src="../images/sure.png" 
								       onclick="sure()"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="image" id="cancle" src="../images/cancel.png " src="../images/button_bg.jpg "
									onclick="cancle()">-->
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</body>
</html>
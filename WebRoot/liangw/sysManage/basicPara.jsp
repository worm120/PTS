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
		
		<script type='text/javascript' src='/PTS/dwr/interface/basicPara.js'></script>
		<script type='text/javascript' src='/PTS/dwr/engine.js'></script>
		<script type='text/javascript' src='/PTS/dwr/util.js'></script>
		<script language="javascript">

// 初始显示原来设置的数据
function getSrcData() {
	var id='<%=request.getParameter("sid")%>';
	//var id="001";
	basicPara.getSrcData(id,callSrcData);
}
function callSrcData(data) {
	if (data == true) {
		var id='<%=request.getParameter("sid")%>';
		//var id="001";
		basicPara.findBy(id,callFindBy);
	}
}
function callFindBy(data) {
	subid=data[0].subid;
	//document.getElementById("substaion").value=data[0].name;
	document.getElementById("sampleTime").value=data[0].sample;
	document.getElementById("checkTime").value=data[0].check;
	document.getElementById("saveTime").value=data[0].save;
	document.getElementById("preTemper").value=data[0].preextem;
	document.getElementById("exceedTemper").value=data[0].extem;
//	document.getElementById("preLowTemper").value=data[0].prelowtem;
//	document.getElementById("lowTemper").value=data[0].lowtem;
//	document.getElementById("preDiffTemper").value=data[0].predifftem;
//	document.getElementById("diffTemper").value=data[0].difftem;
	document.getElementById("preHum").value=data[0].preexhum;
	document.getElementById("exceedHum").value=data[0].exhum;
	// document.getElementById("preLowHumidity").value=data[0].prelowhum;
	// document.getElementById("lowHumidity").value=data[0].lowhum;
	// document.getElementById("timeGap").value=data[0].conti;
	// document.getElementById("temperRise").value=data[0].abnortem;
	document.getElementById("picRate").value=data[0].photorate;
	document.getElementById("changeRate").value=data[0].changetime;
	document.getElementById("rem").value=data[0].rem;
	document.getElementById("syspara").innerHTML="系统参数设置："+data[0].name;
	//document.getElementById("temperpara").innerHTML="系统温升过快报警设置："+data[0].name;
}
//判断是否为浮点数
function ifFloat(a) {
	len = a.length;
	dot = 0;
	if (len == 0)
		return true;
	for ( var i = 0; i < len; i++) {
		oneNum = a.substring(i, i + 1);
		if (oneNum == ".")
			dot++;
		if (((oneNum < "0" || oneNum > "9") && oneNum != ".") || dot > 1)
			return true;
	}
	if (len > 1 && a.substring(0, 1) == "0") {
		if (a.substring(1, 2) != ".")
			return true;
	}
	return false;
}
function sure() {
	// 点击“确定”按钮时，提交设置数据
	//var id="001";
	var id='<%=request.getParameter("sid")%>';
	basicPara.getSrcData(id, callSure);
}
function callSure(data) {
	// subid = "001";
	var subid = '<%=request.getParameter("sid")%>';
	// 点击“确定”按钮时，提交设置数据
	var sampleTime = document.getElementById("sampleTime").value;
	var checkTime = document.getElementById("checkTime").value;
	var saveTime = document.getElementById("saveTime").value;
	var preTemper = document.getElementById("preTemper").value;
	var exceedTemper = document.getElementById("exceedTemper").value;
	var preHum = document.getElementById("preHum").value;
	var exceedHum = document.getElementById("exceedHum").value;
	// var preDiffTemper = document.getElementById("preDiffTemper").value;
	// var diffTemper = document.getElementById("diffTemper").value;
	// var preHumidity = document.getElementById("preHumidity").value;
	// var exceedHumidity = document.getElementById("exceedHumidity").value;
	// var preLowHumidity = document.getElementById("preLowHumidity").value;
	// var lowHumidity = document.getElementById("lowHumidity").value;
	// var timeGap = document.getElementById("timeGap").value;
	// var temperRise = document.getElementById("temperRise").value;
	var picRate = document.getElementById("picRate").value;
	var changeRate = document.getElementById("changeRate").value;
	var rem = document.getElementById("rem").value;
	// 正整数
	var re1 = /^[1-9]+[0-9]*]*$/;
	if (!re1.test(sampleTime) && sampleTime != "") {
		alert("请输入正整数！");
		document.getElementById("sampleTime").focus();
		return;
	}
	if (!re1.test(checkTime) && checkTime != "") {
		alert("请输入正整数！");
		document.getElementById("checkTime").focus();
		return;
	}
	if (!re1.test(saveTime) && saveTime != "") {
		alert("请输入正整数！");
		document.getElementById("saveTime").focus();
		return;
	}
	//if (parseInt(preTemper) != preTemper && preTemper != "") {
	if (ifFloat(preTemper) && preTemper != "") {
		alert("请输入数值！");
		document.getElementById("preTemper").focus();
		return;
	}
	if (ifFloat(exceedTemper) && exceedTemper != "") {
		alert("请输入数值！");
		document.getElementById("exceedTemper").focus();
		return;
	}
	if (ifFloat(preHum) && preHum != "") {
		alert("请输入数值！");
		document.getElementById("preHum").focus();
		return;
	}
	if (ifFloat(exceedHum) && exceedHum != "") {
		alert("请输入数值！");
		document.getElementById("exceedHum").focus();
		return;
	}
	if (!re1.test(picRate) && picRate != "") {
		alert("请输入正整数！");
		document.getElementById("picRate").focus();
		return;
	}
	if (!re1.test(changeRate) && changeRate != "") {
		alert("请输入正整数！");
		document.getElementById("changeRate").focus();
		return;
	}
	if (rem.length > 200) {
		alert("内容限100字以内！");
		document.getElementById("rem").focus();
		return;
	}

	// if (sampleTime.trim() == "" && checkTime.trim() == ""
	// && saveTime.trim() == "" && preTemper.trim() == ""
	// && exceedTemper.trim() == "" && preHum.trim() == ""
	// && lowTemper.trim() == "" && preDiffTemper.trim() == ""
	// && diffTemper.trim() == "" && preHumidity.trim() == ""
	// && exceedHumidity.trim() == "" && preLowHumidity.trim() == ""
	// && lowHumidity.trim() == "" && timeGap.trim() == ""
	// && temperRise.trim() == "" && picRate.trim() == ""
	// && changeRate.trim() == "" && rem.trim() == "") {
	// alert("未设置任何参数");
	// document.getElementById("sampleTime").focus();
	// }
	if (sampleTime.trim() == "" && checkTime.trim() == ""
			&& saveTime.trim() == "" && preTemper.trim() == ""
			&& exceedTemper.trim() == "" && preHum.trim() == ""
			&& exceedHum.trim() == "" && picRate.trim() == ""
			&& changeRate.trim() == "" && rem.trim() == "") {
		alert("未设置任何参数");
		document.getElementById("sampleTime").focus();
	} else if (data == true) {
		basicPara.updateBasicPara(subid, sampleTime, checkTime, saveTime,
				preTemper, exceedTemper, preHum, exceedHum, picRate,
				changeRate, rem, callUpdate);
	} else {
		basicPara.insertBasicPara(subid, sampleTime, checkTime, saveTime,
				preTemper, exceedTemper, preHum, exceedHum, picRate,
				changeRate, rem, callInsert);
	}
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
	document.getElementById("sampleTime").value = "";
	document.getElementById("checkTime").value = "";
	document.getElementById("saveTime").value = "";
	document.getElementById("preTemper").value = "";
	document.getElementById("exceedTemper").value = "";
	// document.getElementById("preLowTemper").value="";
	// document.getElementById("lowTemper").value="";
	// document.getElementById("preDiffTemper").value="";
	// document.getElementById("diffTemper").value="";
	document.getElementById("preHum").value = "";
	document.getElementById("exceedHum").value = "";
	// document.getElementById("preLowHumidity").value="";
	// document.getElementById("lowHumidity").value="";
	// document.getElementById("timeGap").value="";
	// document.getElementById("temperRise").value="";
	document.getElementById("picRate").value = "";
	document.getElementById("changeRate").value = "";
	document.getElementById("sampleTime").focus();
}
</script>
	</head>
	<body onload="getSrcData();">
		<!-- <table bgcolor="#ebe9ed" border=0 cellSpacing=0 cellPadding=0 -->
		<table cellSpacing=0 cellPadding=0 width=100% align=center>
			<tr>
				<td>
					<table border=0.5 cellSpacing=10 cellPadding=0 width=100%
						align=center>
						<tr>
						    <td height=18></td>
						</tr>
						<tr>
							<td align="left" colspan=2>
								<ol id="need">
									<li>
										<label class="title" id="syspara">
										</label>
									</li>
								</ol>
							</td>
							<td align="left" colspan=4>
								<ol id="need">
									<li>
									</li>
								</ol>
							</td>
						</tr>
						<tr style="display:none;">
							<td width=16% align=right>
								<ol id="need">
									<li>
										<label class="span">
											系统采样周期：
										</label>
									</li>
								</ol>
							</td>
							<td width=16% align=left>
								<ol id="need">
									<li>
										<input type="text" id="sampleTime" title="（s/秒）" >&nbsp;&nbsp;（s/秒）
									</li>
								</ol>
							</td>
							<td width=16% align=right>
								<ol id="need">
									<li>
										<label class="span">
											系统巡检周期：
										</label>
									</li>
								</ol>
							</td>
							<td width=16% align=left>
								<ol id="need">
									<li>
										<input type="text" id="checkTime" title="（s/秒）">&nbsp;&nbsp;（s/秒）
									</li>
								</ol>
							</td>
							<td width=16% align=right>
								<ol id="need">
									<li>
										<label class="span">
											记录保存时间间隔：
										</label>
									</li>
								</ol>
							</td>
							<td width=16% align=left>
								<ol id="need">
									<li>
										<input type="text" id="saveTime" title="（s/秒）">&nbsp;&nbsp;（s/秒）
									</li>
								</ol>
							</td>
							<td width=6% align=right>
								<ol id="need">
									<li>
									</li>
								</ol>
							</td>
						</tr>
						<tr>
							<td width=16% align=right>
								<ol id="need">
									<li>
										<label class="span">
											超限预警温度：
										</label>
									</li>
								</ol>
							</td>
							<td width=16% align=left>
								<ol id="need">
									<li>
										<input type="text" id="preTemper" title="（℃/摄氏度）">&nbsp;&nbsp;（℃/摄氏度）
									</li>
								</ol>
							</td>
							<td width=16% align=right>
								<ol id="need">
									<li>
										<label class="span">
											超限报警温度：
										</label>
									</li>
								</ol>
							</td>
							<td width=16% align=left>
								<ol id="need">
									<li>
										<input type="text" id="exceedTemper" title="（℃/摄氏度）">&nbsp;&nbsp;（℃/摄氏度）
									</li>
								</ol>
							</td>
							<td width=16% align=right>
								<ol id="need">
									<li>
										<label class="span">
											超限预警湿度：
										</label>
									</li>
								</ol>
							</td>
							<td width=16% align=left>
								<ol id="need">
									<li>
										<input type="text" id="preHum" title="（RH/湿度）">&nbsp;&nbsp;（RH/湿度）
									</li>
								</ol>
							</td>
							<td width=6% align=right>
								<ol id="need">
									<li>
									</li>
								</ol>
							</td>
						</tr>
						
						
						
						
						
						
						
						<tr>
							<td width=16% align=right>
								<ol id="need">
									<li>
										<label class="span">
											超限报警湿度：
										</label>
									</li>
								</ol>
							</td>
							<td width=16% align=left>
								<ol id="need">
									<li>
										<input type="text" id="exceedHum" title="（RH/湿度）">&nbsp;&nbsp;（RH/湿度）
									</li>
								</ol>
							</td>
							<td width=16% align=right>
								<ol id="need">
									<li>
										<label class="span">
											图像采集频率：
										</label>
									</li>
								</ol>
							</td>
							<td width=16% align=left>
								<ol id="need">
									<li>
										<input type="text" id="picRate" title="（d/小时）">&nbsp;&nbsp;（h/小时）
									</li>
								</ol>
							</td>
							<td width=16% align=right style="display:none;">
								<ol id="need">
									<li>
										<label class="span">
											参照图校准提醒周期：
										</label>
									</li>
								</ol>
							</td>
							<td width=16% align=left style="display:none;">
								<ol id="need">
									<li>
										<input type="text" id="changeRate" title="（d/天）">&nbsp;&nbsp;（d/天）
									</li>
								</ol>
							</td>
							<td width=6% align=right>
								<ol id="need">
									<li>
									</li>
								</ol>
							</td>
						</tr>
						<tr><td height="12px"></td></tr>
						<tr>
							<td align=right>
								<ol id="need1">
									<li>
										<label >
											备注信息：
										</label>
									</li>
								</ol>
							</td>
							<td colspan=5 align=left>
								<ol id="need1">
									<li>
										<textarea id="rem" rows=6 style="width:90%;padding:10px;" title="100字以内"></textarea>
									</li>
								</ol>
							</td>
							<td width=6% align=right>
								<ol id="need">
									<li>
									</li>
								</ol>
							</td>
						</tr>
						<tr>
						    <td height=25></td>
						</tr>
						<tr>
							<td width=16%></td>
							<td width=16%></td>
							<td width=32% align="left" colspan=2>
								<input type="button" class="input-button" value="确定" id="sure" onclick="sure()"/>
							</td>
							<td width=32% align="left" colspan=2>
								<input type="button" class="input-button" value="重置" id="cancle" onclick="cancle()"/>
							</td>
							<td width=6%></td>
						</tr>
						<tr>
							<td width=16% align=right>
								<ol id="need">
									<li>
										<input type="hidden" id="lowTemper" title="（℃/摄氏度）">
									</li>
								</ol>
							</td>
							<td width=16% align=left>
								<ol id="need">
									<li>
										<input type="hidden" id="lowTemper" title="（℃/摄氏度）">
									</li>
								</ol>
							</td>
							<td width=16% align=right>
								<ol id="need">
									<li>
										<input type="hidden" id="preDiffTemper" title="（℃/摄氏度）">
									</li>
								</ol>
							</td>
							<td width=16% align=left>
								<ol id="need">
									<li>
										<input type="hidden" id="preDiffTemper" title="（℃/摄氏度）">
									</li>
								</ol>
							</td>
							<td width=16% align=right>
								<ol id="need">
									<li>
										<input type="hidden" id="diffTemper" title="（℃/摄氏度）">
									</li>
								</ol>
							</td>
							<td width=16% align=left>
								<ol id="need">
									<li>
										<input type="hidden" id="diffTemper" title="（℃/摄氏度）">
									</li>
								</ol>
							</td>
							<td width=6% align=right>
								<ol id="need">
									<li>
									</li>
								</ol>
							</td>
						</tr>
						<tr>
							<td width=16% align=right>
								<ol id="need">
									<li>
										<input type="hidden" id="preHumidity" title="（RH/湿度）">
									</li>
								</ol>
							</td>
							<td width=16% align=left>
								<ol id="need">
									<li>
										<input type="hidden" id="preHumidity" title="（RH/湿度）">
									</li>
								</ol>
							</td>
							<td width=16% align=right>
								<ol id="need">
									<li>
										<input type="hidden" id="exceedHumidity" title="（RH/湿度）">
									</li>
								</ol>
							</td>
							<td width=16% align=left>
								<ol id="need">
									<li>
										<input type="hidden" id="exceedHumidity" title="（RH/湿度）">
									</li>
								</ol>
							</td>
							<td width=16% align=right>
								<ol id="need">
									<li>
										<input type="hidden" id="preLowHumidity" title="（RH/湿度）">
									</li>
								</ol>
							</td>
							<td width=16% align=left>
								<ol id="need">
									<li>
										<input type="hidden" id="preLowHumidity" title="（RH/湿度）">
									</li>
								</ol>
							</td>
							<td width=6% align=right>
								<ol id="need">
									<li>
									</li>
								</ol>
							</td>
						</tr>
						<tr><td height="30px"></td></tr>
						<tr>
							<td align="left" colspan=3>
								<ol id="need">
									<li>
										<label class="title" id="temperpara">
										</label>
									</li>
								</ol>
							</td>
							<td align="left" colspan=4>
								<ol id="need">
									<li>
									</li>
								</ol>
							</td>
						</tr>
						<tr>
							<td width=32% align=right colspan=2>
								<ol id="need">
									<li>
										<input type="hidden" id="timeGap" title="（m/分钟）">
									</li> 
								</ol>
							</td>
							<td width=32% align=right colspan=2>
								<ol id="need">
									<li>
										<input type="hidden" id="temperRise" title="（℃/摄氏度）"/>
									</li>
								</ol>
							</td>
							<td width=32% align=right colspan=2>
								<ol id="need">
									<li>
									</li>
								</ol>
							</td>
							<td width=6% align=right>
								<ol id="need">
									<li>
									</li>
								</ol>
							</td>
						</tr>
						
					</table>
				</td>
			</tr>
		</table>
	</body>
</html>
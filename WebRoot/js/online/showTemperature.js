(function() {
	//setTimeout("init()", 100);
	//window.onload="init";
})();
var intervalPresess = new Array();// 报警提示列表数组
var Para_Check = 60;// 巡检周期（s）
var Para_Voice = "1";// "../audio/baojing.wav";//报警提示音频文件
var t;
var selectNodeId;
var ajaxForMenu;

function init() {
	var svgdoc =document.getElementById("emSvg").getSVGDocument();
	var nodes = svgdoc.getElementsByTagName("text");
	var svgid = new Array();
	var index = 0;
	ajaxForMenu = ajaxFindDeviceNotExsist();
//	alert(ajaxForMenu);
//	alert(ajaxForMenu.getElementsByTagName("node"));
	/*
	var nodess = svgdoc.getElementsByTagName("rect");
	for(var i=0;i < noedss.length;i++)
		{
			var colour = nodess.item(i).getAttribute("fill");
			if(colour=="#000000")
				{
					nodess.item(i).addEventListener("click", hide_menu, false);
				}
		}*/
	//alert(nodess);
	//nodess.addEventListener("click", hide_menu, false);
	
	for ( var i = 0; i < nodes.length; i++) {
		var nodeid = nodes.item(i).getAttribute("id");
		
		var colour = nodes.item(i).getAttribute("fill");
		//alert(colour);
		// nodeid.style.fill="blue";
		if ((nodeid != null)&& (colour == "#ffffff")) {
			nodes.item(i).style.cursor = "pointer";
			nodes.item(i).addEventListener("click", show_menu, false);
			
			
			
			// nodes.item(i).onClick="show_menu()";
			//nodes.item(i).textContent = "未关联";
			svgid[index] = nodeid;
			index++;
		}
		
		//if((nodeid != null)&& colour == "#000000")
		//	nodes.item(i).addEventListener("click", hide_menu, false);
	}		
	
	

	var xmlhttp;
	if (window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	} else {
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.open("GET", "../servlet/showOnlineDevice?nodeid="
			+ svgid.toString() + "&sid="
			+ document.getElementById("Substation_ID").value + "&r="
			+ new Date().getTime(), true);
	xmlhttp.send();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			// 显示返回的相应关id联接线图上的节点的开关柜
			//var s = xmlhttp.responseText;
			var result = xmlhttp.responseXML.getElementsByTagName("node");
			/*
			var result_surround = xmlhttp.responseXML.getElementsByTagName("surround");
			// 环境温度
			var TemValue = result_surround[0].getElementsByTagName("TemValue")[0].childNodes[0].nodeValue;
			// 环境湿度
			var HumidityValue = result_surround[0].getElementsByTagName("HumidityValue")[0].childNodes[0].nodeValue;

			document.getElementById("TemValueH").innerHTML = TemValue;
			document.getElementById("HumidityValueH").innerHTML = HumidityValue;
			*/
			var xunjian = xmlhttp.responseXML.getElementsByTagName("zhouqi");
			var locknum=xunjian[0].getElementsByTagName("Para_Check")[0].childNodes[0].nodeValue;//巡检周期
			if(locknum!=""&&locknum!="null")
			{
				Para_Check=locknum;
			}
			
			
			for ( var i = 0; i < result.length; i++) {
				var svgid = result[i].getElementsByTagName("svgid")[0].childNodes[0].nodeValue;// svgid
				var id = result[i].getElementsByTagName("Device_ID")[0].childNodes[0].nodeValue;// 开关柜id
				var Device_Name = result[i].getElementsByTagName("Device_Name")[0].childNodes[0].nodeValue;// 开关柜名称

				var Device_Tem = result[i].getElementsByTagName("Device_Tem")[0].childNodes[0].nodeValue;// 开关柜温度报警
				var Device_Hum = result[i].getElementsByTagName("Device_Hum")[0].childNodes[0].nodeValue;// 开关柜名称湿度报警
				var Device_Pic = result[i].getElementsByTagName("Device_Pic")[0].childNodes[0].nodeValue;// 开关柜图像报警
				var Device_Hug = result[i].getElementsByTagName("Device_Hug")[0].childNodes[0].nodeValue;// 开关柜弧光报警

				var node = svgdoc.getElementById(svgid);
				if (id == "null") {
					node.textContent = "暂无数据";
				} else {
					//node.textContent = Device_Name+"(正常)";
					node.textContent = "正  常";
				}
				// 报警
				//var alarmR=Device_Name+"：";
				var alarmR="";
				if(Device_Tem >0)
				{
					alarmR="温度";
				}
	
				if(Device_Hum > 0)
				{
					alarmR=alarmR+"||"+"湿度";
				}
				//if(Device_Pic == 1)
				//{
				//	alarmR=alarmR+"||"+"图像";
				//}	
				//if(Device_Hug == 1)
				//{
				//	alarmR=alarmR+"||"+"弧光";
				//}	
				//if(Device_Tem == 2 || Device_Hum == 2 || Device_Pic == 1|| Device_Hug == 1) //报警
				if(Device_Tem == 2 || Device_Hum == 2) //报警
				{//持续闪烁、警报声
					var returnnum=setInterval("Alarm('"+svgid+"')",3000);
					intervalPresess.push(returnnum);
					node.style.fill = 'red';
					node.style.stroke = 'red';
					returnnum=setInterval('AlarmTimeout("' + svgid + '")', 500);
					intervalPresess.push(returnnum);
					node.textContent = alarmR;
				}
				else if(Device_Tem == 1 || Device_Hum == 1 )//预警
				{//持续闪烁、一声警报声
					Alarm(svgid);
					node.style.fill = '#EE4000';
					node.style.stroke = '#EE4000';
					var returnnum=setInterval('preAlarmTimeout("' + svgid + '")', 500);
					intervalPresess.push(returnnum);
					node.textContent = alarmR;
				}

			}
		}
	};


	setInterval("sss('" + svgid.toString() + "')", Para_Check * 1000);

}

function AlarmTimeout(svgid)// 报警闪烁
{
	var svgdoc = document.getElementById("emSvg").getSVGDocument();
	var node = svgdoc.getElementById(svgid);
	//node.style.fill = "#ffffff";
	//node.style.stroke = "#ffffff";
	//alert(node.style.fill);
	if(node.style.fill == "red")
	{
		node.style.fill = "#ffffff";
		node.style.stroke = "#ffffff";
	}
	else
	{
		node.style.fill = "red";
		node.style.stroke = "red";
	}//#EE4000
}
function preAlarmTimeout(svgid)// 预警闪烁
{
	var svgdoc = document.getElementById("emSvg").getSVGDocument();
	var node = svgdoc.getElementById(svgid);
	//alert(node.style.fill);
	if(node.style.fill == "#ee4000"||node.style.fill =="rgb(238, 64, 0)")
	{
		node.style.fill = "#ffffff";
		node.style.stroke = "#ffffff";
	}
	else
	{
		node.style.fill = "#EE4000";
		node.style.stroke = "#EE4000";
	}//#EE4000
}


function Alarm(svgid)// 报警
{
	//var svgdoc = document.getElementById("emSvg").getSVGDocument();
	//var node = svgdoc.getElementById(svgid);
	/*
	node.style.fill = 'red';
	node.style.stroke = 'red';
	//setTimeout('AlarmTimeout("' + svgid + '")', 1000);
	var returnnum=setInterval('AlarmTimeout("' + svgid + '")', 500);
	intervalPresess.push(returnnum);
	//document.getElementById("sound").src = "../alarm/1.wav";
	*/
	playAlarmAudio();//播放报警声音
}

function playAlarmAudio()//播放报警声音
{
	var isIE11 = (navigator.userAgent.toLowerCase().indexOf("trident") > -1 && navigator.userAgent.indexOf("rv") > -1);//检测是否是ie11
	var isFirefox=(navigator.userAgent.toLowerCase().indexOf("firefox") > -1);//检测是否是firefox
	if(isIE11)
	{
		document.getElementById("sound_IE").src = "../alarm/1.wav";
	}
	else if(isFirefox)
	{
		document.getElementById("sound_FF").src = "../alarm/1.wav";
	}
}

function settle(id)// 处理报警数据
{
	window.open(
					'settleAlarm.jsp?alarmid=' + id,
					'nodeInfo',
					'height=400,width=300,top=300px,left=500px,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no');
}

function sss(svgid) {
	/**********先清除之前的报警闪烁提示数组***************/
	for(var i=0;i<intervalPresess.length;i++)
	{
		clearInterval(intervalPresess[i]);
	}
	
	while(intervalPresess.length>0)
	{
	     intervalPresess.pop();
	}
	var svgdoc = document.getElementById("emSvg").getSVGDocument();
	var xmlhttp;
	if (window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	} else {
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.open("GET", "../servlet/showOnlineDevice?nodeid=" + svgid + "&sid="
			+ document.getElementById("Substation_ID").value + "&r="
			+ new Date().getTime(), true);
	xmlhttp.send();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			// 显示返回的相应关id联接线图上的节点的开关柜
			var s = xmlhttp.responseText;
			var result = xmlhttp.responseXML.getElementsByTagName("node");
			/*
			var result_surround = xmlhttp.responseXML.getElementsByTagName("surround");
			// 环境温度
			var TemValue = result_surround[0].getElementsByTagName("TemValue")[0].childNodes[0].nodeValue;
			// 环境湿度
			var HumidityValue = result_surround[0].getElementsByTagName("HumidityValue")[0].childNodes[0].nodeValue;

			document.getElementById("TemValueH").innerHTML = TemValue;
			document.getElementById("HumidityValueH").innerHTML = HumidityValue;
			*/
			var xunjian = xmlhttp.responseXML.getElementsByTagName("zhouqi");
			var locknum=xunjian[0].getElementsByTagName("Para_Check")[0].childNodes[0].nodeValue;//巡检周期
			if(locknum!=""&&locknum!="null")
			{
				Para_Check=locknum;
			}

			for ( var i = 0; i < result.length; i++) {
				var svgid = result[i].getElementsByTagName("svgid")[0].childNodes[0].nodeValue;// svgid
				var id = result[i].getElementsByTagName("Device_ID")[0].childNodes[0].nodeValue;// 开关柜id
				var Device_Name = result[i].getElementsByTagName("Device_Name")[0].childNodes[0].nodeValue;// 开关柜名称

				var Device_Tem = result[i].getElementsByTagName("Device_Tem")[0].childNodes[0].nodeValue;// 开关柜温度报警
				var Device_Hum = result[i].getElementsByTagName("Device_Hum")[0].childNodes[0].nodeValue;// 开关柜名称湿度报警
				var Device_Pic = result[i].getElementsByTagName("Device_Pic")[0].childNodes[0].nodeValue;// 开关柜图像报警
				var Device_Hug = result[i].getElementsByTagName("Device_Hug")[0].childNodes[0].nodeValue;// 开关柜弧光报警

				var node = svgdoc.getElementById(svgid);
				if (id == "null") {
					node.textContent = "暂无数据";
				} else {
					//node.textContent = Device_Name+"(正常)";
					node.textContent = "正   常";
				}
				// 报警
				var alarmR="";
				if(Device_Tem >0)
				{
					alarmR="温度";
				}	
				if(Device_Hum > 0)
				{
					alarmR=alarmR+"||"+"湿度";
				}
				//if(Device_Pic == 1)
				//{
				//	alarmR=alarmR+"||"+"图像";
				//}	
				//if(Device_Hug == 1)
				//{
					//alarmR=alarmR+"||"+"弧光";
				//}	
				//if(Device_Tem == 2 || Device_Hum == 2 || Device_Pic == 1|| Device_Hug == 1) //报警
				if(Device_Tem == 2 || Device_Hum == 2) //报警
				{//持续闪烁、警报声
					var returnnum=setInterval("Alarm('"+svgid+"')",3000);
					intervalPresess.push(returnnum);
					node.style.fill = 'red';
					node.style.stroke = 'red';
					returnnum=setInterval('AlarmTimeout("' + svgid + '")', 500);
					intervalPresess.push(returnnum);
					node.textContent = alarmR;
				}
				else if(Device_Tem == 1 || Device_Hum == 1 )//预警
				{//持续闪烁、一声警报声
					Alarm(svgid);
					/*node.style.fill = 'red';
					node.style.stroke = 'red';
					var returnnum=setInterval('AlarmTimeout("' + svgid + '")', 100);
					intervalPresess.push(returnnum);
					*/
					node.style.fill = '#EE4000';
					node.style.stroke = '#EE4000';
					var returnnum=setInterval('preAlarmTimeout("' + svgid + '")', 500);
					node.textContent = alarmR;
				}
				//var alarmR=Device_Name+"：";
				/*var alarmR="";
				if(Device_Tem == 1)
				{
					alarmR="温度";
				}	
				if(Device_Hum == 1)
				{
					alarmR=alarmR+"||"+"湿度";
				}
				//if(Device_Pic == 1)
				//{
				//	alarmR=alarmR+"||"+"图像";
				//}	
				//if(Device_Hug == 1)
				//{
					//alarmR=alarmR+"||"+"弧光";
				//}	
				//if (Device_Tem == 1 || Device_Hum == 1 || Device_Pic == 1|| Device_Hug == 1) 
				if (Device_Tem == 1 || Device_Hum == 1) 
				{
					var returnnum=setInterval("Alarm('"+svgid+"')",1000);
					intervalPresess.push(returnnum);
					//Alarm(svgid);
					node.textContent = alarmR;
				}
				*/

			}
		}
	};
	// alert(svgid.toString());

}

function show_menu(evt) {
	// 单击节点显示功能菜单
	var node = evt.target;
	svgNodeId = node.getAttribute("id");// 接线图上的节点id
	// document.getElementById("nodeinfo").innerHTML="<a id='"+svgNodeId+"'
	// href='#' class='linkmenu'>设备节点信息</a>";
	// document.getElementById("Tempchart").innerHTML="<a id='"+svgNodeId+"'
	// href='#' class='linkmenu'>实时温度走势图</a>";
	// document.getElementById("currentTemp").innerHTML="<a id='"+svgNodeId+"'
	// class='linkmenu' href='#'>实时温度数据</a>";
	// document.getElementById("historyTemp").innerHTML="<a id='"+svgNodeId+"'
	// class='linkmenu' href='#'>历史温度数据</a>";
	// document.getElementById("alarmLog").innerHTML="<a id='"+svgNodeId+"'
	// class='linkmenu' href='#'>节点报警记录</a>";
	// document.getElementById("samSelect").innerHTML="<a
	// id='"+document.getElementById("Substation_ID").value+"' class='linkmenu'
	// href='#'>信息查询</a>";
	selectNodeId = svgNodeId;
	//var sleft=!parseInt(document.body.scrollLeft)?document.documentElement.scrollLeft-document.documentElement.clientLeft:(document.body.scrollLeft-document.body.clientLeft);
    //var stop=!parseInt(document.body.scrollTop)?document.documentElement.scrollTop-document.documentElement.clientTop:(document.body.scrollTop-document.body.clientTop);

    //alert(bleft+"<>"+btop);
    var x=evt.clientX ;//+ sleft - document.body.clientLeft;
    var y=evt.clientY;// + stop - document.body.clientTop;
	//var x = evt.clientX;
	//var y = evt.clientY;
    var Swidth=document.body.clientWidth;
	var Sheight=document.body.clientHeight;
   // alert("x:"+x+"<>y:"+y+"<>Swidth:"+Swidth+"<>Sheight:"+Sheight);
	//解决边界菜单弹出后被遮住的现象
    if((x+150)>Swidth)
    {
    	x=x-150;
    	for(var i=1;i<5;i++)
        {
        	document.getElementById("m"+i).style.right="150px";
        }
    }
    else
    {
    	if((x+300)>Swidth)
        {
        	for(var i=1;i<5;i++)
            {
            	document.getElementById("m"+i).style.right="150px";
            }
        }
    	else
    	{
    		for(var i=1;i<5;i++)
            {
            	document.getElementById("m"+i).style.right="-150px";
            }
    	}
    }
    var result = ajaxForMenu.getElementsByTagName("node");
    for(i=0;i<result.length;i++)
    {
    	if(svgNodeId==result[i].getElementsByTagName("svgid")[0].childNodes[0].nodeValue)
    	{



    		document.getElementById("menu").style.display = "block";
    		document.getElementById("menu").style.left = x;
    		document.getElementById("menu").style.top = y;

    		document.getElementById("menu").style.position = "absolute";
    		document.getElementById("menu").style.z_index = 400;
    		document.getElementById("close").addEventListener("click", closing, false);
    		var alist = document.getElementById("nodeinfo").getElementsByTagName("a");
    		// alert(alist);
    		document.getElementById("nodeinfo").addEventListener("click",nodeinfoWindow, false);
    		// document.getElementById("Tempchart").addEventListener("click",
    		// chartWindow, false);

    		document.getElementById("currentTemp").addEventListener("click",currentTemp, false);
    		document.getElementById("historyTemp").addEventListener("click",historyTempWindow, false);
    		document.getElementById("alarmLogTem").addEventListener("click",alarmLogTempWindow, false);
    		// document.getElementById("samSelect").addEventListener("click",
    		// searchNodeInfo, false);
    		//如果没有湿度设备就不显示湿度菜单
    		if(parseInt(result[i].getElementsByTagName("humNum")[0].childNodes[0].nodeValue)==0)
    			document.getElementById("huminfo").style.display = "none";
    		else{
	    		document.getElementById("currentHum").addEventListener("click", currentHum,false);
	    		document.getElementById("historyHum").addEventListener("click", historyHum,false);
	    		document.getElementById("alarmLogHum").addEventListener("click",alarmLogHum, false);
    		}
    		
    		//如果没有图像设备就不显示图像菜单
    		if(parseInt(result[i].getElementsByTagName("picNum")[0].childNodes[0].nodeValue)==0)
    			document.getElementById("picinfo").style.display = "none";
    		else{
//	    		document.getElementById("picSet").addEventListener("click", picSet, false);	
//	    		document.getElementById("picCmp").addEventListener("click", picCmp, false);
	    		document.getElementById("dataManage").addEventListener("click", dataManage,false);
//	    		document.getElementById("alarmDeal").addEventListener("click", alarmDeal, false);
	    		document.getElementById("getRemotePic").addEventListener("click",getRemotePic, false);
//	    		document.getElementById("setAlarm").addEventListener("click", setAlarm, false);
    		}
    		// document.getElementById("canshuSet").addEventListener("click", canshuSet,
    		// false);
//    		document.getElementById("alarmTong").addEventListener("click",TemperatureStatistics, false);

    		//document.getElementById("historyPic").addEventListener("click", historyPic,false);
//    		document.getElementById("health").addEventListener("click", health, false);

    		//如果没有弧光设备就不显示弧光
    		if(parseInt(result[i].getElementsByTagName("arcNum")[0].childNodes[0].nodeValue)==0)
    			document.getElementById("arcinfo").style.display = "none";
    		else{
//	    		document.getElementById("huguang").addEventListener("click", huguang, false);
//	    		document.getElementById("qianghu").addEventListener("click", qianghu, false);
//	    		document.getElementById("ruohu").addEventListener("click", ruohu, false);
	    		document.getElementById("recentHu").addEventListener("click", recentHu, false);
    		}
    		
    		//阻止冒泡
    		//evt.cancelBubble = true;
    	}// svgid
    	
    }
    
    


}



function hide_menu(){
	document.getElementById("menu").style.display = "none";
}


function nodeinfoWindow()// 开关柜信息
{
	window.open(
					'nodeInfo.jsp?pid=' + selectNodeId,
					'nodeInfo',
					'resizable=yes,height=300px,width=350px,top=30px,left=30px,scrollbars=yes,toolbar=no,menubar=no,location=no,status=no');
}
function currentTemp()// 当前温度信息
{
	// alert("ff");
	window.open(
					'currentTemperature.jsp?nodeid=' + selectNodeId,
					'currentTemperature',
					'resizable=yes,height=600,width=1100,top=30px,left=30px,toolbar=no,menubar=no,scrollbars=yes,location=no,status=no');
}
function historyTempWindow()// 节点温度历史记录
{
	var sid = document.getElementById("Substation_ID").value;

	var xmlhttp;
	if (window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	} else {
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			// 显示返回的相应关id联接线图上的节点的开关柜
			var did = xmlhttp.responseText;
			window
					.open("../SPC/history/history.jsp?sid="
							+ sid
							+ "&did="
							+ did,'nodeHistory','resizable=yes,height=500,width=1000,top=30px,left=30px,scrollbars=yes');
		}
	};
	xmlhttp.open("GET", "../servlet/getDeviceId?nodeid=" + selectNodeId + "&r="
			+ new Date().getTime(), true);
	xmlhttp.send();
}

function alarmLogTempWindow()// 节点报警信息
{
	window.open(
					'alarmlist.jsp?nodeid=' + selectNodeId,
					'alarmLog',
					'resizable=yes,height=500,width=800,top=30px,left=30px,toolbar=no,menubar=no,location=no,status=no');
}

function TemperatureStatistics()// 报警数据分析
{
	var sid = document.getElementById("Substation_ID").value;
	window.open(
					"../SPC/datastatistic/datas.jsp?sid=" + sid,
					'TemperatureStatistics',
					'resizable=yes,height=700,width=1500,top=30px,left=30px,scrollbars=yes,toolbar=no,menubar=no,location=no,status=no');
}

function qianghu()// 强弧
{
	window.open('qianghu.jsp?pid='+ selectNodeId,'qianghu','resizable=yes,height=300,width=400,top=30px,left=30px,scrollbars=yes,toolbar=no,menubar=no,location=no,status=no');
}

function ruohu()// 弱弧
{
	window.open('ruohu.jsp?pid='+ selectNodeId,'ruohu','height=300,width=400,top=30px,left=30px,resizable=yes,scrollbars=yes,toolbar=no,menubar=no,location=no,status=no');
}


function recentHu()//最近7次弧光
{
	window.open('rencentHuGuang.jsp?pid='+selectNodeId,'ruohu','height=300,width=400,top=30px,left=30px,resizable=yes,scrollbars=yes,toolbar=no,menubar=no,location=no,status=no');
}


function huguang()// 弧光历史记录
{
	// window.open
	// ('huguang.jsp?nodeid='+selectNodeId,'lookcurrentPicAss','height=300,width=400,top=300px,left=500px,toolbar=no,menubar=no,location=no,status=no');
	var sid = document.getElementById("Substation_ID").value;

	var xmlhttp;
	if (window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	} else {
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			// 显示返回的相应关id联接线图上的节点的开关柜
			var did = xmlhttp.responseText;
			window
					.open("../SPC/history/history.jsp?sid="
							+ sid
							+ "&did="
							+ did,'nresizable=yes,odeHistory','height=500,width=800,top=30px,left=30px,scrollbars=yes');
		}
	};
	xmlhttp.open("GET", "../servlet/getDeviceId?nodeid=" + selectNodeId + "&r="
			+ new Date().getTime(), true);
	xmlhttp.send();
}

// 图像巡检
function picSet()// 查看设置
{
	// alert("ff");
	window.open('../liangw/picManage/picSet.jsp?sid='+ document.getElementById("Substation_ID").value+ '&nodeid=' + selectNodeId,'lookcurrentPicq','resizable=yes,height=500,width=1000,top=30px,left=30px,toolbar=no,menubar=no,location=no,status=no');
}
function picSet0()// 查看设置
{
	// alert("ff");
	window.open('../picManage/picSet.jsp?sid='+ document.getElementById("Substation_ID").value+ '&nodeid=' + selectNodeId,'lookcurrentPicq','resizable=yes,height=500,width=1000,top=30px,left=30px,toolbar=no,menubar=no,location=no,status=no');
}
function picCmp()// 分析结果
{
	// alert("ff");
	// window.open
	// ('../surPicture/lookcurrentPicAss.jsp?nodeid='+selectNodeId,'lookcurrentPicAss1','height=500,width=800,top=300px,left=500px,toolbar=no,menubar=no,location=no,status=no');
	window.open('../liangw/picManage/picCmp.jsp?sid='
							+ document.getElementById("Substation_ID").value
							+ '&nodeid=' + selectNodeId,
					'lookcurrentPicAss1',
					'resizable=yes,height=600,scrollbars=yes,width=800,top=30px,left=30px,scrollbars=yes,toolbar=no,menubar=no,location=no,status=no');
}
function dataManage()// 数据管理
{
	// alert("ff");
	window.open('../liangw/picManage/dataManage.jsp?sid='
							+ document.getElementById("Substation_ID").value
							+ '&nodeid=' + selectNodeId,
					'historyPic',
					'resizable=yes,height=500,width=1000,top=30px,left=30px,toolbar=no,scrollbars=yes,menubar=no,location=no,status=no');
}
function alarmDeal()// 报警处理
{
	// alert("ff");
	window.open('../temperature/alarmPic.jsp?sid='
					+ document.getElementById("Substation_ID").value
					+ '&nodeid=' + selectNodeId,
					'alarmDeal',
					'resizable=yes,height=500,width=1000,top=30px,left=30px,toolbar=no,menubar=no,location=no,status=no');
}
function getRemotePic()// 抓拍
{
	// alert("ff");
	window.open('../temperature/remotePic.jsp?sid='
					+ document.getElementById("Substation_ID").value
					+ '&nodeid=' + selectNodeId,
					'remotePic',
					'resizable=yes,top=30px,left=30px');
}

function setAlarm()// 选区设置
{
	// alert("ff");
	window.open('../temperature/PhotoList.jsp?sid='
					+ document.getElementById("Substation_ID").value
					+ '&nodeid=' + selectNodeId,
					'PhotoList',
					'resizable=yes,top=30px,left=30px');
}


function health()// 图像历史数据
{
	// alert("ff");
	window.open(
					'health.jsp?sid=S001',
					'health',
					'resizable=yes,height=500,width=1000,top=30px,left=30px,scrollbars=yes,toolbar=no,menubar=no,location=no,status=no');
}
function currentHum()// 当前湿度信息
{
	window.open(
					'currentHum.jsp?nodeid=' + selectNodeId,
					'currentHumidity',
					'resizable=yes,height=600,width=1100,top=30px,left=30px,toolbar=no,menubar=no,scrollbars=yes,location=no,status=no');
}
function historyHum()// 节点湿度历史记录
{
	var sid = document.getElementById("Substation_ID").value;

	var xmlhttp;
	if (window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	} else {
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			// 显示返回的相应关id联接线图上的节点的开关柜
			var did = xmlhttp.responseText;
			window.open("../SPC/history/history.jsp?sid="
							+ sid
							+ "&did="
							+ did,'nodeHistory','resizable=yes,height=500,width=800,top=30px,left=30px,scrollbars=yes');
		}
	};
	xmlhttp.open("GET", "../servlet/getDeviceId?nodeid=" + selectNodeId + "&r="
			+ new Date().getTime(), true);
	xmlhttp.send();
}

function alarmLogHum()// 节点湿度报警信息
{
	window.open(
					'HumAlarm.jsp?nodeid=' + selectNodeId,
					'alarmLog',
					'resizable=yes,height=600,width=1100,top=30px,left=30px,toolbar=no,menubar=no,location=no,status=no');
}

function canshuSet()// 
{
	window.open(
					'../sysManage/basicPara.jsp?sid=S001',
					'basicPara',
					'resizable=yes,height=500,width=800,top=30px,left=30px,toolbar=no,menubar=no,location=no,status=no');
}

function huguang()// 弧光历史记录
{
	alert("ddd");
	window.open(
					'huguang.jsp?nodeid=' + selectNodeId,
					'lookcurrentPicAss',
					'resizable=yes,height=300,width=400,top=30px,left=30px,toolbar=no,menubar=no,location=no,status=no');
}

function chartWindow()// 实时温度走势图
{
	// alert("ff");
	window.open(
					'lookRealTimeChart.jsp?nodeid=' + selectNodeId,
					'nodeHistory',
					'height=500,width=1000,top=150px,left=200px,toolbar=no,menubar=no,location=no,status=no');
}

function searchNodeInfo()// 节点信息查询
{
	// alert("ff");
	window.open(
					'nodeSearch.jsp?sid=' + selectNodeId,
					'nodeSearch',
					'height=300px,width=300px,top=30px,left=30px,toolbar=no,menubar=no,resizable=no,location=no,status=no');
}

function closing()// 菜单关闭
{
	document.getElementById("menu").style.display = "none";
}


//获得相关节点下各设备的数量以决定点击菜单的显示
function ajaxFindDeviceNotExsist()
{
	var svgdoc =document.getElementById("emSvg").getSVGDocument();
	var nodes = svgdoc.getElementsByTagName("text");
	var svgid = new Array();
	var index = 0;
	for ( var i = 0; i < nodes.length; i++) {
		var nodeid = nodes.item(i).getAttribute("id");
		
		var colour = nodes.item(i).getAttribute("fill");
		//alert(colour);
		// nodeid.style.fill="blue";
		if ((nodeid != null)&& (colour == "#ffffff")) {
			
			svgid[index] = nodeid;
			index++;
		}
		
	}		
	var xmlhttp;
	if (window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	} else {
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}

//	xmlhttp.onreadystatechange = function() {
//		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
//			// 显示返回的相应关id联接线图上的节点的开关柜
//			var s = xmlhttp.responseText;		
////			alert(s);
//			return s;
//
//			}
//	};
	xmlhttp.open("GET", "../servlet/findDeviceNotExsist?nodeid="
			+ svgid.toString() + "&r="
			+ new Date().getTime(), false);//确保ajax能返回值
	xmlhttp.send();
	if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
		// 显示返回的相应关id联接线图上的节点的开关柜
//		var m =xmlhttp.responseText;
//		alert(m);
		var s = xmlhttp.responseXML;		
		
		return s;

	}
}
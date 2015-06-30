(function()
{
	setTimeout("init()",500);
})();
var intervalPresess=new Array();
function init()
	{
		//var svgdoc=window.document.getElementById("emSvg").getSVGDocument();
		//alert("w");
		var svgdoc = document.getElementById("emSvg").getSVGDocument();
		var nodes=svgdoc.getElementsByTagName("text");
		var svgid=new Array();
		var index=0;
		
		for(var i=0;i<nodes.length;i++)
		{
			var nodeid=nodes.item(i).getAttribute("id");
			//nodeid.style.fill="blue";
			if(nodeid!=null)
			{
				nodes.item(i).style.cursor="pointer";
				nodes.item(i).addEventListener("click",show_menu,false);
				nodes.item(i).textContent="未关联";
				svgid[index]=nodeid;
				index++;
			}
		}
		
		
		var xmlhttp;
		if (window.XMLHttpRequest)
		{
		  xmlhttp=new XMLHttpRequest();
		}
		else
		{
		  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange=function()
		{
		  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		  {
			//显示返回的相应关id联接线图上的节点的温度
			  	var alarm_pre_Tem;
				var alarm_Tem;
			  	var s=xmlhttp.responseText;
			  	//alert(xmlhttp.responseXML.xml);
			  	
			    var result=xmlhttp.responseXML.getElementsByTagName("node");
			    var alarmvalue=xmlhttp.responseXML.getElementsByTagName("alarm");
			    /*报警值*/
				for(var i=0;i<alarmvalue.length;i++)
				{
					var alarm_pre_Tem=alarmvalue[i].getElementsByTagName("Para_PreExceed_Tem")[0].childNodes[0].nodeValue;
					var alarm_Tem=alarmvalue[i].getElementsByTagName("Para_Exceed_Tem")[0].childNodes[0].nodeValue;
				}
			    //alert(result.length);
				/*报警处理*/
				var alarmRecord="<div class='alarm-head'>实时报警信息</div><div class='alarm-record'><span class='alarm-record-content'>序号</span><span class='alarm-record-content'>编号</span><span class='alarm-record-content'>温度</span><span class='alarm-record-content'>湿度</span><span class='alarm-record-content'>电压</span><span class='alarm-record-content'>类型</span><span class='alarm-record-content'><a>处理</a></span></div>";
				var alarmRecord_num=1;
				for(var i=0;i<result.length;i++)
				{
					var svgid=result[i].getElementsByTagName("svgid")[0].childNodes[0].nodeValue;//svgid
					var id=result[i].getElementsByTagName("Sample_ID")[0].childNodes[0].nodeValue;//采样点id
					var Sample_Name=result[i].getElementsByTagName("Sample_Name")[0].childNodes[0].nodeValue;//采样点名称
					var TemValue=result[i].getElementsByTagName("TemValue")[0].childNodes[0].nodeValue;//温度值
					var VoltageValue=result[i].getElementsByTagName("VoltageValue")[0].childNodes[0].nodeValue;//电压值
					var HumidityValue=result[i].getElementsByTagName("HumidityValue")[0].childNodes[0].nodeValue;//湿值
					var Alarmid=result[i].getElementsByTagName("Alarmid")[0].childNodes[0].nodeValue;//报警记录id
	
					//<div class='alarm-head'>实时报警信息</div>
					//<div class='alarm-record'><span class='alarm-record-content'>序号</span><span class='alarm-record-content'>温度</span><span class='alarm-record-content'>湿度</span><span class='alarm-record-content'>电压</span><span class='alarm-record-content'>类型</span><span class='alarm-record-content'><a>处理</a></span></div>
					var node=svgdoc.getElementById(svgid);
					if(TemValue=="null")
					{
						node.textContent="暂无数据";
					}
					else
					{
						node.textContent=TemValue+"℃";
						var temperature=parseInt(TemValue);
						if(temperature>=alarm_pre_Tem&&temperature<alarm_Tem)//预报警
					  	{
					  		document.getElementById("sound").src="../audio/baojing.wav";
					  		returnnum=setInterval("preAlarm('"+svgid+"')",1000);
							intervalPresess.push(returnnum);

							alarmRecord=alarmRecord+"<div class='alarm-record'><span class='alarm-record-content'>"+alarmRecord_num+"</span><span class='alarm-record-content'>"+id+"</span><span class='alarm-record-content'>"+TemValue+"</span><span class='alarm-record-content'>"+HumidityValue+"</span><span class='alarm-record-content'>"+VoltageValue+"</span><span class='alarm-record-content'>温度预警</span><span class='alarm-record-content'><a class='xiaoshou' onclick='settle(\""+Alarmid+"\")'>处理</a></span></div>";
							alarmRecord_num++;
					  	}
					  	else if(temperature>=alarm_Tem)//报警
					  	{
					  		document.getElementById("sound").src="../audio/baojing.wav";
					  		returnnum=setInterval("Alarm('"+svgid+"')",1000);
							intervalPresess.push(returnnum);

							alarmRecord=alarmRecord+"<div class='alarm-record'><span class='alarm-record-content'>"+alarmRecord_num+"</span><span class='alarm-record-content'>"+id+"</span><span class='alarm-record-content'>"+TemValue+"</span><span class='alarm-record-content'>"+HumidityValue+"</span><span class='alarm-record-content'>"+VoltageValue+"</span><span class='alarm-record-content'>温度报警</span><span class='alarm-record-content'><a class='xiaoshou' onclick='settle(\""+Alarmid+"\")'>处理</a></span></div>";
							alarmRecord_num++;
					  	}
					}
					
					document.getElementById("alarmMenu").innerHTML =alarmRecord;
				}
		  }
		};
		//alert(svgid.toString());
		xmlhttp.open("GET","../servlet/getTemperature?nodeid="+svgid.toString()+"&r="+new Date().getTime(),true);
		xmlhttp.send();
		
		document.getElementById("show-alarmMenu").addEventListener("click", showAlarm, false);//几点隐藏或显示报警列表
		setInterval("sss('"+svgid.toString()+"')",6000);
		
	}

function preAlarm(svgid)//预警
{
	//alert("fff");
	var svgdoc = document.getElementById("emSvg").getSVGDocument();
	var node=svgdoc.getElementById(svgid);
	node.style.fill='#ff22ff';
	node.style.stroke='#ff22ff';
	setTimeout('AlarmTimeout("'+svgid+'")',600);
	
}

function AlarmTimeout(svgid)//报警闪烁
{
	var svgdoc = document.getElementById("emSvg").getSVGDocument();
	var node=svgdoc.getElementById(svgid);
	node.style.fill="#ffffff";
	node.style.stroke="#ffffff";
}

function Alarm(svgid)//报警
{
	var svgdoc = document.getElementById("emSvg").getSVGDocument();
	var node=svgdoc.getElementById(svgid);
	node.style.fill='red';
	node.style.stroke='red';
	setTimeout('AlarmTimeout("'+svgid+'")',600);
}

function settle(id)//处理报警数据
{
	//alert(id);
	window.open ('settleAlarm.jsp?alarmid='+id,'nodeInfo','height=400,width=300,top=300px,left=500px,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no');
}

function showAlarm()
{
	if(document.getElementById("alarmMenu").style.display=="block")
	{
		document.getElementById("alarmMenu").style.display="none";
		document.getElementById("show-img").src="../images/y.jpg";
	}
	else
	{
		document.getElementById("alarmMenu").style.display="block";
		document.getElementById("show-img").src="../images/z.jpg";
	}
}


function sss(svgid)
{
	//alert(svgid);
	//alert(intervalPresess.length);
	
	for(var i=0;i<intervalPresess.length;i++)
	{
		clearInterval(intervalPresess[i]);
	}
	
	while(intervalPresess.length>0)
	{
	     intervalPresess.pop();
	}
	//clearInterval(intervalPresess);
	var svgdoc = document.getElementById("emSvg").getSVGDocument();
	//var nodes=svgdoc.getElementsByTagName("text");
	var xmlhttp;
	if (window.XMLHttpRequest)
	{
	  xmlhttp=new XMLHttpRequest();
	}
	else
	{
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange=function()
	{
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	  {
		//显示返回的相应关id联接线图上的节点的温度
		  	var alarm_pre_Tem;
			var alarm_Tem;
		  	var s=xmlhttp.responseText;
		  	//alert(xmlhttp.responseXML.xml);
		    var result=xmlhttp.responseXML.getElementsByTagName("node");
		    var alarmvalue=xmlhttp.responseXML.getElementsByTagName("alarm");
		    /*报警值*/
			for(var i=0;i<alarmvalue.length;i++)
			{
				var alarm_pre_Tem=alarmvalue[i].getElementsByTagName("Para_PreExceed_Tem")[0].childNodes[0].nodeValue;
				var alarm_Tem=alarmvalue[i].getElementsByTagName("Para_Exceed_Tem")[0].childNodes[0].nodeValue;
			}
		    //alert(result.length);
			var alarmRecord="<div class='alarm-head'>实时报警信息</div><div class='alarm-record'><span class='alarm-record-content'>序号</span><span class='alarm-record-content'>编号</span><span class='alarm-record-content'>温度</span><span class='alarm-record-content'>湿度</span><span class='alarm-record-content'>电压</span><span class='alarm-record-content'>类型</span><span class='alarm-record-content'><a>处理</a></span></div>";
			var alarmRecord_num=1;
			for(var i=0;i<result.length;i++)
			{
				var svgid=result[i].getElementsByTagName("svgid")[0].childNodes[0].nodeValue;//svgid
				var id=result[i].getElementsByTagName("Sample_ID")[0].childNodes[0].nodeValue;//采样点id
				var Sample_Name=result[i].getElementsByTagName("Sample_Name")[0].childNodes[0].nodeValue;//采样点名称
				var TemValue=result[i].getElementsByTagName("TemValue")[0].childNodes[0].nodeValue;//温度值
				var VoltageValue=result[i].getElementsByTagName("VoltageValue")[0].childNodes[0].nodeValue;//电压值
				var HumidityValue=result[i].getElementsByTagName("HumidityValue")[0].childNodes[0].nodeValue;//湿度值
				var Alarmid=result[i].getElementsByTagName("Alarmid")[0].childNodes[0].nodeValue;//报警记录id
				//alert(svgid);
				var node=svgdoc.getElementById(svgid);
				
				//node.setAttribute("style","fill:red");
				if(TemValue=="null")
				{
					node.textContent="暂无数据";
				}
				else
				{
					node.textContent=TemValue+"℃";
					var temperature=parseInt(TemValue);

				  	if(temperature>=alarm_pre_Tem&&temperature<alarm_Tem)//预报警
				  	{
				  		document.getElementById("sound").src="../audio/baojing.wav";
				  		returnnum=setInterval("preAlarm('"+svgid+"')",1000);
						intervalPresess.push(returnnum);

						alarmRecord=alarmRecord+"<div class='alarm-record'><span class='alarm-record-content'>"+alarmRecord_num+"</span><span class='alarm-record-content'>"+id+"</span><span class='alarm-record-content'>"+TemValue+"</span><span class='alarm-record-content'>"+HumidityValue+"</span><span class='alarm-record-content'>"+VoltageValue+"</span><span class='alarm-record-content'>温度预警</span><span class='alarm-record-content'><a class='xiaoshou' onclick='settle(\""+Alarmid+"\")'>处理</a></span></div>";
						alarmRecord_num++;
				  	}
				  	else if(temperature>=alarm_Tem)//报警
				  	{
				  		document.getElementById("sound").src="../audio/baojing.wav";
				  		returnnum=setInterval("Alarm('"+svgid+"')",1000);
						intervalPresess.push(returnnum);

						alarmRecord=alarmRecord+"<div class='alarm-record'><span class='alarm-record-content'>"+alarmRecord_num+"</span><span class='alarm-record-content'>"+id+"</span><span class='alarm-record-content'>"+TemValue+"</span><span class='alarm-record-content'>"+HumidityValue+"</span><span class='alarm-record-content'>"+VoltageValue+"</span><span class='alarm-record-content'>温度报警</span><span class='alarm-record-content'><a class='xiaoshou' onclick='settle(\""+Alarmid+"\")'>处理</a></span></div>";
						alarmRecord_num++;
				  	}
				}
			}
			document.getElementById("alarmMenu").innerHTML =alarmRecord;
	  }
	};
	//alert(svgid.toString());
	xmlhttp.open("GET","../servlet/getTemperature?nodeid="+svgid+"&r="+new Date().getTime(),true);
	xmlhttp.send();
}


function show_menu(evt)  
{  
	//单击节点显示功能菜单
	var node=evt.target;
	svgNodeId=node.getAttribute("id");//接线图上的节点id
	document.getElementById("nodeinfo").innerHTML="<a id='"+svgNodeId+"' href='#' class='linkmenu'>设备节点信息</a>";
	//document.getElementById("nodeinfo").innerHTML="<a class='linkmenu' onclick='newwindow(nodeInfo.jsp?nodeid="+svgNodeId+")' >设备节点信息</a>";
	document.getElementById("currentTemp").innerHTML="<a id='"+svgNodeId+"' class='linkmenu' href='#'>实时温度数据</a>";
	document.getElementById("historyTemp").innerHTML="<a id='"+svgNodeId+"' class='linkmenu' href='#'>历史温度数据</a>";
	document.getElementById("alarmLog").innerHTML="<a id='"+svgNodeId+"' class='linkmenu' href='#'>节点报警记录</a>";
	var x=evt.clientX;
	var y=evt.clientY;
	document.getElementById("menu").style.display="block";
	document.getElementById("menu").style.left=x;
	document.getElementById("menu").style.top=y;  
	document.getElementById("menu").style.position="absolute";
	document.getElementById("menu").style.z_index=400;
	document.getElementById("close").addEventListener("click", closeing, false);
	var alist=document.getElementById("nodeinfo").getElementsByTagName("a");
	//alert(alist);
	document.getElementById("nodeinfo").getElementsByTagName("a")[0].addEventListener("click", nodeinfoWindow, false);
	document.getElementById("currentTemp").getElementsByTagName("a")[0].addEventListener("click", nodeinfoWindow, false);
	document.getElementById("historyTemp").getElementsByTagName("a")[0].addEventListener("click", historyTempWindow, false);
	document.getElementById("alarmLog").getElementsByTagName("a")[0].addEventListener("click", alarmLogTempWindow, false);
	
} 

function nodeinfoWindow()//节点实时信息
{
	//alert("ff");
	window.open ('nodeInfo.jsp?nodeid='+this.id,'nodeInfo','height=250,width=300,top=300px,left=500px,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no');
}

function historyTempWindow()//节点历史记录
{
	//alert("ff");
	window.open ('nodeHistory.jsp?nodeid='+this.id,'nodeHistory','height=500,width=800,top=300px,left=500px,toolbar=no,menubar=no,location=no,status=no');
}

function alarmLogTempWindow()//节点报警信息
{
	//alert("ff");
	window.open ('alarmLog.jsp?nodeid='+this.id,'alarmLog','height=500,width=800,top=300px,left=500px,toolbar=no,menubar=no,resizable=no,location=no,status=no');
}


function closeing()//菜单关闭
{
	document.getElementById("nodeinfo").innerHTML="";
	document.getElementById("currentTemp").innerHTML="";
	document.getElementById("historyTemp").innerHTML="";
	document.getElementById("alarmLog").innerHTML="";
	document.getElementById("menu").style.display="none";
}

(function() {
	//setTimeout("init()", 100);
	//window.onload="init";
})();
var intervalPresess = new Array();// ������ʾ�б�����
var Para_Check = 60;// Ѳ�����ڣ�s��
var Para_Voice = "1";// "../audio/baojing.wav";//������ʾ��Ƶ�ļ�
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
			//nodes.item(i).textContent = "δ����";
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
			// ��ʾ���ص���Ӧ��id������ͼ�ϵĽڵ�Ŀ��ع�
			//var s = xmlhttp.responseText;
			var result = xmlhttp.responseXML.getElementsByTagName("node");
			/*
			var result_surround = xmlhttp.responseXML.getElementsByTagName("surround");
			// �����¶�
			var TemValue = result_surround[0].getElementsByTagName("TemValue")[0].childNodes[0].nodeValue;
			// ����ʪ��
			var HumidityValue = result_surround[0].getElementsByTagName("HumidityValue")[0].childNodes[0].nodeValue;

			document.getElementById("TemValueH").innerHTML = TemValue;
			document.getElementById("HumidityValueH").innerHTML = HumidityValue;
			*/
			var xunjian = xmlhttp.responseXML.getElementsByTagName("zhouqi");
			var locknum=xunjian[0].getElementsByTagName("Para_Check")[0].childNodes[0].nodeValue;//Ѳ������
			if(locknum!=""&&locknum!="null")
			{
				Para_Check=locknum;
			}
			
			
			for ( var i = 0; i < result.length; i++) {
				var svgid = result[i].getElementsByTagName("svgid")[0].childNodes[0].nodeValue;// svgid
				var id = result[i].getElementsByTagName("Device_ID")[0].childNodes[0].nodeValue;// ���ع�id
				var Device_Name = result[i].getElementsByTagName("Device_Name")[0].childNodes[0].nodeValue;// ���ع�����

				var Device_Tem = result[i].getElementsByTagName("Device_Tem")[0].childNodes[0].nodeValue;// ���ع��¶ȱ���
				var Device_Hum = result[i].getElementsByTagName("Device_Hum")[0].childNodes[0].nodeValue;// ���ع�����ʪ�ȱ���
				var Device_Pic = result[i].getElementsByTagName("Device_Pic")[0].childNodes[0].nodeValue;// ���ع�ͼ�񱨾�
				var Device_Hug = result[i].getElementsByTagName("Device_Hug")[0].childNodes[0].nodeValue;// ���ع񻡹ⱨ��

				var node = svgdoc.getElementById(svgid);
				if (id == "null") {
					node.textContent = "��������";
				} else {
					//node.textContent = Device_Name+"(����)";
					node.textContent = "��  ��";
				}
				// ����
				//var alarmR=Device_Name+"��";
				var alarmR="";
				if(Device_Tem >0)
				{
					alarmR="�¶�";
				}
	
				if(Device_Hum > 0)
				{
					alarmR=alarmR+"||"+"ʪ��";
				}
				//if(Device_Pic == 1)
				//{
				//	alarmR=alarmR+"||"+"ͼ��";
				//}	
				//if(Device_Hug == 1)
				//{
				//	alarmR=alarmR+"||"+"����";
				//}	
				//if(Device_Tem == 2 || Device_Hum == 2 || Device_Pic == 1|| Device_Hug == 1) //����
				if(Device_Tem == 2 || Device_Hum == 2) //����
				{//������˸��������
					var returnnum=setInterval("Alarm('"+svgid+"')",3000);
					intervalPresess.push(returnnum);
					node.style.fill = 'red';
					node.style.stroke = 'red';
					returnnum=setInterval('AlarmTimeout("' + svgid + '")', 500);
					intervalPresess.push(returnnum);
					node.textContent = alarmR;
				}
				else if(Device_Tem == 1 || Device_Hum == 1 )//Ԥ��
				{//������˸��һ��������
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

function AlarmTimeout(svgid)// ������˸
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
function preAlarmTimeout(svgid)// Ԥ����˸
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


function Alarm(svgid)// ����
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
	playAlarmAudio();//���ű�������
}

function playAlarmAudio()//���ű�������
{
	var isIE11 = (navigator.userAgent.toLowerCase().indexOf("trident") > -1 && navigator.userAgent.indexOf("rv") > -1);//����Ƿ���ie11
	var isFirefox=(navigator.userAgent.toLowerCase().indexOf("firefox") > -1);//����Ƿ���firefox
	if(isIE11)
	{
		document.getElementById("sound_IE").src = "../alarm/1.wav";
	}
	else if(isFirefox)
	{
		document.getElementById("sound_FF").src = "../alarm/1.wav";
	}
}

function settle(id)// ����������
{
	window.open(
					'settleAlarm.jsp?alarmid=' + id,
					'nodeInfo',
					'height=400,width=300,top=300px,left=500px,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no');
}

function sss(svgid) {
	/**********�����֮ǰ�ı�����˸��ʾ����***************/
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
			// ��ʾ���ص���Ӧ��id������ͼ�ϵĽڵ�Ŀ��ع�
			var s = xmlhttp.responseText;
			var result = xmlhttp.responseXML.getElementsByTagName("node");
			/*
			var result_surround = xmlhttp.responseXML.getElementsByTagName("surround");
			// �����¶�
			var TemValue = result_surround[0].getElementsByTagName("TemValue")[0].childNodes[0].nodeValue;
			// ����ʪ��
			var HumidityValue = result_surround[0].getElementsByTagName("HumidityValue")[0].childNodes[0].nodeValue;

			document.getElementById("TemValueH").innerHTML = TemValue;
			document.getElementById("HumidityValueH").innerHTML = HumidityValue;
			*/
			var xunjian = xmlhttp.responseXML.getElementsByTagName("zhouqi");
			var locknum=xunjian[0].getElementsByTagName("Para_Check")[0].childNodes[0].nodeValue;//Ѳ������
			if(locknum!=""&&locknum!="null")
			{
				Para_Check=locknum;
			}

			for ( var i = 0; i < result.length; i++) {
				var svgid = result[i].getElementsByTagName("svgid")[0].childNodes[0].nodeValue;// svgid
				var id = result[i].getElementsByTagName("Device_ID")[0].childNodes[0].nodeValue;// ���ع�id
				var Device_Name = result[i].getElementsByTagName("Device_Name")[0].childNodes[0].nodeValue;// ���ع�����

				var Device_Tem = result[i].getElementsByTagName("Device_Tem")[0].childNodes[0].nodeValue;// ���ع��¶ȱ���
				var Device_Hum = result[i].getElementsByTagName("Device_Hum")[0].childNodes[0].nodeValue;// ���ع�����ʪ�ȱ���
				var Device_Pic = result[i].getElementsByTagName("Device_Pic")[0].childNodes[0].nodeValue;// ���ع�ͼ�񱨾�
				var Device_Hug = result[i].getElementsByTagName("Device_Hug")[0].childNodes[0].nodeValue;// ���ع񻡹ⱨ��

				var node = svgdoc.getElementById(svgid);
				if (id == "null") {
					node.textContent = "��������";
				} else {
					//node.textContent = Device_Name+"(����)";
					node.textContent = "��   ��";
				}
				// ����
				var alarmR="";
				if(Device_Tem >0)
				{
					alarmR="�¶�";
				}	
				if(Device_Hum > 0)
				{
					alarmR=alarmR+"||"+"ʪ��";
				}
				//if(Device_Pic == 1)
				//{
				//	alarmR=alarmR+"||"+"ͼ��";
				//}	
				//if(Device_Hug == 1)
				//{
					//alarmR=alarmR+"||"+"����";
				//}	
				//if(Device_Tem == 2 || Device_Hum == 2 || Device_Pic == 1|| Device_Hug == 1) //����
				if(Device_Tem == 2 || Device_Hum == 2) //����
				{//������˸��������
					var returnnum=setInterval("Alarm('"+svgid+"')",3000);
					intervalPresess.push(returnnum);
					node.style.fill = 'red';
					node.style.stroke = 'red';
					returnnum=setInterval('AlarmTimeout("' + svgid + '")', 500);
					intervalPresess.push(returnnum);
					node.textContent = alarmR;
				}
				else if(Device_Tem == 1 || Device_Hum == 1 )//Ԥ��
				{//������˸��һ��������
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
				//var alarmR=Device_Name+"��";
				/*var alarmR="";
				if(Device_Tem == 1)
				{
					alarmR="�¶�";
				}	
				if(Device_Hum == 1)
				{
					alarmR=alarmR+"||"+"ʪ��";
				}
				//if(Device_Pic == 1)
				//{
				//	alarmR=alarmR+"||"+"ͼ��";
				//}	
				//if(Device_Hug == 1)
				//{
					//alarmR=alarmR+"||"+"����";
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
	// �����ڵ���ʾ���ܲ˵�
	var node = evt.target;
	svgNodeId = node.getAttribute("id");// ����ͼ�ϵĽڵ�id
	// document.getElementById("nodeinfo").innerHTML="<a id='"+svgNodeId+"'
	// href='#' class='linkmenu'>�豸�ڵ���Ϣ</a>";
	// document.getElementById("Tempchart").innerHTML="<a id='"+svgNodeId+"'
	// href='#' class='linkmenu'>ʵʱ�¶�����ͼ</a>";
	// document.getElementById("currentTemp").innerHTML="<a id='"+svgNodeId+"'
	// class='linkmenu' href='#'>ʵʱ�¶�����</a>";
	// document.getElementById("historyTemp").innerHTML="<a id='"+svgNodeId+"'
	// class='linkmenu' href='#'>��ʷ�¶�����</a>";
	// document.getElementById("alarmLog").innerHTML="<a id='"+svgNodeId+"'
	// class='linkmenu' href='#'>�ڵ㱨����¼</a>";
	// document.getElementById("samSelect").innerHTML="<a
	// id='"+document.getElementById("Substation_ID").value+"' class='linkmenu'
	// href='#'>��Ϣ��ѯ</a>";
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
	//����߽�˵���������ס������
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
    		//���û��ʪ���豸�Ͳ���ʾʪ�Ȳ˵�
    		if(parseInt(result[i].getElementsByTagName("humNum")[0].childNodes[0].nodeValue)==0)
    			document.getElementById("huminfo").style.display = "none";
    		else{
	    		document.getElementById("currentHum").addEventListener("click", currentHum,false);
	    		document.getElementById("historyHum").addEventListener("click", historyHum,false);
	    		document.getElementById("alarmLogHum").addEventListener("click",alarmLogHum, false);
    		}
    		
    		//���û��ͼ���豸�Ͳ���ʾͼ��˵�
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

    		//���û�л����豸�Ͳ���ʾ����
    		if(parseInt(result[i].getElementsByTagName("arcNum")[0].childNodes[0].nodeValue)==0)
    			document.getElementById("arcinfo").style.display = "none";
    		else{
//	    		document.getElementById("huguang").addEventListener("click", huguang, false);
//	    		document.getElementById("qianghu").addEventListener("click", qianghu, false);
//	    		document.getElementById("ruohu").addEventListener("click", ruohu, false);
	    		document.getElementById("recentHu").addEventListener("click", recentHu, false);
    		}
    		
    		//��ֹð��
    		//evt.cancelBubble = true;
    	}// svgid
    	
    }
    
    


}



function hide_menu(){
	document.getElementById("menu").style.display = "none";
}


function nodeinfoWindow()// ���ع���Ϣ
{
	window.open(
					'nodeInfo.jsp?pid=' + selectNodeId,
					'nodeInfo',
					'resizable=yes,height=300px,width=350px,top=30px,left=30px,scrollbars=yes,toolbar=no,menubar=no,location=no,status=no');
}
function currentTemp()// ��ǰ�¶���Ϣ
{
	// alert("ff");
	window.open(
					'currentTemperature.jsp?nodeid=' + selectNodeId,
					'currentTemperature',
					'resizable=yes,height=600,width=1100,top=30px,left=30px,toolbar=no,menubar=no,scrollbars=yes,location=no,status=no');
}
function historyTempWindow()// �ڵ��¶���ʷ��¼
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
			// ��ʾ���ص���Ӧ��id������ͼ�ϵĽڵ�Ŀ��ع�
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

function alarmLogTempWindow()// �ڵ㱨����Ϣ
{
	window.open(
					'alarmlist.jsp?nodeid=' + selectNodeId,
					'alarmLog',
					'resizable=yes,height=500,width=800,top=30px,left=30px,toolbar=no,menubar=no,location=no,status=no');
}

function TemperatureStatistics()// �������ݷ���
{
	var sid = document.getElementById("Substation_ID").value;
	window.open(
					"../SPC/datastatistic/datas.jsp?sid=" + sid,
					'TemperatureStatistics',
					'resizable=yes,height=700,width=1500,top=30px,left=30px,scrollbars=yes,toolbar=no,menubar=no,location=no,status=no');
}

function qianghu()// ǿ��
{
	window.open('qianghu.jsp?pid='+ selectNodeId,'qianghu','resizable=yes,height=300,width=400,top=30px,left=30px,scrollbars=yes,toolbar=no,menubar=no,location=no,status=no');
}

function ruohu()// ����
{
	window.open('ruohu.jsp?pid='+ selectNodeId,'ruohu','height=300,width=400,top=30px,left=30px,resizable=yes,scrollbars=yes,toolbar=no,menubar=no,location=no,status=no');
}


function recentHu()//���7�λ���
{
	window.open('rencentHuGuang.jsp?pid='+selectNodeId,'ruohu','height=300,width=400,top=30px,left=30px,resizable=yes,scrollbars=yes,toolbar=no,menubar=no,location=no,status=no');
}


function huguang()// ������ʷ��¼
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
			// ��ʾ���ص���Ӧ��id������ͼ�ϵĽڵ�Ŀ��ع�
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

// ͼ��Ѳ��
function picSet()// �鿴����
{
	// alert("ff");
	window.open('../liangw/picManage/picSet.jsp?sid='+ document.getElementById("Substation_ID").value+ '&nodeid=' + selectNodeId,'lookcurrentPicq','resizable=yes,height=500,width=1000,top=30px,left=30px,toolbar=no,menubar=no,location=no,status=no');
}
function picSet0()// �鿴����
{
	// alert("ff");
	window.open('../picManage/picSet.jsp?sid='+ document.getElementById("Substation_ID").value+ '&nodeid=' + selectNodeId,'lookcurrentPicq','resizable=yes,height=500,width=1000,top=30px,left=30px,toolbar=no,menubar=no,location=no,status=no');
}
function picCmp()// �������
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
function dataManage()// ���ݹ���
{
	// alert("ff");
	window.open('../liangw/picManage/dataManage.jsp?sid='
							+ document.getElementById("Substation_ID").value
							+ '&nodeid=' + selectNodeId,
					'historyPic',
					'resizable=yes,height=500,width=1000,top=30px,left=30px,toolbar=no,scrollbars=yes,menubar=no,location=no,status=no');
}
function alarmDeal()// ��������
{
	// alert("ff");
	window.open('../temperature/alarmPic.jsp?sid='
					+ document.getElementById("Substation_ID").value
					+ '&nodeid=' + selectNodeId,
					'alarmDeal',
					'resizable=yes,height=500,width=1000,top=30px,left=30px,toolbar=no,menubar=no,location=no,status=no');
}
function getRemotePic()// ץ��
{
	// alert("ff");
	window.open('../temperature/remotePic.jsp?sid='
					+ document.getElementById("Substation_ID").value
					+ '&nodeid=' + selectNodeId,
					'remotePic',
					'resizable=yes,top=30px,left=30px');
}

function setAlarm()// ѡ������
{
	// alert("ff");
	window.open('../temperature/PhotoList.jsp?sid='
					+ document.getElementById("Substation_ID").value
					+ '&nodeid=' + selectNodeId,
					'PhotoList',
					'resizable=yes,top=30px,left=30px');
}


function health()// ͼ����ʷ����
{
	// alert("ff");
	window.open(
					'health.jsp?sid=S001',
					'health',
					'resizable=yes,height=500,width=1000,top=30px,left=30px,scrollbars=yes,toolbar=no,menubar=no,location=no,status=no');
}
function currentHum()// ��ǰʪ����Ϣ
{
	window.open(
					'currentHum.jsp?nodeid=' + selectNodeId,
					'currentHumidity',
					'resizable=yes,height=600,width=1100,top=30px,left=30px,toolbar=no,menubar=no,scrollbars=yes,location=no,status=no');
}
function historyHum()// �ڵ�ʪ����ʷ��¼
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
			// ��ʾ���ص���Ӧ��id������ͼ�ϵĽڵ�Ŀ��ع�
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

function alarmLogHum()// �ڵ�ʪ�ȱ�����Ϣ
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

function huguang()// ������ʷ��¼
{
	alert("ddd");
	window.open(
					'huguang.jsp?nodeid=' + selectNodeId,
					'lookcurrentPicAss',
					'resizable=yes,height=300,width=400,top=30px,left=30px,toolbar=no,menubar=no,location=no,status=no');
}

function chartWindow()// ʵʱ�¶�����ͼ
{
	// alert("ff");
	window.open(
					'lookRealTimeChart.jsp?nodeid=' + selectNodeId,
					'nodeHistory',
					'height=500,width=1000,top=150px,left=200px,toolbar=no,menubar=no,location=no,status=no');
}

function searchNodeInfo()// �ڵ���Ϣ��ѯ
{
	// alert("ff");
	window.open(
					'nodeSearch.jsp?sid=' + selectNodeId,
					'nodeSearch',
					'height=300px,width=300px,top=30px,left=30px,toolbar=no,menubar=no,resizable=no,location=no,status=no');
}

function closing()// �˵��ر�
{
	document.getElementById("menu").style.display = "none";
}


//�����ؽڵ��¸��豸�������Ծ�������˵�����ʾ
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
//			// ��ʾ���ص���Ӧ��id������ͼ�ϵĽڵ�Ŀ��ع�
//			var s = xmlhttp.responseText;		
////			alert(s);
//			return s;
//
//			}
//	};
	xmlhttp.open("GET", "../servlet/findDeviceNotExsist?nodeid="
			+ svgid.toString() + "&r="
			+ new Date().getTime(), false);//ȷ��ajax�ܷ���ֵ
	xmlhttp.send();
	if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
		// ��ʾ���ص���Ӧ��id������ͼ�ϵĽڵ�Ŀ��ع�
//		var m =xmlhttp.responseText;
//		alert(m);
		var s = xmlhttp.responseXML;		
		
		return s;

	}
}
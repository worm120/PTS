//type:0 娓╁害鑺傜偣鍏宠仈;type:1 鍥惧儚鑺傜偣鍏宠仈
(function()
{
	setTimeout("init()",1000);
})();
function init()
	{
		//var svgdoc=window.document.getElementById("emSvg").getSVGDocument();
	
		var svgdoc = document.getElementById("emSvg").getSVGDocument();
		var nodes=svgdoc.getElementsByTagName("text");
		var subid=document.getElementById("Substation_ID").value;
		//alert(svgdoc);
		/*
		for(var i=0;i<nodes.length;i++)
		{
			//alert(nodes.item(i).textContent);
			//nodes.item(i).textContent="jiedian";
			nodes.item(i).style.cursor="pointer";
			nodes.item(i).addEventListener("click",show_menu,false);		
		}
		******************/
		
		var svgid=new Array();
		var index=0;
		for(var i=0;i<nodes.length;i++)
		{
			var nodeid=nodes.item(i).getAttribute("id");
			
			if(nodeid!=null&&nodeid!="null")
			{
				//alert(nodeid);
				nodes.item(i).style.cursor="pointer";
				//nodes.item(i).style.cssText="color:#000000;background-color:blue;fill:blue;";
				//nodes.item(i).setAttribute("fill", "#000000");
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
			//鏄剧ず杩斿洖鐨勭浉搴斿叧id鑱旀帴绾垮浘涓婄殑鑺傜偣鐨勫悕绉�
			  
			    var result=xmlhttp.responseXML.getElementsByTagName("device");
				for(var i=0;i<result.length;i++)
				{
					var deviceid=result[i].getElementsByTagName("deviceId")[0].childNodes[0].nodeValue;//璁惧寮�叧鏌渋d
					var pid=result[i].getElementsByTagName("deviceValue")[0].childNodes[0].nodeValue;//鑺傜偣鍥緄d
					//alert(sampleid);
					var node=svgdoc.getElementById(pid);
					node.textContent=deviceid;
				}
		  }
		};
		xmlhttp.open("GET","../servlet/getDeviceIdLinked?subid="+subid+"&r="+new Date().getTime(),true);
		xmlhttp.send();

		/******************/
		
	}
function show_menu(evt)  
{  
	var node=evt.target;
	svgNodeId=node.getAttribute("id");
	
	var linkid;
	var subid=document.getElementById("Substation_ID").value;
	
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
		  //alert(xmlhttp.responseXML);
		    var result=xmlhttp.responseXML.getElementsByTagName("device");
		    var linknodeid=xmlhttp.responseXML.getElementsByTagName("sample");
		    var linkid=linknodeid[0].getElementsByTagName("sampleid")[0].childNodes[0].nodeValue;
			document.getElementById("linkedNode").innerHTML="关联状态："+linkid;
		    
			var selectString="";
		    for(var i=0;i<result.length;i++)
			{
				var id=result[i].getElementsByTagName("deviceId")[0].childNodes[0].nodeValue;
				var value=result[i].getElementsByTagName("deviceValue")[0].childNodes[0].nodeValue;
				selectString=selectString+"<div class='samlist'><input id='sid' name='sid' type='checkbox' value='"+id+"'>"+value+"("+id+")</div>";
			}


			document.getElementById("samplelist").innerHTML=selectString;
			/*
			if(typeof(document.getElementsByName("sid").length)!="undefined")
			{
				for(var i=0;i<document.getElementsByName("sid").length;i++)
				{
					document.getElementsByName("sid")[i].addEventListener("change", checkboxChange, false);
				}
			}
			*/
			var x=evt.clientX;
			var y=evt.clientY;
			document.getElementById("menu").style.display="block";
			document.getElementById("menu").style.left=x;
			document.getElementById("menu").style.top=y;  
			document.getElementById("menu").style.position="absolute";
			document.getElementById("menu").style.z_index=3;
			//document.getElementById("devicelist").innerHTML=selectString;
			
			var samples="<select></select>";
	  }
	};
	//type:able 获取可关联的开关柜
	xmlhttp.open("GET","../servlet/getDevice?type=able&svgid="+svgNodeId+"&sid="+subid+"&t="+new Date().getTime(),true);
	xmlhttp.send();
	
	
	document.getElementById("NodeId").value=svgNodeId;
	document.getElementById("node").innerHTML=" "+svgNodeId+"";
	
	//document.getElementById("nodeid").value=svgNodeId;
	document.getElementById("linkSure").addEventListener("click", choose, false);//鎻愪氦绠＄悊
	document.getElementById("linkDel").addEventListener("click", del, false);//鍙栨秷鍏宠仈
	document.getElementById("close").addEventListener("click", closeing, false);//鍏抽棴鑿滃崟
	
} 



function closeing()//鑿滃崟鍏抽棴
{
	//document.getElementById("nodeid").value="";
	document.getElementById("samplelist").innerHTML="";
	//document.getElementById("devicelist").innerHTML="";
	document.getElementById("menu").style.display="none";
}
/*
function showsample()//鏄剧ず瀵瑰簲璁惧鐨勯噰鏍风偣
{
	//alert(document.getElementById("dev"));
	var deviceid=document.getElementById("dev").options[document.getElementById("dev").selectedIndex].value;
	
	//alert(deviceid);
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
		   //鏍规嵁杩斿洖鐨勮澶囧�鐐逛俊鎭叧鑱旀帴绾垮浘涓婄殑鑺傜偣
		  //alert(xmlhttp.responseXML);
		    var result=xmlhttp.responseXML.getElementsByTagName("sample");

		    var selectString="";
		    for(var i=0;i<result.length;i++)
			{
				var id=result[i].getElementsByTagName("sampleId")[0].childNodes[0].nodeValue;
				var value=result[i].getElementsByTagName("sampleValue")[0].childNodes[0].nodeValue;
				selectString=selectString+"<div class='samlist'><input id='sid' name='sid' type='checkbox' value='"+id+"'>"+value+"("+id+")</div>";
			}

			/*鏄剧ず鑺傜偣鍏宠仈閲囨牱鐐归�鎷╄彍鍗曡彍鍗�
			document.getElementById("samplelist").innerHTML=selectString;

			if(typeof(document.getElementsByName("sid").length)!="undefined")
			{
				for(var i=0;i<document.getElementsByName("sid").length;i++)
				{
					document.getElementsByName("sid")[i].addEventListener("change", checkboxChange, false);
				}
			}
	  }
	};
	xmlhttp.open("GET","../servlet/getSample?type=0&deviceid="+deviceid+"&t="+new Date().getTime(),true);
	xmlhttp.send();
}
*/
/*checkbox鏀瑰彉锛屽彧鑳介�涓竴椤�/
function checkboxChange()
{
	//alert(this.value);
	var checkb=document.all("sid");
	if(typeof(checkb.length)!="undefined")
	{
		for(var i=0;i<checkb.length;i++)
		{
			if(checkb[i].checked==true&&checkb[i].value!=this.value)
			{
				checkb[i].checked=false;
			}
		}
	}
}
*/
function choose()//灏嗙墿鐞嗚妭鐐瑰悓鎺ョ嚎鍥句笂鐨勫�鐐瑰叧鑱�
{

	var sampleId;
	var checkb=document.all("sid");
	if(typeof(checkb.length)!="undefined")
	{
		for(var i=0;i<checkb.length;i++)
		{
			if(checkb[i].checked==true)
			{
				sampleId=checkb[i].value;
			}
		}
	}
	else
	{
		sampleId=checkb.value;
	}

	var svgId=document.getElementById("NodeId").value;
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
		    var result=xmlhttp.responseText;
			if(result.indexOf("success")>=0)
			{
				alert("操作关联");
			}
			else
			{
				alert("操作关联，请重新关联！");
			}
			window.location.href=window.location.href; 
		    window.location.reload; 
	  }
	};
	xmlhttp.open("GET","../servlet/linkDevice?Device_ID="+sampleId+"&svgId="+svgId+"&sid="+document.getElementById("Substation_ID").value+"&t="+new Date().getTime(),true);
	xmlhttp.send();
}

function del()//鍙栨秷鑺傜偣鍏宠仈
{
	/*鑾峰彇鎵��鎺ョ嚎鍥緄d*/
	var svgId=document.getElementById("NodeId").value;
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
		//鏍规嵁杩斿洖鐨勬墽琛岀姸鎬佹彁绀虹敤鎴锋搷浣滅粨鏋�
		    var result=xmlhttp.responseText;
			if(result=="success")
			{
				alert("删除成功！");
			}
			else
			{
				alert("删除失败，请重新操作！");
			}
			window.location.href=window.location.href; 
		    window.location.reload; 
	  }
	};
	xmlhttp.open("GET","../servlet/deleteLinkedDevice?type=0&svgId="+svgId+"&t="+new Date().getTime(),true);
	xmlhttp.send();
}


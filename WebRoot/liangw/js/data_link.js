(function()
{
	//alert("ok");
	/*做延时操作，svg加载需要时间，否则getElementsByTagName("text")无法获取对象*/
	setTimeout("init()",1000);
})();
function init()
	{
		//var svgdoc=window.document.getElementById("emSvg").getSVGDocument();
	
		var svgdoc = document.getElementById("emSvg").getSVGDocument();
		var nodes=svgdoc.getElementsByTagName("text");
		var subid=document.getElementById("Substation_ID").value;
		//alert(svgdoc);
		for(var i=0;i<nodes.length;i++)
		{
			//alert(nodes.item(i).textContent);
			//nodes.item(i).textContent="jiedian";
			nodes.item(i).style.cursor="pointer";
			nodes.item(i).addEventListener("click",show_menu,false);		
		}
		/*******************/
		
		var svgid=new Array();
		var index=0;
		for(var i=0;i<nodes.length;i++)
		{
			var nodeid=nodes.item(i).getAttribute("id");
			if(nodeid!=null)
			{
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
			//显示返回的相应关id联接线图上的节点的温度
			  
			    var result=xmlhttp.responseXML.getElementsByTagName("sample");
				for(var i=0;i<result.length;i++)
				{
					var sampleid=result[i].getElementsByTagName("sampleId")[0].childNodes[0].nodeValue;//采样点id
					var pid=result[i].getElementsByTagName("sampleValue")[0].childNodes[0].nodeValue;//节点图id
					//alert(sampleid);
					var node=svgdoc.getElementById(pid);
					node.textContent=sampleid;
				}
		  }
		};
		xmlhttp.open("GET","../servlet/getSampleSvgid?subid="+subid+"&r="+new Date().getTime(),true);
		xmlhttp.send();

		/******************/
		
	}
function show_menu(evt)  
{  
	/*鑾峰彇鐐瑰嚮鐨勪綅缃樉绀哄叧鑱旇妭鐐硅彍鍗曪紝ajax鑾峰彇鍙�鑺傜偣*/
	
	var node=evt.target;
	svgNodeId=node.getAttribute("id");//接线图上的节点id
	
	var linkid;
	
	
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
		//根据返回的设备借点信息关联接线图上的节点
		  //alert(xmlhttp.responseXML);
		    var result=xmlhttp.responseXML.getElementsByTagName("device");
		    var linknodeid=xmlhttp.responseXML.getElementsByTagName("sample");
		    var selectString="<select id='dev' onchange='showsample()'><option value=''>--选择关联设备--</option>";
		    
			for(var i=0;i<result.length;i++)
			{
				//alert(i);
				var id=result[i].getElementsByTagName("deviceId")[0].childNodes[0].nodeValue;
				var value=result[i].getElementsByTagName("deviceValue")[0].childNodes[0].nodeValue;
				//alert(result[i].childNodes[1].childNodes[0].nodeValue);
				selectString=selectString+"<option value="+id+">"+value+"</option>";
			}
			selectString=selectString+"</select>";
			
			//linkid=result[0].getElementsByTagName("sampleid")[0].childNodes[0].nodeValue;
			linkid=linknodeid[0].getElementsByTagName("sampleid")[0].childNodes[0].nodeValue;
			
			document.getElementById("linkedNode").innerHTML="关联状态："+linkid;
			//selectString=selectString+"<select><select>";
			
			/*显示节点关联采样点选择菜单菜单*/
			var x=evt.clientX;
			var y=evt.clientY;
			document.getElementById("menu").style.display="block";
			document.getElementById("menu").style.left=x;
			document.getElementById("menu").style.top=y;  
			document.getElementById("menu").style.position="absolute";
			document.getElementById("menu").style.z_index=3;
			document.getElementById("devicelist").innerHTML=selectString;
			
			var samples="<select></select>";
	  }
	};
	xmlhttp.open("GET","../servlet/getDevice?svgid="+svgNodeId+"&t="+new Date().getTime(),true);
	xmlhttp.send();
	
	
	document.getElementById("NodeId").value=svgNodeId;
	document.getElementById("node").innerHTML="接线图节点  "+svgNodeId+" 关联采样点";
	
	//document.getElementById("nodeid").value=svgNodeId;
	document.getElementById("linkSure").addEventListener("click", choose, false);//提交管理
	document.getElementById("linkDel").addEventListener("click", del, false);//取消关联
	document.getElementById("close").addEventListener("click", closeing, false);//关闭菜单
	
} 



function closeing()//菜单关闭
{
	//document.getElementById("nodeid").value="";
	document.getElementById("samplelist").innerHTML="";
	document.getElementById("devicelist").innerHTML="";
	document.getElementById("menu").style.display="none";
}

function showsample()//显示对应设备的采样点
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
		   //根据返回的设备借点信息关联接线图上的节点
		  //alert(xmlhttp.responseXML);
		    var result=xmlhttp.responseXML.getElementsByTagName("sample");
			//alert(result[0].getElementsByTagName("nodeid")[0].childNodes[0].nodeValue);
		    /*
		    var selectString="<select id='sam' >";
			for(var i=0;i<result.length;i++)
			{
				//alert(i);
				var id=result[i].getElementsByTagName("sampleId")[0].childNodes[0].nodeValue;
				var value=result[i].getElementsByTagName("sampleValue")[0].childNodes[0].nodeValue;
				//alert(result[i].childNodes[1].childNodes[0].nodeValue);
				selectString=selectString+"<option value="+id+">"+value+"</option>";
			}
			selectString=selectString+"</select>";
			//alert(selectString);
			//selectString=selectString+"<select><select>";
			*/
		    
		    var selectString="";
		    for(var i=0;i<result.length;i++)
			{
				var id=result[i].getElementsByTagName("sampleId")[0].childNodes[0].nodeValue;
				var value=result[i].getElementsByTagName("sampleValue")[0].childNodes[0].nodeValue;
				selectString=selectString+"<div class='samlist'><input id='sid' name='sid' type='checkbox' value='"+id+"'>"+value+"("+id+")</div>";
			}
		    
		    
		    
			/*显示节点关联采样点选择菜单菜单*/
			document.getElementById("samplelist").innerHTML=selectString;
			
			
			//document.getElementById("sid").addEventListener("change", checkboxChange, false);
			
			//alert(document.getElementsByName("sid"));
			if(typeof(document.getElementsByName("sid").length)!="undefined")
			{
				for(var i=0;i<document.getElementsByName("sid").length;i++)
				{
					document.getElementsByName("sid")[i].addEventListener("change", checkboxChange, false);
					//document.getElementsByName("sid")[i].onchange = new Function("checkboxChange()");//此方式为添加匿名函数，无法获得本事件的信息；
				}
			}
			//document.getElementsByName("sid").onchange = new Function("checkboxChange()");
	  }
	};
	xmlhttp.open("GET","../servlet/getSample?deviceid="+deviceid+"&t="+new Date().getTime(),true);
	xmlhttp.send();
}

/*checkbox改变，只能选中一项*/
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

function choose()//将物理节点同接线图上的借点关联
{
	/*获取所选采样点id*/
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
	/*获取接线图节点id*/
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
		//根据返回的执行状态提示用户操作结果
		    var result=xmlhttp.responseText;
			if(result=="success")
			{
				alert("关联节点成功！");
			}
			else
			{
				alert("关联节点失败，请重新关联！！");
			}
			
	  }
	};
	xmlhttp.open("GET","../servlet/linkNode?sampleId="+sampleId+"&svgId="+svgId+"&t="+new Date().getTime(),true);
	xmlhttp.send();
}

function del()//取消节点关联
{
	/*获取所选接线图id*/
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
		//根据返回的执行状态提示用户操作结果
		    var result=xmlhttp.responseText;
			if(result=="success")
			{
				alert("取消关联成功！");
			}
			else
			{
				alert("取消关联失败，请重新操作！！");
			}
			
	  }
	};
	xmlhttp.open("GET","../servlet/deletelink?svgId="+svgId+"&t="+new Date().getTime(),true);
	xmlhttp.send();
}


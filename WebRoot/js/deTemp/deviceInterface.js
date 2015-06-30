(function()
{
	setTimeout("init()",200);
}());

function init()
{	var mybg=null;
	var myAlert = document.getElementById("add"); 
	var reg = document.getElementById("adds"); 
	var mClose = document.getElementById("close");
	var sub=document.getElementById("submitt");
	var selectall=document.getElementById("title-checkbox");

	
	reg.onclick = function() 
	{ 
		//var Substation_ID=document.getElementById("Substation_ID");
		var checkb=document.all("beixuan");
		//alert(checkb.length);
		var flag=0;
		var index=-1;
		if(typeof(checkb.length)=="undefined")
		{
			if(document.getElementById("beixuan").checked==true)
			{
				flag++;
				index=0;
			}
		}
		else
		{
			for(var i=0;i<checkb.length;i++)
			{
				//alert(checkb.length);
				if(checkb[i].checked===true)
				{
					flag++;
					index=i;
				}
			}
		}
		if(flag<=0)
		{
			alert("请选则一条记录进行修改！");
		}
		else if(flag>1)
		{
			alert("每次只能对一条记录进行修改！");
		}
		else
		{
			alert("sss");
			var tb=document.getElementById("listtable");
			index=index+1;
			
			//Substation_ID.value=tb.rows[index].cells[6].innerHTML;
			document.getElementById("Device_ID").value=tb.rows[index].cells[2].innerHTML;
			document.getElementById("Device_Addr").value=tb.rows[index].cells[6].innerHTML;
			document.getElementById("Device_StartH").value=tb.rows[index].cells[7].innerHTML;
			document.getElementById("Device_StartL").value=tb.rows[index].cells[8].innerHTML;
			document.getElementById("Device_dataL").value=tb.rows[index].cells[9].innerHTML;
			
			document.getElementById("Device_IP").value=tb.rows[index].cells[10].innerHTML;
			document.getElementById("Device_Port").value=tb.rows[index].cells[11].innerHTML;
			
			//alert(tb.rows[index+1].cells[1].innerHTML);
			myAlert = document.getElementById("add"); 
			myAlert.style.display = "block"; 
			myAlert.style.position = "absolute"; 
			myAlert.style.top = "50%"; 
			myAlert.style.left = "50%"; 
			myAlert.style.marginTop = "-150px"; 
			myAlert.style.marginLeft = "-200px"; 
			myAlert.style.zIndex = "501"; 
			
			mybg = document.createElement("div"); 
			mybg.setAttribute("id","mybg"); 
			mybg.style.background = "#000"; 
			mybg.style.width = "100%"; 
			mybg.style.height = "100%"; 
			mybg.style.position = "absolute"; 
			mybg.style.top = "0"; 
			mybg.style.left = "0"; 
			mybg.style.zIndex = "500"; 
			mybg.style.opacity = "0.3"; 
			mybg.style.filter = "Alpha(opacity=30)"; 
			document.body.appendChild(mybg); 
			document.body.style.overflow = "hidden"; 
		}
	} ;
/*
	mClose.onclick = function() 
	{ 
		myAlert.style.display = "none"; 
		mybg.style.display = "none"; 
		document.getElementById("Device_ID").value="";
		document.getElementById("Device_Addr").value="";
		document.getElementById("Device_StartH").value="";
		document.getElementById("Device_StartL").value="";
		document.getElementById("Device_dataL").value="";
		document.getElementById("Device_IP").value="";
		document.getElementById("Device_Port").value="";
	} ;
	
	selectall.onchange=function()
	{
		var checkb=document.all("beixuan");
		var flag=0;
		if(typeof(checkb.length)=="undefined")
		{
			if(document.getElementById("beixuan").checked===true)
			{
				document.getElementById("beixuan").checked=false;
			}
			else
			{
				document.getElementById("beixuan").checked=true;
			}
		}
		else
		{
			for(var i=0;i<checkb.length;i++)
			{
				if(checkb[i].checked===false)
				{
					flag=1;
				}
			}
			
			if(flag==1)
			{
				for(var i=0;i<checkb.length;i++)
				{
					checkb[i].checked=true;
				}
			}
			else
			{
				for(var i=0;i<checkb.length;i++)
				{
					checkb[i].checked=false;
				}
			}
		}
	};
	*/
	document.getElementById("selectD").addEventListener("click", selectDevicesSet, false);
	document.getElementById("submitt").addEventListener("click", suret, false);
}

function selectDevicesSet()
{
	alert("gg");
	document.getElementById("formsub").action="linkDevice.jsp?SDeviceId="+document.getElementById("SDeviceId").value+"&SDeviceName="+document.getElementById("SDeviceName").value+"&SDevice_Addr="+document.getElementById("SDevice_Addr").value+"&SDevice_IP="+document.getElementById("SDevice_IP").value;
	document.getElementById("formsub").submit();
}

function suret()
{

	var Device_ID=document.getElementById("Device_ID");
	var Device_Addr=document.getElementById("Device_Addr");
	var Device_StartH=document.getElementById("Device_StartH");
	var Device_StartL=document.getElementById("Device_StartL");
	var Device_dataL=document.getElementById("Device_dataL");
	var Device_IP=document.getElementById("Device_IP");
	var Device_Port=document.getElementById("Device_Port");

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
		    var result=xmlhttp.responseText;
		    if(result=="success")
		    {
		    	alert("设置成功！");
		    }
		    else
		    {
		    	alert("操作失败，请重新设置！");
		    }
		    window.location.href=window.location.href; 
		    window.location.reload;    
	  }
	};
	var type="insert";
	//if(document.getElementById("hid").value=="update")
	//{
		//type="update";
	//}
	alert("f");
	xmlhttp.open("GET","../servlet/setDevice?Device_ID="+Device_ID.value+"&Device_Addr="+Device_Addr.value+"&Device_StartH="+Device_StartH.value+"&Device_StartL="+Device_StartL.value+"&Device_dataL="+Device_dataL.value+"&Device_IP="+Device_IP.value+"&Device_Port="+Device_Port.value+"&t="+new Date().getTime(),true);
	xmlhttp.send();
}

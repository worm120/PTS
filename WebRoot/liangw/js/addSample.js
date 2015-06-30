(function()
{
	setTimeout("init()",100);
}());

function init()
{
	//alert("1");
	var myAlert = document.getElementById("add"); 
	var reg = document.getElementById("adds"); 
	var mClose = document.getElementById("close");
	var sub=document.getElementById("submitt");
	var change=document.getElementById("changes");
	var deletes=document.getElementById("dels");
	var subidd=document.getElementById("Substation_ID");
	var devid=document.getElementById("Device_ID");
	var selectall=document.getElementById("title-checkbox");
	reg.onclick = function() 
	{ 
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
		//获取自动编号
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
			//根据返回的变电所的数，自动编号
			    var result=xmlhttp.responseText;
			    result=parseInt(result)+1;
			    var newid;
			    if(result<10)
			    {
			    	newid="SM0000"+result;
			    }
			    else if(result<100&&result>=10)
			    {
			    	newid="SM000"+result;
			    }
			    else if(result<1000&&result>=100)
			    {
			    	newid="SM00"+result;
			    }
			    else 
			    {
			    	newid="SM0"+result;
			    }
			    document.getElementById("Sample_ID").value=newid;
		  }
		};
		xmlhttp.open("GET","../servlet/getNewSampleID?t="+new Date().getTime(),true);
		xmlhttp.send();
	
	
	} ;

	mClose.onclick = function() 
	{ 
		myAlert.style.display = "none"; 
		mybg.style.display = "none"; 

		document.getElementById("Sample_ID").value="";
		document.getElementById("Sample_Name").value="";
		//document.getElementById("Substation_ID").value="";
		document.getElementById("Device_ID").innerHTML="<option value='first'>---请选择设备---</option>";
		document.getElementById("rem").value="";
		document.getElementById("hid").value="insert";
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
	
	sub.addEventListener("click", sure, false);
	change.addEventListener("click", changeSam, false);
	deletes.addEventListener("click", deleteSam, false);
	subidd.addEventListener("change", subidchange, false)
	document.getElementById("hid").value="insert";
}
function subidchange()
{
	//alert("ff");
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
		//返回对应变电所的设备
		    var result=xmlhttp.responseXML.getElementsByTagName("device");
		    var selectString="";
		    
			for(var i=0;i<result.length;i++)
			{
				//alert(i);
				var id=result[i].getElementsByTagName("deviceId")[0].childNodes[0].nodeValue;
				var value=result[i].getElementsByTagName("deviceValue")[0].childNodes[0].nodeValue;
				//alert(result[i].childNodes[1].childNodes[0].nodeValue);
				selectString=selectString+"<option value="+id+">"+value+"</option>";
			}
			document.getElementById("Device_ID").innerHTML=selectString;
	  }
	};
	var sid=document.getElementById("Substation_ID").options[document.getElementById("Substation_ID").selectedIndex].value;
	xmlhttp.open("GET","../servlet/getDevice?sid="+sid+"&t="+new Date().getTime(),true);
	xmlhttp.send();
}
function sure()
{
	//alert("2");
	var Sample_ID=document.getElementById("Sample_ID");
	var Sample_Name=document.getElementById("Sample_Name");
	var Device_ID=document.getElementById("Device_ID");
	var Substation_ID=document.getElementById("Substation_ID");
	
	var Sample_Type=document.getElementById("Sample_Type");
	var Sample_Place=document.getElementById("Sample_Place");
	
	var rem=document.getElementById("rem");
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
		    	alert("操作成功！");
		    }
		    else
		    {
		    	alert("操作失败，请重新更新或添加！");
		    }
		    window.location.href=window.location.href; 
		    window.location.reload;    
	  }
	};
	var type="insert";
	if(document.getElementById("hid").value=="update")
	{
		type="update";
	}
	xmlhttp.open("GET","../servlet/addSample?Substation_ID="+Substation_ID.options[Substation_ID.selectedIndex].value+"&Device_ID="+Device_ID.options[Device_ID.selectedIndex].value+"&Sample_Type="+Sample_Type.options[Sample_Type.selectedIndex].value+"&Sample_ID="+Sample_ID.value+"&Sample_Name="+Sample_Name.value+"&Sample_Place="+Sample_Place.value+"&rem="+rem.value+"&type="+type+"&t="+new Date().getTime(),true);
	xmlhttp.send();
}
function changeSam()
{
	
	
	var checkb=document.all("beixuan");
	var Substation_ID=document.getElementById("Substation_ID");
	var Sample_Type=document.getElementById("Sample_Type");
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
		//alert("sss");
		document.getElementById("hid").value="update";
		var tb=document.getElementById("listtable");
		/*
		for(var i=0;i<Substation_ID.options.length;i++)
		{
			if(Substation_ID.options[i].value==tb.rows[index].cells[7].innerHTML.trim())
			{
				Substation_ID.options[i].selected=true;
				break;
			}
		}
		
		for(var i=0;i<Sample_Type.options.length;i++)
		{
			if(Sample_Type.options[i].value.trim()==tb.rows[index].cells[4].innerHTML.trim())
			{
				Sample_Type.options[i].selected=true;
				break;
			}
		}
		*/
		index=index+1;
		document.getElementById("Sample_ID").value=tb.rows[index].cells[2].innerHTML;
		document.getElementById("Sample_Name").value=tb.rows[index].cells[3].innerHTML;
		document.getElementById("Sample_Place").value=tb.rows[index].cells[5].innerHTML;
		//document.getElementById("Substation_ID").value=tb.rows[index].cells[4].innerHTML;
		//document.getElementById("Substation_Device").value=tb.rows[index].cells[5].innerHTML;
		document.getElementById("rem").value=tb.rows[index].cells[6].innerHTML;
		
		//alert(tb.rows[index+1].cells[1].innerHTML);
		var myAlert = document.getElementById("add"); 
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
}

function deleteSam()
{
	var sid=new Array();
	
	
	var checkb=document.all("beixuan");
	//alert(checkb.length);
	var flag=0;
	var index=0;
	for(var i=0;i<checkb.length;i++)
	{
		//alert(checkb.length);
		if(checkb[i].checked===true)
		{
			sid[index]=checkb[i].value;
			index++;
		}
	}
	/*将被选中的待删除的Id数组转化为字符转上传服务器处理*/
	var id=sid.toString();
	
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
		//返回成功删除记录数
		    var result=xmlhttp.responseText;
		    if(alert("成功删除"+result+"条记录"))
		    {
		    	window.location.href=window.location.href; 
			    window.location.reload; 
		    }
		    
		    
	  }
	};
	xmlhttp.open("GET","../servlet/deleteSample?sid="+id+"&t="+new Date().getTime(),true);
	xmlhttp.send();
	  
	
}
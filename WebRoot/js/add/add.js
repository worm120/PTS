(function()
{
	setTimeout("init()",100);
}());

function init()
{
	var myAlert = document.getElementById("add"); 
	var reg = document.getElementById("adds"); 
	var mClose = document.getElementById("close");
	var sub=document.getElementById("submitt");
	var change=document.getElementById("changes");
	var deletes=document.getElementById("dels");
	var selectall=document.getElementById("title-checkbox");
	//var managed=document.getElementById("managed");
	
	/*点击新增*/
	reg.onclick = function() 
	{ 
		myAlert.style.display = "block"; 
		myAlert.style.position = "fixed"; 
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
		mybg.style.position = "fixed"; 
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
			    result=parseInt(result);
			    var newid;
			    if(result<10)
			    {
			    	newid="00"+result;
			    }
			    else if(result<100&&result>=10)
			    {
			    	newid="0"+result;
			    }
			    else if(result<1000&&result>=100)
			    {
			    	newid=result;
			    }
			    document.getElementById("Substation_ID").value=newid;
		  }
		};
		xmlhttp.open("GET","../servlet/getNewSubstationID?t="+new Date().getTime(),true);
		xmlhttp.send();
	} ;

	mClose.onclick = function() 
	{ 
		myAlert.style.display = "none"; 
		//mybg.style.display = "none"; 
		document.body.removeChild(document.getElementById("mybg"));
		document.body.style.overflow = "auto"; 

		document.getElementById("Substation_ID").value="";
		document.getElementById("Substation_Name").value="";
		document.getElementById("Substation_Place").value="";
		document.getElementById("Substation_Tele").value="";
		//document.getElementById("Substation_Device").value="";
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
	/*
	managed.onclick=function()
	{
		window.location.href="addDevice.jsp";
	};
	*/
	sub.addEventListener("click", sure, false);
	change.addEventListener("click", changeSub, false);
	deletes.addEventListener("click", deleteSub, false);
	document.getElementById("hid").value="insert";
}
function sure()
{
	var Substation_ID=document.getElementById("Substation_ID");
	var Substation_Name=document.getElementById("Substation_Name");
	var Substation_Place=document.getElementById("Substation_Place");
	var Substation_Tele=document.getElementById("Substation_Tele");
	//var Substation_Device=document.getElementById("Substation_Device");
	var rem=document.getElementById("rem");
	
	//alert(Substation_Name.value);
	
	if(Substation_Name.value==null||Substation_Place.value==null||Substation_Name.value==""||Substation_Place.value=="")
	{
		alert("变电所名称或地址不能为空，请重新输入后提交！");
	}
	else 
	{
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
			//根据返回文本判断是否操作成功。
			    var result=xmlhttp.responseText;
			    if(result.indexOf("success")>=0)
			    {
			    	alert("操作成功！");
			    }
			    else
			    {
			    	alert("操作失败，请重新更新或添加！");
			    }
			    window.location.href=window.location.href; 
			    window.location.reload();    
		  }
		};
		var type="insert";
		if(document.getElementById("hid").value=="update")
		{
			type="update";
		}
		xmlhttp.open("GET","../servlet/addSubstation?Substation_ID="+Substation_ID.value+"&Substation_Name="+Substation_Name.value+"&Substation_Place="+Substation_Place.value+"&Substation_Tele="+Substation_Tele.value+"&rem="+rem.value+"&type="+type+"&t="+new Date().getTime(),true);
		xmlhttp.send();
	}
}
function changeSub()
{
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
		//alert("sss");
		document.getElementById("hid").value="update";
		var tb=document.getElementById("listtable");
		index=index+1;
		document.getElementById("Substation_ID").value=tb.rows[index].cells[2].innerHTML;
		document.getElementById("Substation_Name").value=tb.rows[index].cells[3].innerHTML;
		document.getElementById("Substation_Place").value=tb.rows[index].cells[4].innerHTML;
		document.getElementById("Substation_Tele").value=tb.rows[index].cells[5].innerHTML;
		//document.getElementById("Substation_Device").value=tb.rows[index].cells[5].innerHTML;
		document.getElementById("rem").value=tb.rows[index].cells[7].innerHTML;
		
		//alert(tb.rows[index+1].cells[1].innerHTML);
		var myAlert = document.getElementById("add"); 
		myAlert.style.display = "block"; 
		myAlert.style.position = "fixed"; 
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
		mybg.style.position = "fixed"; 
		mybg.style.top = "0"; 
		mybg.style.left = "0"; 
		mybg.style.zIndex = "500"; 
		mybg.style.opacity = "0.3"; 
		mybg.style.filter = "Alpha(opacity=30)"; 
		document.body.appendChild(mybg); 
		document.body.style.overflow = "hidden"; 
	}
}

function deleteSub()
{
	if(confirm("确认删除？"))
	{
		var sid=new Array();
		var checkb=document.all("beixuan");
		
		var flag=0;
		var index=0;
		if(typeof(checkb.length)=="undefined")
		{
			if(document.getElementById("beixuan").checked==true)
			{
				sid[0]=document.getElementById("beixuan").value;
			}
		}
		else
		{
			for(var i=0;i<checkb.length;i++)
			{
				//alert(checkb.length);
				if(checkb[i].checked===true)
				{
					sid[index]=checkb[i].value;
					index++;
				}
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
			    alert("成功删除"+result+"条记录");
			    window.location.href=window.location.href; 
			    window.location.reload(); 
		  }
		};
		xmlhttp.open("GET","../servlet/deleteSubstation?sid="+id+"&t="+new Date().getTime(),true);
		xmlhttp.send();
	}

}
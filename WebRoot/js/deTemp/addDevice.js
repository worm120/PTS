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
	/*var managed=document.getElementById("managed");
	
	managed.onclick=function()
	{
		window.location.href="addSample.jsp";
	};
	*/
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
		//��ȡ�Զ����
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
			//���ݷ��صı�����������Զ����
			    var result=xmlhttp.responseText;
			    result=parseInt(result)+1;
			    var newid;
			    if(result<10)
			    {
			    	newid="D000"+result;
			    }
			    else if(result<100&&result>=10)
			    {
			    	newid="D00"+result;
			    }
			    else if(result<1000&&result>=100)
			    {
			    	newid="D0"+result;
			    }
			    else 
			    {
			    	newid="D"+result;
			    }
			    document.getElementById("Device_ID").value=newid;
		  }
		};
		xmlhttp.open("GET","../servlet/getNewDeviceID?t="+new Date().getTime(),true);
		xmlhttp.send();
	} ;

	mClose.onclick = function() 
	{ 
		myAlert.style.display = "none"; 
		mybg.style.display = "none"; 
		//document.getElementById("Substation_Name").value="";
		document.getElementById("Device_ID").value="";
		document.getElementById("Device_Name").value="";
		document.getElementById("Device_Card").value="";
		document.getElementById("Device_Place").value="";
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
	document.getElementById("selectD").addEventListener("click", selectDevices, false);
	sub.addEventListener("click", sure, false);
	change.addEventListener("click", changeDev, false);
	deletes.addEventListener("click", deleteDev, false);
	document.getElementById("hid").value="insert";
}
function selectDevices()
{
	document.getElementById("formsub").action="addDevice.jsp?sid="+document.getElementById("hid_sid").value+"&DeviceId="+document.getElementById("DeviceId").value+"&DeviceName="+document.getElementById("DeviceName").value+"&DeviceFea="+document.getElementById("DeviceFea").value;
	document.getElementById("formsub").submit();
}

function sure()
{
	//alert("2");
	var Substation_ID=document.getElementById("Substation_ID");
	var Device_ID=document.getElementById("Device_ID");
	var Device_Name=document.getElementById("Device_Name");
	var Device_Card=document.getElementById("Device_Card");
	var Device_Place=document.getElementById("Device_Place");
	var Device_Feature=document.getElementById("Device_Feature");
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
		//���ݷ��ص��豸�����Ϣ��������ͼ�ϵĽڵ�
		    var result=xmlhttp.responseText;
		    if(result=="success")
		    {
		    	alert("�����ɹ���");
		    }
		    else
		    {
		    	alert("����ʧ�ܣ������¸��»���ӣ�");
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
	
	if(Device_Name.value.length>=50)
	{
		alert("���������Ƴ��Ȳ��ܳ���50���ַ���25�����֣����������룡");
	}
	else if(Device_Place.value.length>=100)
	{
		alert("��װ��ַ���Ȳ��ܳ���100���ַ���50�����֣����������룡");
	}
	else if(rem.value.length>50)
	{
		alert("��ע���Ȳ��ܳ���200���ַ���100�����֣����������룡");
	}
	else
	{
		xmlhttp.open("GET","../servlet/addDevice?Substation_ID="+Substation_ID.options[Substation_ID.selectedIndex].value+"&Device_ID="+Device_ID.value+"&Device_Name="+Device_Name.value+"&Device_Card="+Device_Card.value+"&Device_Place="+Device_Place.value+"&Device_Feature="+Device_Feature.value+"&rem="+rem.value+"&type="+type+"&t="+new Date().getTime(),true);
		xmlhttp.send();
	}
	
	
}
function changeDev()
{
	
	var Substation_ID=document.getElementById("Substation_ID");
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
		alert("��ѡ��һ����¼�����޸ģ�");
	}
	else if(flag>1)
	{
		alert("ÿ��ֻ�ܶ�һ����¼�����޸ģ�");
	}
	else
	{
		//alert("sss");
		document.getElementById("hid").value="update";
		var tb=document.getElementById("listtable");
		index=index+1;
		for(var i=0;i<Substation_ID.options.length;i++)
		{
			if(Substation_ID.options[i].value==tb.rows[index].cells[7].innerHTML)
			{
				Substation_ID.options[i].selected=true;
			}
		}
		//Substation_ID.value=tb.rows[index].cells[6].innerHTML;
		document.getElementById("Device_ID").value=tb.rows[index].cells[2].innerHTML;
		document.getElementById("Device_Name").value=tb.rows[index].cells[3].innerHTML;
		document.getElementById("Device_Card").value=tb.rows[index].cells[4].innerHTML;
		document.getElementById("Device_Place").value=tb.rows[index].cells[5].innerHTML;
		document.getElementById("Device_Feature").value=tb.rows[index].cells[6].innerHTML;
		document.getElementById("rem").value=tb.rows[index].cells[8].innerHTML;
		
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

function deleteDev()
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
	/*����ѡ�еĴ�ɾ����Id����ת��Ϊ�ַ�ת�ϴ�����������*/
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
		//���سɹ�ɾ����¼��
		    var result=xmlhttp.responseText;

		    alert("�ɹ�ɾ��"+result+"����¼");
		    
		    window.location.href=window.location.href; 
		    window.location.reload;    
	  }
	};
	xmlhttp.open("GET","../servlet/deleteDevice?did="+id+"&t="+new Date().getTime(),true);
	xmlhttp.send();
	
	
}
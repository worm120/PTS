(function()
{
	setTimeout("init()",300);
}());

function init()
{
	//alert("1");
	//var myAlert = document.getElementById("add"); 
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

			    document.getElementById("Sample_ID").value=result;
		  }
		};
		xmlhttp.open("GET","../servlet/getNewSampleId?t="+new Date().getTime(),true);
		xmlhttp.send();
	} ;

	mClose.onclick = function() 
	{ 
		var myAlert = document.getElementById("add"); 
		myAlert.style.display = "none"; 
		//document.getElementById("mybg").style.display = "none"; 
		document.body.removeChild(document.getElementById("mybg"));
				document.body.style.overflow = "auto"; 

		document.getElementById("Sample_ID").value="";
		document.getElementById("Sample_Name").value="";
		//document.getElementById("Substation_ID").value="";
		document.getElementById("Device_ID").innerHTML="<option value='first'>---��ѡ���豸---</option>";
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
	document.getElementById("selectS").addEventListener("click", selectSamples, false);
	sub.addEventListener("click", sure, false);
	change.addEventListener("click", changeSam, false);
	deletes.addEventListener("click", deleteSam, false);
	subidd.addEventListener("change", subidchange, false);
	document.getElementById("hid").value="insert";
}

function selectSamples()
{
	document.getElementById("formsub").action="addSample.jsp?sid="+document.getElementById("hid_sid").value+"&sampleId="+document.getElementById("sampleId").value+"&sampleName="+document.getElementById("sampleName").value+"&seceltType="+document.getElementById("seceltType").value+"&seceltDeviceID="+document.getElementById("seceltDeviceID").value;
	document.getElementById("formsub").submit();
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
		//���ض�Ӧ��������豸
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
		//���ݷ��ص��豸�����Ϣ��������ͼ�ϵĽڵ�
		    var result=xmlhttp.responseText;
		    if(result.indexOf("success")>=0)
		    {
		    	alert("�����ɹ���");
		    }
		    else
		    {
		    	alert("����ʧ�ܣ������¸��»���ӣ�");
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
	
	if(Sample_ID.value.length<=0)
	{
		alert("�������ų��Ȳ���Ϊ�գ����������룡");
	}
	else if(Sample_Name.value.length>=50||Sample_Name.value.length<=0)
	{
		alert("���������Ƴ��Ȳ��ܳ���50���ַ���25�����֣����������룡");
	}
	else if(Sample_Place.value.length>=100)
	{
		alert("��װ��ַ���Ȳ��ܳ���100���ַ���50�����֣����������룡");
	}
	else if(rem.value.length>50)
	{
		alert("��ע���Ȳ��ܳ���200���ַ���100�����֣����������룡");
	}
	else
	{
		xmlhttp.open("GET","../servlet/addSample?Substation_ID="+Substation_ID.options[Substation_ID.selectedIndex].value+"&Device_ID="+Device_ID.options[Device_ID.selectedIndex].value+"&Sample_Type="+Sample_Type.options[Sample_Type.selectedIndex].value+"&Sample_ID="+Sample_ID.value+"&Sample_Name="+Sample_Name.value+"&Sample_Place="+Sample_Place.value+"&rem="+rem.value+"&type="+type+"&t="+new Date().getTime(),true);
		xmlhttp.send();
	}
	
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
		document.getElementById("Sample_ID").value=tb.rows[index].cells[2].innerHTML;
		document.getElementById("Sample_Name").value=tb.rows[index].cells[3].innerHTML;
		document.getElementById("Sample_Place").value=tb.rows[index].cells[5].innerHTML;
		document.getElementById("rem").value=tb.rows[index].cells[8].innerHTML;
		
		var temp = tb.rows[index].cells[4].innerHTML;
		//alert(temp);
		var selectString="";
		var value="01";
		if(temp=="�¶�"){
			value = "01";
			selectString=selectString+"<option value="+value+">"+temp+"</option>"+"<option value="+'00'+">"+'ͼ��'+"</option>"+"<option value="+'02'+">"+'����'+"</option>"+"<option value="+'03'+">"+'ʪ��'+"</option>";
			document.getElementById("Sample_Type").innerHTML=selectString;	
			}
		else if (temp =="ͼ��"){
			value="00";
			selectString=selectString+"<option value="+value+">"+temp+"</option>"+"<option value="+'01'+">"+'�¶�'+"</option>"+"<option value="+'02'+">"+'����'+"</option>"+"<option value="+'03'+">"+'ʪ��'+"</option>";
			document.getElementById("Sample_Type").innerHTML=selectString;
			}
		else if (temp =="����"){
			value="02";
			selectString=selectString+"<option value="+value+">"+temp+"</option>"+"<option value="+'00'+">"+'ͼ��'+"</option>"+"<option value="+'01'+">"+'�¶�'+"</option>"+"<option value="+'03'+">"+'ʪ��'+"</option>";
			document.getElementById("Sample_Type").innerHTML=selectString;
			}
		else if (temp =="ʪ��"){
			value="03";
			selectString=selectString+"<option value="+value+">"+temp+"</option>"+"<option value="+'00'+">"+'ͼ��'+"</option>"+"<option value="+'01'+">"+'�¶�'+"</option>"+"<option value="+'02'+">"+'����'+"</option>";
			document.getElementById("Sample_Type").innerHTML=selectString;
			}

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

function deleteSam()
{
	var sid=new Array();
	
	
	var checkb=document.all("beixuan");
	//alert(checkb.length);
	var flag=0;
	var index=0;
	if(typeof(checkb.length)=="undefined")
	{
		sid=document.getElementById("beixuan").value;
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
		    //window.location.reload(); 
	  }
	};
	xmlhttp.open("GET","../servlet/deleteSample?sid="+id+"&t="+new Date().getTime(),true);
	xmlhttp.send();

}
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

	var selectall=document.getElementById("title-checkbox");
	
	reg.onclick = function() 
	{ 
		var checkb=document.all("beixuan");
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
			//document.getElementById("hid").value="update";
			var tb=document.getElementById("listtable");
			index=index+1;
			
			//Substation_ID.value=tb.rows[index].cells[6].innerHTML;
			document.getElementById("Sample_ID").value=tb.rows[index].cells[2].innerHTML;
			document.getElementById("Device_Address").value=tb.rows[index].cells[8].innerHTML;
			document.getElementById("Sample_AddressH").value=tb.rows[index].cells[10].innerHTML;
			document.getElementById("Sample_AddressL").value=tb.rows[index].cells[11].innerHTML;
			document.getElementById("Sample_IndexID").value=tb.rows[index].cells[9].innerHTML;
			document.getElementById("Sample_dataL").value=tb.rows[index].cells[12].innerHTML;
			
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
	//alert(mClose);
	mClose.onclick = function() 
	{ 
		myAlert.style.display = "none"; 
		mybg.style.display = "none"; 
		document.getElementById("Sample_ID").value="";
		document.getElementById("Device_Address").value="";
		document.getElementById("Sample_AddressH").value="";
		document.getElementById("Sample_AddressL").value="";
		document.getElementById("Sample_IndexID").value="";
		document.getElementById("Sample_dataL").value="";
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
	document.getElementById("seceltSubstationID").addEventListener("change", subidchange, false);
	document.getElementById("selectS").addEventListener("click", selectSamples, false);
	//change.addEventListener("click", changeDev, false);
	//deletes.addEventListener("click", deleteDev, false);
	//document.getElementById("hid").value="insert";
}
function selectSamples()
{
	document.getElementById("formsub").action="linkSample.jsp?seceltSubstationID="+document.getElementById("seceltSubstationID").value+"&sampleId="+document.getElementById("sampleId").value+"&sampleName="+document.getElementById("sampleName").value+"&seceltType="+document.getElementById("seceltType").value+"&seceltDeviceID="+document.getElementById("seceltDeviceID").value;
	document.getElementById("formsub").submit();
}
function sure()
{

	var Sample_ID=document.getElementById("Sample_ID");
	var Device_Address=document.getElementById("Device_Address");
	var Sample_AddressH=document.getElementById("Sample_AddressH");
	var Sample_AddressL=document.getElementById("Sample_AddressL");
	var Sample_IndexID=document.getElementById("Sample_IndexID");
	var Sample_dataL=document.getElementById("Sample_dataL");

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
		    	alert("���óɹ���");
		    }
		    else
		    {
		    	alert("����ʧ�ܣ����������ã�");
		    }
		    window.location.href=window.location.href; 
		    window.location.reload;    
	  }
	};
	xmlhttp.open("GET","../servlet/setSample?Sample_ID="+Sample_ID.value+"&Device_Address="+Device_Address.value+"&Sample_AddressH="+Sample_AddressH.value+"&Sample_AddressL="+Sample_AddressL.value+"&Sample_dataL="+Sample_dataL.value+"&Sample_IndexID="+Sample_IndexID.value+"&t="+new Date().getTime(),true);
	xmlhttp.send();
}
function subidchange()
{
	alert("ff");
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
		    alert(result);
		    var selectString="";
		    
			for(var i=0;i<result.length;i++)
			{
				//alert(i);
				var id=result[i].getElementsByTagName("deviceId")[0].childNodes[0].nodeValue;
				var value=result[i].getElementsByTagName("deviceValue")[0].childNodes[0].nodeValue;
				selectString=selectString+"<option value="+id+">"+value+"</option>";
			}
			alert(selectString);
			document.getElementById("seceltDeviceID").innerHTML=selectString;
	  }
	};
	var sid=document.getElementById("seceltSubstationID").options[document.getElementById("seceltSubstationID").selectedIndex].value;
	alert(sid);
	xmlhttp.open("GET","../servlet/getSubDevice?sid="+sid+"&t="+new Date().getTime(),true);
	xmlhttp.send();
}
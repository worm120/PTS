(function()
{
	setTimeout("init()",300);
}());

function init()
{
	//alert("1");
	//var myAlert = document.getElementById("add"); 
	var reg = document.getElementById("adds"); 
	var deletes=document.getElementById("dels");
	document.getElementById("selectS").addEventListener("click", selectSamples, false);
	deletes.addEventListener("click", deleteSam, false);
	reg.addEventListener("click", sure, false);
}

function selectSamples()
{
	document.getElementById("formsub").action="fenxiang.jsp?sid="+document.getElementById("hid_sid").value+"&seceltDeviceID="+document.getElementById("seceltDeviceID").value;
	document.getElementById("formsub").submit();
}

function sure()
{

	var Sample_ID=new Array();
	var index=0;
	var checkb=document.all("beixuan");
	var tb=document.getElementById("listtable");
	var flag=0;
	
	if(typeof(checkb.length)!="undefined")
	{
		//
		for(var i=0;i<checkb.length;i++)
		{
			if(checkb[i].checked==true)
			{
				flag++;
			}
		}
	}
	
	
	if(flag==3)
	{
		for(var i=0;i<checkb.length;i++)
		{
			if(checkb[i].checked==true)
			{
				if(index<3)
				{
					Sample_ID[index]=tb.rows[i+1].cells[2].innerHTML;//alert(Sample_ID[index]);
					index++;
					
				}
			}
		}
	}
	else
	{
		alert("��ÿ��ѡ��3���������Ϊһ�飡");
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
	//alert(Sample_ID.toString());
	if(flag==3)
	{
		xmlhttp.open("GET","../servlet/fenxiang?Sample_ID="+Sample_ID.toString()+"&t="+new Date().getTime(),true);
		xmlhttp.send();
	}
	
}

function deleteSam()
{
	var gid=new Array();
	
	
	var checkb=document.all("fenxiang_beixuan");
	//alert(checkb.length);
	var flag=0;
	var index=0;
	if(typeof(checkb.length)=="undefined")
	{
		gid=document.getElementById("fenxiang_beixuan").value;
	}
	else
	{
		for(var i=0;i<checkb.length;i++)
		{
			//alert(checkb.length);
			if(checkb[i].checked===true)
			{
				gid[index]=checkb[i].value;
				index++;
			}
		}
	}
	
	/*����ѡ�еĴ�ɾ����Id����ת��Ϊ�ַ�ת�ϴ�����������*/
	var id=gid.toString();
	
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
		    window.location.reload(); 
	  }
	};
	xmlhttp.open("GET","../servlet/deleteFenzu?gid="+id+"&t="+new Date().getTime(),true);
	xmlhttp.send();

}
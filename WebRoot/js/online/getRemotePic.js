(function()
{
	setTimeout("init()",400);
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
			alert("��ѡ��һ��ͼ�������������㣡");
		}
		else if(flag>1)
		{
			alert("ÿ��ֻ�ܶ�һ��ͼ����������Զ�����㣡");
		}
		else
		{
			alert("sss");
			//document.getElementById("hid").value="update";
			var tb=document.getElementById("listtable");
			index=index+1;
			
			/*Substation_ID.value=tb.rows[index].cells[6].innerHTML;
			document.getElementById("Sample_ID").value=tb.rows[index].cells[2].innerHTML;
			document.getElementById("Device_Address").value=tb.rows[index].cells[8].innerHTML;
			document.getElementById("Sample_AddressH").value=tb.rows[index].cells[9].innerHTML;
			document.getElementById("Sample_AddressL").value=tb.rows[index].cells[10].innerHTML;
			
			var Sample_ID=document.getElementById("Sample_ID");
			*/
			var Device_Address=tb.rows[index].cells[8].innerHTML;
			var ipText=tb.rows[index].cells[9].innerHTML;
			var portText=tb.rows[index].cells[10].innerHTML;
			var index_id=tb.rows[index].cells[11].innerHTML;
			var Sample_AddressH=tb.rows[index].cells[12].innerHTML;
			var Sample_AddressL=tb.rows[index].cells[13].innerHTML;
			var Sample_dataL=tb.rows[index].cells[14].innerHTML;
			
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
				//���ݷ��ص�ͼ���ļ�����ʾͼ��
				    var result=xmlhttp.responseText;
				    alert(result);
				    if(result!="none")
				    {
				    	//alert("��������ͳɹ������ڽ������ݣ������ĵȴ�����Լ1�ְ��Ӻ���ͼ��Ѳ���пƲ鿴�����ĵ�ͼ�񣡣�");
				    	var interval = setInterval(increment,100);
				    	document.getElementById("wrapper").innerHTML="<div class='load-bar'><div class='load-bar-inner' data-loading='0'> <span id='counter'></span> </div></div><h1>Loading</h1><p>�����ϴ��У����Ժ�...</p>";
				    	var current = 0;
				    	function increment()
				    	{
				    	  current++;
				    	  $('#counter').html(current+'%');
				    	  if(current == 100) 
				    	  {
				    		//current = 0;
				    		clearInterval(interval);
				    		document.getElementById("wrapper").innerHTML="<img src='../liangw/images/photo/"+result+"'>";
				    	  }
				    	}
				    }
				    else
				    {
				    	alert("����ʧ�ܣ����������㣡");
				    }
				    window.location.href=window.location.href; 
				    window.location.reload;    
			  }
			};
			xmlhttp.open("GET","../servlet/remoteGetPic?index_id="+index_id+"&t="+new Date().getTime(),true);
			xmlhttp.send();
			
			
		}
	} ;
	
}


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
		alert("请每次选择3个采样点分为一组！");
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
		//根据返回的设备借点信息关联接线图上的节点
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
	
	/*将被选中的待删除的Id数组转化为字符转上传服务器处理*/
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
		//返回成功删除记录数
		    var result=xmlhttp.responseText;
		    alert("成功删除"+result+"条记录");
	    	window.location.href=window.location.href; 
		    window.location.reload(); 
	  }
	};
	xmlhttp.open("GET","../servlet/deleteFenzu?gid="+id+"&t="+new Date().getTime(),true);
	xmlhttp.send();

}
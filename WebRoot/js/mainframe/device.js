function deviceManage()
{
	var sid=document.getElementById("sid").value;
	if(sid=="none")
	{
		alert("���������ϽǱ����ѡ��˵�����ѡ���������");
	}
	else
	{
		document.getElementById("showcontent").src="device/addDevice.jsp?sid="+sid;
	}
	
}

function sampleManage()
{
	var sid=document.getElementById("sid").value;
	if(sid=="none")
	{
		alert("���������ϽǱ����ѡ��˵�����ѡ���������");
	}
	else
	{
		document.getElementById("showcontent").src="device/addSample.jsp?sid="+sid;
	}
	
}

function fenxiang()
{
	var sid=document.getElementById("sid").value;
	if(sid=="none")
	{
		alert("���������ϽǱ����ѡ��˵�����ѡ���������");
	}
	else
	{
		document.getElementById("showcontent").src="device/fenxiang.jsp?sid="+sid;
	}
	
}

function refresh()
{
	deviceManage();
}

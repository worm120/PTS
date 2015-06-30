function deviceManage()
{
	var sid=document.getElementById("sid").value;
	if(sid=="none")
	{
		alert("请先在左上角变电所选择菜单项中选定变电所！");
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
		alert("请先在左上角变电所选择菜单项中选定变电所！");
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
		alert("请先在左上角变电所选择菜单项中选定变电所！");
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

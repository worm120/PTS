function show(type)
{
	var sid=document.getElementById("sid").value;
	switch(type)
    {
        case "jiben":
		        	if(sid=="none")
			    	{
			    		alert("���������ϽǱ����ѡ��˵�����ѡ���������");
			    	}
			    	else
			    	{
			    		document.getElementById("showcontent").src='liangw/sysManage/basicPara.jsp?sid='+sid;
			    	}
		        	break;
        case "baojing":
		        	if(sid=="none")
			    	{
			    		alert("���������ϽǱ����ѡ��˵�����ѡ���������");
			    	}
			    	else
			    	{
			    		document.getElementById("showcontent").src='liangw/sysManage/alarmSet.jsp?sid='+sid;
			    	}
		        	break;
    }
}
function refresh()
{
	show("jiben");
}

function show(type)
{
	var sid=document.getElementById("sid").value;
    switch(type)
    {
        case "baojing":if(sid=="none")
				    	{
				    		alert("���������ϽǱ����ѡ��˵�����ѡ���������");
				    	}
				    	else
				    	{
				    		document.getElementById("showcontent").src='SPC/log/alarmlog.jsp?sid='+sid;
				    	}
        				break;
        case "caozuo":if(sid=="none")
				    	{
				    		alert("���������ϽǱ����ѡ��˵�����ѡ���������");
				    	}
				    	else
				    	{
				    		document.getElementById("showcontent").src='SPC/log/operationlog.jsp?sid='+sid;
				    	}
        				break;
     	case "alarm":if(sid=="none")
			    	{
			    		alert("���������ϽǱ����ѡ��˵�����ѡ���������");
			    	}
			    	else
			    	{
			    		document.getElementById("showcontent").src='SPC/datastatistic/datas.jsp?sid='+sid;
			    	}
     				break;
     	case "del":if(sid=="none")
			    	{
			    		alert("���������ϽǱ����ѡ��˵�����ѡ���������");
			    	}
			    	else
			    	{
			    		document.getElementById("showcontent").src='SPC/log/dellog.jsp?sid='+sid;
			    	}
     				break;
     }
}
function refresh()
{
	show(baojing);
}
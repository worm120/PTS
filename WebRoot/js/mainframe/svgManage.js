function show(type)
{
	var sid=document.getElementById("sid").value;
    switch(type)
    {
        case "linkSub":
			        	if(sid=="none")
				    	{
				    		alert("���������ϽǱ����ѡ��˵�����ѡ���������");
				    	}
				    	else
				    	{
				    		document.getElementById("showcontent").src='linkMap/linkMapS.jsp?sid='+sid;
				    	}
        				break;
        case "linkDevNode":
				        	if(sid=="none")
					    	{
					    		alert("���������ϽǱ����ѡ��˵�����ѡ���������");
					    	}
					    	else
					    	{
					    		document.getElementById("showcontent").src='linkMap/linkDevice.jsp?sid='+sid;
					    	}
        					break;
     	case "linkDevMap":
				     		if(sid=="none")
					    	{
					    		alert("���������ϽǱ����ѡ��˵�����ѡ���������");
					    	}
					    	else
					    	{
					    		document.getElementById("showcontent").src='testContent.html?sid='+sid;
					    	}
				     		break;
     	case "Mapedit":
			     		if(sid=="none")
				    	{
				    		alert("���������ϽǱ����ѡ��˵�����ѡ���������");
				    	}
				    	else
				    	{
				    		//document.getElementById("showcontent").src='svgEdit/svg-editor.html?sid='+sid;
				    		//var sid=document.getElementById("sid").value;
				    	    window.open ('svgEdit/svg-editor.html?sid='+sid,'svgEdit','fullscreen=yes,height=500,width=1000,top=30px,left=30px,scrollbars=yes,resizable=yes');
				    	}
			     		break;
     	case "delDevMap":
     		if(sid=="none")
	    	{
	    		alert("���������ϽǱ����ѡ��˵�����ѡ���������");
	    	}
	    	else
	    	{
	    		document.getElementById("showcontent").src='linkMap/deleteSVG.jsp?sid='+sid;
	    	}
     		break;
     }
}
function refresh()
{
	show("linkSub");
}
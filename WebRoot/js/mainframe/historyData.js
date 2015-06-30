
function show(type)
{
	var sid=document.getElementById("sid").value;
    switch(type)
    {
        case "look":if(sid=="none")
			    	{
			    		alert("请先在左上角变电所选择菜单项中选定变电所！");
			    	}
			    	else
			    	{
			    		document.getElementById("showcontent").src='SPC/history/history.jsp?sid='+sid;
			    	}
        			break;
        case "delete":
        			if(sid=="none")
			    	{
			    		alert("请先在左上角变电所选择菜单项中选定变电所！");
			    	}
			    	else
			    	{
			    		document.getElementById("showcontent").src='SPC/history/delhistory.jsp?sid='+sid;
			    	}
        			break;
    }
}
function refresh()
{
	show(look);
}
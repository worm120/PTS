
function show(type)
{
    var sid=document.getElementById("sid").value;
    switch(type)
    {
        case "deviceInterface":if(sid=="none")
						    	{
						    		alert("请先在左上角变电所选择菜单项中选定变电所！");
						    	}
						    	else
						    	{
						    		document.getElementById("showcontent").src='interface/linkDevice.jsp?sid='+sid;
						    	}
								break;
        case "sampleInterface":if(sid=="none")
						    	{
						    		alert("请先在左上角变电所选择菜单项中选定变电所！");
						    	}
						    	else
						    	{
						    		document.getElementById("showcontent").src='interface/linkSample.jsp?sid='+sid;
						    	}break;
        case "paraInterface":if(sid=="none")
						    	{
						    		alert("请先在左上角变电所选择菜单项中选定变电所！");
						    	}
						    	else
						    	{
						    		document.getElementById("showcontent").src='interface/setInterface.jsp?sid='+sid;
						    	}break;
    }
}
function refresh()
{
	show("deviceInterface");
}
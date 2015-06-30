function show(type)
{
	//var sid=document.getElementById("sid").value;
	switch(type)
    {
		/*
        case "add":document.getElementById("showcontent").src='liangw/userManage/addUser.jsp?sid='+sid;break;
        case "delete":document.getElementById("showcontent").src='liangw/userManage/deleteUser.jsp?sid='+sid;break;
        case "fenpei":document.getElementById("showcontent").src='liangw/userManage/rightAllo.jsp?sid='+sid;break;
        case "person":document.getElementById("showcontent").src='liangw/userManage/selfInfo.jsp?sid='+sid;break;
        */
	    case "add":document.getElementById("showcontent").src='liangw/userManage/addUser.jsp';break;
	    case "delete":document.getElementById("showcontent").src='liangw/userManage/deleteUser.jsp';break;
	    case "fenpei":document.getElementById("showcontent").src='liangw/userManage/rightAllo.jsp';break;
	    case "person":document.getElementById("showcontent").src='liangw/userManage/selfInfo.jsp';break;
    };
}
function refresh()
{
	show("add");
}

function interface()
{
	var sid=document.getElementById("sid").value;
    window.open ('interfaceSet.jsp?sid='+sid,'interfaceSet','height=500,width=1300,top=30px,left=30px,scrollbars=yes,resizable=yes');
	
}
function system()
{
	var sid=document.getElementById("sid").value;
    window.open ('systemSet.jsp?sid='+sid,'systemSet','height=500,width=1300,top=30px,left=30px,scrollbars=yes,resizable=yes');
}
function online()
{
	
	var sid=document.getElementById("sid").value;
    window.open ('online.jsp?sid='+sid,'online','height=bodyHeight,width=bodyWidth,top=30px,left=30px,scrollbars=yes,resizable=yes');
}
function map()
{
	var sid=document.getElementById("sid").value;
    window.open ('svgManage.jsp?sid='+sid,'svgManage','height=500,width=1300,top=30px,left=30px,scrollbars=yes,resizable=yes');
}
function user()
{
	var sid=document.getElementById("sid").value;
    window.open ('userSet.jsp?sid='+sid,'userSet','height=500,width=1300,top=30px,left=30px,scrollbars=yes,resizable=yes');
}
function logs()
{
	var sid=document.getElementById("sid").value;
    window.open ('logs.jsp?sid='+sid,'logs','height=500,width=1300,top=30px,left=30px,scrollbars=yes,resizable=yes');
}
function device()
{
	var sid=document.getElementById("sid").value;
    window.open ('device.jsp?sid='+sid,'device','height=500,width=1300,top=30px,left=30px,scrollbars=yes,resizable=yes');
}
function history()
{
	var sid=document.getElementById("sid").value;
    window.open ('historyData.jsp?sid='+sid,'historyData','height=500,width=1300,top=30px,left=30px,scrollbars=yes,resizable=yes');
}
function refresh()
{
	var sid=document.getElementById("sid").value;
	document.getElementById("showcontent").src='temperature/lookOnlineTemperature.jsp?sid='+sid;
}




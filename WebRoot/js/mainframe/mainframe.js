var isIE11 = (navigator.userAgent.toLowerCase().indexOf("trident") > -1 && navigator.userAgent.indexOf("rv") > -1);//����Ƿ���ie11
var isFirefox=(navigator.userAgent.toLowerCase().indexOf("firefox") > -1);//����Ƿ���firefox
if(!isIE11&&!isFirefox)
{
	alert("�𾴵��û�������ǰ���������IE11��Firefox,����ʹ����������������ﵽϵͳ����������飡");
}
function showmenu(id)
{

	if(document.getElementById(id).style.display=="block")
	{
		document.getElementById(id).style.display="none";
	}
	else
	{
		document.getElementById(id).style.display="block";
	}
}
function changeSub(sid)
{
	//alert(sid);
	//document.getElementById("sub_name").value=sid.substring(3);
	document.getElementById("sub_name").innerHTML=sid.substring(3);
	document.getElementById("sid").value=sid.substring(0,3);
	document.getElementById("usermenu").style.display="none";
	refresh();
}
function showAllScreen()
{
	//document.getElementById("main-top").style.display="none";
	//document.getElementById("main-bottom").style.top="0px";
	document.getElementById("closeAll").style.display="block";
	fullScreen();
}
function closeAllScreen()
{
	document.getElementById("main-top").style.display="block";
	document.getElementById("main-bottom").style.top="90px";
	document.getElementById("closeAll").style.display="none";
	exitFullScreen();
}
function logout()
{
	window.close();
    //window.location.href="index.jsp";
}
function fullScreen() {
	 var el = document.documentElement;
	  var rfs = el.requestFullScreen || el.webkitRequestFullScreen || 
	      el.mozRequestFullScreen || el.msRequestFullScreen;
	  if(typeof rfs != "undefined" && rfs) {
	    rfs.call(el);
	  } else if(window.ActiveXObject!= "undefined") {
	    //for IE��������ʵ����ģ���˰��¼��̵�F11��ʹ�����ȫ��
	    var wscript = new ActiveXObject("WScript.Shell");
	    if(wscript != null) {
	        wscript.SendKeys("{F11}");
	    }
	  }
	}
function exitFullScreen() {
  var el = document;
  var cfs = el.cancelFullScreen || el.webkitCancelFullScreen || 
      el.mozCancelFullScreen || el.exitFullScreen;
  if(typeof cfs != "undefined" && cfs) {
    cfs.call(el);
  } else if(window.ActiveXObject != "undefined") {
    //for IE�������fullScreen��ͬ��ģ�ⰴ��F11���˳�ȫ��
    var wscript = new ActiveXObject("WScript.Shell");
    if(wscript != null) {
        wscript.SendKeys("{F11}");
    }
  }
}



<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.spi.DirStateFactory.Result"%>
<%@ page contentType="text/html;charset=gbk" language="java" import="java.util.*" import="com.action.dataselect"  pageEncoding="gbk"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>大成DSEP-2000电力图像智能与温湿度安全监测系统</title>
        <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
        <meta http-equiv="pragma" content="no-cache">
	        <style type="text/css">
			*{box-sizing: border-box;}
			html{height: 100%;}
			body{background: #efeeea;background: linear-gradient(#f9f9f9, #cecbc4);background: -moz-linear-gradient(#f9f9f9, #cecbc4);background: -webkit-linear-gradient(#f9f9f9, #cecbc4);background: -o-linear-gradient(#f9f9f9, #cecbc4);color: #757575;font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif;text-align: center;}
			h1, p{padding:0; margin:0;}
			.wrapper{width: 350px;margin: 200px auto;}
			.wrapper p a{color:#757575; text-decoration:none;}
			.wrapper .load-bar{width: 100%;height: 25px;border-radius: 30px;background: #dcdbd7;position: relative;box-shadow: 0 1px 0 rgba(255, 255, 255, 0.8), inset 0 2px 3px rgba(0, 0, 0, 0.2);}
			.wrapper .load-bar:hover .load-bar-inner, .wrapper .load-bar:hover #counter{animation-play-state: paused;-moz-animation-play-state: paused;-o-animation-play-state: paused;-webkit-animation-play-state: paused;}
			.wrapper .load-bar-inner{height: 99%;width: 0%;border-radius: inherit;position: relative;background: #c2d7ac;background: linear-gradient(#e0f6c8, #98ad84);background: -moz-linear-gradient(#e0f6c8, #98ad84);background: -webkit-linear-gradient(#e0f6c8, #98ad84);background: -o-linear-gradient(#e0f6c8, #98ad84);box-shadow: inset 0 1px 0 rgba(255, 255, 255, 1), 0 1px 5px rgba(0, 0, 0, 0.3), 0 4px 5px rgba(0, 0, 0, 0.3);animation: loader 10s linear infinite;-moz-animation: loader 10s linear infinite;-webkit-animation: loader 10s linear infinite;-o-animation: loader 10s linear infinite;}
			.wrapper #counter{position: absolute;background: #eeeff3;background: linear-gradient(#eeeff3, #cbcbd3);background: -moz-linear-gradient(#eeeff3, #cbcbd3);background: -webkit-linear-gradient(#eeeff3, #cbcbd3);background: -o-linear-gradient(#eeeff3, #cbcbd3);padding: 5px 10px;border-radius: 0.4em;box-shadow: inset 0 1px 0 rgba(255, 255, 255, 1), 0 2px 4px 1px rgba(0, 0, 0, 0.2), 0 1px 3px 1px rgba(0, 0, 0, 0.1);left: -25px;top: -50px;font-size: 12px;font-weight: bold;width: 44px;animation: counter 10s linear infinite;-moz-animation: counter 10s linear infinite;-webkit-animation: counter 10s linear infinite;-o-animation: counter 10s linear infinite;}
			.wrapper #counter:after{content: "";position: absolute;width: 8px;height: 8px;background: #cbcbd3;transform: rotate(45deg);-moz-transform: rotate(45deg);-webkit-transform: rotate(45deg);-o-transform: rotate(45deg);left: 50%;margin-left: -4px;bottom: -4px;box-shadow: 3px 3px 4px rgba(0, 0, 0, 0.2), 1px 1px 1px 1px rgba(0, 0, 0, 0.1);border-radius: 0 0 3px 0;}
			.wrapper h1{font-size: 28px;padding: 20px 0 8px 0;}
			.wrapper p{font-size: 13px;} @keyframes loader{from{width: 0%;}
			to{width: 100%;}
			} @-moz-keyframes loader{from{width: 0%;}
			to{width: 100%;}
			} @-webkit-keyframes loader{from{width: 0%;}
			to{width: 100%;}
			} @-o-keyframes loader{from{width: 0%;}
			to{width: 100%;}
			} @keyframes counter{from{left: -25px;}
			to{left: 323px;}
			} @-moz-keyframes counter{from{left: -25px;}
			to{left: 323px;}
			} @-webkit-keyframes counter{from{left: -25px;}
			to{left: 323px;}
			} @-o-keyframes counter{from{left: -25px;}
			to{left: 323px;}
			}
			.title {background-color:rgba(0,0,0,0.56); text-align:center; width:100%; position:fixed; top:0; left:0; padding:5px 0;}
			.title a {color:#FFF; text-decoration:none; font-size:16px; font-weight:bolder; line-height:24px;}
			</style>
			
			<script src="../js/jquery-1.5.1.min.js" type="text/javascript"></script>
		<script type="text/javascript">
			<%
				//System.out.println(request.getParameter("index_id"));
				out.print("var index_id='"+request.getParameter("index_id")+"';");
			%>

			var imgpath="none";//要显示的图像文件名
			var xmlhttp;
			if (window.XMLHttpRequest)
			{
			  xmlhttp=new XMLHttpRequest();
			}
			else
			{
			  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange=function()
			{
			  if (xmlhttp.readyState==4 && xmlhttp.status==200)
			  {
					//根据返回的图像文件名显示图像
				    var result=xmlhttp.responseText;
				    //alert(result);
				    if(result!="none")
				    {
				    	//alert("拍摄命令发送成功，正在接收数据，请耐心等待，大约1分半钟后，在图像巡检中科查看到刚拍的图像！！");
						imgpath=result;
				    }
				    else
				    {
				    	//alert("操作失败，请重新拍摄！");
				    }
				    //window.location.href=window.location.href; 
				    //window.location.reload;    
			  }
			};
			//alert(index_id);
			xmlhttp.open("GET","../servlet/remoteGetPic?index_id="+index_id+"&t="+new Date().getTime(),true);
			xmlhttp.send();
			
			
			$(function(){
			interval = setInterval(increment,40);
			var current = 0;
			function increment()
			{
			  current++;
			  $('#counter').html(current+'%');
			  if(current == 100) 
			  {
				//current = 0;
				clearInterval(interval);
				if(imgpath=="none")
				{
					document.getElementById("wrapper").innerHTML="抓拍失败，请重试！";
				}
				else
				{
					document.getElementById("wrapper").innerHTML="<img width='400px' height='300px' src='../liangw/images/photo/"+imgpath+"'>";
				}
			  }
			}
			});
		</script>
    </head>
    <body>
    
     <div class="title"><a>远程抓拍图像</a></div>
	<div class="wrapper" id="wrapper">
	  <div class="load-bar">
	    <div class="load-bar-inner" data-loading="0"> <span id="counter"></span> </div>
	  </div>
	  <h1>Loading</h1>
	  <p>数据上传中，请稍候...</p>
	</div>
    </body>
</html>


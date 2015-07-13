<%@ page language="java" import="com.action.*" import="java.util.*" pageEncoding="gbk"%>
<%@page import="java.sql.ResultSet"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>大成DSEP-2000电力图像智能与温湿度安全监测系统</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css"><link href="../css/beijing.css" type="text/css" rel="Stylesheet"/>
	-->
	<script type="text/javascript" src="../js/online/showTemperature.js" charset="gbk"></script>
	<style type="text/css">
		body{ overflow: auto;margin:0px;padding:0px font-size: 12px;}
		.box{width:100%; height: 100%;overflow: auto; background-color:  #fff;position: relative; margin-left:auto; margin-right:auto; }
		#menu{width:150px;  background-color: #e2ecf5; font-size: 12px;}
		#node{width:100%; height: 22px; line-height: 22px; text-align:left;padding-left: 10px;  background-color: #4523ff;border-bottom:1px solid #686868; color: #ffffff;}
		#close{position:absolute;top:0;right:0px; font-size: 10px; line-height: 20px;cursor: pointer; color:#ff0000;}
		.samlist{ width: 100%; height: 20px; line-height: 20px; float: left; text-align: left; padding-left: 10px; margin: 1px 0px;border-bottom:1px solid #adadac;}
		.linkmenu{ text-decoration: none;}
		.linkmenu:hover{ color: #494949;}
		
		#alarmMenu{ width:200px; height: 95%; overflow: auto;background-color:rgba(36,36,36,0.5);  z-index: 100;  position: absolute;top:2px;right:10px;font-size: 12px;}
		.alarm-head{ text-align: center; width: 100%; line-height: 20px; color: #D3FF93; font-size: 15px; font-weight: bold; background-color:#585858; opacity:0.6;}
		.alarm-record{ color: #acacac; line-height: 20px; margin: 0px; padding:1px 2px; border-bottom:1px solid #797979; }
		.alarm-record-content{margin-left:2px;padding:1px 2px; color: #acacac; line-height: 20px; }
		.xiaoshou{ cursor:  pointer; color:#dd3355;}
		#show-alarmMenu{ width: 10px; height: 60px; background-color: transparent;  margin-top:-30px; position:absolute; top: 50%; right:10px; z-index: 300;opacity:0.6; cursor: pointer; }
		#leadMenu{ height: 50px; width: auto; min-width: 300px; max-width:700px; position: absolute;background-color:rgba(36,36,36,0.5);  z-index: 101;top:1px;left:1px;font-size: 12px;overflow: auto;}
		.subnode{width: 40px; height:50px; float: left; position: relative; margin: 0 3px; padding: 0; cursor: pointer;}
		.subicon{width: 40px; height:40px; float: left; position: relative; margin: 0; padding: 0;cursor: pointer; }
		.subname{width: 40px; height:10px; float: left; position: relative; margin: 0; padding: 0;cursor: pointer; color:#ffffff; font-size:10px; overflow: hidden; }
		.select{line-height: 30px;float: left;border: 1px solid #ddd;position: absolute;display: inline-block;top:1px;}
		.selectname{line-height: 30px;margin:0 5px;float: left;}
		.selectCon{line-height: 30px;float: left; padding:6px 0;}
		.selectInput{width:100px;}
		.huanjing{width:130px; height: 100px; overflow: auto;background-color:rgba(36,36,36,0.5);  z-index: 100;  position: fixed;top:2px;right:1px;font-size: 12px;color:#FFFFFF;}
		.nei{margin-left:10px;}
		
		ul {
		 margin: 0;
		 padding: 0;
		 list-style: none;
		 width: 150px;
		 border-bottom: 1px solid #adadac;
		 z-index: 500;
		 }
		 ul li {
		 position: relative;
		 }
		li ul {
		 position: absolute;
		 top: 0;
		 display: none;
		 }
		 
		 ul li a {
		 display: block;
		 text-decoration: none;
		 color: #777;
		 background: #e2ece5;
		 padding: 5px;
		 border: 1px solid #adadac;
		 border-bottom: 0;
		 }
		 ul li a:hover 
		 {
			 color: #494949;
		 }
		li:hover ul { display: block; }
	</style>
  </head>
  <%
  		dataselect ds=new dataselect();
  		String sql="select * from SubMap where Substation_ID='"+request.getParameter("sid").toString()+"'";
  		String svgpath="";
  		ResultSet rs=ds.select(sql);
  		if(rs!=null)
  		{
  			while(rs.next())
  			{
  				svgpath=rs.getString("Map_Name");
  			}
  		}
  		ds.close();
  	%>
  <body>	
	<!--<div id="boxx" class="box" ></div> align="center" -->
	
	<!-- 引入svg图片 -->
	<object style="position:relative;background-color:#000;" hspace="0" vspace="0" width="1000px" height="600px"  id="emSvg" type="image/svg+xml" data="../svg/<%=svgpath %>"></object>
	
	<ul id="menu" style="display:none;"> 
	  
	  <li id="teminfo"><a href="#">温度信息</a><div id="close" style="">关闭</div> 
	    <ul id="m1" > 
	      <li><a href="#" id="currentTemp">当前温度数据</a></li> 
	      <!-- <li ><a href="#" id="Tempchart">实时温度数据走势图</a></li>  -->
	      <li style="display:none;"><a href="#" id="historyTemp">历史温度数据 </a></li> 
	      <li><a href="#" id="alarmLogTem">温度报警记录 </a></li>
	    </ul> 
	  </li> 
	  <li id="huminfo"><a href="#">湿度信息</a> 
	    <ul id="m2" > 
	      <li><a href="#" id="currentHum">当前湿度数据</a></li> 
	      <li style="display:none;"><a href="#" id="historyHum">历史湿度数据 </a></li> 
	      <li><a href="#" id="alarmLogHum">湿度报警记录 </a></li>
	    </ul> 
	  </li> 
	  <li id="picinfo"><a href="#">图像信息</a> 
	    <ul id="m3" > 
	      
<!-- 	      <li style="display:none;"><a href="#" id="picSet">查看设置</a></li>  -->
	       
<!-- 	      <li  style="display:none;"><a href="#" id="setAlarm">选区设置</a></li> -->
	      
<!-- 	      <li style="display:none;"><a href="#" id="picCmp">分析结果</a></li> -->
	      <li><a href="#" id="dataManage">图片管理</a></li>
<!-- 	      <li style="display:none;"><a href="#" id="alarmDeal">报警处理</a></li>  -->
	      <li><a href="#" id="getRemotePic">抓拍</a></li> 
	    </ul> 
	  </li> 
	  <li id="arcinfo"><a href="#">弧光信息</a> 
	    <ul id="m4" > 
	      <li><a href="#" id="recentHu">最近弧光</a></li>
<!-- 	      <li style="display:none;"><a href="#" id="qianghu">强弧</a></li>  -->
<!-- 	      <li style="display:none;"><a href="#" id="ruohu">弱弧</a></li>  -->
<!--       <li style="display:none;"><a href="#" id="huguang">历史记录</a></li>  -->
	    </ul> 
	  </li> 
	  <!-- <li><a href="#" id="canshuSet">参数设置</a>  -->
	  </li> 
<!-- 	  <li style="display:none;"><a href="#" id="alarmTong">报警数据分析</a>  -->
<!-- 	  </li> -->
<!-- 	   <li style="display:none;"><a href="#" id="health">健康状况评估</a>  -->
<!-- 	  </li> -->
	  <li id="devinfo"><a href="#" id="nodeinfo">开关柜信息</a></li> 
	</ul>
	<!-- 显示环境温、湿度 -->
	<div class="huanjing" style="display:none;">
		<p class="nei">环境温度：<font id="TemValueH" color="red" size="5">26</font>℃</p>
		<p class="nei">环境湿度：<font id="HumidityValueH" color="red" size="5">65</font>RH</p>
	</div> 
	 
	<div style="display:none;">
		<input id="NodeId" type="hidden">
		<input id="Substation_ID" type="hidden" value="<%=request.getParameter("sid").toString()%>">
	</div>
	<div style="position:fixed;z-index: 100;right:1px;bottom:0px;">
		<button type="button" onclick="big();">放大 +</button>
    	<button type="button" onclick="small();">缩小 -</button>
	</div>
	<bgsound name="sound_IE" id="sound_IE"  src="" /><!--IE11支持-->
	<!-- <object  name="sound" id="sound" data="../alarm/1.mp3" type="audio/x-wav"></object> -->
	<audio name="sound_FF" id="sound_FF"  src="" type="audio/wav" autoplay="autoplay"></audio><!--非IE11支持-->
	<script type="text/javascript">
		/*
		function isIE() 
		{ //ie?
		    if (!!window.ActiveXObject || "ActiveXObject" in window)
		        return true;
		    else
		        return false;
		}
		alert(isIE());
		*/
		//var isIE11 = (navigator.userAgent.toLowerCase().indexOf("trident") > -1 && navigator.userAgent.indexOf("rv") > -1);//检测是否是ie11

		//alert(navigator.userAgent.toLowerCase().match("rv:(\\d+\\.\\d+)")[1]);//ie的版本号
		//自动获取比例大小
		//var Swidth=document.body.clientWidth;
		//var Sheight=document.body.clientHeight-90;

		var Swidth=document.body.clientWidth;
		var Sheight=document.body.clientHeight+40;		
		var svgBox=document.getElementById('emSvg');
		svgBox.setAttribute("width",Swidth);
	    svgBox.setAttribute("height",Sheight);
	
		function big()
	    {
	    	var box = document.getElementById('emSvg'); 
	    	var boxwidth=box.getAttribute("width")*1.2;
	    	var boxheight=box.getAttribute("height")*1.2;
	    	
	    	box.setAttribute("width",boxwidth);
	    	box.setAttribute("height",boxheight);
	    }
	    function small()
	    {
	    	var box = document.getElementById('emSvg'); 
	    	var boxwidth=box.getAttribute("width")/1.2;
	    	var boxheight=box.getAttribute("height")/1.2;
	    	
	    	box.setAttribute("width",boxwidth);
	    	box.setAttribute("height",boxheight);
	    }
		/*var rDrag = {
			
			o:null,
			
			init:function(o){
				o.onmousedown = this.start;
			},
			start:function(e){
				var o;
				e = rDrag.fixEvent(e);
		        e.preventDefault && e.preventDefault();
		        rDrag.o = o = this;
				o.x = e.clientX - rDrag.o.offsetLeft;
		        o.y = e.clientY - rDrag.o.offsetTop;
				document.onmousemove = rDrag.move;
				document.onmouseup = rDrag.end;
			},
			move:function(e){
				e = rDrag.fixEvent(e);
				var oLeft,oTop;
				oLeft = e.clientX - rDrag.o.x;
				oTop = e.clientY - rDrag.o.y;
				rDrag.o.style.left = oLeft + 'px';
				rDrag.o.style.top = oTop + 'px';
			},
			end:function(e){
				e = rDrag.fixEvent(e);
				rDrag.o = document.onmousemove = document.onmouseup = null;
			},
		    fixEvent: function(e){
		        if (!e) {
		            e = window.event;
		            e.target = e.srcElement;
		            e.layerX = e.offsetX;
		            e.layerY = e.offsetY;
		        }
		        return e;
		    }
		};*/
		window.onload = function(){
		    var obj = document.getElementById('menu');
			//rDrag.init(obj);
			init();
		};
	</script>
  </body>
</html>

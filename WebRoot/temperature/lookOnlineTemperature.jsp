<%@ page language="java" import="com.action.*" import="java.util.*" pageEncoding="gbk"%>
<%@page import="java.sql.ResultSet"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>���DSEP-2000����ͼ����������ʪ�Ȱ�ȫ���ϵͳ</title>
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
	
	<!-- ����svgͼƬ -->
	<object style="position:relative;background-color:#000;" hspace="0" vspace="0" width="1000px" height="600px"  id="emSvg" type="image/svg+xml" data="../svg/<%=svgpath %>"></object>
	
	<ul id="menu" style="display:none;"> 
	  
	  <li id="teminfo"><a href="#">�¶���Ϣ</a><div id="close" style="">�ر�</div> 
	    <ul id="m1" > 
	      <li><a href="#" id="currentTemp">��ǰ�¶�����</a></li> 
	      <!-- <li ><a href="#" id="Tempchart">ʵʱ�¶���������ͼ</a></li>  -->
	      <li style="display:none;"><a href="#" id="historyTemp">��ʷ�¶����� </a></li> 
	      <li><a href="#" id="alarmLogTem">�¶ȱ�����¼ </a></li>
	    </ul> 
	  </li> 
	  <li id="huminfo"><a href="#">ʪ����Ϣ</a> 
	    <ul id="m2" > 
	      <li><a href="#" id="currentHum">��ǰʪ������</a></li> 
	      <li style="display:none;"><a href="#" id="historyHum">��ʷʪ������ </a></li> 
	      <li><a href="#" id="alarmLogHum">ʪ�ȱ�����¼ </a></li>
	    </ul> 
	  </li> 
	  <li id="picinfo"><a href="#">ͼ����Ϣ</a> 
	    <ul id="m3" > 
	      
<!-- 	      <li style="display:none;"><a href="#" id="picSet">�鿴����</a></li>  -->
	       
<!-- 	      <li  style="display:none;"><a href="#" id="setAlarm">ѡ������</a></li> -->
	      
<!-- 	      <li style="display:none;"><a href="#" id="picCmp">�������</a></li> -->
	      <li><a href="#" id="dataManage">ͼƬ����</a></li>
<!-- 	      <li style="display:none;"><a href="#" id="alarmDeal">��������</a></li>  -->
	      <li><a href="#" id="getRemotePic">ץ��</a></li> 
	    </ul> 
	  </li> 
	  <li id="arcinfo"><a href="#">������Ϣ</a> 
	    <ul id="m4" > 
	      <li><a href="#" id="recentHu">�������</a></li>
<!-- 	      <li style="display:none;"><a href="#" id="qianghu">ǿ��</a></li>  -->
<!-- 	      <li style="display:none;"><a href="#" id="ruohu">����</a></li>  -->
<!--       <li style="display:none;"><a href="#" id="huguang">��ʷ��¼</a></li>  -->
	    </ul> 
	  </li> 
	  <!-- <li><a href="#" id="canshuSet">��������</a>  -->
	  </li> 
<!-- 	  <li style="display:none;"><a href="#" id="alarmTong">�������ݷ���</a>  -->
<!-- 	  </li> -->
<!-- 	   <li style="display:none;"><a href="#" id="health">����״������</a>  -->
<!-- 	  </li> -->
	  <li id="devinfo"><a href="#" id="nodeinfo">���ع���Ϣ</a></li> 
	</ul>
	<!-- ��ʾ�����¡�ʪ�� -->
	<div class="huanjing" style="display:none;">
		<p class="nei">�����¶ȣ�<font id="TemValueH" color="red" size="5">26</font>��</p>
		<p class="nei">����ʪ�ȣ�<font id="HumidityValueH" color="red" size="5">65</font>RH</p>
	</div> 
	 
	<div style="display:none;">
		<input id="NodeId" type="hidden">
		<input id="Substation_ID" type="hidden" value="<%=request.getParameter("sid").toString()%>">
	</div>
	<div style="position:fixed;z-index: 100;right:1px;bottom:0px;">
		<button type="button" onclick="big();">�Ŵ� +</button>
    	<button type="button" onclick="small();">��С -</button>
	</div>
	<bgsound name="sound_IE" id="sound_IE"  src="" /><!--IE11֧��-->
	<!-- <object  name="sound" id="sound" data="../alarm/1.mp3" type="audio/x-wav"></object> -->
	<audio name="sound_FF" id="sound_FF"  src="" type="audio/wav" autoplay="autoplay"></audio><!--��IE11֧��-->
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
		//var isIE11 = (navigator.userAgent.toLowerCase().indexOf("trident") > -1 && navigator.userAgent.indexOf("rv") > -1);//����Ƿ���ie11

		//alert(navigator.userAgent.toLowerCase().match("rv:(\\d+\\.\\d+)")[1]);//ie�İ汾��
		//�Զ���ȡ������С
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

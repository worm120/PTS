<%@page import="java.sql.ResultSet"%>
<%@ page language="java" import="com.action.*" import="java.util.*" pageEncoding="gbk"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>大成DSEP-2000电力图像智能与温湿度安全监测系统</title>
    <meta http-equiv="Content-Type" content="text/html charset=gbk">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link href="../css/beijing.css" type="text/css" rel="Stylesheet"/>
	<script type="text/javascript" src="../js/link/data_link.js" charset="utf-8" ></script>
	<style type="text/css">
		body{ overflow: auto;margin:0px;}
		.box{width:100%; height: 100%;overflow: auto; background-color:  #fff; }
		#menu{ width: 200px; height: 240px; overflow: hidden; background-color: #e2ecf5; font-size: 12px;}
		#node{width:100%; height: 22px; line-height: 22px; text-align:left;padding-left: 10px;  background-color: #4523ff;border-bottom:1px solid #686868; color: #ffffff;}
		#linkedNode{width:100%; height: 20px;line-height:20px; border-bottom:1px solid #686868;padding-left: 10px;}
		#devicelist{width:100%; height: 20px;line-height:20px; border-bottom:1px solid #686868;padding-left: 10px;}
		#samplelist{width:100%; height: 150px; overflow-y:auto;border-bottom:1px solid #686868;}
		#close{position:absolute;top:0;right:0px; font-size: 10px; line-height: 20px;cursor: pointer; color:#ff0000;}
		.samlist{ width: 100%; height: 20px; line-height: 20px; float: left; text-align: left; padding-left: 10px; margin: 1px 0px;}
		.sub{width: 100%; height:auto; line-height:auto; float: left; text-align: center; padding: 0px; margin: 0px;}
		.pleft{padding-left: 10px;}
		.sbutton{ font-size: 12px; margin: 0px 5px; height:auto; width: 70px; cursor: pointer;}
	</style>
  </head>
  
  <body>
  	<%
  		dataselect ds=new dataselect();
  		String svgpath="";
  		if(request.getParameter("sid")==null)
  		{
  		
  		}
  		else
  		{	
  			String sql="select * from SubMap where Substation_ID='"+request.getParameter("sid").toString()+"'";
  			//String sql="select * from SubMap where Sample_Device_Substation='S001'";
	  		//System.out.print(sql);
	  		
	  		ResultSet rs=ds.select(sql);
	  		if(rs!=null)
	  		{
	  			while(rs.next())
	  			{
	  				svgpath=rs.getString("Map_Name");
	  			}
	  		}
	  		rs.close();
	  		ds.close();												
  		}
  		
  	
  	%>
    <!--<img src="some.jpg" alt="alternative image" /> <embed id="emSvg" style="width: 800px; height: 500px;; overflow: auto; background: transparent;"  src="../svg/<%=svgpath %>" wmode="transparent"/> -->  
	
	
	<!-- <div class="box"></div> 
		<object id="emSvg" style="position:relative;background-color:#fff;" width="1000px" height="700px" type="image/svg+xml" data="../svg/<%=svgpath %>"></object>
	-->
	<object style="position:relative;background-color:#000;" hspace="0" vspace="0" width="500px" height="300px"  id="emSvg" type="image/svg+xml" data="../svg/<%=svgpath %>"></object>
	
	<div style="position:fixed;z-index: 100;right:1px;bottom:0px;">
		<button type="button" onclick="big();">Zoom +</button>
    	<button type="button" onclick="small();">Zoom -</button>
	</div>
	<div id="menu" style="display:none;">
		<div id="node"><!-- 为接线图节点  <input type="text" name="nodeid" id="nodeid" class="nid" /> 关联采样点 --></div>
		<div style="color:red;" id="linkedNode"></div><!-- 已关联的采样点信息 -->
		<div id="samplelist"></div><!-- 设备列表 -->
		<!-- <div id="samplelist"></div> --><!-- 采样点列表 -->
		<div id="close" style="">关闭</div>
		<div class="sub"><button id="linkSure" class="sbutton">提交关联</button><button id="linkDel" class="sbutton">取消关联</button></div>
		
		<input id="NodeId" type="hidden">
		<input id="Substation_ID" type="hidden" value="<%=request.getParameter("sid").toString()%>">
	</div>
  </body>
  <script type="text/javascript">
  		var Swidth=document.body.clientWidth;
		var Sheight=document.body.clientHeight-90;
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
  </script>
</html>

<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.spi.DirStateFactory.Result"%>
<%@ page contentType="text/html;charset=gbk" language="java" import="java.util.*" import="com.action.dataselect"  pageEncoding="utf-8"%>
<% 
	String pid=request.getParameter("Sample_ID");//摄像头编号
	dataselect ds=new dataselect();
	String getA="select * from PhotoArea where Sample_ID='"+pid+"'";
	ResultSet rs=ds.select(getA);
	String A1="";//选区1
	String A2="";//选区2
	String A3="";//选区3
	
	if(rs!=null)
	{
		while(rs.next())
		{
			A1=rs.getString("Photo_1").toString();
			A2=rs.getString("Photo_2").toString();
			A3=rs.getString("Photo_3").toString();
		}
	}
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>test</title>
  <meta http-equiv="Content-type" content="text/html;charset=utf-8" />

<script src="../Jcrop/js/jquery.min.js"></script>
<script src="../Jcrop/js/jquery.Jcrop.js"></script>
<script type="text/javascript">
  jQuery(function($){

    // I did JSON.stringify(jcrop_api.tellSelect()) on a crop I liked:
    var c = {"x":13,"y":7,"x2":487,"y2":107,"w":474,"h":100};
	
	var jcrop_api;
	
    $('#target').Jcrop(
	{
      bgFade: true,
	  allowSelect:true,
      //setSelect: [c.x,c.y,c.x2,c.y2],
	  //onChange:   showCoords,
      onSelect:   showCoords,
      onRelease:  clearCoords
	 },
	 function()
	 {
	  jcrop_api = this;
	 }
	);
	//jcrop_api.setSelect([11,94,45,319]);
	function showCoords(c)
	{
		if(confirm("新建报警监测区域吗？"))
		{
			if($('#a1').val()=="")
			{
				$('#a1').val("["+c.x+","+c.y+","+c.x2+","+c.y2+"]");
			}
			else if($('#a2').val()=="")
			{
				$('#a2').val("["+c.x+","+c.y+","+c.x2+","+c.y2+"]");
			}
			else if($('#a3').val()=="")
			{
				$('#a3').val("["+c.x+","+c.y+","+c.x2+","+c.y2+"]");
			}
		}
		else
		{
			//alert("no");
		}
		/*
		$('#x1').val(c.x);
		$('#y1').val(c.y);
		$('#x2').val(c.x2);
		$('#y2').val(c.y2);
		$('#w').val(c.w);
		$('#h').val(c.h);
		*/
	};
	$('#look1').click(
		function()
		{
			jcrop_api.enable();
			jcrop_api.setSelect(eval($('#a1').val()));
		}
	);
	$('#look2').click(
		function()
		{
			jcrop_api.enable();
			jcrop_api.setSelect(eval($('#a2').val()));
		}
	);
	$('#look3').click(
		function()
		{
			jcrop_api.enable();
			jcrop_api.setSelect(eval($('#a3').val()));
		}
	);
	$('#save').click(
		function()
		{
			/*
			alert("kk");
			$.post("../servlet/setPhotoAlarm",
			  {
				A1:$('#a1').val(),
				A2:$('#a2').val(),
				A3:$('#a3').val(),
				picid:<%=pid%>
			  },
			  function(data,status)
			  {
				alert("Data: " + data + "\nStatus: " + status);
			  });
			 */
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
				    alert(result);
				    if(result=="success")
				    {
				    	alert("success!");
				    	
				    }
				    else
				    {
				    	alert("操作失败！");
				    }
				    window.location.href=window.location.href; 
				    window.location.reload;    
			  }
			};
			//alert("../servlet/setPhotoAlarm?picid=<%=pid%>&A1="+$('#a1').val()+"&A2="+$('#a2').val()+"&A3="+$('#a3').val()+"&t="+new Date().getTime());
			xmlhttp.open("GET","../servlet/setPhotoAlarm?picid=<%=pid%>&A1="+$('#a1').val()+"&A2="+$('#a2').val()+"&A3="+$('#a3').val()+"&t="+new Date().getTime(),true);
			xmlhttp.send();
			  
		}
	);

	function clearCoords()
	{
		//$('#coords input').val('');
	};
  });


</script>
<link rel="stylesheet" href="../Jcrop/demos/demo_files/main.css" type="text/css" />
<link rel="stylesheet" href="../Jcrop/demos/demo_files/demos.css" type="text/css" />
<link rel="stylesheet" href="../Jcrop/css/jquery.Jcrop.css" type="text/css" />
<style type="text/css">
  #target {
    background-color: #ccc;
    width: 500px;
    height: 330px;
    font-size: 24px;
    display: block;
  }
  .area{line-height:30px;}
  .look{cursor: pointer;margin-left:10px;}
</style>

</head>
<body>

<div class="container" style="width:500px;margin-left:auto;margin-right:auto;">


<div class="page-header">
<ul class="breadcrumb first">
  <li><a>在线巡检</a> <span class="divider">/</span></li>
  <li><a>图像管理</a> <span class="divider">/</span></li>
  <li class="active">图像报警设置</li>
</ul>
<h4>
	1、请在下面图片上以画矩形的方式选取关注区域<br/>
	2、删除某个区域，直接删除选取文本框中的坐标，点击保存即可。
</h4>
</div>

  <p id="target">
    
  </p>

  <div class="description" id="selected" >
	<p class="area">选区1：<input id="a1" type="text" value="<%=A1%>"><a id="look1" class="look">查看</a></p>
	<p class="area">选区2：<input id="a2" type="text" value="<%=A2%>"><a id="look2" class="look">查看</a></p>
	<p class="area">选区3：<input id="a3" type="text" value="<%=A3%>"><a id="look3" class="look">查看</a></p>
  </div>

<div class="clearfix"><button id="save">保存</button></div>

</div>

</body>
</html>


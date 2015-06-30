<%@page import="java.sql.ResultSet"%>
<%@ page contentType="text/html;charset=gbk" language="java" import="java.util.*" import="com.action.dataselect"  pageEncoding="utf-8"%>
<%@page import="com.action.dataselect"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>大成DSEP-2000电力图像智能与温湿度安全监测系统</title>

<style type="text/css">
*{margin:0;padding:0;}
.container{position:relative;width:1000px;height:600px;margin-left:auto; margin-right:auto; border:1px solid #fff;top:150px;}
.box{width:120px;height:120px;background:#fff;cursor: pointer;}
.fun{margin-left:auto;margin-right: auto;font-size: 25px;font-weight:bolder;}
.boximg{width:120px;height:120px;}
tr{height:200px;align-content: center;}
td{width:200px;align-content: center;}
</style>
</head>
<body>
<div class="container">
	<%
		//System.out.println(session.getAttribute("user_id"));
		//out.println(session.getAttribute("user_id"));
		if(session.getAttribute("user_id")==null)
		{
			response.sendRedirect("index.jsp");
		}
		else
		{
			dataselect ds=new dataselect();
			ResultSet rs=null;
			String sql="";
			sql="select count(*) from Users where User_Right='00000' and User_Login='"+session.getAttribute("user_id")+"'";
			rs=ds.select(sql);
			rs.first();
			int flag=rs.getInt(1);
			if(flag==1)
			{//超级管理员
				out.print("<table align='center'><tr><td><div class='box' ><a onclick='substation()'><img class='boximg' src='images/sub.jpg'><div class='fun'>&nbsp&nbsp变电所</div></a></div></td>"
								+"<td><div class='box' ><a onclick='user()'><img class='boximg' src='images/12.jpg'><div class='fun'>用户管理</div></a></div></td>"
								+"<td><div class='box' ><a onclick='map()'><img class='boximg' src='images/6.jpg'><div class='fun'>接线图</div></a></div></td>"
								+"<td rowspan='2'><div class='box' ><a onclick='online()'><img class='boximg' src='images/3.png'><div class='fun'>在线巡检</div></a></div></td>"
								+"<td><div class='box' ><a onclick='logs()'><img class='boximg' src='images/15.jpg'><div class='fun'>日志管理</div></a></div></td>"
							+"</tr><tr>"
								+"<td><div class='box' ><a onclick='system()'><img class='boximg' src='images/2.png'><div class='fun'>系统设置</div></a></div></td>"
								+"<td><div class='box' ><a onclick='device()'><img class='boximg' src='images/8.jpg'><div class='fun'>设备管理</div></a></div></td>"
								+"<td><div class='box' ><a onclick='interface()'><img class='boximg' src='images/1.png'><div class='fun'>接口设置</div></a></div></td>"
								+"<td><div class='box' ><a onclick='history()'><img class='boximg' src='images/9.jpg'><div class='fun'>历史数据</div></a></div></td>"
							+"</tr>"
						+"</table>");
			}
			else
			{//普通根据权限分配用户
				sql="select Substation_ID,User_Right from ACL where User_ID in(select User_ID from Users where User_Login='"+session.getAttribute("user_id")+"')";
				rs=ds.select(sql);
				rs.last();
				int rownum=rs.getRow();
		
				String[] sid=new String[rownum];
				String[] right=new String[rownum];
				rs.beforeFirst();
				int i=0;
				if(rs!=null)
				{
					while(rs.next())
					{
						sid[i]=rs.getString(1);
						right[i]=rs.getString(2);
						i++;
					}
				}
				
				String[] rightEnable=new  String[9];
				for(int j=0;j<9;j++)//9个权限
				{
					for(int k=0;k<i;k++)
					{
						if(right[k].charAt(j)=='1')
						{
							rightEnable[j]="1";
							continue;
						}
						else
						{
							rightEnable[j]="0";
						}
					}
				}
				
				//打印权限菜单
				
				out.print("<table align='center'><tr>");
				if(rightEnable[0].equals("1")==true)//变电所
				{
					out.print("<td><div class='box' ><a onclick='substation()'><img class='boximg' src='images/sub.jpg'><div class='fun'>&nbsp&nbsp变电所</div></a></div></td>");
				}
				else
				{
					out.print("<td><div class='box' style='opacity:0.4;'><a><img class='boximg' src='images/sub.jpg'><div class='fun'>&nbsp&nbsp&nbsp&nbsp变电所</div></a></div></td>");
				}
				if(rightEnable[2].equals("1")==true)//用户
				{
					out.print("<td><div class='box' ><a onclick='user()'><img class='boximg' src='images/12.jpg'><div class='fun'>用户管理</div></a></div></td>");
				}
				else
				{
					out.print("<td><div class='box' style='opacity:0.4;'><a><img class='boximg' src='images/12.jpg'><div class='fun'>用户管理</div></a></div></td>");
				}
				if(rightEnable[4].equals("1")==true)//接线图
				{
					out.print("<td><div class='box' ><a onclick='map()'><img class='boximg' src='images/6.jpg'><div class='fun'>接线图</div></a></div></td>");
				}
				else
				{
					out.print("<td><div class='box' style='opacity:0.4;'><a><img class='boximg' src='images/6.jpg'><div class='fun'>接线图</div></a></div></td>");
				}
				if(rightEnable[6].equals("1")==true)//在线巡检
				{
					out.print("<td rowspan='2'><div class='box' ><a onclick='online()'><img class='boximg' src='images/3.png'><div class='fun'>在线巡检</div></a></div></td>");
				}
				else
				{
					out.print("<td><div class='box' style='opacity:0.4;'><a><img class='boximg' src='images/3.png'><div class='fun'>在线巡检</div></a></div></td>");
				}
				if(rightEnable[7].equals("1")==true)//日志
				{
					out.print("<td><div class='box' ><a onclick='logs()'><img class='boximg' src='images/15.jpg'><div class='fun'>日志管理</div></a></div></td>");
				}
				else
				{
					out.print("<td><div class='box' style='opacity:0.4;'><a><img class='boximg' src='images/15.jpg'><div class='fun'>日志管理</div></a></div></td>");
				}
				
				out.print("</tr><tr>");
				
				if(rightEnable[1].equals("1")==true)//系统设置
				{
					out.print("<td><div class='box' ><a onclick='system()'><img class='boximg' src='images/2.png'><div class='fun'>系统设置</div></a></div></td>");
				}
				else
				{
					out.print("<td><div class='box' style='opacity:0.4;'><a><<img class='boximg' src='images/2.png'><div class='fun'>系统设置</div></a></div></td>");
				}
				if(rightEnable[3].equals("1")==true)//设备管理
				{
					out.print("<td><div class='box' ><a onclick='device()'><img class='boximg' src='images/8.jpg'><div class='fun'>设备管理</div></a></div></td>");
				}
				else
				{
					out.print("<td><div class='box' style='opacity:0.4;'><a><img class='boximg' src='images/8.jpg'><div class='fun'>设备管理</div></a></div></td>");
				}
				if(rightEnable[5].equals("1")==true)//接口设置
				{
					out.print("<td><div class='box' ><a onclick='interface()'><img class='boximg' src='images/1.png'><div class='fun'>接口设置</div></a></div></td>");
				}
				else
				{
					out.print("<td><div class='box' style='opacity:0.4;'><a><img class='boximg' src='images/1.png'><div class='fun'>接口设置</div></a></div></td>");
				}
				if(rightEnable[8].equals("1")==true)//历史数据
				{
					out.print("<td><div class='box' ><a onclick='history()'><img class='boximg' src='images/9.jpg'><div class='fun'>历史数据</div></a></div></td>");
				}
				else
				{
					out.print("<td><div class='box' style='opacity:0.4;'><a><img class='boximg' src='images/9.jpg'><div class='fun'>历史数据</div></a></div></td>");
				}
				
				out.print("</tr></table>");
	
			}
			rs.close();
			ds.close();
		}
		
		//System.out.println("qian:"+session.getMaxInactiveInterval()+"<>"+session.getCreationTime()+"<>"+session.getLastAccessedTime());
	 %>

	<!--  
	<table align="center">
		<tr>
			<td><div class="box" ><a onclick="substation()"><img class="boximg" src="images/sub.jpg"><div class="fun">&nbsp&nbsp&nbsp&nbsp变电所</div></a></div></td>
			<td><div class="box" ><a onclick="user()"><img class="boximg" src="images/12.jpg"><div class="fun">用户管理</div></a></div></td>
			<td><div class="box" ><a onclick="map()"><img class="boximg" src="images/6.jpg"><div class="fun">接线图</div></a></div></td>
			<td rowspan="2"><div class="box" ><a onclick="online()"><img class="boximg" src="images/3.png"><div class="fun">在线巡检</div></a></div></td>
			<td><div class="box" ><a onclick="logs()"><img class="boximg" src="images/15.jpg"><div class="fun">日志管理</div></a></div></td>
		</tr>
		<tr>
			<td><div class="box" ><a onclick="system()"><img class="boximg" src="images/2.png"><div class="fun">系统设置</div></a></div></td>
			<td><div class="box" ><a onclick="device()"><img class="boximg" src="images/8.jpg"><div class="fun">设备管理</div></a></div></td>
			<td><div class="box" ><a onclick="interface()"><img class="boximg" src="images/1.png"><div class="fun">接口设置</div></a></div></td>
			<td><div class="box" ><a onclick="history()"><img class="boximg" src="images/9.jpg"><div class="fun">历史数据</div></a></div></td>
		</tr>
	</table>
	-->
</div>
<script type="text/javascript"> 

	function substation()
    {
        window.open ('device/addSubstation.jsp','addSubstation','height=500,width=1000,top=300px,left=500px,scrollbars=yes,resizable=yes');
    }
    function interface()
    {
        window.open ('interfaceSet.jsp','interfaceSet','fullscreen=yes,top=300px,left=500px,scrollbars=yes,resizable=yes');
    }
    function system()
    {
        window.open ('systemSet.jsp','systemSet','fullscreen=yes,top=300px,left=500px,scrollbars=yes,resizable=yes');
    }
    function online()
    {
    	var bodyHeight = window.screen.availHeight;
		var bodyWidth = window.screen.availWidth;
        window.open ('online.jsp','online','fullscreen=yes,top=0px,left=0px,height=bodyHeight+"px",width=bodyWidth+"px",scrollbars=yes,resizable=yes');
    }
    function map()
    {
        window.open ('svgManage.jsp','svgManage','fullscreen=yes,top=300px,left=500px,scrollbars=yes,resizable=yes');
    }
    function user()
    {
        window.open ('userSet.jsp','userSet','fullscreen=yes,top=300px,left=500px,scrollbars=yes,resizable=yes');
    }
    function logs()
    {
        window.open ('logs.jsp','logs','fullscreen=yes,top=300px,left=500px,scrollbars=yes,resizable=yes');
    }
    function device()
    {
        window.open ('device.jsp','devicej','fullscreen=yes,top=300px,left=500px,scrollbars=yes,resizable=yes');
    }
    function history()
    {
        window.open ('historyData.jsp','fullscreen=yes,width=1000,top=300px,left=500px,scrollbars=yes,resizable=yes');
    }
    function refresh()
    {
    	var xmlhttp;
		if (window.XMLHttpRequest) {
			xmlhttp = new XMLHttpRequest();
		} else {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				// 显示返回的相应关id联接线图上的节点的开关柜
				}
		};
		xmlhttp.open("GET", "../servlet/refreshSession?r="+ new Date().getTime(), true);
		xmlhttp.send();
    }
    setInterval("refresh()",300000);
</script>
</body>
</html>

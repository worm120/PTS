<%@page import="java.sql.ResultSet"%>
<%@ page contentType="text/html;charset=gbk" language="java" import="java.util.*" import="com.action.dataselect"  pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>大成DSEP-2000电力图像智能与温湿度安全监测系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="css/font-awesome/css/font-awesome.css" rel="stylesheet">  
    <link href="css/mainframe.css" rel="stylesheet">
    <link rel="StyleSheet" href="dtree/dtree.css" type="text/css" />
	<script language="javascript" type="text/javascript" src="js/mainframe/mainframe.js"></script>
	<script language="javascript" type="text/javascript" src="js/mainframe/online.js"></script>
	<script type="text/javascript" src="dtree/dtree.js"></script>
</head>
<%	
	String[] sid=null;
	String[] sname=null;
	int index=0;//有权限变电所下标
	int flag=0;//有无超级管理员权限
	dataselect ds=new dataselect();
    ResultSet rs=null;
	if(session.getAttribute("user_id")==null)
	{
		response.sendRedirect("index.jsp");
	}
	else
	{
		
		String sql="";

		sql="select count(*) from Users where User_Right='00000' and User_Login='"+session.getAttribute("user_id")+"'";
		rs=ds.select(sql);
		rs.first();
		flag=rs.getInt(1);
		if(flag==1)
		{//超级管理员
			//String sql="select Substation_ID,Substation_Name from ACL left join Substation on Substation.Substation_ID=ACL.Substation_ID  where User_ID in(select User_ID from Users where User_Login='"+session.getAttribute("user_id")+"')";
			sql="select * from Substation";
			rs=ds.select(sql);
			
			rs.last();
			int num=rs.getRow();
			sid=new String[num];
			sname=new String[num];
			rs.beforeFirst();
			
			while(rs.next())
			{
				sid[index]=rs.getString("Substation_ID");
				sname[index]=rs.getString("Substation_Name");
				index++;
			}
		}
		else
		{//普通根据权限分配用户
			sql="select Substation_ID,Substation_Name,User_Right from ACL left join Substation on Substation.Substation_ID=ACL.Substation_ID  where User_ID in(select User_ID from Users where User_Login='"+session.getAttribute("user_id")+"')";
			//sql="select Substation_ID,User_Right from ACL where User_ID in(select User_ID from Users where User_Login='"+session.getAttribute("user_id")+"')";
			rs=ds.select(sql);
			rs.last();
			int rownum=rs.getRow();
			
			sid=new String[rownum];
			sname=new String[rownum];
			
			String[] snamew=new String[rownum];
			String[] sidd=new String[rownum];
			String[] right=new String[rownum];
			rs.beforeFirst();
			int i=0;
			if(rs!=null)
			{
				while(rs.next())
				{
					sidd[i]=rs.getString(1);
					snamew[i]=rs.getString(2);
					right[i]=rs.getString(3);
					i++;
				}
			}
			for(int k=0;k<i;k++)
			{
				if(right[k].charAt(6)=='1')
				{
					sid[index]=sidd[k];
					sname[index]=snamew[k];
					index++;
				}
			}
		}
		//rs.close();
		//ds.close();
	}
	/*
	dataselect ds=new dataselect();
	ResultSet rs=null;
	String sql="select * from Substation";
	rs=ds.select(sql);
	
	rs.last();
	int num=rs.getRow();
	String[] sid=new String[num];
	String[] sname=new String[num];
	rs.beforeFirst();
	int index=0;
	while(rs.next())
	{
		sid[index]=rs.getString("Substation_ID");
		sname[index]=rs.getString("Substation_Name");
		index++;
	}
	rs.close();
	ds.close();
	*/
%>
<body>
    <div id="main-top">
        <div class="logo"><img style="float:left;" class="topimgs" src="images/logo.gif"><div class="funType">在线巡检</div><div class="funtip">当前菜单:</div></div>
        <div class="main_menu">
            <ul id="menu" class="topmenu-ul">
                <li class="topmenu-ul-li">
                    <a onclick="showmenu('usermenu')" >
                        	<span style="font-size:12px;line-height:30px;">选择变电所：</span>
                        	<label id="sub_name" class="sunname" name="sub_name" ><%if(index>0){out.print(sname[0]);}%></label>
                        	<!-- <input id="sub_name" class="sunname" name="sub_name" type="text" value="<%//if(index>0){out.print(sname[0]);}%>" readonly="readonly"> -->
                            <input id="sid" name="sid" type=hidden value="<%if(index>0){out.print(sid[0]);}%>" >
                        <!--
                        <span class="usermenulispan">
                        </span>--> 
                        <i class="icon-sort-down"></i>
                    </a> 
                    <ul id="usermenu" style="display:none;z-index:200;">
                        <li style="margin-top: -12px; width:0px; height:0px; border-left:10px solid transparent;border-right:10px solid transparent;border-bottom:10px solid #fff;"></li>
                        <%
                        	for(int i=0;i<index;i++)
                        	{
                        		out.print("<li onclick='changeSub(\""+sid[i]+sname[i]+"\")'><i class='icon-list' style='color:#444;'></i><span class='usermenulispan'>"+sname[i]+"</span></li>");
                        	}
						%>
                        <!-- 
                        <li onclick="changeSub('0011号变电所')"><i class="icon-user"></i><span class="usermenulispan">1号变电所</span></li>
                        <li class="divider"></li>
                        <li onclick="changeSub('0022号变电所')"><i class="icon-user"></i><span class="usermenulispan">2号变电所</span></li>
                        <li class="divider"></li>
                        <li onclick="changeSub('0033号变电所')"><i class="icon-random"></i><span class="usermenulispan">3号变电所</span></li>
                        <li class="divider"></li>
                        <li onclick="changeSub('0044号变电所')"><i class="icon-key"></i><span class="usermenulispan">4号变电所</span></li>
                   		 -->
                    </ul>
                </li>
                
                <li class="topmenu-ul-li">
                    <a onclick="system()">
                        <i class="icon icon-cog"></i>
                        <span class="usermenulispan">系统设置</span>
                    </a>
                </li>
                <li class="topmenu-ul-li">
                    <a onclick="user()">
                        <i class="icon icon-cog"></i>
                        <span class="usermenulispan">用户管理</span>
                    </a>
                </li>
                <li class="topmenu-ul-li">
                    <a onclick="interface()">
                        <i class="icon icon-cog"></i>
                        <span class="usermenulispan">接口设置</span>
                    </a>
                </li>
                <li class="topmenu-ul-li">
                    <a onclick="device()">
                        <i class="icon icon-cog"></i>
                        <span class="usermenulispan">设备设置</span>

                    </a>
                </li>
                <li class="topmenu-ul-li">
                    <a onclick="map()">
                        <i class="icon icon-cog"></i>
                        <span class="usermenulispan">接线图管理</span>
                    </a>
                </li>
                
                <li class="topmenu-ul-li">
                    <a onclick="logs()">
                        <i class="icon-file-alt"></i>
                        <span class="usermenulispan">日志设置</span>
                        <!--<i class="icon icon-sort-down"></i>-->
                    </a>
                </li>
                <li class="topmenu-ul-li">
                    <a onclick="history()">
                        <i class="icon-bar-chart"></i>
                        <span class="usermenulispan">历史数据</span>
                        <!--<i class="icon icon-sort-down"></i>-->
                    </a>
                </li>
                <li class="topmenu-ul-li">
                    <a>
                        <i class="icon-fullscreen"></i>
                        <span class="usermenulispan">按F11全屏</span>
                    </a>
                </li>
                <!-- 
                <li class="topmenu-ul-li">
                    <a onclick="showAllScreen()">
                        <i class="icon-fullscreen"></i>
                        <span class="usermenulispan">全屏显示</span>
                    </a>
                </li>
                 -->
                <li class="topmenu-ul-li">
                    <a onclick="logout()">
                        <i class="icon icon-share-alt"></i>
                        <span class="usermenulispan">关闭</span>
                    </a>
                </li>
                
            </ul>
            
            <div id="timef">
                   
                <script type="text/javascript" >
                    setInterval("timef.innerHTML='<i class=\"icon-user\"></i>当前用户： <font color=red size=4><%out.print(session.getAttribute("user_id"));%></font>&nbsp&nbsp&nbsp&nbsp&nbsp'+new Date().toLocaleString()+' 星期'+'日一二三四五六'.charAt(new Date().getDay());",1000);
                </script>
            </div>
        
        </div>
        
    </div>
    
    
    <!-- 左部菜单 -->
    <div id="menuleft" name="menuleft">
    	<div class="dtree">
			<p><a href="javascript: d.openAll();" style="font-weight:bold;">展开</a> | <a href="javascript: d.closeAll();" style="font-weight:bold;">收起</a></p>
			<script type="text/javascript">
				
				
				d = new dTree('d');
				d.add(0,-1,'功能菜单');
				<%	
					
					/*获取角色，判断是否是全局权限*/
					
					int num=1;
					//if(isAdmin.equals("yes"))//有全局权限
					if(flag==1)//有全局权限
					{
						out.print("d.add("+num+",0,'变电所管理','device/addSubstation.jsp','点击进入管理变电所界面','showcontent');");
						num++;
						/*
						out.print("d.add("+num+",0,'选定系统结构图','linkMap/selectLeadMap.jsp','点击进入选定系统结构图界面','f');");
						num++;
						out.print("d.add("+num+",0,'关联系统结构图','linkMap/linkLeadMap.jsp','点击进入关联系统结构图界面','f');");
						num++;
						out.print("d.add("+num+",0,'接口设置','dataInterface/setInterface.jsp','点击进入接口设置界面','f');");
						num++;
						out.print("d.add("+num+",0,'设置设备接口信息','dataInterface/linkDevice.jsp','点击进入设置设备接口信息界面','f');");
						num++;
						out.print("d.add("+num+",0,'设置采样点接口信息','dataInterface/linkSample.jsp','点击进入设置采样点接口信息界面','f');");
						num++;
						*/
						out.print("d.add("+num+",0,'启动数据采集接口','interface/startInterface.jsp','点击进入启动数据采集接口界面','showcontent');");
						num++;
						
						int[] temp=new int[10];
						String getSub="select * from Substation";
						rs=ds.select(getSub);
						if(rs!=null)
						{
							while(rs.next())
							{
								out.print("d.add("+num+",0,'"+rs.getString("Substation_Name")+"','','','showcontent');");
								temp[0]=num;
								num++;
								/*系统管理*/
								out.print("d.add("+num+","+temp[0]+",'系统管理','','点击进入系统管理界面','showcontent');");
								temp[1]=num;
								num++;
								out.print("d.add("+num+","+temp[1]+",'基本参数','liangw/sysManage/basicPara.jsp?sid="+rs.getString("Substation_ID")+"','点击进入基本参数设置界面','showcontent');");
								num++;
								out.print("d.add("+num+","+temp[1]+",'报警设置','liangw/sysManage/alarmSet.jsp?sid="+rs.getString("Substation_ID")+"','点击进入报警设置界面','showcontent');");
								num++;
								/*用户管理*/
								out.print("d.add("+num+","+temp[0]+",'用户管理','','','showcontent');");
								temp[2]=num;
								num++;
								out.print("d.add("+num+","+temp[2]+",'添加用户','liangw/userManage/addUser.jsp?sid="+rs.getString("Substation_ID")+"','点击进入添加用户界面','showcontent');");
								num++;
								out.print("d.add("+num+","+temp[2]+",'删除用户','liangw/userManage/deleteUser.jsp?sid="+rs.getString("Substation_ID")+"','点击进入删除用户置界面','showcontent');");
								num++;
								out.print("d.add("+num+","+temp[2]+",'权限分配','liangw/userManage/rightAllo.jsp?sid="+rs.getString("Substation_ID")+"','点击进入权限分配界面','showcontent');");
								num++;
								out.print("d.add("+num+","+temp[2]+",'个人信息','liangw/userManage/selfInfo.jsp?sid="+rs.getString("Substation_ID")+"','点击进入个人信息界面','showcontent');");
								num++;
								/*设备管理*/
								out.print("d.add("+num+","+temp[0]+",'设备管理','','点击进入具体变电所管理界面','showcontent');");
								temp[3]=num;
								num++;
								out.print("d.add("+num+","+temp[3]+",'设备管理','device/addDevice.jsp?sid="+rs.getString("Substation_ID")+"','点击进入设备管理界面','showcontent');");
								num++;
								out.print("d.add("+num+","+temp[3]+",'采样点管理','device/addSample.jsp?sid="+rs.getString("Substation_ID")+"','点击进入采样点管理界面','showcontent');");
								num++;
								out.print("d.add("+num+","+temp[3]+",'采样点分相','device/fenxiang.jsp?sid="+rs.getString("Substation_ID")+"','采样点分相','showcontent');");
								num++;
								
								/*接线图编辑器*/
								out.print("d.add("+num+","+temp[0]+",'接线图编辑器','svgEdit/svg-editor.html','点击进入接线图编辑器界面','_blank');");
								num++;

								/*接线图管理*/
								out.print("d.add("+num+","+temp[0]+",'接线图管理','','点击进入接线图管理界面','showcontent');");
								temp[4]=num;
								num++;
								out.print("d.add("+num+","+temp[4]+",'关联变电所接线图','linkMap/linkMapS.jsp?sid="+rs.getString("Substation_ID")+"','点击进入关联变电所接线图界面','showcontent');");
								num++;
								out.print("d.add("+num+","+temp[4]+",'关联开关柜节点','linkMap/linkDevice.jsp?sid="+rs.getString("Substation_ID")+"','点击进入关联开关柜节点界面','showcontent');");
								num++;
								//out.print("d.add("+num+","+temp[4]+",'关联图像巡检图','linkMap/linklMapPhoto.jsp?sid="+rs.getString("Substation_ID")+"','点击进入关联图像巡检图界面','f');");
								//num++;
								//out.print("d.add("+num+","+temp[4]+",'关联图像节点','linkMap/linkNodePhoto.jsp?sid="+rs.getString("Substation_ID")+"','点击进入关联图像节点界面','f');");
								//num++;
								
								/*接口设置*/
								out.print("d.add("+num+","+temp[0]+",'接口设置','','点击进入接口设置界面','showcontent');");
								temp[5]=num;
								num++;
								out.print("d.add("+num+","+temp[5]+",'设备关联设置','interface/linkDevice.jsp?sid="+rs.getString("Substation_ID")+"','点击进入设备关联设置界面','showcontent');");
								num++;
								out.print("d.add("+num+","+temp[5]+",'节点关联设置','interface/linkSample.jsp?sid="+rs.getString("Substation_ID")+"','点击进入节点关联设置界面','showcontent');");
								num++;
								
								
								/*在线巡检管理*/
								out.print("d.add("+num+","+temp[0]+",'温度巡检','temperature/lookOnlineTemperature.jsp?sid="+rs.getString("Substation_ID")+"&userid="+request.getParameter("id")+"&type=all','点击进入在线巡检界面','showcontent');");
								//temp[5]=num;
								num++;
								//out.print("d.add("+num+","+temp[0]+",'图像巡检','surPicture/onlinePicture.jsp?sid="+rs.getString("Substation_ID")+"&userid="+request.getParameter("id")+"&type=all','点击进入在线巡检界面','showcontent');");
								//num++;
								
								/*图像管理
								out.print("d.add("+num+","+temp[0]+",'图像管理','','点击进入图像管理界面','showcontent');");
								temp[6]=num;
								num++;
								out.print("d.add("+num+","+temp[6]+",'图像设置','picManage/picSet.jsp?sid="+rs.getString("Substation_ID")+"','点击进入图像设置界面','showcontent');");
								num++;
								
								out.print("d.add("+num+","+temp[6]+",'选区设置','picManage/selSet.jsp?sid="+rs.getString("Substation_ID")+"','点击进入选区设置界面','showcontent');");
								num++;
								
								out.print("d.add("+num+","+temp[6]+",'数据管理','picManage/dataManage.jsp?sid="+rs.getString("Substation_ID")+"','点击进入数据管理界面','showcontent');");
								num++;
								out.print("d.add("+num+","+temp[6]+",'图像分析','picManage/picCmp.jsp?sid="+rs.getString("Substation_ID")+"','点击进入对比监控界面','showcontent');");
								num++;
								out.print("d.add("+num+","+temp[6]+",'远程图像','surPicture/remotePic.jsp?sid="+rs.getString("Substation_ID")+"','点击进入远程图像界面','showcontent');");
								num++;
								*/
								/*报警统计
								out.print("d.add("+num+","+temp[0]+",'报警统计','','点击进入报警统计界面','showcontent');");
								temp[9]=num;
								num++;
								out.print("d.add("+num+","+temp[9]+",'操作日志','alarmStatistics/TemperatureStatistics.jsp?sid="+rs.getString("Substation_ID")+"','点击进入报警统计界面','showcontent');");
								num++;
								*/
								
								/*日志管理*/
								out.print("d.add("+num+","+temp[0]+",'日志管理','','点击进入日志管理界面','showcontent');");
								temp[7]=num;
								num++;
								out.print("d.add("+num+","+temp[7]+",'操作日志','SPC/log/operationlog.jsp?sid="+rs.getString("Substation_ID")+"','点击进入操作日志界面','showcontent');");
								num++;
								out.print("d.add("+num+","+temp[7]+",'报警日志','SPC/log/alarmlog.jsp?sid="+rs.getString("Substation_ID")+"','点击进入报警日志界面','showcontent');");
								num++;
								out.print("d.add("+num+","+temp[7]+",'报警数据分析','SPC/datastatistic/datas.jsp?sid="+rs.getString("Substation_ID")+"','点击进入报警数据分析界面','showcontent');");
								num++;
								out.print("d.add("+num+","+temp[7]+",'删除日志','SPC/log/dellog.jsp?sid="+rs.getString("Substation_ID")+"','点击进入删除日志界面','showcontent');");
								num++;
								
								
								
								/*历史记录*/
								out.print("d.add("+num+","+temp[0]+",'历史记录','','点击进入历史记录界面','showcontent');");
								temp[8]=num;
								num++;
								out.print("d.add("+num+","+temp[8]+",'查看历史记录','SPC/history/history.jsp?sid="+rs.getString("Substation_ID")+"','点击进入查看历史记录界面','showcontent');");
								num++;
								out.print("d.add("+num+","+temp[8]+",'清除历史记录','SPC/history/delhistory.jsp?sid="+rs.getString("Substation_ID")+"','点击进入清除历史记录界面','showcontent');");
								num++;
							}
						}

					}
					else//没有全局权限
					{
						//getRightDirectory gr=new getRightDirectory();
						int[] temp=new int[9];
						//String getSub="select * from ACL,Users where ACL.User_ID=Users.User_ID and User_Login='"+request.getParameter("id")+"'";
						String getSub="select Substation_ID,Substation_Name,User_Right from ACL left join Substation on Substation.Substation_ID=ACL.Substation_ID  where User_ID in(select User_ID from Users where User_Login='"+session.getAttribute("user_id")+"')";
						rs=ds.select(getSub);
						
						if(rs!=null)
						{
							while(rs.next())
							{
							
								String subid=rs.getString("Substation_ID");
								String subname=rs.getString("Substation_Name");
								String right=rs.getString("User_Right");
								//System.out.println(subid+"<>"+subname);
								
								out.print("d.add("+num+",0,'"+subname+"','','点击进入具体变电所管理界面','showcontent');");
								temp[0]=num;
								num++;

								if(right.charAt(1)=='1')
								{
									/*系统管理*/
									out.print("d.add("+num+","+temp[0]+",'系统管理','','点击进入具体系统管理界面','showcontent');");
									temp[1]=num;
									num++;
									out.print("d.add("+num+","+temp[1]+",'基本参数','liangw/sysManage/basicPara.jsp?sid="+rs.getString("Substation_ID")+"','点击进入基本参数设置界面','showcontent');");
									num++;
									out.print("d.add("+num+","+temp[1]+",'报警设置','liangw/sysManage/alarmSet.jsp?sid="+rs.getString("Substation_ID")+"','点击进入报警设置界面','showcontent');");
									num++;
								}
								
								if(right.charAt(2)=='1')
								{
									/*用户管理*/
									out.print("d.add("+num+","+temp[0]+",'用户管理','','','showcontent');");
									temp[2]=num;
									num++;
									out.print("d.add("+num+","+temp[2]+",'添加用户','liangw/userManage/addUser.jsp?sid="+rs.getString("Substation_ID")+"','点击进入添加用户界面','showcontent');");
									num++;
									out.print("d.add("+num+","+temp[2]+",'删除用户','liangw/userManage/deleteUser.jsp?sid="+rs.getString("Substation_ID")+"','点击进入删除用户置界面','showcontent');");
									num++;
									out.print("d.add("+num+","+temp[2]+",'权限分配','liangw/userManage/rightAllo.jsp?sid="+rs.getString("Substation_ID")+"','点击进入权限分配界面','showcontent');");
									num++;
									out.print("d.add("+num+","+temp[2]+",'个人信息','liangw/userManage/selfInfo.jsp?sid="+rs.getString("Substation_ID")+"','点击进入个人信息界面','showcontent');");
									num++;
								}
								
								if(right.charAt(3)=='1')
								{
									/*设备管理*/
									out.print("d.add("+num+","+temp[0]+",'设备管理','','点击进入具体变电所管理界面','showcontent');");
									temp[3]=num;
									num++;
									out.print("d.add("+num+","+temp[3]+",'设备管理','device/addDevice.jsp?sid="+rs.getString("Substation_ID")+"','点击进入设备管理界面','showcontent');");
									num++;
									out.print("d.add("+num+","+temp[3]+",'采样点管理','device/addSample.jsp?sid="+rs.getString("Substation_ID")+"','点击进入采样点管理界面','showcontent');");
									num++;
									out.print("d.add("+num+","+temp[3]+",'采样点分相','device/fenxiang.jsp?sid="+rs.getString("Substation_ID")+"','采样点分相','showcontent');");
									num++;
								}
								/*接线图编辑器*/
								out.print("d.add("+num+","+temp[0]+",'接线图编辑器','svgEdit/svg-editor.html','点击进入接线图编辑器界面','_blank');");
								num++;
								
								if(right.charAt(4)=='1')
								{
									/*接线图管理*/
									out.print("d.add("+num+","+temp[0]+",'接线图管理','','点击进入接线图管理界面','showcontent');");
									temp[4]=num;
									num++;
									out.print("d.add("+num+","+temp[4]+",'关联变电所接线图','linkMap/linkMapS.jsp?sid="+rs.getString("Substation_ID")+"','点击进入关联变电所接线图界面','showcontent');");
									num++;
									out.print("d.add("+num+","+temp[4]+",'关联开关柜节点','linkMap/linkDevice.jsp?sid="+rs.getString("Substation_ID")+"','点击进入关联开关柜节点界面','showcontent');");
									num++;
								}
								if(right.charAt(5)=='1')
								{
									/*接口设置*/
									out.print("d.add("+num+","+temp[0]+",'接口设置','','点击进入接口设置界面','showcontent');");
									temp[5]=num;
									num++;
									out.print("d.add("+num+","+temp[5]+",'设备关联设置','interface/linkDevice.jsp?sid="+rs.getString("Substation_ID")+"','点击进入设备关联设置界面','showcontent');");
									num++;
									out.print("d.add("+num+","+temp[5]+",'节点关联设置','interface/linkSample.jsp?sid="+rs.getString("Substation_ID")+"','点击进入节点关联设置界面','showcontent');");
									num++;
								}
								
								/*在线巡检管理*/
								if(right.charAt(6)=='1')
								{
									out.print("d.add("+num+","+temp[0]+",'温度巡检','Temperature/lookOnlineTemperature.jsp?sid="+subid+"&userid="+request.getParameter("id")+"&type=part','点击进入在线巡检界面','showcontent');");
									//temp[5]=num;
									num++;
									
									//out.print("d.add("+num+","+temp[0]+",'图像巡检','surPicture/onlinePicture.jsp?sid="+subid+"&userid="+request.getParameter("id")+"&type=part','点击进入在线巡检界面','showcontent');");
									//num++;
									
								}
								
								/*
								if(right.charAt(11)=='1'||right.charAt(12)=='1'||right.charAt(13)=='1')
								{
									//图像管理
									out.print("d.add("+num+","+temp[0]+",'图像管理','','点击进入图像管理界面','showcontent');");
									temp[6]=num;
									num++;
									if(right.charAt(11)=='1')
									{
										out.print("d.add("+num+","+temp[6]+",'图像设置','picManage/picSet.jsp?sid="+subid+"','点击进入图像设置界面','showcontent');");
										num++;
									}
									//if(right.charAt(22)=='1')
									//{
										out.print("d.add("+num+","+temp[6]+",'选区设置','picManage/selSet.jsp?sid="+subid+"','点击进入数据管理界面','showcontent');");
										num++;
									//}
									if(right.charAt(12)=='1')
									{
										out.print("d.add("+num+","+temp[6]+",'数据管理','picManage/dataManage.jsp?sid="+subid+"','点击进入数据管理界面','showcontent');");
										num++;
									}
									if(right.charAt(13)=='1')
									{
										out.print("d.add("+num+","+temp[6]+",'图像分析','picManage/picCmp.jsp?sid="+subid+"','点击进入对比监控界面','showcontent');");
										num++;
									}
									out.print("d.add("+num+","+temp[6]+",'远程图像','surPicture/remotePic.jsp?sid="+rs.getString("Substation_ID")+"','点击进入远程图像界面','showcontent');");
									num++;
								}
								*/
								/*报警统计
								out.print("d.add("+num+","+temp[0]+",'报警统计','','点击进入报警统计界面','showcontent');");
								temp[9]=num;
								num++;
								out.print("d.add("+num+","+temp[9]+",'操作日志','alarmStatistics/TemperatureStatistics.jsp?sid="+rs.getString("Substation_ID")+"','点击进入报警统计界面','showcontent');");
								num++;
								*/
								if(right.charAt(7)=='1')
								{
									/*日志管理*/
									out.print("d.add("+num+","+temp[0]+",'日志管理','','点击进入日志管理界面','showcontent');");
									temp[7]=num;
									num++;
									out.print("d.add("+num+","+temp[7]+",'操作日志','SPC/log/operationlog.jsp?sid="+rs.getString("Substation_ID")+"','点击进入操作日志界面','showcontent');");
									num++;
									out.print("d.add("+num+","+temp[7]+",'报警日志','SPC/log/alarmlog.jsp?sid="+rs.getString("Substation_ID")+"','点击进入报警日志界面','showcontent');");
									num++;
									out.print("d.add("+num+","+temp[7]+",'报警数据分析','SPC/datastatistic/datas.jsp?sid="+rs.getString("Substation_ID")+"','点击进入报警数据分析界面','showcontent');");
									num++;
									out.print("d.add("+num+","+temp[7]+",'删除日志','SPC/log/dellog.jsp?sid="+rs.getString("Substation_ID")+"','点击进入删除日志界面','showcontent');");
									num++;
								}
								
								if(right.charAt(8)=='1')
								{
									out.print("d.add("+num+","+temp[0]+",'历史记录','','点击进入历史记录界面','showcontent');");
									temp[8]=num;
									num++;
									out.print("d.add("+num+","+temp[8]+",'查看历史记录','SPC/history/history.jsp?sid="+rs.getString("Substation_ID")+"','点击进入查看历史记录界面','showcontent');");
									num++;
									out.print("d.add("+num+","+temp[8]+",'清除历史记录','SPC/history/delhistory.jsp?sid="+rs.getString("Substation_ID")+"','点击进入清除历史记录界面','showcontent');");
									num++;			  	
								}
							}
						}
					}
					rs.close();
					ds.close();
				%>
				document.write(d);
				//-->
			</script>
		
		</div>
    
    </div>
    <!--显示/隐藏左侧菜单 -->
    <div id="menuleft_show" onclick="showMenuleft()"><img id="leftImg" src="images/show.gif"/></div>
    <div id="main-bottom">
        <iframe id="showcontent" name="showcontent" src="temperature/lookOnlineTemperature.jsp?sid=<%if(index>0){out.print(sid[0]);}%>"></iframe>
    </div>
    <!--产生模拟数据 -->
    <div style="display:none;">
        <iframe src="SOS2.jsp"></iframe>
    </div>
    <div id="closeAll" class="closeAll" onclick="closeAllScreen()"> 退出全屏 </div>
</body>

<!-- 显示或隐藏左侧树形菜单 -->
<script type="text/javascript">
		var Swidth=document.body.clientWidth;
		var Sheight=document.body.clientHeight-92;
		var svgBox=document.getElementById('menuleft');
		//svgBox.setAttribute("width",Swidth);
	    //svgBox.setAttribute("height",Sheight);
	    svgBox.style.cssText="height:"+Sheight+"px;";
	    var floatMenu=document.getElementById('menuleft_show');
	    showHeight=(document.body.clientHeight-92)/2;
		floatMenu.style.cssText="top:"+showHeight+"px;";
		var showFlag="0";
	    function showMenuleft()
	    {
	    	if(showFlag=="0")
	    	{
	    		document.getElementById('menuleft').style.display="block";
	    		document.getElementById('leftImg').src="images/hide.gif";
	    		showFlag="1";
	    	}
	    	else
	    	{
	    		document.getElementById('menuleft').style.display="none";
	    		document.getElementById('leftImg').src="images/show.gif";
	    		showFlag="0";
	    	}
	    }
	    
	   // alert("d");	
</script>
</html>

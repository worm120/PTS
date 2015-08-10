<%@page import="java.sql.ResultSet"%>
<%@ page contentType="text/html;charset=gbk" language="java" import="java.util.*" import="com.action.dataselect"  pageEncoding="utf-8"%>
<%@page import="com.action.dataselect"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>大成DSEP-2000电力图像智能与温湿度安全监测系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="css/font-awesome/css/font-awesome.css" rel="stylesheet">  
    <link href="css/mainframe.css" rel="stylesheet">
    <script language="javascript" type="text/javascript" src="js/mainframe/mainframe.js"></script>
    <script language="javascript" type="text/javascript" src="js/mainframe/userSet.js"></script>
</head>
<%
	String[] sid=null;
	String[] sname=null;
	int index=0;//有权限变电所下标
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
		rs.close();
		ds.close();
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
        <div class="logo"><img class="topimgs" src="images/logo.gif"><div class="funType">用户管理</div><div class="funtip">当前菜单:</div></div>
        <div class="main_menu">
            <ul id="menu" class="topmenu-ul">
				<!--
                <li class="topmenu-ul-li">
                    <a onclick="showmenu('usermenu')" >
                        <i class="icon icon-user"></i>
                        	<input id="sub_name" class="sunname" name="sub_name" type="text" value="<--请选择变电所>" disabled="true" >-->
                            <input id="sid" name="sid" type=hidden value="none" >																		
                       <!-- <i class="icon-sort-down"></i>
                    </a> 
                    <ul id="usermenu" style="display:none;z-index:200;" >
                        <li style="margin-top: -12px; width:0px; height:0px; border-left:10px solid transparent;border-right:10px solid transparent;border-bottom:10px solid #000;"></li>
                        <%/*
                        	for(int i=0;i<index;i++)
                        	{
                        		out.print("<li onclick='changeSub(\""+sid[i]+sname[i]+"\")'><i class='icon-user'></i><span class='usermenulispan'>"+sname[i]+"</span></li>");
                        	}
							*/
						%>
                    </ul>
                </li>
                -->
                <li class="topmenu-ul-li">
                    <a onclick="show('add')" >
                        <i class="icon icon-user"></i>
                        <span class="usermenulispan">添加用户</span>
                        <i class="icon-sort-down"></i>
                    </a> 
                </li>
                
                <li class="topmenu-ul-li">
                    <a onclick="show('delete')">
                        <i class="icon icon-cog"></i>
                        <span class="usermenulispan">删除用户</span>
                        <!--<i class="icon icon-sort-down"></i>-->
                    </a>
                </li>
                <li class="topmenu-ul-li">
                    <a onclick="show('fenpei')">
                        <i class="icon icon-cog"></i>
                        <span class="usermenulispan">权限管理</span>
                        <!--<i class="icon icon-sort-down"></i>-->
                    </a>
                </li>
                <li class="topmenu-ul-li">
                    <a onclick="show('person')">
                        <i class="icon icon-cog"></i>
                        <span class="usermenulispan">用户信息</span>
                        <!--<i class="icon icon-sort-down"></i>-->
                    </a>
                </li>
                
                <li class="topmenu-ul-li">
<!--                     <a onclick="showAllScreen()"> -->
                        <i class="icon icon-cog"></i>
                        <span class="usermenulispan">按F11全屏</span>
                        <!--<i class="icon icon-sort-down"></i>-->
<!--                     </a> -->
                </li>
            
                <li class="topmenu-ul-li">
                    <a onclick="logout()">
                        <i class="icon icon-share-alt"></i>
                        <span class="usermenulispan">关闭</span>
                    </a>
                </li>
                
            </ul>
            
            <div id="timef">
                   
                <script type="text/javascript" >
                    setInterval("timef.innerHTML='当前用户： <font color=red size=4><%out.print(session.getAttribute("user_id"));%></font>&nbsp&nbsp&nbsp&nbsp&nbsp'+new Date().toLocaleString()+' 星期'+'日一二三四五六'.charAt(new Date().getDay());",1000);
                </script>
            </div>
        
        </div>
        
    </div>
    
    <div id="main-bottom">
        <iframe id="showcontent" name="showcontent" src="remind.jsp"></iframe>
    </div>
    <div id="closeAll" class="closeAll" onclick="closeAllScreen()"> 退出全屏 </div>
</body>

</html>




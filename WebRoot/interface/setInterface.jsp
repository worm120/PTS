<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.spi.DirStateFactory.Result"%>
<%@ page contentType="text/html;charset=gbk" language="java" import="java.util.*" import="com.action.dataselect"  pageEncoding="gbk"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>大成DSEP-2000电力图像智能与温湿度安全监测系统</title>
        <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
        <meta http-equiv="pragma" content="no-cache">
        <link href="../font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css">  
        <link  rel="stylesheet" type="text/css" href="../css/add.css">   
        <script src="../js/deTemp/addDevice.js" charset="gbk" type="text/javascript"></script>
    </head>
    <body>
    <%
    	String Imagepath="";
    	String imgStartTime="";
    	String imgEndTime="";
		String huStartTime="";
    	String huEndTime="";
    	dataselect ds=new dataselect();
    	request.setCharacterEncoding("gbk");
    	if(request.getParameter("Imagepath")!=null)
		{
			String updateset="update Interface set Imagepath='"+request.getParameter("Imagepath")+"',imgStartTime='"+request.getParameter("imgStartTime")+"',imgEndTime='"+request.getParameter("imgEndTime")+"',huStartTime='"+request.getParameter("huStartTime")+"',huEndTime='"+request.getParameter("huEndTime")+"'";
			int i=ds.update(updateset);
			if(i>0)
			{
				out.print("<script>alert('设置成功！');</script>");
			}
			else
			{
				out.print("<script>alert('设置失败，重新设置！');</script>");
			}
		}

		String sqls="select * from Interface";
		ResultSet rs=ds.select(sqls);
		if(rs!=null)
		{	
			while(rs.next())
			{
				Imagepath=rs.getString("Imagepath");
				imgStartTime=rs.getString("imgStartTime");
				imgEndTime=rs.getString("imgEndTime");
				huStartTime=rs.getString("huStartTime");
				huEndTime=rs.getString("huEndTime");
			}
		}
		rs.close();
		ds.close();
	%>
    <!--content start-->
    <div id="content">
        <div id="content-header">
            <div id="content-header-leader">
                <a class="tip-button">
                    <i class="icon icon-home"></i>
                   	 首页
                </a>
                <a class="current" href="#">
                   	 接口设置
                </a>
            </div>
        </div>
        <form action="setInterface.jsp" method="post" id="formsub">
        <div id="content-field">
            <div class="box-title">
<!--                 <div class="select"> -->
<!--                 	<div class="selectname">接口图片存储文件夹路径：</div><div class="selectCon"><input class="selectInput" style=" width: 400px;" type="text" name="Imagepath" id="Imagepath" value="<%=Imagepath %>"></div><div class="selectname">例如H:\apache-tomcat-6.0.14\webapps\PTS\images\;选择tomcat服务器下的PTS\images\</div> -->
<!--                 </div> -->
				<br>
                <div class="select">
                	<div class="selectname">系统周期抓拍开始时间：</div><div class="selectCon"><input class="selectInput" style=" width: 400px;" type="text" name="imgStartTime" id="imgStartTime" value="<%=imgStartTime %>"></div><div class="selectname">例如06:00:00,全部为英文输入法，格式hh:mm:ss即时分秒</div>
                </div>
                <br>
				<div class="select">
                	<div class="selectname">系统周期抓拍结束时间：</div><div class="selectCon"><input class="selectInput" style=" width: 400px;" type="text" name="imgEndTime" id="imgEndTime" value="<%=imgEndTime %>"></div><div class="selectname">例如16:30:00,全部为英文输入法，格式hh:mm:ss即时分秒</div>
                </div>
				<br>
				<div class="select">
                	<div class="selectname">弧光非采样周期开始时间：</div><div class="selectCon"><input class="selectInput" style=" width: 400px;" type="text" name="huStartTime" id="huStartTime" value="<%=huStartTime %>"></div><div class="selectname">例如06:00:00,全部为英文输入法，格式hh:mm:ss即时分秒</div>
                </div>
                <br>
				<div class="select">
                	<div class="selectname">弧光非采样周期结束时间：</div><div class="selectCon"><input class="selectInput" style=" width: 400px;" type="text" name="huEndTime" id="huEndTime" value="<%=huEndTime %>"></div><div class="selectname">例如16:30:00,全部为英文输入法，格式hh:mm:ss即时分秒</div>
                </div>
				
                <div class="caozuo">
                    <i class="icon-indent-left"></i>
                   	<button id="selectD"  class="btn-add" type="submit">设置</button>
                </div>
            </div>
        </div>
        </form>
    </div>
   </body>
</html>
    
    
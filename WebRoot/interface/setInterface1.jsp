<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.spi.DirStateFactory.Result"%>
<%@ page contentType="text/html;charset=gbk" language="java" import="java.util.*" import="com.action.dataselect"  pageEncoding="gbk"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>���DSEP-2000����ͼ����������ʪ�Ȱ�ȫ���ϵͳ</title>
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
    	dataselect ds=new dataselect();
    	request.setCharacterEncoding("gbk");
    	if(request.getParameter("Imagepath")!=null)
		{
			String updateset="update Interface set Imagepath='"+request.getParameter("Imagepath")+"',imgStartTime='"+request.getParameter("imgStartTime")+"',imgEndTime='"+request.getParameter("imgEndTime")+"'";
			int i=ds.update(updateset);
			if(i>0)
			{
				out.print("<script>alert('���óɹ���');</script>");
			}
			else
			{
				out.print("<script>alert('����ʧ�ܣ��������ã�');</script>");
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
                   	 ��ҳ
                </a>
                <a class="current" href="#">
                   	 �ӿ�����
                </a>
            </div>
        </div>
        <form action="setInterface.jsp" method="post" id="formsub">
        <div id="content-field">
            <div class="box-title">
                <div class="select">
                	<div class="selectname">�ӿ�ͼƬ�洢�ļ���·����</div><div class="selectCon"><input class="selectInput" style=" width: 400px;" type="text" name="Imagepath" id="Imagepath" value="<%=Imagepath %>"></div><div class="selectname">����H:\apache-tomcat-6.0.14\webapps\PTS\images\;ѡ��tomcat�������µ�PTS\images\</div>
                </div>
                <div class="select">
                	<div class="selectname">ϵͳ����ץ�Ŀ�ʼʱ�䣺</div><div class="selectCon"><input class="selectInput" style=" width: 400px;" type="text" name="imgStartTime" id=imgStartTime value="<%=imgStartTime %>"></div><div class="selectname">����06:00:00,ȫ��ΪӢ�����뷨����ʽhh:mm:ss��ʱ����</div>
                </div>
                <div class="select">
                	<div class="selectname">ϵͳ����ץ�Ľ���ʱ�䣺</div><div class="selectCon"><input class="selectInput" style=" width: 400px;" type="text" name="imgEndTime" id="imgEndTime" value="<%=imgEndTime %>"></div><div class="selectname">����16:30:00,ȫ��ΪӢ�����뷨����ʽhh:mm:ss��ʱ����</div>
                </div>
                <div class="caozuo">
                    <i class="icon-indent-left"></i>
                   	<button id="selectD"  class="btn-add" type="submit">����</button>
                </div>
            </div>
        </div>
        </form>
    </div>
   </body>
</html>
    
    
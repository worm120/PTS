<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.spi.DirStateFactory.Result"%>
<%@ page contentType="text/html;charset=gbk" language="java" import="java.util.*" import="com.action.dataselect"  pageEncoding="gbk"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>���DSEP-2000����ͼ����������ʪ�Ȱ�ȫ���ϵͳ</title>
        <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
        <meta http-equiv="pragma" content="no-cache">
        <link href="../css/font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css">  
        <link  rel="stylesheet" type="text/css" href="../css/add_new.css">   
        <script src="../js/add/addDevice.js" charset="gbk" type="text/javascript"></script>
    </head>
    <body>
    <!--content start-->
    <div id="content">
        <div id="content-header">
            <div id="content-header-leader">
                <a class="tip-button">
                    <i class="icon icon-home"></i>
                   	 ��ҳ
                </a>
                <a class="current" href="#">
                	<i class="icon-double-angle-right"></i>
                   	 �豸����
                </a>
            </div>
        </div>
        <div id="content-field">
            <div class="box-title">
                <div class="checkall"><input name="title-checkbox" id="title-checkbox" type="checkbox"></div>
                <div class="quanxuan">ȫѡ</div>
                <div class="checktitle">�豸��ѯ������</div>
                <div class="select">
                	<div class="selectname">�豸��ţ�</div><div class="selectCon"><input class="selectInput"  type="text" name="DeviceId" id="DeviceId"></div>
                	<div class="selectname">�豸���ƣ�</div><div class="selectCon"><input class="selectInput"  type="text" name="DeviceName" id="DeviceName"></div>
                	<!--<div class="selectname">����ֵ��</div><div class="selectCon"><input class="selectInput"  type="text" name="DeviceFea" id="DeviceFea"></div>-->
                </div>
                <div class="caozuo">
                    <button id="selectD"  class="btn-add">��ѯ</button>
                    <i class="icon-plus"></i>
                    <button id="adds" class="btn-add" href="#">����</button>
                    <i class="icon-indent-left"></i>
                    <button id="changes" class="btn-edit" href="#">�༭</button> 
                    <i class="icon-remove-sign"></i>
                    <button id="dels" class="btn-del" href="#">ɾ��</button>
                    <!-- <i class="icon-wrench"></i>
                    	<button id="managed" class="btn-link" href="#">���������</button>
                     -->
                </div>
            </div>
            <div class="box-content" >
                <table class="table-style" id="listtable">
                  <thead>
                    <tr>
                        <th class="table-style-th" style="width:10px;text-align:center;"><i class="icon-resize-vertical"></i></th>
                        <th class="table-style-th">���</th>
                        <th class="table-style-th">���</th>
                        <th class="table-style-th">�豸����</th>
                        <th class="table-style-th">�豸����</th>
                        <th class="table-style-th">�豸��ַ</th>
						<!--  <th class="table-style-th">�豸����ֵ</th>-->
                        <th class="table-style-th">���������</th>
                        <th class="table-style-th">��ע</th>
                    </tr>
                  </thead>
                  <tbody>
                  	<%
                  		String sid=request.getParameter("sid");//��������
		    			dataselect ds=new dataselect();
		    			String sqls="select * from Device left join Substation on Substation.Substation_ID=Device.Substation_ID where Device.Substation_ID='"+sid+"'";
		    			if(request.getParameter("DeviceId")!=null&&request.getParameter("DeviceId").trim().equals("")==false&&request.getParameter("DeviceId").trim().equals("undefined")==false)
		    			{
		    				sqls=sqls+" and Device.Device_ID='"+request.getParameter("DeviceId")+"'";
		    			}
		    			else if(request.getParameter("DeviceName")!=null&&request.getParameter("DeviceName").trim().equals("")==false&&request.getParameter("DeviceName").trim().equals("undefined")==false)
		    			{
		    				String Sname=new String(request.getParameter("DeviceName").getBytes("ISO-8859-1"),"GB2312");
		    				sqls=sqls+" and Device.Device_Name='"+Sname+"'";
		    			}
		    			/*else if(request.getParameter("DeviceFea")!=null&&request.getParameter("DeviceFea").trim().equals("")==false&&request.getParameter("DeviceFea").trim().equals("undefined")==false)
		    			{
		    				sqls=sqls+" and Device.Device_Feature='"+request.getParameter("DeviceFea")+"'";
		    			}
		    			*/
		    			//System.out.println(sqls);
		    			ResultSet rs=ds.select(sqls);
		    			if(rs!=null)
		    			{	
		    				//out.print("<table id='listtable' class='listtable'><tr><td></td><td>���</td><td>��������� </td><td>��������ڵ�λ��</td><td>��ϵ�绰</td><td>�豸�� </td><td>��ע</td></tr>");
		    				int num=1;
		    				String Device_ID="";
	    					String Device_Name="";
	    					String Device_Card="";
	    					String Device_Place="";
	    					//String Device_Feature="";
	    					String Substation_Name="";
	    					String rem="";
		    				
		    				while(rs.next())
		    				{
		    					if(rs.getString("Device_ID")!=null&&rs.getString("Device_ID").equals("null")==false)
		    					{
		    						Device_ID=rs.getString("Device_ID").trim();
		    					}
		    					if(rs.getString("Device_Name")!=null&&rs.getString("Device_Name").equals("null")==false)
		    					{
		    						Device_Name=rs.getString("Device_Name").trim();
		    					}
		    					if(rs.getString("Device_Card")!=null&&rs.getString("Device_Card").equals("null")==false)
		    					{
		    						Device_Card=rs.getString("Device_Card").trim();
		    					}
		    					if(rs.getString("Device_Place")!=null&&rs.getString("Device_Place").equals("null")==false)
		    					{
		    						Device_Place=rs.getString("Device_Place").trim();
		    					}
		    					/*if(rs.getString("Device_Feature")!=null&&rs.getString("Device_Feature").equals("null")==false)
		    					{
		    						Device_Feature=rs.getString("Device_Feature").trim();
		    					}*/
		    					if(rs.getString("Substation_Name")!=null&&rs.getString("Substation_Name").equals("null")==false)
		    					{
		    						Substation_Name=rs.getString("Substation_Name").trim();
		    					}
		    					if(rs.getString("rem")!=null&&rs.getString("rem").equals("null")==false)
		    					{
		    						rem=rs.getString("rem").trim();
		    					}
		    					out.print("<tr><td class='table-style-td' style='width:10px;'><input type='checkbox' name='beixuan' id='beixuan' value='"+Device_ID+"'></td><td class='table-style-td' style='width:100px;'>"+num+"</td><td class='table-style-td'>"
		    					+Device_ID+"</td><td class='table-style-td'>"
		    					+Device_Name+" </td><td class='table-style-td'>"
		    					+Device_Card+"</td><td class='table-style-td'>"
		    					+Device_Place+"</td><td class='table-style-td'>"
								//+Device_Feature+" </td><td class='table-style-td'>"
		    					+Substation_Name+" </td><td class='table-style-td'>"
		    					+rem+"</td></tr>");
		    					num++;
		    					Device_ID="";
	    						Device_Name="";
	    						Device_Card="";
	    						Device_Place="";
	    						//Device_Feature="";
	    						Substation_Name="";
	    						rem="";
		    				}
		    				num=0;
		    			}
    				%>
                  </tbody>
                </table>
            </div>
        </div>
       <!--  <div id="content-foot"></div> -->
        
    </div>
    <!--content end-->
    
    <div id="add" > 
		
			<h4><span>����豸</span><span id="close">�ر�</span></h4>
			<div style="margin:15px;"></div>
			<div class="inputdiv">
				<div class="addname"><label>ѡ��������</label></div>
				<div class="addinput">
					<select id="Substation_ID"  class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'">
					<%
						sqls="select * from Substation where Substation_ID='"+request.getParameter("sid")+"'";
		    			ResultSet rs1=ds.select(sqls);
		    			if(rs1!=null)
		    			{	
		    				//out.print("<table id='listtable' class='listtable'><tr><td></td><td>���</td><td>�豸���� </td><td>�豸����</td><td>�豸��ַ</td><td>��������� </td><td>��ע</td></tr>");
		    				while(rs1.next())
		    				{
		    					out.println("<option value='"+rs1.getString("Substation_ID")+"'>"+rs1.getString("Substation_Name")+"</option>");
		    				}
		    			}
		    			rs1.close();
						ds.close();
					%>
				</select>
				</div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>��ţ�</label></div>
				<div class="addinput"><input disabled id="Device_ID" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /> </div>
			</div> 
		<form action="#" method="post" id="formsub">
			<div class="inputdiv">
				<div class="addname"><label>�豸���ƣ�</label></div>
				<div class="addinput"><input id="Device_Name" type="text" title="����30������" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /><font color="red">*</font></div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>�豸���ţ�</label></div>
				<div class="addinput"><input id="Device_Card" type="text" title="����10���ַ�" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>�豸��ַ��</label></div>
				<div class="addinput"><input id="Device_Place" type="text" title="����50������" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			<!-- 
			<div class="inputdiv">
				<div class="addname"><label>�豸����ֵ��</label></div>
				<div class="addinput"><input id="Device_Feature" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /><font color="red">*</font></div>
			</div> 
			  -->
			<div class="inputdiv">
				<div class="addname"><label>��ע��</label></div>
				<div class="addinput"><input id="rem" type="text" class="myinp" title="����200���ַ���100������" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			<p class="inputdiv">
			<input id="submitt" type="submit" value="�ύ" class="sub" />
			<input type="reset" value="����"  class="sub" />
			</p> 
			<input id="hid" type="hidden">
			<input id="hid_sid" type="hidden" value="<%=sid %>">
		</form>
	</div> 
    
    </body>
</html>


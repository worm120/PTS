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
        <script src="../js/add/add.js" charset="gbk" type="text/javascript"></script>
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
                   	 �����
                </a>
            </div>
        </div>
        <div id="content-field">
            <div class="box-title">
                <div class="checkall"><input name="title-checkbox" id="title-checkbox" type="checkbox"></div>
                <div class="quanxuan">ȫѡ</div>
                <div class="checktitle">���������</div>
                <div class="caozuo">
                    
                    <i class="icon-plus"></i>
                    <button id="adds" class="btn-add" href="#">����</button>
                    <i class="icon-indent-left"></i>
                    <button id="changes" class="btn-edit" href="#">�༭</button> 
                    <i class="icon-remove-sign"></i>
                    <button id="dels" class="btn-del" href="#">ɾ��</button>
                    <!-- <i class="icon-wrench"></i>
                    <button id="managed" class="btn-link" href="#">�����豸</button>
                     -->
                </div>
            </div>
            <div class="box-content">
                <table class="table-style" id="listtable">
                  <thead>
                    <tr>
                        <th class="table-style-th" style="width:10px;text-align:center;"><i class="icon-resize-vertical"></i></th>
                        <th class="table-style-th">���</th>
                        <th class="table-style-th">���</th>
                        <th class="table-style-th">���������</th>
                        <th class="table-style-th">����λ��</th>
                        <th class="table-style-th">��ϵ�绰</th>
                        <th class="table-style-th">�豸��</th>
                        <th class="table-style-th">��ע</th>
                    </tr>
                  </thead>
                  <tbody>
                  	<%
		    			dataselect ds=new dataselect();
		    			String sqls="select * from Substation";
		    			ResultSet rs=ds.select(sqls);
		    			if(rs!=null)
		    			{	
		    				//out.print("<table id='listtable' class='listtable'><tr><td></td><td>���</td><td>��������� </td><td>��������ڵ�λ��</td><td>��ϵ�绰</td><td>�豸�� </td><td>��ע</td></tr>");
		    				int num=1;
		    				while(rs.next())
		    				{
		    					out.print("<tr><td class='table-style-td' style='width:10px;'><input type='checkbox' name='beixuan' id='beixuan' value='"+rs.getString("Substation_ID")+"'></td><td class='table-style-td' style='width:100px;'>"+num+"</td><td class='table-style-td'>"
		    					+rs.getString("Substation_ID")+"</td><td class='table-style-td'>"
		    					+rs.getString("Substation_Name")+" </td><td class='table-style-td'>"
		    					+rs.getString("Substation_Place")+"</td><td class='table-style-td'>"
		    					+rs.getString("Substation_Tele")+"</td><td class='table-style-td'>"
		    					+rs.getInt("Substation_Device")+" </td><td class='table-style-td'>"
		    					+rs.getString("rem")+"</td></tr>");
		    					num++;
		    				}
		    				//out.print("</table>");
		    			}
		    			ds.close();
    				%>
                  </tbody>
                </table>
            </div>
        </div>
       <!--  <div id="content-foot"></div> -->
        
    </div>
    <!--content end-->
    
    <div id="add" > 
		<form action="#" method="post">
			<h4><span>��ӱ����</span><span id="close">�ر�</span></h4>
			<div style="margin:15px;"></div>
			<div class="inputdiv">
				<div class="addname"><label>��ţ�</label></div>
				<div class="addinput"><input disabled id="Substation_ID" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /> </div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>��������ƣ�</label></div>
				<div class="addinput"><input id="Substation_Name" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>�����λ�ã�</label></div>
				<div class="addinput"><input id="Substation_Place" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>��ϵ�绰��</label></div>
				<div class="addinput"><input id="Substation_Tele" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			<!-- 
			<div class="inputdiv">
				<div class="addname"><label>�豸����</label></div>
				<div class="addinput"><input id="Substation_Device" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			 -->
			<div class="inputdiv">
				<div class="addname"><label>��ע��</label></div>
				<div class="addinput"><input id="rem" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			<p class="inputdiv">
			<input id="submitt" type="submit" value="�ύ" class="sub" />
			<input type="reset" value="����"  class="sub" />
			</p> 
			<input id="hid" type="hidden">
		</form>
	</div> 
    
    </body>
</html>


<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.spi.DirStateFactory.Result"%>
<%@ page contentType="text/html;charset=gbk" language="java" import="java.util.*" import="com.action.dataselect"  pageEncoding="gbk"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>大成DSEP-2000电力图像智能与温湿度安全监测系统</title>
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
                   	 首页
                </a>
                <a class="current" href="#">
                   	 变电所
                </a>
            </div>
        </div>
        <div id="content-field">
            <div class="box-title">
                <div class="checkall"><input name="title-checkbox" id="title-checkbox" type="checkbox"></div>
                <div class="quanxuan">全选</div>
                <div class="checktitle">变电所管理</div>
                <div class="caozuo">
                    
                    <i class="icon-plus"></i>
                    <button id="adds" class="btn-add" href="#">新增</button>
                    <i class="icon-indent-left"></i>
                    <button id="changes" class="btn-edit" href="#">编辑</button> 
                    <i class="icon-remove-sign"></i>
                    <button id="dels" class="btn-del" href="#">删除</button>
                    <!-- <i class="icon-wrench"></i>
                    <button id="managed" class="btn-link" href="#">管理设备</button>
                     -->
                </div>
            </div>
            <div class="box-content">
                <table class="table-style" id="listtable">
                  <thead>
                    <tr>
                        <th class="table-style-th" style="width:10px;text-align:center;"><i class="icon-resize-vertical"></i></th>
                        <th class="table-style-th">序号</th>
                        <th class="table-style-th">编号</th>
                        <th class="table-style-th">变电所名称</th>
                        <th class="table-style-th">所在位置</th>
                        <th class="table-style-th">联系电话</th>
                        <th class="table-style-th">设备数</th>
                        <th class="table-style-th">备注</th>
                    </tr>
                  </thead>
                  <tbody>
                  	<%
		    			dataselect ds=new dataselect();
		    			String sqls="select * from Substation";
		    			ResultSet rs=ds.select(sqls);
		    			if(rs!=null)
		    			{	
		    				//out.print("<table id='listtable' class='listtable'><tr><td></td><td>编号</td><td>变电所名称 </td><td>变电所所在的位置</td><td>联系电话</td><td>设备数 </td><td>备注</td></tr>");
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
			<h4><span>添加变电所</span><span id="close">关闭</span></h4>
			<div style="margin:15px;"></div>
			<div class="inputdiv">
				<div class="addname"><label>编号：</label></div>
				<div class="addinput"><input disabled id="Substation_ID" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /> </div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>变电所名称：</label></div>
				<div class="addinput"><input id="Substation_Name" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>变电所位置：</label></div>
				<div class="addinput"><input id="Substation_Place" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>联系电话：</label></div>
				<div class="addinput"><input id="Substation_Tele" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			<!-- 
			<div class="inputdiv">
				<div class="addname"><label>设备数：</label></div>
				<div class="addinput"><input id="Substation_Device" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			 -->
			<div class="inputdiv">
				<div class="addname"><label>备注：</label></div>
				<div class="addinput"><input id="rem" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			<p class="inputdiv">
			<input id="submitt" type="submit" value="提交" class="sub" />
			<input type="reset" value="重置"  class="sub" />
			</p> 
			<input id="hid" type="hidden">
		</form>
	</div> 
    
    </body>
</html>


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
        <link  rel="stylesheet" type="text/css" href="../css/add.css">   
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
                   	 ʪ�ȱ�������
                </a>
            </div>
        </div>
        <div id="content-field">
            <div class="box-content" >
                <table class="table-style" id="listtable">
                  <thead>
                    <tr>
                        <th class="table-style-th">���</th>
                        <th class="table-style-th">���</th>
                        <th class="table-style-th">������</th>
                        <th class="table-style-th">ʪ��</th>
                        <th class="table-style-th">��������</th>
                        
                        <th class="table-style-th">���ع�</th>
                        <th class="table-style-th">�������ַ</th>
                        <th class="table-style-th">���������</th>
                        <th class="table-style-th">ֵ��Ա</th>
                        <th class="table-style-th">�����¼</th>
                        <th class="table-style-th"></th>
                    </tr>
                  </thead>
                  <tbody>
                  	<%
                  		String pid=request.getParameter("pid");//��������
		    			dataselect ds=new dataselect();
		    			String sqls="select * from AlarmLogHumidity  left join SampleDetail on SampleDetail.Sample_ID=AlarmLogHumidity.Sample_ID where AlarmLogHumidity.Sample_ID in(select Devpoint.Device_ID from Devpoint where pid='"+pid+"')";
		    			ResultSet rs=ds.select(sqls);
		    			if(rs!=null)
		    			{	
		    				//out.print("<table id='listtable' class='listtable'><tr><td></td><td>���</td><td>��������� </td><td>��������ڵ�λ��</td><td>��ϵ�绰</td><td>�豸�� </td><td>��ע</td></tr>");
		    				int num=1;
		    				String TemValue="";
		    				String AlarmType="";
		    				
		    				String Odate="";
		    				String Sdate="";
		    				String Cresult="";

		    				String Sample_ID="";
		    				String Sample_Name="";
		    				String Sample_Place="";
			
		    				String Device_ID="";
	    					String Device_Name="";

	    					String Substation_Name="";
	    					String rem="";
		    				String UID="";
		    				while(rs.next())
		    				{
		    					int index=0;
		    					index=rs.getInt("Id");
		    					if(rs.getString("UID")!=null&&rs.getString("UID").equals("null")==false)
		    					{
		    						UID=rs.getString("UID").trim();
		    					}
		    					if(rs.getString("Sample_ID")!=null&&rs.getString("Sample_ID").equals("null")==false)
		    					{
		    						Sample_ID=rs.getString("Sample_ID").trim();
		    					}
		    					if(rs.getString("Sample_Name")!=null&&rs.getString("Sample_Name").equals("null")==false)
		    					{
		    						Sample_Name=rs.getString("Sample_Name").trim();
		    					}
		    					if(rs.getString("HumValue")!=null&&rs.getString("HumValue").equals("null")==false)
		    					{
		    						TemValue=rs.getString("HumValue").trim();
		    					}
		    					if(rs.getString("AlarmType")!=null&&rs.getString("AlarmType").equals("null")==false)
		    					{
		    						AlarmType=rs.getString("AlarmType").trim();
		    						if(rs.getString("AlarmType").trim().equals("1"))
		    						{
		    							AlarmType="Ԥ��";
		    						}
		    						else if(rs.getString("AlarmType").trim().equals("2"))
		    						{
		    							AlarmType="����";
		    						}
		    					}
		    					if(rs.getString("Odate")!=null&&rs.getString("Odate").equals("null")==false)
		    					{
		    						Odate=rs.getString("Odate").trim();
		    					}
		    					if(rs.getString("Sdate")!=null&&rs.getString("Sdate").equals("null")==false)
		    					{
		    						Sdate=rs.getString("Sdate").trim();
		    					}
		    					if(rs.getString("Cresult")!=null&&rs.getString("Cresult").equals("null")==false)
		    					{
		    						Cresult=rs.getString("Cresult").trim();
		    					}

		    					if(rs.getString("Device_ID")!=null&&rs.getString("Device_ID").equals("null")==false)
		    					{
		    						Device_ID=rs.getString("Device_ID").trim();
		    					}
		    					if(rs.getString("Device_Name")!=null&&rs.getString("Device_Name").equals("null")==false)
		    					{
		    						Device_Name=rs.getString("Device_Name").trim();
		    					}
		    					if(rs.getString("Sample_Place")!=null&&rs.getString("Sample_Place").equals("null")==false)
		    					{
		    						Sample_Place=rs.getString("Sample_Place").trim();
		    					}
		    					if(rs.getString("Substation_Name")!=null&&rs.getString("Substation_Name").equals("null")==false)
		    					{
		    						Substation_Name=rs.getString("Substation_Name").trim();
		    					}
		    					if(rs.getString("rem")!=null&&rs.getString("rem").equals("null")==false)
		    					{
		    						rem=rs.getString("rem").trim();
		    					}
		    					out.print("<tr><td class='table-style-td'>"+num+"</td><td class='table-style-td'>"
		    					+index+"</td><td class='table-style-td'>"
		    					+Sample_Name+"("+Sample_ID+")"+"</td><td class='table-style-td'>"
		    					+TemValue+"</td><td class='table-style-td'>"
		    					+AlarmType+"</td><td class='table-style-td'>"
		    					+Device_Name+"</td><td class='table-style-td'>"
		    					+Sample_Place+"</td><td class='table-style-td'>"
		    					+Substation_Name+" </td><td class='table-style-td'>"
		    					+UID+" </td><td class='table-style-td'>"
		    					+Cresult+"</td><td class='table-style-td' style='width:10px;'><button class='btn-add' onClick='settle("+index+")'>����</button></td></tr>");
		    					
		    					num++;
		    					Device_ID="";
	    						Device_Name="";
	    						Sample_Name="";
	    						Sample_ID="";
	    						TemValue="";
	    						Substation_Name="";
	    						AlarmType="";
	    						Cresult="";
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
		<form action="#" method="post" id="formsub">
			<h4><span>����豸</span><span id="close">�ر�</span></h4>
			<div style="margin:15px;"></div>
			<div class="inputdiv">
				<div class="addname"><label>��¼��ţ�</label></div>
				<div class="addinput"><input disabled id="Id" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /> </div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>���봦����־��</label></div>
				<div class="addinput"><textarea id="Cresult" type="text" style="height:150px;" title="����200������" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'">������¼��</textarea><font color="red">*</font></div>
			</div> 
			<p class="inputdiv">
			<input id="submitt" type="submit" value="�ύ" class="sub" onClick="chuli()"/>
			<input type="reset" value="����"  class="sub" />
			</p> 
			<input id="hid" type="hidden">
			<input id="hid_sid" type="hidden" value="<% %>">
		</form>
	</div> 
    
    </body>
    <script type="text/javascript">
    	function chuli()
    	{
    		var alarmID=document.getElementById("Id").value;//��־���
    		var alarmcontent=document.getElementById("Cresult").value;//������־������
    		
    		//alert("fff");
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
				//�Ƿ���³ɹ�
				var result=xmlhttp.responseText;
			    if(result=="success")
			    {
			    	alert("�����ɹ���");
			    }
			    else
			    {
			    	alert("����ʧ�ܣ������¸��»���ӣ�");
			    }
			  }
			};
			//alert(svgid.toString());
			xmlhttp.open("GET","../servlet/settleAlarm?type=hum&alarmid="+alarmID+"&userid=kkk&alarmcontent="+alarmcontent+"&r="+new Date().getTime(),true);
			xmlhttp.send();
    	}
    	function settle(id)
    	{
    		var myAlert = document.getElementById("add"); 
    		myAlert.style.display = "block"; 
			myAlert.style.position = "absolute"; 
			myAlert.style.top = "50%"; 
			myAlert.style.left = "50%"; 
			myAlert.style.marginTop = "-150px"; 
			myAlert.style.marginLeft = "-200px"; 
			myAlert.style.zIndex = "501"; 
			
			mybg = document.createElement("div"); 
			mybg.setAttribute("id","mybg"); 
			mybg.style.background = "#000"; 
			mybg.style.width = "100%"; 
			mybg.style.height = "100%"; 
			mybg.style.position = "absolute"; 
			mybg.style.top = "0"; 
			mybg.style.left = "0"; 
			mybg.style.zIndex = "500"; 
			mybg.style.opacity = "0.3"; 
			mybg.style.filter = "Alpha(opacity=30)"; 
			document.body.appendChild(mybg); 
			document.body.style.overflow = "hidden";

			document.getElementById("Id").value=id;
			
			
	
    	}
    	var mClose = document.getElementById("close");
    	mClose.onclick = function() 
		{ 
			document.getElementById("add").style.display = "none"; 
			mybg.style.display = "none"; 
			document.getElementById("Id").value="";
			document.getElementById("Cresult").value="";
		};

    </script>
</html>


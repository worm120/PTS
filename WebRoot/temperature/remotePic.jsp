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
        <!-- <script src="../js/online/getRemotePic.js" charset="gbk" type="text/javascript"></script>-->
        
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
                   	 Զ��ͼ��
                </a>
            </div>
        </div>
        <div id="content-field">
            <div class="box-title">
                <div class="checkall"><input name="title-checkbox" id="title-checkbox" type="checkbox"></div>
                <!--  <div class="quanxuan">ȫѡ</div>-->
                <div class="checktitle">ѡ��ͼ�������Զ������ͼ��</div>
                <div class="caozuo">
                    <i class="icon-wrench"></i>
                    <button id="adds" class="btn-add" href="#">����ͼ��</button>
                </div>
            </div>
            <div class="box-content">
                <table class="table-style" id="listtable">
                  <thead>
                    <tr>
                        <th class="table-style-th" style="width:10px;text-align:center;"><i class="icon-resize-vertical"></i></th>
                        <th class="table-style-th">���</th>
                        <th class="table-style-th">���</th>
                        <th class="table-style-th">����������</th>          
						<th class="table-style-th">����������</th>
						<th class="table-style-th">�����㰲װ��ַ</th>
						<th class="table-style-th">�����豸</th>
                        <th class="table-style-th">���������</th>
                        <th class="table-style-th">�豸id</th>
                        <th class="table-style-th">Ŀ�ĵ�ַ</th>
                        <th class="table-style-th">�˿ں�</th>
                        <th class="table-style-th">����ͷID||λ��</th>
                        <th class="table-style-th">������ʼ��ַH</th>
                        <th class="table-style-th">������ʼ��ַL</th>
                        <th class="table-style-th">���ݳ���</th>
                        <th class="table-style-th">��ע</th>
                    </tr>
                  </thead>
                  <tbody>
                  	<%
                  		String pid=request.getParameter("nodeid");
                  		String sid=request.getParameter("sid");
		    			dataselect ds=new dataselect();
		    			String sqls="select * from Sample left join Substation on Substation.Substation_ID=Sample.Substation_ID left join Device on Device.Device_ID=Sample.Device_ID left join DeviceSet on DeviceSet.Device_ID=Sample.Device_ID left join SampleAddress on SampleAddress.Sample_ID=Sample.Sample_ID where  Sample.Sample_ID in(select Sample.Sample_ID from Sample where Sample_Type='00' and Sample.Device_ID in(select Devpoint.Device_ID from Devpoint where pid='"+pid+"')) and Device_Address is not null and Sample_AddressH is not null order by Sample.Substation_ID,Sample.Device_ID";
		    			//sqls="select * from Sample left join Substation on Substation.Substation_ID=Sample.Substation_ID left join Device on Device.Device_ID=Sample.Device_ID left  left join SampleAddress on SampleAddress.Sample_ID=Sample.Sample_ID where Sample_ID in(select Sample_ID from Sample,SampleAddress where Sample.Sample_ID=SampleAddress.Sample_ID and Sample.Sample_Type='0' and Device_Address is not null and Sample_AddressH is not null) order by Sample.Substation_ID,Sample.Device_ID";
		    			//String sqls=" select Sample.Sample_ID from Sample where Sample_Type='00' and Sample.Device_ID in(select Devpoint.Device_ID from Devpoint where pid='"+pid+"')";
		    			
		    			
		    			
		    			ResultSet rs=ds.select(sqls);
		    			if(rs!=null)
		    			{	
		    				//out.print("<table id='listtable' class='listtable'><tr><td></td><td>���</td><td>��������� </td><td>��������ڵ�λ��</td><td>��ϵ�绰</td><td>�豸�� </td><td>��ע</td></tr>");
		    				int num=1;
		    				
		    				String type="";
		    				String Sample_ID="";
	    					String Sample_Name="";
	    					String Sample_Place="";
	    					String Device_Name="";
	    					String Substation_Name="";
	    					String Device_Addr="";
	    					String Sample_AddressH="";
	    					String Sample_AddressL="";
	    					String Device_IP="";
	    					String Device_Port="";
	    					
	    					String Sample_IndexID="";
	    					String Sample_dataL="";
	    					String rem="";
		    				
		    				while(rs.next())
		    				{
		    					//String type="";
		    					if(rs.getString("Sample_Type").equals("01"))
		    					{
		    						type="�¶�";
		    					}
		    					else if(rs.getString("Sample_Type").equals("00"))
		    					{
		    						type="ͼ��";
		    					}
		    					
		    					if(rs.getString("Sample_ID")!=null&&rs.getString("Sample_ID").equals("null")==false)
		    					{
		    						Sample_ID=rs.getString("Sample_ID").trim();
		    					}
		    					if(rs.getString("Sample_Name")!=null&&rs.getString("Sample_Name").equals("null")==false)
		    					{
		    						Sample_Name=rs.getString("Sample_Name").trim();
		    					}
		    					if(rs.getString("Sample_Place")!=null&&rs.getString("Sample_Place").equals("null")==false)
		    					{
		    						Sample_Place=rs.getString("Sample_Place").trim();
		    					}
		    					if(rs.getString("Device_Name")!=null&&rs.getString("Device_Name").equals("null")==false)
		    					{
		    						Device_Name=rs.getString("Device_Name").trim();
		    					}
		    					if(rs.getString("Substation_Name")!=null&&rs.getString("Substation_Name").equals("null")==false)
		    					{
		    						Substation_Name=rs.getString("Substation_Name").trim();
		    					}
		    					if(rs.getString("Device_Addr")!=null&&rs.getString("Device_Addr").equals("null")==false)
		    					{
		    						Device_Addr=rs.getString("Device_Addr").trim();
		    					}
		    					if(rs.getString("Device_IP")!=null&&rs.getString("Device_IP").equals("null")==false)
		    					{
		    						Device_IP=rs.getString("Device_IP").trim();
		    					}
		    					if(rs.getString("Device_Port")!=null&&rs.getString("Device_Port").equals("null")==false)
		    					{
		    						Device_Port=rs.getString("Device_Port").trim();
		    					}
		    					if(rs.getString("Sample_AddressH")!=null&&rs.getString("Sample_AddressH").equals("null")==false)
		    					{
		    						Sample_AddressH=rs.getString("Sample_AddressH").trim();
		    					}
		    					if(rs.getString("Sample_AddressL")!=null&&rs.getString("Sample_AddressL").trim().equals("null")==false)
		    					{
		    						Sample_AddressL=rs.getString("Sample_AddressL").trim();
		    					}
		    					
		    					if(rs.getString("Sample_IndexID")!=null&&rs.getString("Sample_IndexID").equals("null")==false)
		    					{
		    						Sample_IndexID=rs.getString("Sample_IndexID").trim();
		    					}
		    					if(rs.getString("Sample_dataL")!=null&&rs.getString("Sample_dataL").equals("null")==false)
		    					{
		    						Sample_dataL=rs.getString("Sample_dataL").trim();
		    					}
		    					
		    					if(rs.getString("rem")!=null&&rs.getString("rem").equals("null")==false)
		    					{
		    						rem=rs.getString("rem").trim();
		    					}
		    					
		    					out.print("<tr><td class='table-style-td' style='width:10px;'><input type='checkbox' name='beixuan' id='beixuan' value='"+Sample_ID+"'></td><td class='table-style-td' style='width:50px;'>"+num+"</td><td class='table-style-td'>"
		    					+Sample_ID+"</td><td class='table-style-td'>"
		    					+Sample_Name+"</td><td class='table-style-td'>"
		    					+type+"</td><td class='table-style-td'>"
		    					+Sample_Place+"</td><td class='table-style-td'>"
								+Device_Name+"</td><td class='table-style-td'>"
								+Substation_Name+"</td><td class='table-style-td'>"
								+Device_Addr+"</td><td class='table-style-td'>"
								+Device_IP+"</td><td class='table-style-td'>"
								+Device_Port+"</td><td class='table-style-td'>"
								+Sample_IndexID+"</td><td class='table-style-td'>"
		    					+Sample_AddressH+"</td><td class='table-style-td'>"
		    					+Sample_AddressL+"</td><td class='table-style-td'>"
		    					+Sample_dataL+"</td><td class='table-style-td'>"
		    					+rs.getString("rem")+"</td></tr>");
		    					num++;
		    					type="";
		    					Sample_ID="";
	    						Sample_Name="";
	    						Sample_Place="";
	    						Device_Name="";
	    						Substation_Name="";
	    						Device_Addr="";
	    						Sample_AddressH="";
	    						Sample_AddressL="";
	    						Device_IP="";
	    						Device_Port="";
	    					
	    						Sample_IndexID="";
	    						Sample_dataL="";
	    						rem="";
		    				}
		    				//out.print("</table>");
		    			}
    				%>
                  </tbody>
                </table>
            </div>
        </div>
       <!--  <div id="content-foot"></div> -->

    </div>
    <!--content end-->
	
	
    </body>
    <script type="text/javascript">
    	var myAlert = document.getElementById("add"); 
		var reg = document.getElementById("adds"); 
		var mClose = document.getElementById("close");
		var sub=document.getElementById("submitt");
	
		var selectall=document.getElementById("title-checkbox");
		
		var setindex;
		reg.onclick = function() 
		{ 
			var checkb=document.all("beixuan");
			var flag=0;
			var index=-1;
			if(typeof(checkb.length)=="undefined")
			{
				if(document.getElementById("beixuan").checked==true)
				{
					flag++;
					index=0;
				}
			}
			else
			{
				for(var i=0;i<checkb.length;i++)
				{
					//alert(checkb.length);
					if(checkb[i].checked==true)
					{
						flag++;
						index=i;
					}
				}
			}
			if(flag<=0)
			{
				alert("��ѡ��һ��ͼ�������������㣡");
			}
			else if(flag>1)
			{
				alert("ÿ��ֻ�ܶ�һ��ͼ����������Զ�����㣡");
			}
			else
			{
				//alert("sss");
				//document.getElementById("hid").value="update";
				var tb=document.getElementById("listtable");
				index=index+1;
				
				/*Substation_ID.value=tb.rows[index].cells[6].innerHTML;
				document.getElementById("Sample_ID").value=tb.rows[index].cells[2].innerHTML;
				document.getElementById("Device_Address").value=tb.rows[index].cells[8].innerHTML;
				document.getElementById("Sample_AddressH").value=tb.rows[index].cells[9].innerHTML;
				document.getElementById("Sample_AddressL").value=tb.rows[index].cells[10].innerHTML;
				
				var Sample_ID=document.getElementById("Sample_ID");
				
				var Device_Address=tb.rows[index].cells[8].innerHTML;
				var ipText=tb.rows[index].cells[9].innerHTML;
				var portText=tb.rows[index].cells[10].innerHTML;
				
				var Sample_AddressH=tb.rows[index].cells[12].innerHTML;
				var Sample_AddressL=tb.rows[index].cells[13].innerHTML;
				var Sample_dataL=tb.rows[index].cells[14].innerHTML;*/
				var index_id=tb.rows[index].cells[11].innerHTML;
				window.open("getRemotePic.jsp?index_id="+index_id,"hhhhhhhhhhhh","resizable=yes,height=300px,width=350px,top=30px,left=30px,scrollbars=yes");
				
				/*
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
					//���ݷ��ص�ͼ���ļ�����ʾͼ��
					    var result=xmlhttp.responseText;
					    //alert(result);
					    if(result!="none")
					    {
					    	//alert("��������ͳɹ������ڽ������ݣ������ĵȴ�����Լ1�ְ��Ӻ���ͼ��Ѳ���пƲ鿴�����ĵ�ͼ�񣡣�");
					    	//document.getElementById("wrapper").innerHTML="<img src='../liangw/images/photo/"+result+"'>";
					    	//document.getElementById("wrapper").innerHTML="<div class='load-bar'><div class='load-bar-inner' data-loading='0'> <span id='counter'></span> </div></div><h1>Loading</h1><p>�����ϴ��У����Ժ�...</p>";
					    	//document.getElementById("wrapper").style.display="block";
							//alert("opjjen");
							//showImg();
							imgpath=result;
					    }
					    else
					    {
					    	alert("����ʧ�ܣ����������㣡");
					    }
					    window.location.href=window.location.href; 
					    window.location.reload;    
				  }
				};
				xmlhttp.open("GET","../servlet/remoteGetPic?index_id="+index_id+"&t="+new Date().getTime(),true);
				xmlhttp.send();
				*/
			}
		} ;
		
    </script>
</html>


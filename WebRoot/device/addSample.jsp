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
        <!-- <script src="../js/add/addSample.js" charset="gbk" type="text/javascript"></script> -->
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
                   	 ���������
                </a>
            </div>
        </div>
        <div id="content-field">
            <div class="box-title">
                <div class="checkall"><input name="title-checkbox" id="title-checkbox" type="checkbox"></div>
                <div class="quanxuan">ȫѡ</div>
                <div class="checktitle">��ѯ����</div>
                <div class="select">
                	<div class="selectname">�������ţ�</div><div class="selectCon"><input class="selectInput"  type="text" name="sampleId" id="sampleId" ></div>
                	<div class="selectname">���������ƣ�</div><div class="selectCon"><input class="selectInput"  type="text" name="sampleName" id="sampleName" ></div>
                	<div class="selectname">���ͣ�</div><div class="selectCon"><select name="seceltType" id="seceltType"><option value="no">---����---</option><option value="01">�¶�</option><option value="00">ͼ��</option><option value="02">����</option><option value="03">ʪ��</option></select></div>
                	
                	<div class="selectname">�����豸��</div>
                	<div class="selectCon">
                		<select name="seceltDeviceID" id="seceltDeviceID">
                			<option value="no">---ѡ���豸---</option>
                			<%
						    	dataselect ds=new dataselect();
						    	String sid=request.getParameter("sid");//��������
						    	String getdevice="select * from Device where Substation_ID='"+sid+"'";
						    	ResultSet rs=ds.select(getdevice);
						    	String deviceSelect=""; 
						    	if(rs!=null)
						    	{
						    		while(rs.next())
						    		{
						    			out.print("<option value='"+rs.getString("Device_ID")+"'>"+rs.getString("Device_Name")+"</option>");
						    			deviceSelect=deviceSelect+"<option value='"+rs.getString("Device_ID")+"'>"+rs.getString("Device_Name")+"</option>";
						    		}
						    	}
						     %>
                		</select>
                	</div>
                </div>
                <div class="caozuo">
                    <button id="selectS"  class="btn-add">��ѯ</button>
                    <i class="icon-plus"></i>
                    <button id="adds" class="btn-add" href="#">����</button>
                    <i class="icon-indent-left"></i>
                    <button id="changes" class="btn-edit" href="#">�༭</button> 
                    <i class="icon-remove-sign"></i>
                    <button id="dels" class="btn-del" href="#">ɾ��</button>
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
                        <th class="table-style-th">������λ��</th>
						<th class="table-style-th">�����豸</th>
                        <th class="table-style-th">���������</th>
                        <th class="table-style-th">��ע</th>
                    </tr>
                  </thead>
                  <tbody>
                  	<%
		    			String sqls="select * from Sample left join Substation on Substation.Substation_ID=Sample.Substation_ID left join Device on Device.Device_ID=Sample.Device_ID where Sample.Substation_ID='"+sid+"'";
		    			if(request.getParameter("sampleId")!=null&&request.getParameter("sampleId").trim().equals("")==false&&request.getParameter("sampleId").trim().equals("undefined")==false)
		    			{
		    				sqls=sqls+" and Sample.Sample_ID='"+request.getParameter("sampleId")+"'";
		    			}
		    			else if(request.getParameter("sampleName")!=null&&request.getParameter("sampleName").trim().equals("")==false&&request.getParameter("sampleName").trim().equals("undefined")==false)
		    			{
		    				String Sname=new String(request.getParameter("sampleName").getBytes("ISO-8859-1"),"GB2312");
		    				sqls=sqls+" and Sample.Sample_Name='"+Sname+"'";
		    			}
		    			else if(request.getParameter("seceltType")!=null&&request.getParameter("seceltType").equals("no")==false)
		    			{
		    				sqls=sqls+" and Sample.Sample_Type='"+request.getParameter("seceltType")+"'";
		    			}
		    			else if(request.getParameter("seceltDeviceID")!=null&&request.getParameter("seceltDeviceID").equals("no")==false)
		    			{
		    				sqls=sqls+" and Sample.Device_ID='"+request.getParameter("seceltDeviceID")+"'";
		    			}
						
						//sqls=sqls+" order by Sample.Device_ID";
						sqls=sqls+" order by Sample.Device_ID asc,Sample.Sample_Type";

						
		    			rs=ds.select(sqls);
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
	    					String rem="";
		    				while(rs.next())
		    				{
		    					//System.out.println(num);
		    					if(rs.getString("Sample_Type")!=null&&rs.getString("Sample_Type").equals("01"))
		    					{
		    						type="�¶�";
		    					}
		    					else if(rs.getString("Sample_Type")!=null&&rs.getString("Sample_Type").equals("00"))
		    					{
		    						type="ͼ��";
		    					}
		    					else if(rs.getString("Sample_Type")!=null&&rs.getString("Sample_Type").equals("02"))
		    					{
		    						type="����";
		    					}
		    					else if(rs.getString("Sample_Type")!=null&&rs.getString("Sample_Type").equals("03"))
		    					{
		    						type="ʪ��";
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
		    					if(rs.getString("rem")!=null&&rs.getString("rem").equals("null")==false)
		    					{
		    						rem=rs.getString("rem").trim();
		    					}
		    					out.print("<tr><td class='table-style-td' style='width:10px;'><input type='checkbox' name='beixuan' id='beixuan' value='"+Sample_ID+"'></td><td class='table-style-td' style='width:100px;'>"+num+"</td><td class='table-style-td'>"
		    					+Sample_ID+"</td><td class='table-style-td'>"
		    					+Sample_Name+" </td><td class='table-style-td'>"
		    					+type+"</td><td class='table-style-td'>"
		    					+Sample_Place+"</td><td class='table-style-td'>"
								+Device_Name+" </td><td class='table-style-td'>"
		    					+Substation_Name+" </td><td class='table-style-td'>"
		    					+rem+"</td></tr>");
		    					num++;
		    					type="";
		    					Sample_ID="";
	    						Sample_Name="";
	    						Sample_Place="";
	    						Device_Name="";
	    						Substation_Name="";
	    						rem="";
		    				}
		    				//out.print("</table>");
		    			}
		    			//rs.close();
    				%>
                  </tbody>
                </table>
            </div>
        </div>
       <!--  <div id="content-foot"></div> -->
        
    </div>
    <!--content end-->
    
    <div id="add"> 
			<h4><span>��Ӳ�����</span><span id="close">�ر�</span></h4>
			<div style="margin:15px;"></div>
			<div class="inputdiv">
				<div class="addname"><label>ѡ��������</label></div>
				<div class="addinput">
					<select id="Substation_ID"  class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'">
					<%
						sqls="select * from Substation where Substation_ID='"+sid+"'";
		    			rs=ds.select(sqls);
		    			if(rs!=null)
		    			{	
		    				//out.print("<table id='listtable' class='listtable'><tr><td></td><td>���</td><td>�豸���� </td><td>�豸����</td><td>�豸��ַ</td><td>��������� </td><td>��ע</td></tr>");
		    				while(rs.next())
		    				{
		    					out.println("<option value='"+rs.getString("Substation_ID")+"'>"+rs.getString("Substation_Name")+"</option>");
		    				}
		    			}
		    			rs.close();
						ds.close();
					%>
				</select> 
				</div>
			</div> 
			
			<div class="inputdiv">
				<div class="addname"><label>ѡ���豸��</label></div>
				<div class="addinput">
					<select id="Device_ID"  class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'">
						<option value="first">---��ѡ���豸---</option>
						<%=deviceSelect %>
					</select> 
				</div>
			</div> 
			
			<div class="inputdiv">
				<div class="addname"><label>��ţ�</label></div>
				<div class="addinput"><input disabled id="Sample_ID" type="text" class="myinp"  onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /> </div>
			</div>
		<form action="#" method="post" id="formsub"> 
			<div class="inputdiv">
				<div class="addname"><label>���������ƣ�</label></div>
				<div class="addinput"><input id="Sample_Name" type="text" class="myinp" title="����25������" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /><font color="red">*</font></div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>λ�ã�</label></div>
				<div class="addinput"><input id="Sample_Place" type="text" class="myinp" title="����50������" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>���ͣ�</label></div>
				<div class="addinput">
					<select id="Sample_Type"  class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'">
						<option value="01">�¶�</option>
						<option value="00">ͼ��</option>
						<option value="02">����</option>
						<option value="03">ʪ��</option>
					</select> 
				</div>
			</div> 

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
    <script>
    	(function()
		{
			setTimeout("init()",300);
		}());
		
		function init()
		{
			//alert("1");
			var myAlert = document.getElementById("add"); 
			var reg = document.getElementById("adds"); 
			var mClose = document.getElementById("close");
			var sub=document.getElementById("submitt");
			var change=document.getElementById("changes");
			var deletes=document.getElementById("dels");
			var subidd=document.getElementById("Substation_ID");
			var devid=document.getElementById("Device_ID");
			var selectall=document.getElementById("title-checkbox");
			reg.onclick = function() 
			{ 
				var myAlert = document.getElementById("add"); 
				myAlert.style.display = "block"; 
				myAlert.style.position = "fixed"; 
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
				mybg.style.position = "fixed"; 
				mybg.style.top = "0"; 
				mybg.style.left = "0"; 
				mybg.style.zIndex = "500"; 
				mybg.style.opacity = "0.3"; 
				mybg.style.filter = "Alpha(opacity=30)"; 
				document.body.appendChild(mybg); 
			
				document.body.style.overflow = "hidden";
				//��ȡ�Զ����
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
					//���ݷ��صı�����������Զ����
					    var result=xmlhttp.responseText;
					    //alert(result);
		
					    document.getElementById("Sample_ID").value=result;
				  }
				};
				xmlhttp.open("GET","../servlet/getNewSampleId?t="+new Date().getTime(),true);
				xmlhttp.send();
			} ;
		
			mClose.onclick = function() 
			{ 
				var myAlert = document.getElementById("add"); 
				myAlert.style.display = "none"; 
				//document.getElementById("mybg").style.display = "none"; 
				document.body.removeChild(document.getElementById("mybg"));
				
				document.body.style.overflow = "auto"; 

				document.getElementById("Sample_ID").value="";
				document.getElementById("Sample_Name").value="";
				//document.getElementById("Substation_ID").value="";
				//document.getElementById("Device_ID").innerHTML="<option value='first'>---��ѡ���豸---</option>";
				document.getElementById("rem").value="";
				document.getElementById("hid").value="insert";
			} ;
			
			selectall.onchange=function()
			{
				var checkb=document.all("beixuan");
				var flag=0;
				if(typeof(checkb.length)=="undefined")
				{
					if(document.getElementById("beixuan").checked===true)
					{
						document.getElementById("beixuan").checked=false;
					}
					else
					{
						document.getElementById("beixuan").checked=true;
					}
				}
				else
				{
					for(var i=0;i<checkb.length;i++)
					{
						if(checkb[i].checked===false)
						{
							flag=1;
						}
					}
					
					if(flag==1)
					{
						for(var i=0;i<checkb.length;i++)
						{
							checkb[i].checked=true;
						}
					}
					else
					{
						for(var i=0;i<checkb.length;i++)
						{
							checkb[i].checked=false;
						}
					}
				}
			};
			
			
			document.getElementById("selectS").addEventListener("click", selectSamples, false);
			sub.addEventListener("click", sure, false);
			change.addEventListener("click", changeSam, false);
			deletes.addEventListener("click", deleteSam, false);
			subidd.addEventListener("change", subidchange, false);
			document.getElementById("hid").value="insert";
		}
		
		function selectSamples()
		{
			document.getElementById("formsub").action="addSample.jsp?sid="+document.getElementById("hid_sid").value+"&sampleId="+document.getElementById("sampleId").value+"&sampleName="+document.getElementById("sampleName").value+"&seceltType="+document.getElementById("seceltType").value+"&seceltDeviceID="+document.getElementById("seceltDeviceID").value;
			document.getElementById("formsub").submit();
		}
		
		function subidchange()
		{
			//alert("ff");
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
				//���ض�Ӧ��������豸
				    var result=xmlhttp.responseXML.getElementsByTagName("device");
				    var selectString="";
				    
					for(var i=0;i<result.length;i++)
					{
						//alert(i);
						var id=result[i].getElementsByTagName("deviceId")[0].childNodes[0].nodeValue;
						var value=result[i].getElementsByTagName("deviceValue")[0].childNodes[0].nodeValue;
						//alert(result[i].childNodes[1].childNodes[0].nodeValue);
						selectString=selectString+"<option value="+id+">"+value+"</option>";
					}
					document.getElementById("Device_ID").innerHTML=selectString;
			  }
			};
			var sid=document.getElementById("Substation_ID").options[document.getElementById("Substation_ID").selectedIndex].value;
			xmlhttp.open("GET","../servlet/getDevice?sid="+sid+"&t="+new Date().getTime(),true);
			xmlhttp.send();
		}
		function sure()
		{
			//alert("2");
			var Sample_ID=document.getElementById("Sample_ID");
			var Sample_Name=document.getElementById("Sample_Name");
			var Device_ID=document.getElementById("Device_ID");
			var Substation_ID=document.getElementById("Substation_ID");
			var Sample_Type=document.getElementById("Sample_Type");
			var Sample_Place=document.getElementById("Sample_Place");
			var rem=document.getElementById("rem");
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
				//���ݷ��ص��豸�����Ϣ��������ͼ�ϵĽڵ�
				    var result=xmlhttp.responseText;
				    if(result.indexOf("success")>=0)
				    {
				    	alert("�����ɹ���");
				    }
				    else
				    {
				    	alert("����ʧ�ܣ������¸��»���ӣ�");
				    }
				    window.location.href=window.location.href; 
				    window.location.reload();    
			  }
			};
			var type="insert";
			if(document.getElementById("hid").value=="update")
			{
				type="update";
			}
			
			if(Sample_Name.value.length>=50)
			{
				alert("���������Ƴ��Ȳ��ܳ���50���ַ���25�����֣����������룡");
			}
			else if(Sample_Place.value.length>=100)
			{
				alert("��װ��ַ���Ȳ��ܳ���100���ַ���50�����֣����������룡");
			}
			else if(rem.value.length>50)
			{
				alert("��ע���Ȳ��ܳ���200���ַ���100�����֣����������룡");
			}
			else
			{
				xmlhttp.open("GET","../servlet/addSample?Substation_ID="+Substation_ID.options[Substation_ID.selectedIndex].value+"&Device_ID="+Device_ID.options[Device_ID.selectedIndex].value+"&Sample_Type="+Sample_Type.options[Sample_Type.selectedIndex].value+"&Sample_ID="+Sample_ID.value+"&Sample_Name="+Sample_Name.value+"&Sample_Place="+Sample_Place.value+"&rem="+rem.value+"&type="+type+"&t="+new Date().getTime(),true);
				xmlhttp.send();
			}
			
		}
		function changeSam()
		{
			var checkb=document.all("beixuan");
			var Substation_ID=document.getElementById("Substation_ID");
			var Sample_Type=document.getElementById("Sample_Type");
			//alert(checkb.length);
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
					if(checkb[i].checked===true)
					{
						flag++;
						index=i;
					}
				}
			}
			
			if(flag<=0)
			{
				alert("��ѡ��һ����¼�����޸ģ�");
			}
			else if(flag>1)
			{
				alert("ÿ��ֻ�ܶ�һ����¼�����޸ģ�");
			}
			else
			{
				//alert("sss");
				document.getElementById("hid").value="update";
				var tb=document.getElementById("listtable");
				index=index+1;
				document.getElementById("Sample_ID").value=tb.rows[index].cells[2].innerHTML;
				document.getElementById("Sample_Name").value=tb.rows[index].cells[3].innerHTML;
				document.getElementById("Sample_Place").value=tb.rows[index].cells[5].innerHTML;
				document.getElementById("rem").value=tb.rows[index].cells[8].innerHTML;
				
				var temp = tb.rows[index].cells[4].innerHTML;
				//alert(temp);
				var selectString="";
				var value="01";
				if(temp=="�¶�"){
					value = "01";
					selectString=selectString+"<option value="+value+">"+temp+"</option>"+"<option value="+'00'+">"+'ͼ��'+"</option>"+"<option value="+'02'+">"+'����'+"</option>"+"<option value="+'03'+">"+'ʪ��'+"</option>";
					document.getElementById("Sample_Type").innerHTML=selectString;	
					}
				else if (temp =="ͼ��"){
					value="00";
					selectString=selectString+"<option value="+value+">"+temp+"</option>"+"<option value="+'01'+">"+'�¶�'+"</option>"+"<option value="+'02'+">"+'����'+"</option>"+"<option value="+'03'+">"+'ʪ��'+"</option>";
					document.getElementById("Sample_Type").innerHTML=selectString;
					}
				else if (temp =="����"){
					value="02";
					selectString=selectString+"<option value="+value+">"+temp+"</option>"+"<option value="+'00'+">"+'ͼ��'+"</option>"+"<option value="+'01'+">"+'�¶�'+"</option>"+"<option value="+'03'+">"+'ʪ��'+"</option>";
					document.getElementById("Sample_Type").innerHTML=selectString;
					}
				else if (temp =="ʪ��"){
					value="03";
					selectString=selectString+"<option value="+value+">"+temp+"</option>"+"<option value="+'00'+">"+'ͼ��'+"</option>"+"<option value="+'01'+">"+'�¶�'+"</option>"+"<option value="+'02'+">"+'����'+"</option>";
					document.getElementById("Sample_Type").innerHTML=selectString;
					}
			
				
		
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
			}
		}
		
		function deleteSam()
		{
			var sid=new Array();
			
			
			var checkb=document.all("beixuan");
			//alert(checkb.length);
			var flag=0;
			var index=0;
			if(typeof(checkb.length)=="undefined")
			{
				sid=document.getElementById("beixuan").value;
			}
			else
			{
				for(var i=0;i<checkb.length;i++)
				{
					//alert(checkb.length);
					if(checkb[i].checked===true)
					{
						sid[index]=checkb[i].value;
						index++;
					}
				}
			}
			
			/*����ѡ�еĴ�ɾ����Id����ת��Ϊ�ַ�ת�ϴ�����������*/
			var id=sid.toString();
			
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
				//���سɹ�ɾ����¼��
				    var result=xmlhttp.responseText;
				    alert("�ɹ�ɾ��"+result+"����¼");
			    	window.location.href=window.location.href; 
				    //window.location.reload(); 
			  }
			};
			xmlhttp.open("GET","../servlet/deleteSample?sid="+id+"&t="+new Date().getTime(),true);
			xmlhttp.send();
		
		}
    </script>
</html>


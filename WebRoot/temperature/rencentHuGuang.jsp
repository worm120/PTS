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
                   	 ��������¼
                </a>
            </div>
        </div>
        <div id="content-field">
            <div class="box-title">
                
            </div>
            <div class="box-content" >
                <table class="table-style" id="listtable">
                  <thead>
                    <tr>
                        <!--<th class="table-style-th" style="width:10px;text-align:center;"><i class="icon-resize-vertical"></i></th>-->
                        <th class="table-style-th">���</th>
                        <th class="table-style-th">������</th>
                        <th class="table-style-th">���һ�λ������ʱ��</th>
                        <th class="table-style-th">���һ�λ��ⷢ������</th>
						<th class="table-style-th">������λ������ʱ��</th>
                        <th class="table-style-th">������λ��ⷢ������</th>
                        <th class="table-style-th">������λ������ʱ��</th>
                        <th class="table-style-th">������λ��ⷢ������</th>
                        <th class="table-style-th">����Ĵλ������ʱ��</th>
                        <th class="table-style-th">����Ĵλ��ⷢ������</th>
                        <th class="table-style-th">�����λ������ʱ��</th>
                        <th class="table-style-th">�����λ��ⷢ������</th>
                        <th class="table-style-th">������λ������ʱ��</th>
                        <th class="table-style-th">������λ��ⷢ������</th>
                        <th class="table-style-th">����ߴλ������ʱ��</th>
                        <th class="table-style-th">����ߴλ��ⷢ������</th>
						<th class="table-style-th">���ع�</th>
                        <th class="table-style-th">���������</th>
                       <!--  <th class="table-style-th">��ע</th> -->
                    </tr>
                  </thead>
                  <tbody>
                  	<%
                  		String pid=request.getParameter("pid");//��������
		    			dataselect ds=new dataselect();
		    				    			
		    			String gethu="select recentHg.id,recentHg.Sample_ID,Sample_Name,recentHg.Sample_ID,hg_recent1_time,hg_recent1_date,hg_recent2_time,hg_recent2_date,hg_recent3_time,hg_recent3_date,hg_recent4_time,hg_recent4_date,hg_recent5_time,hg_recent5_date,hg_recent6_time,hg_recent6_date,hg_recent7_time,hg_recent7_date,Device_Name,Substation_Name from recentHg left join SampleDetail on SampleDetail.Sample_ID=recentHg.Sample_ID where recentHg.Sample_ID in(select Sample.Sample_ID from Sample where Sample.Device_ID in(select Devpoint.Device_ID from Devpoint where Devpoint.Pid='"+pid+"'))";
		    			
		    			ResultSet rs=ds.select(gethu);
		    			if(rs!=null)
		    			{	
		    				//out.print("<table id='listtable' class='listtable'><tr><td></td><td>���</td><td>��������� </td><td>��������ڵ�λ��</td><td>��ϵ�绰</td><td>�豸�� </td><td>��ע</td></tr>");
		    				int num=1;
		    				String Sample_ID="";
		    				String Sample_Name="";	    					
	    					String Device_Name="";
	    					String Substation_Name="";
	    					String hg_recent1_time="";//���һ�λ��ⷢ��ʱ�����ⳤ��ʱ�䣨��λ���룩

							String hg_recent1_date="";//���һ�λ��ⷢ������
							
							//����ڶ���
							String hg_recent2_time="";//������λ��ⷢ��ʱ�����ⳤ��ʱ�䣨��λ���룩
	
							String hg_recent2_date="";//������λ��ⷢ������					
							
							//���������
							String hg_recent3_time="";//������λ��ⷢ��ʱ�����ⳤ��ʱ�䣨��λ���룩
	
							String hg_recent3_date="";//������λ��ⷢ������

							//������Ĵ�
							String hg_recent4_time="";//����Ĵλ��ⷢ��ʱ�����ⳤ��ʱ�䣨��λ���룩

							String hg_recent4_date="";//����Ĵλ��ⷢ������

							
							//��������
							String hg_recent5_time="";//�����λ��ⷢ��ʱ�����ⳤ��ʱ�䣨��λ���룩

							String hg_recent5_date="";//�����λ��ⷢ������
							
							//���������
							String hg_recent6_time="";//������λ��ⷢ��ʱ�����ⳤ��ʱ�䣨��λ���룩

							String hg_recent6_date="";//������λ��ⷢ������
							
							//������ߴ�
							String hg_recent7_time="";//����λ��ⷢ��ʱ�����ⳤ��ʱ�䣨��λ���룩

							String hg_recent7_date="";//����ߴλ��ⷢ������
							
							
		    				while(rs.next())
		    				{
		    					int index=0;
		    					index=rs.getInt("id");
		    					if(rs.getString("Sample_ID")!=null&&rs.getString("Sample_ID").equals("null")==false)
		    					{
		    						Sample_ID=rs.getString("Sample_ID").trim();
		    					}
		    					if(rs.getString("Device_Name")!=null&&rs.getString("Device_Name").equals("null")==false)
		    					{
		    						Device_Name=rs.getString("Device_Name").trim();
		    					}
		    					if(rs.getString("Sample_Name")!=null&&rs.getString("Sample_Name").equals("null")==false)
		    					{
		    						Sample_Name=rs.getString("Sample_Name").trim();
		    					}
		    					
		    					if(rs.getString("Substation_Name")!=null&&rs.getString("Substation_Name").equals("null")==false)
		    					{
		    						Substation_Name=rs.getString("Substation_Name").trim();
		    					}
								
								hg_recent1_time=rs.getString("hg_recent1_time");//���һ�λ��ⷢ��ʱ�����ⳤ��ʱ�䣨��λ���룩
								
								hg_recent1_date=rs.getString("hg_recent1_date");//���һ�λ��ⷢ��������ʱ������λ�룩
								if(hg_recent1_time.equals("0"))
								{
									hg_recent1_time="δ����";
									hg_recent1_date="��";
								}
	
								
								hg_recent2_time=rs.getString("hg_recent2_time");//���һ�λ��ⷢ��ʱ�����ⳤ��ʱ�䣨��λ���룩
								hg_recent2_date=rs.getString("hg_recent2_date");//���һ�λ��ⷢ��������ʱ������λ�룩
								if(hg_recent2_time.equals("0"))
								{
									hg_recent2_time="δ����";
									hg_recent2_date="��";
								}
								
								hg_recent3_time=rs.getString("hg_recent3_time");//���һ�λ��ⷢ��ʱ�����ⳤ��ʱ�䣨��λ���룩
								hg_recent3_date=rs.getString("hg_recent3_date");//���һ�λ��ⷢ��������ʱ������λ�룩
								if(hg_recent3_time.equals("0"))
								{
									hg_recent3_date="��";
								}
								
								hg_recent4_time=rs.getString("hg_recent4_time");//���һ�λ��ⷢ��ʱ�����ⳤ��ʱ�䣨��λ���룩
								hg_recent4_date=rs.getString("hg_recent4_date");//���һ�λ��ⷢ��������ʱ������λ�룩
								if(hg_recent4_time.equals("0"))
								{
									hg_recent4_time="δ����";
									hg_recent4_date="��";
								}
								
								hg_recent5_time=rs.getString("hg_recent5_time");//���һ�λ��ⷢ��ʱ�����ⳤ��ʱ�䣨��λ���룩
								hg_recent5_date=rs.getString("hg_recent5_date");//���һ�λ��ⷢ��������ʱ������λ�룩
								if(hg_recent5_time.equals("0"))
								{
									hg_recent5_time="δ����";
									hg_recent5_date="��";
								}
								
								hg_recent6_time=rs.getString("hg_recent6_time");//���һ�λ��ⷢ��ʱ�����ⳤ��ʱ�䣨��λ���룩
								hg_recent6_date=rs.getString("hg_recent6_date");//���һ�λ��ⷢ��������ʱ������λ�룩
								if(hg_recent6_time.equals("0"))
								{
									hg_recent6_time="δ����";
									hg_recent6_date="��";
								}
								
								hg_recent7_time=rs.getString("hg_recent7_time");//���һ�λ��ⷢ��ʱ�����ⳤ��ʱ�䣨��λ���룩
								hg_recent7_date=rs.getString("hg_recent7_date");//���һ�λ��ⷢ��������ʱ������λ�룩
								if(hg_recent7_time.equals("0"))
								{
									hg_recent7_time="δ����";
									hg_recent7_date="��";
								}

								
		    					out.print("<tr><td class='table-style-td' style='width:100px;'>"+num+"</td><td class='table-style-td'>"
		    					+Sample_Name+"("+Sample_ID+")"+"</td><td class='table-style-td'>"
		    					+hg_recent1_time+"</td><td class='table-style-td'>"
		    					+hg_recent1_date+"</td><td class='table-style-td'>"
								
								+hg_recent2_time+"</td><td class='table-style-td'>"
		    					+hg_recent2_date+"</td><td class='table-style-td'>"
								//+hg_2_date+" </td><td class='table-style-td'>"
								+hg_recent3_time+"</td><td class='table-style-td'>"
		    					+hg_recent3_date+"</td><td class='table-style-td'>"
								//+hg_3_date+" </td><td class='table-style-td'>"
								+hg_recent4_time+"</td><td class='table-style-td'>"
		    					+hg_recent4_date+"</td><td class='table-style-td'>"
								//+hg_4_date+" </td><td class='table-style-td'>"
								+hg_recent5_time+"</td><td class='table-style-td'>"
		    					+hg_recent5_date+"</td><td class='table-style-td'>"
								//+hg_5_date+" </td><td class='table-style-td'>"
								+hg_recent6_time+"</td><td class='table-style-td'>"
		    					+hg_recent6_date+"</td><td class='table-style-td'>"
								//+hg_6_date+" </td><td class='table-style-td'>"
								+hg_recent7_time+"</td><td class='table-style-td'>"
		    					+hg_recent7_date+"</td><td class='table-style-td'>"
								//+hg_7_date+" </td><td class='table-style-td'>"
								
								
								+Device_Name+" </td><td class='table-style-td'>"
		    					+Substation_Name+" </td></tr>");
		    					num++;
		    					Sample_Name="";
	    						Device_Name="";
	    						Sample_ID="";

	    						Substation_Name="";
	    						
								hg_recent1_time="";//���һ�λ��ⷢ��ʱ�����ⳤ��ʱ�䣨��λ���룩
								hg_recent1_date="";//���һ�λ��ⷢ��������ʱ������λ�룩
							
								//����ڶ���
								hg_recent2_time="";//������λ��ⷢ��ʱ�����ⳤ��ʱ�䣨��λ���룩
								hg_recent2_date="";//������λ��ⷢ��������ʱ������λ�룩
								
								//���������
								hg_recent3_time="";//������λ��ⷢ��ʱ�����ⳤ��ʱ�䣨��λ���룩
								hg_recent3_date="";//������λ��ⷢ��������ʱ������λ�룩
								
								//������Ĵ�
								hg_recent4_time="";//����Ĵλ��ⷢ��ʱ�����ⳤ��ʱ�䣨��λ���룩
								hg_recent4_date="";//����Ĵλ��ⷢ��������ʱ������λ�룩
								
								
								//��������
								hg_recent5_time="";//�����λ��ⷢ��ʱ�����ⳤ��ʱ�䣨��λ���룩
								hg_recent5_date="";//�����λ��ⷢ��������ʱ������λ�룩
								
								//���������
								hg_recent6_time="";//������λ��ⷢ��ʱ�����ⳤ��ʱ�䣨��λ���룩
								hg_recent6_date="";//������λ��ⷢ��������ʱ������λ�룩
								
								//������ߴ�
								hg_recent7_time="";//����λ��ⷢ��ʱ�����ⳤ��ʱ�䣨��λ���룩
								hg_recent7_date="";//����ߴλ��ⷢ��������ʱ������λ�룩
								
								
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

    </body>
	
</html>


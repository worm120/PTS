package loghistory;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
import java.text.*; 
import java.sql.*;  
import javax.naming.*;   
import javax.sql.DataSource;   
import java.io.*;


import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;


public class arcexcela extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public arcexcela() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		String sid="",s="",f="",did="";
		if(request.getParameter("sid")!=null)
		{sid=request.getParameter("sid").toString();}
		if(request.getParameter("s")!=null)
		{s=request.getParameter("s").toString();}
		if(request.getParameter("f")!=null)
		{f=request.getParameter("f").toString();}
		if(request.getParameter("did")!=null)
		{did=request.getParameter("did").toString();}
		
		
		HSSFWorkbook wb = new HSSFWorkbook();  
        // 创建工作表对象并命名  
        HSSFSheet sheet = wb.createSheet("弧光报警日志");  
        // 遍历集合对象创建行和单元格 

        HSSFRow row1 = sheet.createRow(0);  
        // 开始创建单元格并赋值  
         
        HSSFCell Cell0 = row1.createCell(0);  
        Cell0.setCellValue("时间"); 
        HSSFCell Cell1 = row1.createCell(1);  
        Cell1.setCellValue("采样点"); 
        HSSFCell Cell2 = row1.createCell(2);  
        Cell2.setCellValue("报警频率"); 
        HSSFCell Cell3 = row1.createCell(3);  
        Cell3.setCellValue("报警类型");
        HSSFCell Cell4 = row1.createCell(4);  
        Cell4.setCellValue("用户"); 
        HSSFCell Cell5 = row1.createCell(5);  
        Cell5.setCellValue("处理时间");
        HSSFCell Cell6 = row1.createCell(6);  
        Cell6.setCellValue("处理日志"); 
        HSSFCell Cell7 = row1.createCell(7);  
        Cell7.setCellValue("主机ip地址"); 
        HSSFCell Cell8 = row1.createCell(8);  
        Cell8.setCellValue("备注"); 
        

        try 
    	{
        	Context ctx=new InitialContext();
    	    DataSource ds=(DataSource)ctx.lookup("java:comp/env/jdbc/c");
    	    Connection conn=ds.getConnection();
    		Statement stmt=conn.createStatement();
    		String sql6="select * from AlarmLogArc a,Sample b where a.Odate between '"+s+"' and '"+f+"' and b.Substation_ID='"+sid+"' and b.Device_ID='"+did+"' and b.Sample_ID=a.Sample_ID and b.Sample_Type='02'";
    		ResultSet rs6=stmt.executeQuery(sql6);
        
        if(rs6!=null)
        {
        	int i=1;
        	
        		while (rs6.next())
            	{
            		// 创建行  
                    HSSFRow row = sheet.createRow(i);  
                    // 开始创建单元格并赋值  
                   
                    Cell0 = row.createCell(0);  
                    Cell0.setCellValue(rs6.getString("Odate")); 
                    Cell1 = row.createCell(1);  
                    Cell1.setCellValue(rs6.getString("Sample_ID")); 
                    Cell2 = row.createCell(2);  
                    Cell2.setCellValue(rs6.getInt("AlarmNum")); 
                    Cell3 = row.createCell(3);  
                    Cell3.setCellValue(rs6.getString("AlarmType")); 
                    Cell4 = row.createCell(4);  
                    Cell4.setCellValue(rs6.getString("UID")); 
                    Cell5 = row.createCell(5);  
                    Cell5.setCellValue(rs6.getString("Sdate")); 
                    Cell6 = row.createCell(6);  
                    Cell6.setCellValue(rs6.getString("Cresult")); 
                    Cell7 = row.createCell(7);  
                    Cell7.setCellValue(rs6.getString("IP")); 
                    Cell8 = row.createCell(8);  
                    Cell8.setCellValue(rs6.getString("rem")); 
                    
 
                    
                    i++;
                   
    			}
        		rs6.close();
    			stmt.close();
    			conn.close();
    				
			} 
    	 }
        	catch (Exception e)
			{
				// TODO: handle exception
			}
       

        FileOutputStream fos = null;  
        try 
        {  
            fos = new FileOutputStream("F:\\book.xls");  
            wb.write(fos);  
        } 
        catch (Exception e) 
        {  
            e.printStackTrace();  
        } 
        finally 
        {  
            if (fos != null) 
            {  
                try
                {  
                    fos.close();  
                } 
                catch (Exception e) 
                {  
                    e.printStackTrace();  
                }  
            }  
        }  

        response.setContentType("Application/msexcel");  
        response.setHeader("Content-disposition","attachment; filename=arcalarmexcel.xls" );  
        wb.write(response.getOutputStream()); 
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}

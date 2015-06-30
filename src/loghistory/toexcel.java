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


public class toexcel extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public toexcel() {
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
		
		
		String sid="",s="",f="";
		if(request.getParameter("sid")!=null)
		{sid=request.getParameter("sid").toString();}
		if(request.getParameter("s")!=null)
		{s=request.getParameter("s").toString();}
		if(request.getParameter("f")!=null)
		{f=request.getParameter("f").toString();}
		
		
		HSSFWorkbook wb = new HSSFWorkbook();  
        // 创建工作表对象并命名  
        HSSFSheet sheet = wb.createSheet("操作日志");  
        // 遍历集合对象创建行和单元格 

        HSSFRow row1 = sheet.createRow(0);  
        // 开始创建单元格并赋值  
         
        HSSFCell Cell0 = row1.createCell(0);  
        Cell0.setCellValue("时间"); 
        HSSFCell Cell1 = row1.createCell(1);  
        Cell1.setCellValue("用户"); 
        HSSFCell Cell2 = row1.createCell(2);  
        Cell2.setCellValue("操作性质"); 
        HSSFCell Cell3 = row1.createCell(3);  
        Cell3.setCellValue("操作结果"); 
        HSSFCell Cell4 = row1.createCell(4);  
        Cell4.setCellValue("主机ip地址"); 
        
        

        try 
    	{
        	Context ctx=new InitialContext();
    	    DataSource ds=(DataSource)ctx.lookup("java:comp/env/jdbc/c");
    	    Connection conn=ds.getConnection();
    		Statement stmt=conn.createStatement();
    		String sql6="select * from Logs a,Users b where a.OTim between '"+s+"' and '"+f+"' and a.UID=b.User_Login and b.Substation_ID='"+sid+"'";
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
                    Cell0.setCellValue(rs6.getString("OTim")); 
                    Cell1 = row.createCell(1);  
                    Cell1.setCellValue(rs6.getString("UID")); 
                    Cell2 = row.createCell(2);  
                    Cell2.setCellValue(rs6.getString("Oper")); 
                    Cell3 = row.createCell(3);  
                    Cell3.setCellValue(rs6.getString("Res")); 
                    Cell4 = row.createCell(4);  
                    Cell4.setCellValue(rs6.getString("IP")); 
                    
                    
                    i++;
                    /*HSSFCell Cell0 = row.createCell(0);  
                    Cell0.setCellValue(rs.getString("teacher_id"));  
                    HSSFCell Cell1 = row.createCell(1);  
                    Cell1.setCellValue(rs.getString("teacher_name")); 
                    HSSFCell Cell2 = row.createCell(2);  
                    Cell2.setCellValue(rs.getString("allowance_personnel")); 
                    HSSFCell Cell3 = row.createCell(3);  
                    Cell3.setCellValue(rs.getString("allowance_complete")); 
                    HSSFCell Cell4 = row.createCell(4);  
                    Cell4.setCellValue(rs.getString("allowance_allowance_deduct")); 
                    HSSFCell Cell5 = row.createCell(5);  
                    Cell5.setCellValue(rs.getString("allowance_exceed")); 
                    HSSFCell Cell6 = row.createCell(6);  
                    Cell6.setCellValue(rs.getString("allowance_exAllow")); 
                    HSSFCell Cell7 = row.createCell(7);  
                    Cell7.setCellValue(rs.getString("allowance_excess")); 
                    HSSFCell Cell8 = row.createCell(8);  
                    Cell8.setCellValue(rs.getString("allowance_staAllow")); 
                    HSSFCell Cell9 = row.createCell(9);  
                    Cell9.setCellValue(rs.getString("allowance_instructor")); 
                    HSSFCell Cell10 = row.createCell(10);  
                    Cell10.setCellValue(rs.getString("allowance_attend")); 
                    HSSFCell Cell11 = row.createCell(11);  
                    Cell11.setCellValue(rs.getString("allowance_patrol")); 
                    HSSFCell Cell12 = row.createCell(12);  
                    Cell12.setCellValue(rs.getString("allowance_overAllow")); 
                    HSSFCell Cell13 = row.createCell(13);  
                    Cell13.setCellValue(rs.getString("allowance_labour")); 
                    HSSFCell Cell14 = row.createCell(14);  
                    Cell14.setCellValue(rs.getString("allowance_seventy")); 
                    HSSFCell Cell15 = row.createCell(15);  
                    Cell15.setCellValue(rs.getString("allowance_thirty")); 
                    HSSFCell Cell16 = row.createCell(16);  
                    Cell16.setCellValue(rs.getString("allowance_total")); 
                    HSSFCell Cell17 = row.createCell(17);  
                    Cell17.setCellValue(rs.getString("allowance_vertification")); 
                    HSSFCell Cell18 = row.createCell(18);  
                    Cell18.setCellValue(rs.getString("allowance_year_allocation")); 
                    HSSFCell Cell19 = row.createCell(19);  
                    Cell19.setCellValue(rs.getString("allowance_year_check")); 
                    HSSFCell Cell20 = row.createCell(20);  
                    Cell20.setCellValue(rs.getString("allowance_year_average")); 
                    HSSFCell Cell21 = row.createCell(21);  
                    Cell21.setCellValue(rs.getString("allowance_is_quantity_of_work")); 
                    HSSFCell Cell22 = row.createCell(22);  
                    Cell22.setCellValue(rs.getString("allowance_date")); */
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
        response.setHeader("Content-disposition","attachment; filename=operationlog.xls" );  
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

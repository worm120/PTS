package com.action;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
public class dataselect
{
	//String url = "jdbc:microsoft:sqlserver://localhost:1433;DatabaseName=Electricity_Monitoring_System";
	String url = "jdbc:sqlserver://172.16.93.254:1433;DatabaseName=SDB";
    String username = "sa";
    String password = "lwg123456";
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	PreparedStatement pstat = null;
	
  //无参数的构造函数
	public dataselect() 
	{
		try
		{
			Context c = new InitialContext();
			DataSource ds = (DataSource)c.lookup("java:comp/env/jdbc/c");
			conn = ds.getConnection();//记得要捕获 NamingException 与 SQLException 异常			
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}
	
	//取得数据库连接
	public Connection getCon(){
		
		/*try{
			//System.out.println(url+"<>"+username+"<>"+password);
			//Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver").newInstance();
			//Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver").newInstance();
			//conn = DriverManager.getConnection(url, username, password); 
			//
			Context c = new InitialContext();
			DataSource ds = (DataSource)c.lookup("java:comp/env/jdbc/c");
			conn = ds.getConnection();//记得要捕获 NamingException 与 SQLException 异常			
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return conn;
		*/
		try {
			if(this.conn==null||this.conn.isClosed()==true)
			{
				try
				{
					Context c = new InitialContext();
					DataSource ds = (DataSource)c.lookup("java:comp/env/jdbc/c");
					this.conn = ds.getConnection();//记得要捕获 NamingException 与 SQLException 异常			
				}
				catch(Exception ex)
				{
					ex.printStackTrace();
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		return this.conn;
	}

	//执行数据库查询并返回查询结果
	public ResultSet select(String sql){
		try{
			conn = getCon();
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return rs;
	}
	
	//执行数据库更新
	public int update(String sql){
		int i=0;
		try{
			conn = getCon();
			stmt= conn.createStatement();
			i=stmt.executeUpdate(sql);
			if(i==0)
			{
				System.out.print(sql+": 未成功更新");
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return i;
	}
	
	// 执行数据库查询并返回查询结果
		public ResultSet query(String sql) {
			try {
				//System.out.println("connStatusfff:"+conn);
				//System.out.println("connStatus:"+conn.isClosed());
				conn = getCon();
				//System.out.println("connStatus2:"+conn.isClosed());
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			return rs;
		}

		// 执行数据库查询
		public ResultSet query(String sql, Map<String, Object> mymap) {
			try {
				conn = this.getCon();
				sql += " where 1=1";
				if (mymap.size() != 0) {
					for (String k : mymap.keySet()) {
						sql += " and " + k + "=? ";
					}
				}
				pstat = conn.prepareStatement(sql);
				if (mymap.size() != 0) {
					int i = 1;
					for (String k : mymap.keySet()) {
						pstat.setObject(i++, mymap.get(k));
					}
				}
				return pstat.executeQuery();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return null;
		}
	
	//执行存储过程--温度
	public void execute(float Tvalue,float Vvalue,float Hvalue,String nodeid ){
		int i=0;
		try{
			conn = getCon();
			CallableStatement c=conn.prepareCall("{call insertTemperature(?,?,?,?)}");  
			c.setFloat(1,Tvalue);
			c.setFloat(2,Vvalue);
			c.setFloat(3,Hvalue);
			c.setString(4,nodeid);
			c.execute();
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	
	//执行存储过程--湿度度
		public void executeHum(float Tvalue,float Vvalue,float Hvalue,String nodeid ){
			int i=0;
			try{
				conn = getCon();
				CallableStatement c=conn.prepareCall("{call insertHumidity(?,?,?,?)}");  
				c.setFloat(1,Tvalue);
				c.setFloat(2,Vvalue);
				c.setFloat(3,Hvalue);
				c.setString(4,nodeid);
				c.execute();
			}catch(Exception ex){
				ex.printStackTrace();
			}
		}
	
	// 执行数据库更新
		public boolean update(String sql, Object[] args) {
			try {
				conn = this.getCon();
				pstat = conn.prepareStatement(sql);
				if (args != null) {
					for (int i = 0; i < args.length; i++) {
						pstat.setObject(i + 1, args[i]);
					}
				}
				int x = pstat.executeUpdate();
				return x == 0 ? false : true;

			} catch (SQLException e) {
				e.printStackTrace();
			}
			return false;
		}

		// 执行数据库更新,有返回值
		public boolean update0(String sql) {
			try {
				conn = getCon();
				pstat = conn.prepareStatement(sql);
				int x = pstat.executeUpdate(sql);
				return x == 0 ? false : true;
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			return false;
		}

		// 关闭数据库连接
		public void closeAll() {
			try {
				if (rs != null) {
					rs.close();
					rs = null;
				}
				if (pstat != null) {
					pstat.close();
					pstat = null;
				}
				if (conn != null) {
					conn.close();
					//conn = null;
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
	//关闭数据库连接
	public void close(){
		try{
			if (this.rs != null)
			{
				this.rs.close();
			}
			if (this.stmt != null)
			{
				this.stmt.close();
			}
			if (this.conn != null)
			{
				this.conn.close();
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}		
	}	

}


<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>

<!DOCTYPE html>

<html lang="zh-CN">
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>���DSEP-2000����ͼ����������ʪ�Ȱ�ȫ���ϵͳ</title>
		<!-- �� Bootstrap ���� CSS �ļ� -->
		<link rel="stylesheet" href="css/font-awesome/bootstrap.min.css">

	
		
		<style>
			.bg{background-image: url(images/logo13.jpg);}
			.fheigh{height: 100%;padding-top: 20%;}
			.headerp{margin-bottom: 40px;}
		</style>
	</head>
	<body class="bg">
		<!--
		<img class="img-responsive" src="img/��������.jpg" />
		-->
		<div class="container fheigh">
			<div class="row">
				<header class="headerp">
					<h1 class="text-center  header text-info text-navy">����ͼ����������ʪ�Ȱ�ȫ���ϵͳ</h1>
				</header>
				
				<div class="col-xs-12 col-sm-4 col-md-4 col-lg-4 col-sm-offset-4 col-md-offset-4 col-lg-offset-4 rowheight" >
					<form class="formp" onSubmit="return false">
					  <div class="form-group">
					      	<label class="sr-only" for="exampleInputEmail1">username</label>
					    	<input type="text" class="form-control" id="user_id" value="admin" placeholder="�û���">
					  </div>
					  <div class="form-group">
					    	<label class="sr-only" for="Password">Password</label>
					    	<input type="password" class="form-control" id="user_psw" value="admin" placeholder="����">
					  </div>
					  
					  <button type="submit" id="submits" onclick="loginn()" class="btn btn-info btn-block">��&nbsp;&nbsp;&nbsp;&nbsp;½</button>
					</form>
				</div>

			</div>

		</div>
		<script type="text/javascript">
		function loginn()
		{
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
				//��ʾ���ص���Ӧ��id������ͼ�ϵĽڵ�Ŀ��ع�
				  	var result=xmlhttp.responseText;
				  	//alert(result);
				    if(result.indexOf("sucess")>=0)
					{
						window.location.href="selectFunction.jsp";
					}
					else
					{
						alert("�û��������벻��ȷ����ȷ�Ϻ����µ�¼��");
					}
			  }
			};
			if(document.getElementById("user_id").value.trim()==""||document.getElementById("user_psw").value.trim()=="")
			{
				alert("�û��������벻��Ϊ�գ����������룡");
			}
			else
			{
				xmlhttp.open("GET","servlet/checklogin?username="+document.getElementById("user_id").value+"&password="+document.getElementById("user_psw").value+"&r="+new Date().getTime(),true);
				xmlhttp.send();
			}
		}
	</script>
	</body>
</html>


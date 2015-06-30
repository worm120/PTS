<%@ page language="java" import="java.util.*"  pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Flot Examples: Categories</title>
	<link href="css/examples.css" rel="stylesheet" type="text/css">
	<!--[if lte IE 8]><script language="javascript" type="text/javascript" src="../../excanvas.min.js"></script><![endif]-->
	<script language="javascript" type="text/javascript" src="js/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="js/jquery.flot.js"></script>
	<script language="javascript" type="text/javascript" src="js/jquery.flot.categories.js"></script>
	<script type="text/javascript">

	</script>
</head>
<body>
<%

	int a[] = {5,9,21,4,3,1,30};
	int temp;    //ÁÙÊ±±äÁ¿
	int i,j;

	for(i=0;i<7;i++)
     	for(j=0;j<6;j++)
     	{
             temp = a[j];
             if(a[j] < a[j+1])
             {                   
                   a[j] = a[j+1];
                   a[j+1] = temp;
             }
    	 }
	for(i=0;i<7;i++){out.print("<p>"+a[i]+"</p>");}
 %>
	<div id="header">
		<h2>Categories</h2>
	</div>

	<div id="content">

		<div class="demo-container">
			<div id="placeholder" class="demo-placeholder"></div>
		</div>

		<p>With the categories plugin you can plot categories/textual data easily.</p>

	</div>

	<div id="footer">
		Copyright &copy; 2007 - 2014 IOLA and Ole Laursen
	</div>

</body>
</html>






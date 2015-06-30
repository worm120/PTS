<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %> 


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
	<head>
		<title>图像与温度安全监测管理系统</title>
		<meta content="text/html; charset=utf-8" http-equiv=content-type>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<link rel="stylesheet" type="text/css"
			href="../jquery/css/imgareaselect-default.css" />
		<!-- 
		<link   href="../css/add.css">  -->
		<script type='text/javascript' src='/PTS/dwr/interface/picCmp.js'></script>
		<script type='text/javascript' src='/PTS/dwr/engine.js'></script>
		<script type='text/javascript' src='/PTS/dwr/util.js'></script>
		
<style type="text/css">

.box-content{padding: 0px;border-bottom: 1px solid #cdcdcd;font-size: 12px; color: #666; width: 100%; position: relative;margin: 0px;overflow-y: auto;max-height: 760px;}
.table-style{border:0px; margin-bottom: 0px;border-spacing: 0px;width: 80%; background-color: transparent;position: relative;}
.table-style-th{vertical-align: bottom;height: 20px;padding: 5px 10px 2px;border-bottom: 0px;text-align:left;color: #666666;background-color: #efefef;border-left: 1px solid #ddd;font-weight: bold;border-bottom: 1px solid #ddd;font-size:12px;}
.table-style-th1{vertical-align: middle;height: 20px;padding: 5px 10px 2px;border-bottom: 0px;text-align:left;color: #666666;background-color: #efefef;border-left: 1px solid #ddd;font-weight: bold;border-bottom: 1px solid #ddd;font-size:12px;}
.table-style-td{vertical-align: middle;height: 30px;padding: 5px 10px 2px;border-bottom: 0px;text-align: left;color: #666666;background-color: #f9f9f9;border-left: 1px solid #ddd;border-bottom: 1px solid #ddd;}


.table-style-thsel{vertical-align: bottom;height: 50px;padding: 5px 10px 2px;border-bottom: 0px;text-align: center;color: #666666;background-color: #efefef;border-left: 1px solid #ddd;font-weight: bold;border-bottom: 1px solid #ddd;font-size:17px;}

.table-style-tdsel{vertical-align: top;height: 30px;padding: 5px 10px 2px;border-bottom: 0px;text-align: center;color: #666666;background-color: #f9f9f9;border-left: 1px solid #ddd;border-bottom: 1px solid #ddd;}

</style>

<script language="javascript">
// 按“开始对比”按钮后开始进行两篇图片的比较
function cmp() {
	var picture = document.getElementById("picture").value;
			document.getElementById("xs").innerHTML = "";
			document.getElementById("total").innerHTML = "";
			document.getElementById("xsd").innerHTML = "";
			document.getElementById("vpicture").src = "../images/temp/rt.jpg";
			displayMessage();
	setTimeout(function(){hiddenMessage();
	//document.getElementById("aa").style.display="";
	callCmp();
	align = "top";},2000);
}

// 显示比较结果
function callCmp() {
	rate = 82.7;
	document.getElementById("xs").innerHTML = "63485";
	document.getElementById("total").innerHTML = "76800";
	document.getElementById("xsd").innerHTML = "<img width=20 height=20 src='' id='a'/>"
			+ "<img width=20 height=20 src='' id='b'/>"
			+ "<img width=20 height=20 src='' id='c'/>&nbsp;"
			+ "<img width=7 height=7 src='../images/number/point.jpg' id='point'/>&nbsp;"
			+ "<img width=20 height=20 src='' id='d'/>&nbsp;"
			+ "<img valign='bottom' width=25 height=25 src='../images/number/per.jpg' id='per'/>";
  curIndex = 0; 
  arr = new Array(); 
  arr[0] = "../images/number/0.jpg"; 
  arr[1] = "../images/number/1.jpg"; 
  arr[2] = "../images/number/2.jpg"; 
  arr[3] = "../images/number/3.jpg"; 
  arr[4] = "../images/number/4.jpg"; 
  arr[5] = "../images/number/5.jpg"; 
  arr[6] = "../images/number/6.jpg"; 
  arr[7] = "../images/number/7.jpg";
  arr[8] = "../images/number/8.jpg";
  arr[9] = "../images/number/9.jpg";
   document.getElementById("a").src = arr[0];
   document.getElementById("b").src = arr[8];
   document.getElementById("c").src = arr[2];
   document.getElementById("d").src = arr[7];
  // setInterval(changeImg,timeInterval);
}


 function changeImg() {
	var a = document.getElementById("a");
	var b = document.getElementById("b");
	var c = document.getElementById("c");
	var d = document.getElementById("d");
	if (rate == 100) {
		a.src = arr[1];
		b.src = arr[0];
		c.src = arr[0];
		d.src = arr[0];
		var chImg = document.getElementById("chooseImg").src;
		var img = chImg.split("/");
		var image = img[img.length - 1];
		document.getElementById("vpicture").src = "<%=basePath%>images/result/"
				+ image;
	} else {
		a.src = arr[0];
		if (rate.substring(0, 1) == b.src.substring(b.src.length - 5,
				b.src.length - 4)) {
			bi = rate.substring(0, 1);
			if (rate.substring(1, 2) == c.src.substring(c.src.length - 5,
					c.src.length - 4)) {
				ci = rate.substring(1, 2);
				if (rate.substring(3, 4) == d.src.substring(d.src.length - 5,
						d.src.length - 4)) {
					di = rate.substring(3, 4);
				} else {
					di =di+ 1;
					d.src = arr[di];
				}
			} else {
				ci=ci+ 1;
				c.src = arr[ci];
			}
		} else {
			bi =bi+ 1;
			b.src = arr[bi];
		}
		if (rate.substring(0, 1) == b.src.substring(b.src.length - 5,
				b.src.length - 4)
				&& rate.substring(1, 2) == c.src.substring(c.src.length - 5,
						c.src.length - 4)
				&& rate.substring(3, 4) == d.src.substring(d.src.length - 5,
						d.src.length - 4)) {

			var chImg = document.getElementById("chooseImg").src;

			// alert(src="<%=basePath%>/upload")
			// alert("<%=basePath%>images/result/"+data[0].phoid)

			var img = chImg.split("/");
			var image = img[img.length - 1];
			// alert("<%=basePath%>images/result/"+image);

			// document.getElementById("vpicture").src =
			// "../images/result/"+image;
			document.getElementById("vpicture").src = "<%=basePath%>images/result/"
					+ image;
		}
	}
}
</script>
<SPAN style="FONT-FAMILY: SimSun"><script type="text/javascript">  
function XXX() {  
    displayMessage();  
}  
  
function displayMessage() {  
    if (navigator.userAgent.indexOf("Firefox") == -1) {  
        /*var obj = document.getElementsByTagName('SELECT');  
        for ( var i = 0; i < obj.length; i++) {  
            if (obj[i].type.indexOf("select") != -1)  
                obj[i].style.visibility = 'hidden';  
        }  */
        mask.style.visibility = 'visible';  
        massage_box.style.visibility = 'visible';  
    }  
}  
function hiddenMessage() {  
    mask.style.visibility = 'hidden';  
    massage_box.style.visibility = 'hidden';  
}  
var Obj = ''  
document.onmouseup = MUp  
document.onmousemove = MMove  
function MDown(Object) {  
    Obj = Object.id  
    document.all(Obj).setCapture()  
    pX = event.x - document.all(Obj).style.pixelLeft;  
    pY = event.y - document.all(Obj).style.pixelTop;  
}  
  
function MMove() {  
    if (Obj != '') {  
        document.all(Obj).style.left = event.x - pX;  
        document.all(Obj).style.top = event.y - pY;  
    }  
}  
  
function MUp() {  
    if (Obj != '') {  
        document.all(Obj).releaseCapture();  
        Obj = '';  
    }  
}  
</script></SPAN>  
<SPAN style="FONT-FAMILY: SimSun"><style type="text/css">  
#massage_box {  
    position: absolute;  
    left: 35%;  
    top: expression(body.scrollTop +(             
         body.clientHeight-this.offsetHeight)/ 2 );  
    width: 400px;  
    height: 220px;  
    filter: dropshadow(color = #666666, offx = 3, offy = 3, positive = 2);  
    z-index: 2;  
    visibility: hidden  
}  
  
#mask {  
    position: absolute;  
    top: 0;  
    left: 0;  
    width: expression(body.clientWidth);  
    height: expression(body.scrollHeight > body.clientHeight ?          
            body.scrollHeight :        
              body.clientHeight);  
    background: #666;  
    filter: ALPHA(opacity = 60);  
    z-index: 1;  
    visibility: hidden  
}  
  
.massage {  
    border: #036 solid;  
    border-width: 1 1 3 1;  
    width: 95%;  
    height: 95%;  
    background: #fff;  
    color: #036;  
    font-size: 18px;  
    line-height: 150%  
}  
  
.header {  
    background: #554295;  
    height: 10%;  
    font-family: Verdana, Arial, Helvetica, sans-serif;  
    font-size: 13px;  
    padding: 3 5 0 5;  
    color: #fff  
}  
</style></SPAN>  
		
	</head>
	<SPAN style="FONT-FAMILY: SimSun">
	<body onload="cmp();">
		<table  border=0 cellSpacing=0 cellPadding=0
			width=100% align=center>
			<tr>
				<td align="center" width=40%>
					<select id="infer" name="infer" onchange="changeinfer()" class="selected" style="display:none;">
						<option selected value=-1>
							请按采样点选择参照图像
						</option>
					</select>
				</td>
				<td align="center" width=60%>
					<select id="picture" onchange="choosePic()" style="display:none;"
					        onclick="firstSample()" class="selected">
						<option selected value=-1>
							请按采样时间选择需对比的图像
						</option>
					</select>&nbsp;&nbsp;<input type="submit" id="compare" value="开始对比" style="display:none;"
						onclick="cmp();">
				</td>
			</tr>
			<tr>
				<td height=20></td>
			</tr>
			<tr>
				<td align=center width=50% height=150>
					<img id="sourceImg" src="../images/temp/0.jpg">
				</td>
				<td align=center width=50% height=150 id="td1">
				    <img id="chooseImg" src="../images/temp/1.jpg"/> 
				</td>
			</tr>
			<tr>
				<td height=30></td>
			</tr>
		</table>
		<!-- 
		<div id="showView" class="view_content"> -->
		<div id="massage_box" onclick="hiddenMessage();">  
            <div class="massage">  
                <div class="header" onmousedown="MDown(massage_box);">  
                    <div style="display: inline; width: 150px; position: absolute">正在加载中 ... ...  
                    </div>  
                    <span  
                        onClick="massage_box.style.visibility='hidden'; mask.style.visibility='hidden'"  
                        style="float: right; display: inline; cursor: hand"><img src="../images/guanbi.png" height="20px" width="20px"/></span>  
                </div>  
                <div  style="margin-top: 20px; margin-left: 20px; width: 128px; height: 50px; float: left;">  
                    <img src="../images/cxz_ly.gif" />  
                </div>  
                <div style="margin-top: 50px; width: 180px; height: 200px; float: right;">系统正在进行分析  
                    <br />请稍候……  
                </div>  
            </div>  
        </div>  
        <div id="mask" onclick="hiddenMessage();">  
        </div>  
		
		<div id="aa">
		<!--
			<table border=0 width=100% align=center id="picture" id="result1">
				<tr><td height=10></td></tr>
				<tr>
					<td align="center" width=90% valign="middle">
						对比结果
					</td>
					<td align="right" width=2%></td>
				</tr>
				<tr><td height=20></td></tr>
			</table>-->
			<div class="box-content">
			<table class="table-style" align=center id="result2">
				<tr>
					<td align="right" width=10% class="table-style-th" >相似像素：</td>
					<td id="xs" align="left" width=17% class="table-style-td"></td>
					<td align="right" width=9% class="table-style-th">总像素：</td>
					<td id="total" align="left" width=17% class='table-style-td'></td>
					<td align="right" width=9% class="table-style-th">相似度：</td>
					<!-- <td id="xsd" align="left" width=6%></td> -->
					<td id="xsd" align="left" width=38% class='table-style-td'>
					</td>
				</tr>
				<tr>
				    <td align="center" width=53% colspan=4 class='table-style-th'>分析结果：</td>
				    <td align="center" width=47% colspan=2 class='table-style-th'>分析图像：</td>
				</tr>
				<tr>
				    <td align="left" width=53% colspan=4 class='table-style-td'>这是一个分析报告。</td>
				    <td align=center width=47% colspan=2 class='table-style-td'>
						<img id="vpicture" src=""/>
					</td>
				</tr>
			</table>
			</div></div>
	
	 
    </body></SPAN>  
</html>
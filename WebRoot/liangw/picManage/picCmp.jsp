<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %> 
<%@ page import="java.sql.*,liangw.PicManage,liangw.PicManageBean"%>

<jsp:useBean id="picBean" class="liangw.PicManageBean"
	scope="session"></jsp:useBean>

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
.black_overlay {
	display: none;
	position: absolute;
	top: 0%;
	left: 0%;
	width: 100%;
	height: 100%;
	background-color: #EEEEEE;
	z-index: 1001;
	-moz-opacity: 0.8;
	opacity: .80;
	filter: alpha(opacity = 80);
}
.view_content {
	display: none;
	position: absolute;
	top: 0;
	left: 20%;
	width: 60%;
	height: 80%;
	padding: 10px;
	border: 10px solid orange;
	background-color: white;
	z-index: 1002;
	overflow: auto;
}

.box-content{padding: 0px;border-bottom: 1px solid #cdcdcd;font-size: 12px; color: #666; width: 100%; position: relative;margin: 0px;overflow-y: auto;max-height: 760px;}
.table-style{border:0px; margin-bottom: 0px;border-spacing: 0px;width: 80%; background-color: transparent;position: relative;}
.table-style-th{vertical-align: bottom;height: 20px;padding: 5px 10px 2px;border-bottom: 0px;text-align:left;color: #666666;background-color: #efefef;border-left: 1px solid #ddd;font-weight: bold;border-bottom: 1px solid #ddd;font-size:12px;}
.table-style-th1{vertical-align: middle;height: 20px;padding: 5px 10px 2px;border-bottom: 0px;text-align:left;color: #666666;background-color: #efefef;border-left: 1px solid #ddd;font-weight: bold;border-bottom: 1px solid #ddd;font-size:12px;}
.table-style-td{vertical-align: middle;height: 30px;padding: 5px 10px 2px;border-bottom: 0px;text-align: left;color: #666666;background-color: #f9f9f9;border-left: 1px solid #ddd;border-bottom: 1px solid #ddd;}


.table-style-thsel{vertical-align: bottom;height: 50px;padding: 5px 10px 2px;border-bottom: 0px;text-align: center;color: #666666;background-color: #efefef;border-left: 1px solid #ddd;font-weight: bold;border-bottom: 1px solid #ddd;font-size:17px;}

.table-style-tdsel{vertical-align: top;height: 30px;padding: 5px 10px 2px;border-bottom: 0px;text-align: center;color: #666666;background-color: #f9f9f9;border-left: 1px solid #ddd;border-bottom: 1px solid #ddd;}

</style>

<script language="javascript">
//全局变量，图像的ID和路径
var picid = new Array;
var piclocation = new Array;
var referid;

// 加载图像信息
function getPicture(sid) {
	//alert(sid+".."+referid)
	picCmp.getPicTime1(sid,referid,callGetCmpPic);
}
function callGetCmpPic(data) {
    var picture = document.getElementById("picture");
	document.getElementById("picture").options.length = 0;
	document.getElementById("picture").add(new Option("请按采样时间选择需对比的图像", "-1"));
	for (var i = 0; i < data.length; i++) {
		picid[i]=data[i].photoid;
		piclocation[i]=data[i].plocation;
		picture.add(new Option(data[i].pdate, i));
	}
}
// 先选择开关柜

// 先选择采样点
function firstSample() {
	var infer = document.getElementById("infer").value;
	if (infer == "-1") {
		alert("请按采样点选择参照图像！");
		document.getElementById("infer").value="-1";
		document.getElementById("chooseImg").src="";
		document.getElementById("sourceImg").src="";
		document.getElementById("infer").focus();
	}
}

//根据开关柜自动加载开关柜下的所有图像采样点
function changeDevice() {
    var sid = '<%=request.getParameter("sid")%>';
	var nodeid = '<%=request.getParameter("nodeid")%>';
    //var device = document.getElementById("device").value;
    document.getElementById("sourceImg").src="";
	document.getElementById("chooseImg").src="";
    document.getElementById("picture").value="-1";
    document.getElementById("infer").style.display="";
    picCmp.getSample(sid,nodeid,callGetSample);
}
function callGetSample(data) {
    var infer = document.getElementById("infer");
	document.getElementById("infer").options.length = 0;
	document.getElementById("infer").add(new Option("请按采样点选择参照图像", "-1"));
	for (var i = 0; i < data.length; i++) {
		infer.add(new Option(data[i].sname, data[i].sid));
    }
}




// 根据所选择的采样点从数据库显示相应的图片
function changeinfer() {
	var infer = document.getElementById("infer").value;
	document.getElementById("chooseImg").src="";
	if (infer=="-1") {
		document.getElementById("picture").value = "-1";
		document.getElementById("sourceImg").src="";
	    //chooseImg.style.display  = 'none';
		return;
	}
	document.getElementById("picture").style.display="";
	picCmp.getInfer(infer, callInfer);
}

function callInfer(data) {
	if (data == null) {
		alert("该采样点还没有参考图像，请先在'查看设置'中设置参考图像！");
		document.getElementById("chooseImg").src="";
		document.getElementById("sourceImg").src="";
		//window.close();
		window.opener.picSet0();
		//window.open("../picManage/picSet.jsp");
		//return;
	} else {
		var infer = document.getElementById("infer").value;
		picCmp.showInferPic(infer,callShowInferPic);
	}
}
function callShowInferPic(data) {
	document.getElementById("sourceImg").src=data[0].plocation;
	sourceImg=data[0].plocation;
	referid = data[0].photoid;
	var infer = document.getElementById("infer").value;
	getPicture(infer);
}

// 根据所选择的时间从数据库显示相应的图片
function choosePic() {
	var picture = document.getElementById("picture").value;
	if (picture=="-1") {
		document.getElementById("chooseImg").src="";
		return;
	}
	//alert(piclocation[picture])
	document.getElementById("chooseImg").src=piclocation[picture];
	document.getElementById("compare").style.display="";
	chooseImg=piclocation[picture];
}

// 按“开始对比”按钮后开始进行两篇图片的比较
function cmp() {
	document.getElementById("aa").style.display="none"; 
	var picture = document.getElementById("picture").value;
	if (infer == "-1") {
		alert("请先选择采样点");
		document.getElementById("infer").focus();
	} else {
		if (picture == "-1") {
			alert("请选择需对比的图像");
			document.getElementById("picture").focus();
		} else {
			document.getElementById("xs").innerHTML = "";
			document.getElementById("total").innerHTML = "";
			document.getElementById("xsd").innerHTML = "";
			document.getElementById("vpicture").src = "";
			displayMessage();
	setTimeout(function(){hiddenMessage();
	document.getElementById("aa").style.display="";
	picCmp.getCompare(picid[picture],callCmp);
	align = "top";},2000);
	//hiddenMessage();
			//document.getElementById("result2").style.display="";
			
			//document.getElementById('showView').style.display = 'block';
			//document.getElementById('fade').style.display = 'block';
			
			//document.getElementById("vpicture").src = "<%=basePath%>images/result/"+image;
		}
	}
}
var rate = null;
// 显示比较结果
function callCmp(data) {
	rate = data[0].rate;
	document.getElementById("xs").innerHTML = data[0].fam;
	document.getElementById("total").innerHTML = data[0].total;
	// document.getElementById("xsd").innerHTML=data[0].rate + "%";
	document.getElementById("xsd").innerHTML = "<img width=20 height=20 src='' id='a'/>"
			+ "<img width=20 height=20 src='' id='b'/>"
			+ "<img width=20 height=20 src='' id='c'/>&nbsp;"
			+ "<img width=7 height=7 src='../images/number/point.jpg' id='point'/>&nbsp;"
			+ "<img width=20 height=20 src='' id='d'/>&nbsp;"
			+ "<img valign='bottom' width=25 height=25 src='../images/number/per.jpg' id='per'/>";
	
	
  curIndex = 0; 
  ai=0;
  bi=0;
  ci=0;
  di=0;
  var timeInterval = 100; 
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
   document.getElementById("a").src = arr[Math.round(Math.random()*9)];
   document.getElementById("b").src = arr[Math.round(Math.random()*9)];
   document.getElementById("c").src = arr[Math.round(Math.random()*9)];
   document.getElementById("d").src = arr[Math.round(Math.random()*9)];
   //time1 = setInterval(changeImg,timeInterval); 
   setInterval(changeImg,timeInterval);
   //setTimeout(changeImg,timeInterval);
   
}


 function changeImg() {
	var a = document.getElementById("a");
	var b = document.getElementById("b");
	var c = document.getElementById("c");
	var d = document.getElementById("d");
	// alert(a.src.substring(a.src.length-5,a.src.length-4))
	// alert(rate.substring(0,1))
	// if (curIndex == arr.length-1) {
	if (rate == 100) {
		a.src = arr[1];
		b.src = arr[0];
		c.src = arr[0];
		d.src = arr[0];
		// setTimeout( "alert('aa')",10000);
		var chImg = document.getElementById("chooseImg").src;

		// alert(src="<%=basePath%>/upload")
		// alert("<%=basePath%>images/result/"+data[0].phoid)

		var img = chImg.split("/");
		var image = img[img.length - 1];
		//alert(image)
		//alert("<%=basePath%>images/result/"+image);

		// document.getElementById("vpicture").src = "../images/result/"+image;
		document.getElementById("vpicture").src = "<%=basePath%>liangw/images/result/"
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
			//alert("<%=basePath%>liangw/images/result/" + image)
			document.getElementById("vpicture").src = "<%=basePath%>liangw/images/result/"
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
	<body onload="changeDevice();">
		<table  border=0 cellSpacing=0 cellPadding=0
			width=100% align=center>
			<tr>
				<td align="center" width=40%>
					<select id="infer" onchange="changeinfer()" class="selected" style="display:none;"
					        onclick="firstDevice()">
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
					</select>&nbsp;&nbsp;<input type="submit" id="compare" style="display:none;" value="开始对比"
						onclick="cmp();">
				</td>
			</tr>
			<tr>
				<td height=20></td>
			</tr>
			<tr>
				<td align=center width=50% height=150>
					<img id="sourceImg" src="" style="width: 450;  height: 350">
				</td>
				<td align=center width=50% height=150 id="td1">
				    <img id="chooseImg" src="" style="width: 450; height: 350"/> 
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
		
		<div id="aa" style="display:none;">
			<div class="box-content">
			<table class="table-style" align=center id="result2">
				<tr>
					<td align="right" width=10% class="table-style-th" >相似像素：</td>
					<td id="xs" align="left" width=17% class="table-style-td"></td>
					<td align="right" width=9% class="table-style-th">总像素：</td>
					<td id="total" align="left" width=17% class='table-style-td'></td>
					<td align="right" width=9% class="table-style-th">相似度：</td>
					<td id="xsd" align="left" width=38% class='table-style-td'></td>
				</tr>
				<tr>
				    <td align="center" width=53% colspan=4 class='table-style-th'>分析结果：</td>
				    <td align="center" width=47% colspan=2 class='table-style-th'>分析图像：</td>
				</tr>
				<tr>
				    <td align="left" width=53% colspan=4 class='table-style-td'>&nbsp;&nbsp;&nbsp;&nbsp;图中白色部分为两张图像的差异之处，黑色部分表示该处相同。如果图像为全白则表示基本为两张完全不同的图像，若为全黑则表示两张图像基本完全相同。</td>
				    <td align=center width=47% colspan=2 class='table-style-td'>
						<img id="vpicture" src="" style="width:450;height:350"/>
					</td>
				</tr>
			</table>
			</div></div>
    </body></SPAN>  
</html>
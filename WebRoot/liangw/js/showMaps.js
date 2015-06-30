
function link(filename)
{
	var sid = document.getElementById("sid").value;
	if(confirm("确定将"+filename+"选定为该变电所的接线图吗"))
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
			//根据返回的设备借点信息关联接线图上的节点
			    var result=xmlhttp.responseText;
			    if(result=="success")
		    	{
			    	alert("变电所 "+sid+" 关联接线图 "+filename+" 成功！");
		    	}
			    else
			    {
			    	alert("变电所接线图关联失败，重新选择接线图关联!");
			    }
			    window.location.reload; 
				
		  }
		};
		xmlhttp.open("GET","../servlet/linkSubmation?sid="+sid+"&svgname="+filename+"&t="+new Date().getTime(),true);
		xmlhttp.send();
	}
}



/*打开预览模式
function yulan()
{
	//alert("dd");
	window.open("lookMap.jsp","","");	
}
*/
function yulan(path)
{
    mybg = document.createElement("div"); 
    mybg.setAttribute("id","mybg"); 
    mybg.style.background = "#000"; 
    mybg.style.width = "100%"; 
    mybg.style.height = "100%"; 
    mybg.style.position = "absolute"; 
    mybg.style.top = "0"; 
    mybg.style.left = "0"; 
    mybg.style.zIndex = "400"; 
    mybg.style.opacity = "0.5"; 
    mybg.style.filter = "Alpha(opacity=30)"; 
    document.body.appendChild(mybg); 
    
    var bigdiv=document.getElementById("enlarge");
    bigdiv.style.textAlign = "center";
    
    /*
    bigdiv.style.width = "800px"; 
    bigdiv.style.height = "760px"; 
    bigdiv.style.overflow = "auto";
    bigdiv.style.margin-left = "auto";
    //bigdiv.style.position = "absolute"; 
    //bigdiv.style.top = "0"; 
    //bigdiv.style.left = "0"; 
    bigdiv.style.zIndex = "500"; 
    bigdiv.style.textAlign = "center";
    bigdiv.style.cursor="Pointer";
    //bigdiv.style.filter = "Alpha(opacity=30)"; 
    bigdiv.style.display = "block"; 
    */
    
    
    document.body.style.overflow = "hidden";
    
    bigdiv.innerHTML="<img style='margin-left:auto; margin-right:auto' src='"+path+"'>";
    
    //bigdiv.className="showp";
    
    bigdiv.style.cssText="top:50%;left:50%;position:absolute;overflow:auto;width:800px; height: 500px; text-align: center; margin-left: -400px; margin-right:auto;margin-top:-250px;; z-index:500; cursor:pointer; display:block;";
    
    mybg.onclick=function()
    {
        var mybg=document.getElementById("mybg");
        var bigdiv=document.getElementById("enlarge");
        bigdiv.style.display = "none"; 
        //mybg.style.display = "none";
        document.body.removeChild(mybg);  
    };
    bigdiv.onclick=function()
    {
        var mybg=document.getElementById("mybg");
        var bigdiv=document.getElementById("enlarge");
        bigdiv.style.display = "none"; 
        //mybg.style.display = "none";
        document.body.removeChild(mybg);  
    };
}







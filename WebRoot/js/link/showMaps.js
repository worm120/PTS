
function link(filename)
{
	var sid = document.getElementById("sid").value;
	if(confirm("ȷ����"+filename+"ѡ��Ϊ�ñ�����Ľ���ͼ��"))
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
			//���ݷ��ص��豸�����Ϣ��������ͼ�ϵĽڵ�
			    var result=xmlhttp.responseText;
			    if(result.indexOf("success")>=0)
		    	{
			    	alert("����� "+sid+" ��������ͼ "+filename+" �ɹ���");
		    	}
			    else
			    {
			    	alert("���������ͼ����ʧ�ܣ�����ѡ�����ͼ����!");
			    }
			    window.location.href=window.location.href; 
			    window.location.reload(); 
				
		  }
		};
		xmlhttp.open("GET","../servlet/linkSubmation?sid="+sid+"&svgname="+filename+"&t="+new Date().getTime(),true);
		xmlhttp.send();
	}
}

function delSvg(filename)
{
	var sid = document.getElementById("sid").value;
	if(confirm("ȷ����"+filename+"����ͼɾ����"))
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
			//���ݷ��ص��豸�����Ϣ��������ͼ�ϵĽڵ�
			    var result=xmlhttp.responseText;
			    if(result.indexOf("success")>=0)
		    	{
			    	alert("����ͼ "+filename+" ɾ���ɹ���");
		    	}
			    else
			    {
			    	alert("����ͼɾ��ʧ�ܣ�����ɾ������ͼ!");
			    }
			    window.location.href=window.location.href; 
			    window.location.reload(); 
				
		  }
		};
		xmlhttp.open("GET","../servlet/deleteSVG?sid="+sid+"&svgname="+filename+"&t="+new Date().getTime(),true);
		xmlhttp.send();
	}

}



/*��Ԥ��ģʽ
function yulan()
{
	//alert("dd");
	window.open("lookMap.jsp","","");	
}
*/
function yulan(path)
{
	//alert("dd");
    mybg = document.createElement("div"); 
    mybg.setAttribute("id","mybg"); 
    mybg.style.background = "#000"; 
    mybg.style.width = "100%"; 
    mybg.style.height = "100%"; 
    mybg.style.position = "absolute"; 
    mybg.style.top = "0"; 
    mybg.style.left = "0"; 
    mybg.style.zIndex = "99"; 
    mybg.style.opacity = "0.5"; 
    mybg.style.filter = "Alpha(opacity=30)"; 
    //mybg.style.border = "1px solid #ff0011";
    document.body.appendChild(mybg); 
    
    var bigdiv=document.getElementById("enlarge");
    bigdiv.style.textAlign = "center";
    

    
    document.body.style.overflow = "hidden";
    
    bigdiv.innerHTML="<img id='showimage' width='800px' height='500px'  style='margin-left:auto; margin-right:auto' src='"+path+"'>";
    
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







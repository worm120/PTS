<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
  <title>SVG Zooming</title>
  
  <script>
    
    function big()
    {
    	var box = document.getElementById('svgbox'); 
    	var boxwidth=box.getAttribute("width")*2;
    	var boxheight=box.getAttribute("height")*2;
    	
    	box.setAttribute("width",boxwidth);
    	box.setAttribute("height",boxheight);
    }
    function small()
    {
    	var box = document.getElementById('svgbox'); 
    	var boxwidth=box.getAttribute("width")/2;
    	var boxheight=box.getAttribute("height")/2;
    	
    	box.setAttribute("width",boxwidth);
    	box.setAttribute("height",boxheight);
    }
    
  </script>
</head>

<body onload="initialize();">
  <div style=" margin-bottom: 8px;">
   <button type="button" onclick="big();">Zoom +</button>
    <button type="button" onclick="small();">Zoom -</button>
  </div>
  <!--<svg id="svgElement" currentScale="1" width="800px" height="600px" viewBox="0 0 800 600">  <!-- The viewBox attribute resolves a zooming issue. -->
  <div class="box" ><!-- align="center" -->
		<object id="svgbox" style="position:relative;" width="800px" height="500px" type="image/svg+xml" data="../svg/141024131004.svg"></object>
		<!-- <embed id="svgbox" src="../svg/141024131004.svg" width="800px" height="500px" type="image/svg+xml" pluginspage="http://www.adobe.com/svg/viewer/install/" />
		 -->
  </div>

  
</body>

</html>

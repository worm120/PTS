function ImageAutoZoom(Img,FitWidth,FitHeight)
{
	alert("kkk");
  var image=new Image();
  image.src=Img.src;
  if(image.width>0 && image.height>0) 
  {
    if(image.width/image.height>= FitWidth/FitHeight)
    {
     if(image.width>FitWidth) 
     {
       Img.width=FitWidth;
       Img.height=(image.height*FitWidth)/image.width; 
     }
     else if(image.hight>FitHeight)
     {
       Img.height=FitHeight;
       Img.width=(image.width*FitHeight)/image.height; 
     }
     else
     {
      Img.width=FitWidth;
      Img.height=FitHeight;
     }
    }
  }
} 
import processing.video.*;
//import ketai.camera.*;
//PImage testImg;
Capture cam;
//KetaiCamera cam;

void setup(){
  //fullScreen();
  //orientation(LANDSCAPE);
  size(1600,1200);
  noStroke();
  //testImg = loadImage(sketchPath("")+"11600.jpg");
  //cam = new KetaiCamera(this, 1080, 1920, 20);
  try{
  cam = new Capture(this, 1600, 1200);
  }catch(Exception Err){
    cam = new Capture(this,1600, 1200, "pipeline:autovideosrc");
  }
  //cam = new Capture(this, 1600, 1200, "pipeline: ksvideosrc device-index=0 ! video/x-raw,width=1600,height=1200");
  cam.start();
}

void draw(){
  if(cam.available()) {
    cam.read();
    MakePixcel(cam, int(mouseX/100), int(mouseY/100));
  }
  
  /*if (cam != null && cam.isStarted())
    //image(cam, width/2, height/2, width, height);
    MakePixcel(cam, 28, 2);
  else
  {
    background(128);
    text("Camera is currently off.", width/2, height/2);
  }*/
}

void onCameraPreviewEvent()
{
  cam.read();
}

void MakePixcel(PImage InImg, int PixcelUnit, int LineWidth ){
  PImage OutImg = InImg;
  int PixcelFillUnit = PixcelUnit - LineWidth;
  color LineFillX = color(0, 0, 0);
  color LineFillY = color(0, 0, 0);
  for (int line=PixcelFillUnit; line < OutImg.width; line+=PixcelUnit){
    fill(LineFillX);
    rect(line, 0, LineWidth, OutImg.height);
  }
  for (int line=PixcelFillUnit; line < OutImg.height; line+=PixcelUnit){
    fill(LineFillY);
    rect(0, line, OutImg.width, LineWidth);
  }
  for(int PixcelX=0; PixcelX < OutImg.width; PixcelX+=PixcelUnit){
    for(int PixcelY=0; PixcelY < OutImg.height; PixcelY+=PixcelUnit){
      fill(OutImg.get(PixcelX, PixcelY));
      rect(PixcelX, PixcelY, PixcelFillUnit, PixcelFillUnit);
    }
  }

}

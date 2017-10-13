//import neessary kinect utilities
import KinectPV2.KJoint;
import KinectPV2.*;
import java.util.*;

//declare object array
ArrayList<Fountain> f;

//setup a switch for seeing the calibration screen
boolean trigger = true;

PImage img;
KinectPV2 kinect;

//a place to store the last values of the closest point to the sensor in case there isn't enough information to make a conclusion
float lastX = 0;
float lastY = 0;

//Distance Threashold
float zoom = 200;
int maxD = 2000; // 4.5mx
int minD = 50;  //  50cm

void setup() {
  colorMode(HSB);
  fullScreen(P3D, 2);
  //initialize kinect
  kinect = new KinectPV2(this);
  kinect.enableDepthImg(true);
  //Enable point cloud
  kinect.enablePointCloud(true);
  
  //method for starting capture in the kinect
  kinect.init();
  
  //declare your array of moving objects
  f = new ArrayList<Fountain>();
  //f.add(new Fountain(width / 2, height / 2));
}

void draw() {
  background(0);
  
  //initialize an image for the calibration method
  img = createImage(kinect.WIDTHDepth, kinect.HEIGHTDepth, RGB);
  
  //obtain the raw depth data in integers from [0 - 4500]
  int [] rawData = kinect.getRawDepthData();
  
  //load the pixels of the blank image
  if(trigger == true){
  img.loadPixels();
  }
  
  float sumX = 0;
  float sumY = 0;
  float totalPixels = 0;
  
  //a loop that iterates through all the the depth pixels and creates an image that shows up in red if the depth is within
  //the minimum and maximum thresholds currently set (see key pressed for adjustments)
  for(int i = 0; i < kinect.WIDTHDepth; i++){
   for(int j = 0; j < kinect.HEIGHTDepth; j++){
      if(rawData[i + j*kinect.WIDTHDepth] > minD && rawData[i + j*kinect.WIDTHDepth] < maxD){
       img.pixels[i + j*kinect.WIDTHDepth] = color(0, 255, 255);  
       sumX += i;
       sumY += j;
       totalPixels++;
      }
     }
  }
  
  //will show the image if set
  if(trigger == true){
  img.updatePixels();
  image(img,0,0);
  }
  
  
  //sets a threshold for how many pixels it is detecting within the threshold
  if(totalPixels > 150){
   float x = sumX / totalPixels;
   float y = sumY / totalPixels;
   //if there are enough pixels within the threshold run the sketch to the average point
   if(f.size() == 0){
     f.add(new Fountain(x, y));
   }
  for(int i = 0; i < f.size(); i++){
   Fountain c = f.get(i);
   c.follow(width - map(x, 0, kinect.WIDTHDepth, 0, width), map(y, 0, kinect.HEIGHTDepth, 0, height) - height / 2);
   c.run();
  }
  lastX = width - map(x, 0, kinect.WIDTHDepth, 0, width);
  lastY = map(y, 0, kinect.HEIGHTDepth, 0, height) - height / 1.75;
  }
  
   else{
    //run the objects as if they are gravitating to the last usable point that was recorded by the depth sensor
    for(int i = 0; i < f.size(); i++){
     Fountain c = f.get(i);
     c.follow(lastX, lastY);
     c.run();
  }
  }
}

//for changing the thresholds and switching the calibration image on and off
void keyPressed() {
  if (key == '1') {
    minD += 10;
    println("Change min: "+minD);
  }

  if (key == '2') {
    minD -= 10;
    println("Change min: "+minD);
  }

  if (key == '3') {
    maxD += 10;
    println("Change max: "+maxD);
  }

  if (key == '4') {
    maxD -=10;
    println("Change max: "+maxD);
  }
  if(key== 'a'){
   zoom += 10; 
  }
  if(key == 's'){
   zoom -= 10; 
  }
  if(key == ' '){
   if(trigger == true){
    trigger = false; 
    println("image off");
   }else{
     trigger = true;
     println("image on");
   }
  }
}
class Particle{
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  boolean isDead;
  int firstFrame;
  int lifeSpan;
  float hue;
  float startX;
  float startY;
  float sz = 4;
  
 Particle(int l, float X, float Y){
   hue = random(200, 255);
   startX = X;
   startY = Y;
   location = new PVector(startX, startY);
   velocity = new PVector(random(-3.5,3.5), random(-1.45, 1.45));
   acceleration = new PVector(0,0);
   firstFrame = frameCount;
   isDead = false;
   lifeSpan = l;
 }
 
 void update(){
   velocity.add(acceleration);
   location.add(velocity);
   if(frameCount - firstFrame > lifeSpan || location.x < 0 || location.x > width || location.y < 0 || location.y > height){
    isDead = true; 
   }
   acceleration.mult(0.0);
   
 }
 void display(){
   noStroke();
   //stroke(hue, 255, 255, lifeSpan - (frameCount - firstFrame));
   //fill(hue, 255, 255, lifeSpan - (frameCount - firstFrame));
   //strokeWeight(0);
   fill(random(250, 255), 255);
   ellipse(location.x, location.y, sz, sz);
 }
 void applyForce(PVector force){
  acceleration.add(force); 
 }
}
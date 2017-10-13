class Fountain{
  
 ArrayList<Particle> Particles;
 int number;
 float stX;
 float stY;
 PVector gravity;
 
 Fountain(float x, float y){
   stX = x;
   stY = y;
   
   Particles = new ArrayList<Particle>();
   for(int i = 0; i < number; i++){
     Particles.add(new Particle(int(random(80, 120)), stX, stY));
     Particles.add(new Particle(int(random(80, 120)), stX, stY));
   }
   
   gravity = new PVector(0, 0.1);
 }
 
 void run(){
   for(int i = 0; i < 100; i++){
     Particles.add(new Particle(int(random(120, 220)),stX, stY));
   }
   
   for(int i = 0; i < Particles.size(); i++){
   Particle p = Particles.get(i);
   p.applyForce(gravity);
   p.update();
   p.display();
   if(p.isDead == true){
    Particles.remove(i); 
   }
   }
 }
 void follow(float _x, float _y){
   stX = _x;
   stY = _y;
 }
 }
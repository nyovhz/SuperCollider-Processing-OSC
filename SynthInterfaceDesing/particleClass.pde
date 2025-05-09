class Particle{
  PVector location;
  PVector acceleration;
  PVector velocity;
  PVector steer;
  PVector boundary;
  float count;
  float maxSpeed;
  float maxForce;
  float alfa;
  float theta;
  
  
  Particle(float x, float y, float z) {
    acceleration = new PVector(Vx,Vy,Vz);
    velocity = new PVector(random(5),random(5),random(5));
    location = new PVector(x,y,z);
    boundary = new PVector(width/2,height/2,0);
    
    maxSpeed = speed;
    maxForce = centerF;
    count = density;
    alfa = 255;
    
  }

void setGeometry(boolean xxx, boolean xxx_){
  if(xxx){
    displaySph();
    
  }

  if(xxx_){
    displayBox();
  }  
}  

void setGeoLocation(){
    
    translate(width/2+200,200,-1440);    
    translate(location.x,location.y,location.z);
    
    theta = velocity.heading2D()+TWO_PI*frameCount*rot*0.1;
    rotateZ(theta);
    rotateX(theta);
    rotateY(theta);
    
}
  
void displayBox() {
  pushMatrix();   
     if(fill_){
        fill(255);
      }else{
        noFill();
      }
      
      if(stroke_){
       stroke(count/8,alfa*2);
      }else{
       noStroke();
      }
    
    setGeoLocation();
    strokeWeight(1);
    rotateY(75);
    box(count);
  popMatrix();
}

void displaySph(){
  pushMatrix();
      setGeoLocation();
      fill(count,alfa);
      noStroke();
      sphere(40);
  popMatrix();
}

void update(){
    //checkEdges();
    
    velocity.add(acceleration);    
    velocity.limit(maxSpeed);
    location.add(velocity);   
    seek(new PVector(mouseX,mouseY));    
    count -= 2.0;
  }
  
  boolean isDead(){
    if(count < 0.0){
      return true;
    } else {
      return false;
    }
  }
  
  void seek(PVector target){
    PVector desired = PVector.sub(target,location);
    desired.normalize();
    desired.mult(maxSpeed);
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxForce);
    applyForce(steer);
  }
  
  void applyForce(PVector force){
    acceleration.add(force);
  }
  
 
  
  void checkEdges(){
    if((location.x > 1160) || (location.x < 270 )){
      velocity.x = velocity.x * -2;   
    }
    if((location.y > height) || (location.y < 0 )){
      velocity.y = velocity.y * -2;       
    } 
  }
}

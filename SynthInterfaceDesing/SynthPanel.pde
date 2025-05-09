class panel{
  int x, y, x2, y2;
  color q;
  panel(int x_,int y_,int x2_,int y2_, color q_){
    x = x_;
    y = y_;
    x2 = x2_;
    y2 = y2_;
    q = q_;
  }
  
  void display(){
    fill(0);
    stroke(q);
    strokeWeight(1);
    beginShape();
    vertex(20, 20);
    vertex(130,20);
    vertex(160,40);
    vertex(335,40);
    vertex(width/2-20, 600);
    vertex(width/2-20,height-20);
    vertex(width/2-50,height-20);
    vertex(width/2-70,height-30);
    vertex(70,height-30);
    vertex(50,height-20);
    vertex(20, height-20);
    endShape(CLOSE);
    
    beginShape();
    vertex(width-20,height/3-100);
    vertex(width-20,height-20);
    vertex(width/2+275,height-20);
    vertex(width/2+275,height-50);
    vertex(width/2+375,height-100);
    vertex(width-30,height-100);
    vertex(width-30,height/2);
    vertex(width-50,height/2-30);
    vertex(width-50,height/3-70);
    endShape(CLOSE);
  
    
    pushMatrix();
    stroke(q);
    strokeWeight(2);
    line(280, 350,280+A*50,300); //A
    line(280+A*50,300,280+D*50+A*50,350-S*50); //D
    line(280+D*50+A*50,350-S*50, 330+D*50+A*50, 350-S*50); //S
    line(330+D*50+A*50,350-S*50, 330+D*50+A*50+Rls*50, 350); //R
    popMatrix();
    
  }
}

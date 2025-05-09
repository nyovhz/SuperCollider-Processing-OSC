import controlP5.*;
import oscP5.*;
import netP5.*;

ControlP5 cp5;
OscP5 oscP5;
NetAddress myRemoteLocation;

lightQ l;
panel panel1;
CheckBox checkbox;

ArrayList<Particle> plist = new ArrayList<Particle>();

//Global Variables
float density;
float speed;
float centerF;
float Vx;
float Vy;
float Vz;
float rot;
//COLOR
float R;
float G;
float B;
float R_;
float G_;
float B_;
color panelColor = color(random(255),random(255),random(255));
//checkbox
int myColorBackground;
boolean setSphere_;
boolean setBox_;
boolean fill_;
boolean stroke_;


//SynthSliders

int Freq;
float Mul;
float Amp;
float LPF;
float BPF;
float HPF;
float A;
float D;
float S;
float Rls;
////////////////////////
//booleans

boolean osc1 = false;


void setup(){
size(1420,850,P3D);
smooth(2);
  
  oscP5 = new OscP5(this,12000);
  myRemoteLocation = new NetAddress("127.0.0.1",57120);
 
  panel1 = new panel(25,25,width/2-100,height-75,panelColor); 
  l = new lightQ();
  cp5 = new ControlP5(this);
  //checkbox
  
  checkbox = cp5.addCheckBox("checkbox")
                .setPosition(width/2+500,40)
                .setSize(30, 20)
                .setItemsPerRow(3)
                .setBackgroundColor(panelColor)
                .setSpacingColumn(20)
                .setSpacingRow(20)
                .addItem("Sph", 0)
                .addItem("str", 50)
                .addItem("fill", 100)
                .addItem("Box", 150)
                .addItem("200", 200)
                .addItem("255", 255);

  //Animation Controls//
  addSlider("density",300,1000,random(500),width/3,40,color(255),color(50),150,20);  
  addSlider("speed",0,20,random(20),width/3+20,70,color(255),color(50),150,20);      
  addSlider("centerF",0,1,0,width/3+40,100,color(255),color(50),150,20);
  addSlider("Vx",-10,10,0,width/2,40,color(255),color(50),150,20);
  addSlider("Vy",-10,10,0,width/2+20,70,color(255),color(50),150,20);
  addSlider("Vz",-10,20,0,width/2+40,100,color(255),color(50),150,20);
  addSlider("rot",-0.1,0.1,0,width/2+250,40,color(255),color(50),15,70);
  addSlider("R",0,255,random(255),width/2+350,40,color(255,0,0),color(50),10,60);
  addSlider("G",0,255,random(255),width/2+370,50,color(0,255,0),color(50),10,60);
  addSlider("B",0,255,random(255),width/2+390,60,color(0,0,255),color(50),10,60);
  addSlider("R_",0,255,random(255),width/2+410,60,color(255,0,0),color(50),10,60);
  addSlider("G_",0,255,random(255),width/2+430,50,color(0,255,0),color(50),10,60);
  addSlider("B_",0,255,random(255),width/2+450,40,color(0,0,255),color(50),10,60);
  
  //Synth Controls//
      //Oscilator//
      addSlider("Freq",0,10000,0,50,100,color(255),color(50),150,20);
      addSlider("Mul",0,2,1,50,130,color(255),color(50),150,20);

      //Filter//
      addSlider("LPF",20,20000,100,50,200,color(255),color(50),150,20);
      addSlider("BPS",1000,10000,5000,50,230,color(255),color(50),150,20);
      addSlider("HPF",20,20000,20000,50,260,color(255),color(50),150,20);
      
      //Envelope//
      addSlider("A",0,1,0.5,275,400,color(255),color(50),15,80);
      addSlider("D",0,1,0.5,300,400,color(255),color(50),15,80);
      addSlider("S",0,1,0.5,325,400,color(255),color(50),15,80);
      addSlider("Rls",0,1,0.5,350,400,color(255),color(50),15,80);
      
      //Amplifier//
      addSlider("Amp",0,2,1,50,330,color(255),color(50),150,20);
      
      //Effects//
      addSlider("Delay",0,10000,random(1000),50,400,color(255),color(50),150,20);
      addSlider("Reverb",0,10000,random(1000),50,430,color(255),color(50),150,20);
      addSlider("Distor",0,10000,random(1000),50,460,color(255),color(50),150,20);
      
      //Sequencer//
      
      
}

void draw(){
  background(0);

  
  panel1.display();
  l.set();
  keyPressed();
  addParticle();
  sendControlOsc(Freq,"/synthControl/key");
  lights();
}

void addSlider(String name, float min, float max, float set, int x, int y,color tint, color backtint, int szX,int szY){
  Slider s = cp5.addSlider(name);
  s.setSize(szX,szY);
  s.setRange(min,max);
  s.setValue(set);
  s.setPosition(x,y);
  s.getColor().setBackground(backtint);
  s.getCaptionLabel().setColor(tint);
  s.getValueLabel().setColor(tint);
  customize();
}

void customize(){
  cp5.setColorActive(color(25));
  cp5.setColorForeground(color(125));
}

void addParticle(){
   for(int j = 0; j < plist.size(); j++){       
        Particle p = plist.get(j);
        p.setGeometry(setSphere_, setBox_);
        p.update();
        
       if(p.isDead()){
         plist.remove(j);
       }
       
   }
}

void keyPressed(){
  
    if(keyPressed){
      if(key == 'q'){
      plist.add(new Particle(random(250,width-250),random(height),random(10)));
      }
    } //addParticle();
  
  
  if(keyPressed){
    if(key == 'r'){
         density = random(1200);
         speed = random(20.0);
         centerF = random(0.10);
         Vx = random(-10,10);
         Vy = random(-10,10);
         Vz = random(-10,10);
         rot = random(-0.005,0.005);
        
    }
  }
  
  //////////////////////////////////////
  if (key==' ') {
    checkbox.deactivateAll();
  } 
  else {
    for (int i=0;i<6;i++) {
      // check if key 0-5 have been pressed and toggle
      // the checkbox item accordingly.
      if (keyCode==(48 + i)) { 
        // the index of checkbox items start at 0
        checkbox.toggle(i);
        println("toggle "+checkbox.getItem(i).getName());
        // also see 
        //checkbox.activate(i);
        // checkbox.deactivate(index);
      }
    }
  }
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(checkbox)) {
    myColorBackground = 0;
    setSphere_ = false;
    setBox_ = false;   
    fill_ = false;
    stroke_ = false;
    
    
    for (int j = 0; j < checkbox.getArrayValue().length;j++){
      //sphere
      int _01 = (int)checkbox.getArrayValue()[0];
      int _02 = (int)checkbox.getArrayValue()[1];
      int _03 = (int)checkbox.getArrayValue()[2];
      //box
      int _04 = (int)checkbox.getArrayValue()[3];
      int _05 = (int)checkbox.getArrayValue()[4];
      int _06 = (int)checkbox.getArrayValue()[5];
      
      if(_01 == 1){
        setSphere_ = true;
      }
      
      if(_02 == 1){
        stroke_ = true;
      }
      if(_03 == 1){
        fill_ = true;
      }
      if(_04 == 1){
        setBox_ = true;
      }
    }
  }
}

void sendControlOsc(int xx, String str){
  float [] oscValues = {Mul,Amp,LPF,BPF,HPF,A,D,S,Rls};

  OscMessage controlOsc = new OscMessage(str);
  controlOsc.add(round(xx));
    for(int i=0; i<oscValues.length; i++){
    controlOsc.add(oscValues[i]);
    }
    oscP5.send(controlOsc, myRemoteLocation);
}

void oscEvent(OscMessage theOscMessage){
 if(theOscMessage.checkAddrPattern("/step1") == true){
     plist.add(new Particle(random(250,width-250),random(height),random(100)));
     print(" addrpattern: "+theOscMessage.addrPattern());
     println(" typetag: "+theOscMessage.typetag());
 }
 if(theOscMessage.checkAddrPattern("/step2") == true){
     speed = random(20.0);
     
     Vx = random(-10,10);
     Vy = random(-10,10);
     Vz = random(-10,10);
     rot = random(-0.005,0.005);
 }
}

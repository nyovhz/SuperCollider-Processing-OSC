class lightQ{
  int xs;
  int ys;
  int zs;
  int nx;
  int ny;
  int nz;
  float angle;
  float conce;
  
  lightQ(){
   xs = 1200;
   ys = 800;
   zs = 0;
   nx = 200;
   ny = 100;
   nz = -1000;
   angle = 100;
   conce = 0; 
  }
  
  void set(){
    spotLight(R,G,B,xs,ys,zs,nx,ny,nz,angle,conce+25);
    spotLight(R_,G_,B_,xs,100,zs,nx,ny,nz,angle,conce+25);
  }
}

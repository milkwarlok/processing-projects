float theta = 0.;
float step = 0.01;
float alpha = 0.;
float alphaStep = 0.005;
boolean loop = true;
void setup(){
  frameRate(1000);
  size(600, 601);
  background(255);
  fill(0);
}
void draw(){
  translate(width/2, height/2);
  float x = f(alpha)*cos(theta);
  float y = f(alpha)*sin(theta);
  
  float next_x = f(alpha)*cos(theta + step);
  float next_y = f(alpha)*sin(theta + step);
  
  line(x, y, next_x, next_y);
  theta += step;
  alpha+= alphaStep;
}


float f(float x){
  return 75*(sin(2*x) + sin(3*x));}


void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(e > 0){
  alphaStep += 0.001;
  }
  else{
  alphaStep -= 0.001;
  }
  if(alphaStep < 0) step = 0.001;

  background(255);
  text("alphaStep: "+alphaStep, 0, 0);
}
void mouseClicked() {
  if(loop){
  noLoop();
  loop=!loop;
  }else{
      loop();
      loop=!loop;
  }
}

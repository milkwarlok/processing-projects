float theta = 0.;
float step = 0.6;
boolean loop = true;
void setup(){
size(600, 600);
background(255);
fill(0);
text("Rotate the wheel: ", width/2, height/2);

}

void draw(){
translate(width/2, height/2);
float x = 300*cos(theta);
float y = 300*sin(theta);

float next_x = 300*cos(theta + step);
float next_y = 300*sin(theta + step);

line(x, y, next_x, next_y);
theta += step;
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(e > 0){
  step += 0.1;
  }
  else{
  step -= 0.1;
  }
  if(step < 0) step = 0;

  background(255);
text("Step: "+step, 0,0);
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

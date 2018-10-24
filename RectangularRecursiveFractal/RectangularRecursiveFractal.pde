void setup(){
noFill();
background(255);
size(600, 600);
drawRect(width/2, height/2, 256, 256);
}

void draw(){}

void drawRect(float x, float y, float w, float h){
  if(w <= 1 || h <= 1) return;
  rect(x - w/2, y - w/2, w, h);

  drawRect(x + w/2, y - h/2, w/2, h/2);
  drawRect(x - w/2, y - h/2, w/2, h/2);
  drawRect(x, y + h/2, w/2, h/2); 
}

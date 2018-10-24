import java.util.Random;
int divisor = 2;
int posDivisor = 2;
boolean top = true;
boolean left = true;
boolean bottom = true;
boolean right = true;
Random rand = new Random();
void setup(){
noFill();
background(255);
size(600, 600);
drawCircle(width/2, height/2, 256);
}

void draw(){}

void drawCircle(float x, float y, float d){
  if(d <= 1) return;
  ellipse(x, y, d, d);
  top = rand.nextBoolean();
  right  = rand.nextBoolean() || top;
  bottom  = rand.nextBoolean() || right;
  left = rand.nextBoolean() || left;
  if(top)
  drawCircle(x + d/posDivisor, y, d/divisor);
  if(left)
  drawCircle(x - d/posDivisor, y, d/divisor);
  if(bottom)
  drawCircle(x, y + d/posDivisor, d/divisor);
  if(left);
  drawCircle(x, y - d/posDivisor, d/divisor);

}

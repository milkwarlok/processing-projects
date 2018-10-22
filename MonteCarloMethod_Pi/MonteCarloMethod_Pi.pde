ArrayList<PVector> allPoints;
ArrayList<PVector> inCirclePoints;
int diameter = 0;
void setup(){
size(600, 600);
allPoints = new ArrayList<PVector>();
inCirclePoints = new ArrayList<PVector>();
diameter = width < height ? width : height;
frameRate(1000);
}
void draw(){
translate(diameter/2, diameter/2);
fill(0);
rect(-diameter/2, -diameter/2, diameter, diameter);
fill(200, 255, 255);
ellipse(0, 0, diameter, diameter);

float x = random(-diameter/2, diameter/2);
float y = random(-diameter/2, diameter/2);

allPoints.add(new PVector(x, y));

if(dist(x, y, 0, 0) < diameter/2){
  inCirclePoints.add(new PVector(x, y));
}

fill(255, 100, 100);
for(int i = 0; i < allPoints.size(); i++){
  PVector point = allPoints.get(i);
  ellipse(point.x, point.y, 10, 10);
}
fill(255, 255, 100);
for(int i = 0; i < inCirclePoints.size(); i++){
  PVector point = inCirclePoints.get(i);
  ellipse(point.x, point.y, 10, 10);
}
fill(0);
textSize(32);
text("pi = " + 4.*(float)inCirclePoints.size()/(float)allPoints.size(),0, 0);
}

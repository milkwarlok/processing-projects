float sigma = 10;
float rho = 28;
float beta = 8.0/3.0;
float x = 1, y = 0, z = 0;
float angle = 0;
ArrayList<Point> points;
void setup(){
size(600, 600, P3D);
points = new ArrayList<Point>();
}

void draw(){
  float dt = 0.01;
  float dx = dt*(sigma*(y - x));
  float dy = dt*(x*(rho - z) - y);
  float dz = dt*(x*y - beta*z);
  points.add(new Point(x, y, z));
  x = x + dx;
  y = y + dy;
  z = z + dz;
  angle+=0.001;
  pushMatrix();
  colorMode(RGB);
  background(255);
    translate(width/2, height/2);
    scale(4);
    rotateY(angle);
    noFill();  
    colorMode(HSB);

    beginShape();
    for(int i = 0; i < points.size(); i++){
      Point p = points.get(i);
      stroke(map(i, 0, points.size(), 0, 255), 255, 255);
      vertex(p.x, p.y, p.z);
    }
    endShape();
  popMatrix();
}

class Point{
float x;
float y;
float z;
Point(){}
Point(float x, float y, float z){
  this.x = x;
  this.y = y;
  this.z = z;
}
}

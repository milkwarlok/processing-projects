Point p;
PImage img;
ArrayList<Point> objs;
    void setup(){
  objs = new ArrayList<Point>();
  for(int i = 0; i < 5; i++){

  PVector location = new PVector( (i + 1) * 100, height/2 - 100);
  PVector speed = new PVector(3,0);
  PVector acc = new PVector(0,0);
    p = new Point(location, speed, acc, (i + 1) * 3);
    objs.add(p);
  }
  size(800, 600);
  img = loadImage("леха.png");

}
void draw(){
    background(0);
  fill(0);


  for(int i = 0; i < objs.size(); i++){

    p = objs.get(i);
      PVector currentForce = new PVector(mouseX - p.location.x, mouseY - p.location.y);
    currentForce.setMag(0.2);
    p.applyForce(currentForce);
    p.update();
    p.show();
  }
}
class Point{
PVector location;
PVector speed;
PVector acc;
float limit;

Point(){}
Point(PVector location, PVector speed, PVector acc, float limit){
  this.location = location;
  this.speed = speed;
  this.acc = acc;
  this.limit = limit;
}
void update(){
speed.add(acc);
speed.limit(limit);
location.add(speed);
}

void show(){
  //ellipse(location.x, location.y, 20, 20);
  image(img, location.x - 50, location.y - 75, 100, 150);
}

void applyForce(PVector force){
  acc = force;
}
}

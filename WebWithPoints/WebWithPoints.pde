import java.util.Random;
ArrayList<Point> points;
Random rand;
float connectionDistance;
void setup(){
  size(600, 400);
  rand = new Random();
  points = new ArrayList<Point>();
  for(int i = 0; i < 25; i++){
    points.add(
    new Point(new PVector(rand.nextInt(width - 2) + 1, rand.nextInt(height - 2) + 1)
    , new PVector(3*rand.nextFloat(), 3*rand.nextFloat())
    ));
  }
  connectionDistance = width/5;

}
void draw(){
  background(0); 
  fill(0);
   for(int i = 0; i < points.size(); i++){
      Point p = points.get(i);
      p.update();

      stroke(255);
      strokeWeight(1);
      p.show();
    }
   
     for(int i = 0; i < points.size(); i++){
        for(int j = i; j < points.size() ; j++){
          Point ip = points.get(i);
          Point jp = points.get(j);
          float actualDistance = dist(ip.location.x, ip.location.y, jp.location.x, jp.location.y);
          float expectedDistance = connectionDistance;
          if(actualDistance < expectedDistance){
            strokeWeight(map(actualDistance, 0, expectedDistance, 10, 1));
            stroke(map(actualDistance, 0, expectedDistance, 255, 0), 255, 255);
            line(ip.location.x, ip.location.y, jp.location.x, jp.location.y);
          }
        }
    }

}


class Point{
  PVector location;
  PVector speed;
  Point(){}
  Point(PVector location, PVector speed){
    this.location = location;
    this.speed = speed;
  }
  
  void update(){
    location.add(speed);
    checkBoundaries();
  }
  
  void show(){
    ellipse(location.x, location.y, 10, 10);
  }
  
  void checkBoundaries(){
    if(location.x <= 0){
      speed.x = -speed.x;
    }
    if(location.y <= 0){
      speed.y = -speed.y;
    }
    if(location.x >= width){
      speed.x = -speed.x;
    }
    if(location.y >= height){
      speed.y = -speed.y;
    }
  }
}

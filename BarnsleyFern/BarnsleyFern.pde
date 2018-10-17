import java.util.Random;
Point next;
int resolution = 100000;
// boundaries: https://en.wikipedia.org/wiki/Barnsley_fern
float left = -2.1820;
float right = 2.6558;
float bottom = 0.0;
float top = 9.9983;
Random rand;

void setup(){
  strokeWeight(2);
  size(600, 600);
}

public Point getNextBarnsleyFernPoint(Point previousPoint, int randomNumber){
  randomNumber = randomNumber%100;
  if(randomNumber < 1){
    return new Point(0., 0.16*previousPoint.y);
  }
  else if(randomNumber >= 1 && randomNumber < 86)
  {
    return new Point(0.85 * previousPoint.x + 0.04 * previousPoint.y, 
                     -0.04 * previousPoint.x + 0.85 * previousPoint.y + 1.6);
  }
  else if(randomNumber >= 86 && randomNumber < 93)
  {
    return new Point(0.2 * previousPoint.x - 0.26 * previousPoint.y, 
                     0.23 * previousPoint.x + 0.22 * previousPoint.y + 1.6);
  }
  else
  {
    return new Point(-0.15 * previousPoint.x + 0.28 * previousPoint.y, 
                      -.26 * previousPoint.x + 0.24 * previousPoint.y + 0.44);
  }
}
void draw(){
  background(0);
  next = new Point(0, 0);
  rand = new Random();
  
  loadPixels();
  for(int i = 0; i < resolution; i++){
      next = getNextBarnsleyFernPoint(next, rand.nextInt(100));
      float x = map(next.x, left, right, 0., width);
      float y = map(next.y, bottom, top, height, 0);
      int index = (int)x%width + (int)y%height*width;
      pixels[index] = color(0, 255, 0);
  }
updatePixels();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  resolution = resolution + (int)(e * resolution/10);
  if(resolution < 1000) resolution = 1000;
}


class Point{
public float x; 
public float y;

  Point(){};
  Point(float x, float y){
  this.x = x;
  this.y = y;
  }
}

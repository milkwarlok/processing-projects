float alpha;
float alphaStep;
int xStep;
int yStep;
ArrayList<Point> pointsTop;
ArrayList<Point> pointsLeft;
ArrayList<Point> lissajousPoints;
int radius;

void setup(){
size(600, 600);
noFill();

alpha = 0.0;
alphaStep = 0.001;
xStep = 100;
yStep = 100;
radius = xStep/2;

pointsTop = new ArrayList<Point>();
pointsLeft = new ArrayList<Point>();
lissajousPoints = new ArrayList<Point>();
}

void draw(){
  background(255);
  //counting TOP circles
  for(int i = 0; i < width/xStep ; i++){
    int x = xStep * i + 3*radius + (int)(radius * cos((i+1) * alpha));
    int y = radius + (int)(radius * sin((i+1) * alpha));
    pointsTop.add(new Point(x,y));
    line(x, 0, x, height);
    alpha+= alphaStep;
    }
  //rendering TOP circles  
  for(int pointN = 0; pointN < pointsTop.size(); pointN ++){
      point(pointsTop.get(pointN).x,pointsTop.get(pointN).y);
    }
  //counting LEFT circles
  for(int i = 0; i < width/xStep ; i++){
    int x = radius + (int)(radius * cos((i+1) * alpha));
    int y = yStep * i + 3*radius + (int)(radius * sin((i+1) * alpha));
    pointsLeft.add(new Point(x,y));
    line(0, y, width, y);
    alpha+= alphaStep;
  }
  //rendering LEFT circles
  for(int pointN = 0; pointN < pointsLeft.size(); pointN ++){
    point(pointsLeft.get(pointN).x,pointsLeft.get(pointN).y);
  }
  //counting lissajousPoints(intersection of left circles' y-coorinates and top circles' x-coordinate)
  for(int i = 0; i < width/xStep ; i++){
    for(int j = 0; j < height/yStep; j++){
    int x = xStep * i + 3*radius + (int)(radius * cos((i+1) * alpha));
    int y = yStep * j + 3*radius + (int)(radius * sin((j+1) * alpha));
    
    lissajousPoints.add(new Point(x,y));
    alpha+= alphaStep;
    }
  }
  //rendering lissajousPoints
  for(int pointN = 0; pointN < lissajousPoints.size(); pointN ++){
    point(lissajousPoints.get(pointN).x,lissajousPoints.get(pointN).y);
  }
  //clearing arrays
    if(alpha > (float)2*TWO_PI) {
      alpha = 0.0;
      pointsTop.clear();
      pointsLeft.clear();
      lissajousPoints.clear();
  }
}
class Point{
public float x; 
public float y;
  Point(float x, float y){
  this.x = x;
  this.y = y;
  }
}

ArrayList<ArrayList<ACircle>> circles;
int step = 10;
int count = 0;
void setup(){
  circles = new ArrayList<ArrayList<ACircle>>();

  size(800, 600);
  //fullScreen(P2D);
  for(int i = 0; i < width; i = i + step){
    circles.add(new ArrayList<ACircle>());
    for(int j = 0; j < height; j = j + step){
      circles.get(i/step).add(new ACircle(i + step/2, j + step/2, step/2));
    }
  }

noStroke();
colorMode(HSB);
}

void draw(){
    count++;
  for(int i = 0; i < circles.size(); i++){
      for(int j = 0; j < circles.get(i).size(); j++){
        ACircle circle= circles.get(i).get(j);
        fill((count + dist(mouseX, mouseY, circle.x, circle.y)) % 255, 255, 255);
        ellipse(circle.x, circle.y, circle.radius, circle.radius);
      }
  }
}

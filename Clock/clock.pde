//и тебe :D
int secPadding=0;
int minPadding=0;
int hourPadding=0;


float secMultiplier = 50;
float minMultiplier = 50;
float hourMultiplier = 50;
final float ONE_DEGREE = (float)Math.PI/(float)180;
float currentAngle = 0.0;
void setup(){
size(800, 800);
background(0);
noFill();
strokeWeight(5);

secPadding = 90;
minPadding = 60;
hourPadding = 30;
}

void draw(){
  background(0);
  
  // draw hour-circle
  stroke(120,0,200);
  arc(width/2, height/2, width - hourPadding, height - hourPadding, 0 - HALF_PI,
  map(hour()%12, 0, 11, (float)0, TWO_PI - PI/6) - HALF_PI
  );
  // draw hour-arrow
  hourMultiplier = 0.9*(width/2 - hourPadding);
  line(width/2, height/2, 
  hourMultiplier*(float)Math.cos(map(hour()%12, 0, 11, (float)0, TWO_PI - PI/6) - HALF_PI) + width/2 ,
  hourMultiplier*(float)Math.sin(map(hour()%12, 0, 11, (float)0, TWO_PI - PI/6) - HALF_PI) + height/2
  );
  
  //draw minute-circle
  stroke(0,200,120);
  arc(width/2, height/2, width - minPadding, height - minPadding, 0 - HALF_PI,
  map(minute(), 0, 59, (float)0, TWO_PI - PI/30) - HALF_PI
  );
  //draw minute-arrow
  minMultiplier = 0.9*(width/2 - minPadding);
  line(width/2, height/2, 
  minMultiplier*(float)Math.cos(map(minute(), 0, 59, (float)0, TWO_PI - PI/30) - HALF_PI) + width/2 ,
  minMultiplier*(float)Math.sin(map(minute(), 0, 59, (float)0, TWO_PI - PI/30) - HALF_PI) + height/2
  );
 
 //draw seconds-circle
  stroke(200,0,120);
  arc(width/2, height/2, width - secPadding, height - secPadding, 0 - HALF_PI,
  map(second(), 0, 59, (float)0, TWO_PI - PI/30) - HALF_PI
  );
  //draw seconds-arrow
  secMultiplier = 0.9*(width/2 - secPadding);
  line(width/2, height/2, 
  secMultiplier*(float)Math.cos(map(second(), 0, 59, (float)0, TWO_PI - PI/30) - HALF_PI) + width/2 ,
  secMultiplier*(float)Math.sin(map(second(), 0, 59, (float)0, TWO_PI - PI/30) - HALF_PI) + height/2
  );  
}

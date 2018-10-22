import java.util.LinkedList;
LinkedList<Integer> numbers;
int mouseShiftX;
int mouseShiftY;
int count;

void setup(){
  fullScreen();
  numbers = new LinkedList<Integer>();
  mouseShiftX = 0;
  mouseShiftY = 0;
  count = 1;
  numbers.add(0);
}

void draw(){
  background(255);
  noFill();
  int lastRecaman = numbers.get(numbers.size() - 1);
  if(lastRecaman - count > 0 && !numbers.contains(lastRecaman - count)){
    numbers.add(lastRecaman - count);
  }
  else{
    numbers.add(lastRecaman + count);
  }
  count++;
  for(int i = 0; i < numbers.size() - 1; i++){
      int currentNum = numbers.get(i);
      int nextNum = numbers.get(i + 1);
      colorMode(HSB, 255);
      stroke(map(i, 0, numbers.size(), 0, 255), 255,255);
      if(i % 2 == 0){
        arc((currentNum + nextNum)/2 - mouseShiftX, height/2 - mouseShiftY, 
        abs(currentNum-nextNum), abs(currentNum-nextNum)
        ,0,PI);
      }
      else{
        arc((currentNum + nextNum)/2 - mouseShiftX, height/2 - mouseShiftY, 
        abs(currentNum-nextNum), abs(currentNum-nextNum)
        ,PI,TWO_PI);
      }
      colorMode(RGB, 255);
  }
}

void mouseDragged() 
{
  mouseShiftX += pmouseX - mouseX;
  mouseShiftY += pmouseY - mouseY;
  println(mouseShiftX);
}

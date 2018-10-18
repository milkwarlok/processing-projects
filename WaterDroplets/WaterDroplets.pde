double damping = 0.99;
int[][] frame1;
int[][] frame2;
int waveHeight = Integer.MAX_VALUE/1024;
java.util.Random rand;
void setup(){
  size(800, 600);
  frame1 = new int[height][width];
  frame2 = new int[height][width];
  frameRate(60);
  rand = new java.util.Random();
}

void draw(){
  if(rand.nextInt(100) < 30){
    int randY = rand.nextInt(width - 2) + 1;
    int randX = rand.nextInt(height - 2) + 1;
    int randHeight = rand.nextInt(waveHeight/2) + waveHeight/2;
  frame1[randX][randY] = randHeight;
  frame1[randX - 1][randY] = randHeight;
  frame1[randX + 1][randY] = randHeight;
  frame1[randX][randY - 1] = randHeight;
  frame1[randX][randY + 1] = randHeight;
  }
  
  loadPixels();
  for(int i = 1; i < height - 1; i++){
    for(int j = 1; j < width - 1; j++){
      frame2[i][j] = (frame1[i-1][j]+
                      frame1[i+1][j]+
                      frame1[i][j+1]+
                      frame1[i][j-1])/2 - frame2[i][j];
      frame2[i][j]*= damping;
      int index = j + width * i;
      pixels[index] = color(map(frame2[i][j], 0, waveHeight, 200, 0));
    }
  }
  updatePixels();
  
  int[][] temp = frame1;
  frame1 = frame2;
  frame2 = temp;
}

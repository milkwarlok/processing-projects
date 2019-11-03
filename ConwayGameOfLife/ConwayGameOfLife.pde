import java.util.Random;
int nOfCellsX = 100;
int nOfCellsY = 100;
int initProbability = 20;
int wOfCell, hOfCell;
int[][] field;
int[][] buffer;

Random r = new Random();
void setup(){
  size(600, 600);
  wOfCell = width/nOfCellsX;
  hOfCell = height/nOfCellsY;
  
  field = new int[nOfCellsX][nOfCellsY];
  buffer= new int[nOfCellsX][nOfCellsY];
  
  for(int i = 0; i < nOfCellsX; i++){
    for(int j = 0; j < nOfCellsY; j++){
      field[i][j] = r.nextInt(100) < initProbability? 1 : 0;
    }
  }
}

void draw(){
  
  frameRate(10);
  background(255);
  for(int i = 0; i < nOfCellsX; i++){
    for(int j = 0; j < nOfCellsY; j++){
      int nOfCellsAlive = 0;
      for(int k = i - 1; k <= i+1; k++){
        for(int r = j - 1; r <= j+1; r++){
          if(k < 0 || r < 0 || k >= nOfCellsX ||r >= nOfCellsY) continue;
          if(k == i && r == j) continue;
          if(field[k][r] == 1){
            nOfCellsAlive++;
          }
        }
      }
      if(field[i][j] == 0){
        if(nOfCellsAlive == 3){
          buffer[i][j] = 1;
        }else{
          buffer[i][j] = field[i][j];
        }
      }else{
        if( nOfCellsAlive < 2){
          buffer[i][j] = 0;
        }else if(nOfCellsAlive == 2 || nOfCellsAlive == 3){
          buffer[i][j] = 1;
        }else{
          buffer[i][j] = 0;
        }
      }
    }
  }
  for(int i = 0; i < nOfCellsX; i++){
    for(int j = 0; j < nOfCellsY; j++){
      field[i][j] = buffer[i][j];
    }
  }
  stroke(0);
  for(int i = 0; i < nOfCellsX; i++){
    for(int j = 0; j < nOfCellsY; j++){
      if(field[i][j] == 0){
        fill(255);
      }else{
        fill(0);
      }
      rect(i * wOfCell, j * hOfCell, wOfCell, hOfCell);
    }
  }
}

void mouseDragged(){
  int indX = mouseX/wOfCell;
  int indY = mouseY/hOfCell;
  if(field[indX][indY] == 0){
    field[indX][indY] = 1;
  }else{
    field[indX][indY] = 0;
  }
}

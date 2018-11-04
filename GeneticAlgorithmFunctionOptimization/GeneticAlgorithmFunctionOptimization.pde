import java.util.List;
import java.util.Comparator;
//Variant n. 25;
float a =  3;
float b = 12;
float c = 23;
float d = 21;

float scaleX = 4.;
float scaleY = 0.001;
float functionStartX = -20.;
float functionEndX = 49.;
float functionOffsetX = 0.;
float functionOffsetY = 0.;
int generationSize = 100;
int mutationChance = 5;
int generationCount = 0;
List<Integer> parents;
void setup(){
  size(600, 600);
  //1. create first generation
  parents = generateFirstGeneration(generationSize);
frameRate(24);
}
void draw(){
if(generationCount >= 500) noLoop();
background(255);
translate(width/2 +  + functionOffsetX, height/2 +  + functionOffsetY); 
//2. Create children
List<Integer> children = generateChildren(parents);
//3. Apple mutation, with change of mutationChance.
applyMutation(children, mutationChance);
//4. Combine parents and children, and shrink population to initialValue;
parents = combineAndShrinkGenerations(parents, children);

//5. render results:
text("Generation: "  + ++generationCount, -width/2 + 20, - height/2 + 20);
  println(children.size());
  println(parents.size());
stroke(0);
fill(0);
strokeWeight(1);
drawAxes();
noFill();
stroke(255, 120, 120);

  beginShape();
    for(float i = functionStartX; i < functionEndX; i+= 0.001){
    vertex(scaleX*i, -scaleY*Y_(i));
    }
  endShape();
    for(int i = 0; i < parents.size(); i++){
      stroke(255, 0, 255);
      strokeWeight(5);
    point(scaleX*parents.get(i),
         -scaleY*Y_(parents.get(i)));
  }
}

float Y(float x, float a, float b, float c, float d){
  return -1*(x - a)*(x - b)*(x - c)*(x - d);
}

float Y_(float x){
    return Y(x, a, b, c, d);
}


List<Integer> generateFirstGeneration(int n){
  List<Integer> firstGeneration = new ArrayList<Integer>();
  
  for(int i = 0; i < n; i++){
    firstGeneration.add((int)random(functionStartX, functionEndX));
  }
  
  return firstGeneration;
}
List<Integer> generateChildren(List<Integer> parents){
  List<Integer> children = new ArrayList<Integer>(parents.size());
  for(int i = 0; i < parents.size()/2; i++){
    //1. Get parents indeces.
    int firstParentIndex = (int)random(parents.size());
    int secondParentIndex;
    if(firstParentIndex < parents.size()/2){
      secondParentIndex = (int)random(firstParentIndex + 1, parents.size());
    }
    else{
      secondParentIndex = (int)random(0, firstParentIndex);
    }
    //2. Get actual parents.
    int firstParent = parents.get(firstParentIndex);
    int secondParent = parents.get(secondParentIndex);
    //3. Get parents binaries("genomes");
    String firstParentBinary = Integer.toBinaryString(firstParent);
    String secondParentBinary = Integer.toBinaryString(secondParent);
    //4. Find children binaries ("genomes");
    String firstChildBinary = firstParentBinary.substring(0, firstParentBinary.length()/2) +
                              secondParentBinary.substring(secondParentBinary.length()/2, secondParentBinary.length());
    String secondChildBinary = secondParentBinary.substring(0, secondParentBinary.length()/2) +
                              firstParentBinary.substring(firstParentBinary.length()/2, firstParentBinary.length());
    //5. Convert binaries to actual children;
    int firstChild = (int)Long.parseLong(firstChildBinary, 2);
    int secondChild = (int)Long.parseLong(secondChildBinary, 2);
    //6. Add new children.
    children.add(firstChild);
    children.add(secondChild);
  }

  return children;
}

void applyMutation(List<Integer> children, int mutationChance){
  for(int i = 0; i < children.size(); i++){
    int randNum = (int) random(100);
    if(randNum < mutationChance){
      int pwr = (int) random(0, 32);
      int mutantGene = 1;
      mutantGene = mutantGene << pwr;
      // swap bit 0->1 or 1->0 in children.get(i)
      if((children.get(i) | mutantGene) == children.get(i)){
       children.set(i, children.get(i) & ~mutantGene);
      }
      else {
        children.set(i, children.get(i) | mutantGene);
      }
    }
  }
}


List<Integer> combineAndShrinkGenerations(List<Integer> parents, List<Integer> children){
    parents.addAll(children);
    //1. Sort generation by comparing their output values from Y_(float x) function.
    java.util.Collections.sort(parents, new Comparator<Integer>() {
            @Override
            public int compare(Integer o1, Integer o2) {
                return new Float(Y_(o2)).compareTo(Y_(o1));
            }
        });
    //2. Take the top half.
    parents = parents.subList(0, parents.size()/2);
    return parents;
}


void drawAxes(){
  line(-width/2, 0, width/2, 0);
  text("X",  width/2 - 20, 20);
  
  line(0, -height/2, 0, height/2);
  text("Y", 20, -height/2 + 20);

}


void mouseWheel(MouseEvent event) {
  float addVal = 0.2;
  float e = event.getCount();
  if(e < 0){

  switch(key){
  case '1': case 'a':
  a+= addVal;
  break;
  case '2': case 'b':
  b+= addVal;
  break;
  case '3': case 'c': 
  c+= addVal;
  break;
  case '4': case 'd': 
  d+= addVal; 
  break;
  }
  }
  else{
    switch(key){
  case '1': case 'a':
  a-=addVal;
  break;
  case '2': case 'b':
  b-= addVal;
  break;
  case '3': case 'c': 
  c-= addVal;
  break;
  case '4': case 'd': 
  d-= addVal; 
  break;
  }
}
  parents = generateFirstGeneration(generationSize);
  generationCount = 0;
  loop();
}

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import processing.core.PApplet;
import processing.event.MouseEvent;

  int numberOfColumns;
  int numberOfRows;
  int columnWidth = 100;
  int rowHeight = 100;
  int radius = 20;
  int numberOfGenerations = 1000;
  Path initialPath;
  List<Path> parents;
  List<Path> children;
  
  void setup(){
        size(400, 300);
        initialPath = new Path(this);
          for(int i = 0; i < width/columnWidth; i++){
          for(int j = 0; j < height/rowHeight; j++){
             int leftX = columnWidth * i + radius;
             int rightX = columnWidth * (i + 1) - radius;
             int topY = rowHeight * j + radius;
             int bottomY = rowHeight * (j + 1) - radius;
             int x = (int) random(leftX, rightX);
             int y = (int) random(topY, bottomY);
//             int x = (int) random(width);
//             int y = (int) random(height);
             ellipse(x, y, radius, radius);
             initialPath.getCities().add(new Circle(x, y, radius, this));
          }
        }
        // 1. Create first generation of random paths between cities in initialPath variable.
        parents = getFirstGeneration(initialPath);
        
  }
  
  void draw(){
         background(255);
         // 2. Create new children.
         children = createChildren(parents);
         // 3. Apply mutation upon children
         applyMutation(children, 10);
         parents = combineAndShrinkGenerations(parents, children);
         
         Path bestPath = parents.get(0);
         for(int i = 0; i < parents.size(); i++){
           if(bestPath.distance() > parents.get(i).distance()){
           bestPath = parents.get(i);
           }
         }
         bestPath.show();
         println("BEST: " + bestPath.distance());
         text(frameCount%parents.size(), 10, 10);
  }
  
  List<Path> getFirstGeneration(Path initialPath){
        List<Path> firstGeneration = new ArrayList<Path>();
        for(int i = 0; i < numberOfGenerations; i++){
          Path pathCopy = initialPath.copyOf();
          Path newPath = new Path(this);
          for(; 0 != pathCopy.getCities().size();){
            int jndex = (int) random(0, pathCopy.getCities().size());
            Circle c = pathCopy.getCities().get(jndex);
            newPath.getCities().add(new Circle(c.x, c.y, c.radius, this));
            pathCopy.getCities().remove(jndex);
          }
          firstGeneration.add(newPath);
        }
        return firstGeneration;
      }

      List<Path> createChildren( List<Path> p){
        List<Path> parents = new ArrayList<Path>();
        for(int i = 0; i < p.size(); i++){
          parents.add(new Path(p.get(i).getCities(), p.get(i).parent));
        }
        List<Path> children= new ArrayList<Path>(parents.size());
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
          //2. Get actual parents.0
          Path firstParent = parents.get(firstParentIndex).copyOf();
          Path secondParent = parents.get(secondParentIndex).copyOf();
          //3. Create first and second children. They both contain first half of "opposite" parents(firstChild - first half of second parent, and vice-versa)
          ArrayList<Circle> fc = new ArrayList<Circle>(secondParent.getCities().subList(0, secondParent.getCities().size()/2));
          Path firstChild = new Path(fc, this);
          ArrayList<Circle> sc = new ArrayList<Circle>(firstParent.getCities().subList(0, firstParent.getCities().size()/2));
          Path secondChild = new Path(sc, this);
          //4. Add the remaining elements from the other parent.
          firstParent.getCities().removeAll(secondChild.getCities());
          secondParent.getCities().removeAll(firstChild.getCities());
          
          firstChild.getCities().addAll(secondParent.getCities());
          secondChild.getCities().addAll(firstParent.getCities());
          
          children.add(firstChild);
          children.add(secondChild);
        }
        return children;
      }


      void applyMutation(List<Path> children, int mutationChance){
        int rand = (int)random(0, 100);
        for(int i = 0; i < children.size(); i++){
          if(rand < mutationChance){
            Path path = children.get(i);
            int firstIndex = (int)random(path.getCities().size());
                int secondIndex;
                for(int j = 0; j < children.size()/10; j++){
                  if(firstIndex < path.getCities().size()/2){
                    secondIndex = (int)random(firstIndex, path.getCities().size());
                  }
                  else{
                    secondIndex = (int)random(0, firstIndex);
                  }
                  Circle temp = path.getCities().get(firstIndex);
                  path.getCities().set(firstIndex, path.getCities().get(secondIndex));
                  path.getCities().set(secondIndex, temp);
                }
          }
                
          }
        }

      List<Path> combineAndShrinkGenerations(List<Path> parents, List<Path> children){
        List<Path> temp = new ArrayList<Path>();
        temp.addAll(parents);
        temp.addAll(children);
              java.util.Collections.sort(temp, new Comparator<Path>(){
              @Override
              public int compare(Path x, Path y){
                return new Float(x.distance()).compareTo(new Float(y.distance()));
              }
              });              
          return new ArrayList<Path>(temp.subList(0, temp.size()/2));
      }


public void mouseClick(){
  noLoop();
  children = createChildren(parents);
  loop();
}


class Circle{
PApplet parent;
int x;
int y;
int radius;

Circle(){}
Circle(int x, int y, int radius, PApplet parent){
  this.x = x;
  this.y = y;
  this.radius = radius;
  this.parent = parent;
}

public void show(){
  parent.ellipse(x, y, radius, radius);
}
}


class Path implements Comparable<Path>{
  private List<Circle> cities;
  PApplet parent;
  
  Path(PApplet parent){
  setCities(new ArrayList<Circle>());
  this.parent = parent;
  }
  Path(List<Circle> cities, PApplet parent){
    this.setCities(cities);
    this.parent = parent;
  }
  void show(){
    parent.stroke(100, 255, 200);
    parent.strokeWeight(4);
      for(int i = 0; i < getCities().size() - 1; i++){
        parent.line(getCities().get(i).x, getCities().get(i).y, getCities().get(i + 1).x, getCities().get(i + 1).y);
      }
      parent.fill(255, 50, 200);
      parent.noStroke();
      for(int i = 0; i < getCities().size(); i++){
        getCities().get(i).show();
      }
  }

  Path copyOf(){
    Path path = new Path(parent);
    java.util.Iterator<Circle> iter = this.getCities().iterator();
    for(; iter.hasNext();){
      Circle c = iter.next();
      path.getCities().add(new Circle(c.x, c.y, c.radius, parent));
    }
    return path;
  }

  float distance(){
      float distance = 0;
      for(int i = 0; i < getCities().size() - 1; i++){
        Circle cityA = getCities().get(i);
        Circle cityB = getCities().get(i + 1);
        distance+= parent.dist(cityA.x, cityA.y, cityB.x, cityB.y);
      }
      return distance;
  }
   public int compareTo(Path o){
     return new Float(o.distance()).compareTo(new Float(distance()));
   }
  List<Circle> getCities() {
    return cities;
  }
  void setCities(List<Circle> cities) {
    this.cities = cities;
  }
}

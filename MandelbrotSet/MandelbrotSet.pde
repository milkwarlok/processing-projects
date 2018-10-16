int maxIterations = 100;
float epsilon = 0.00001;
ArrayList<Float> Left;
ArrayList<Float> Right;
ArrayList<Float> Top;
ArrayList<Float> Bottom;
int zoomValue = 300;

void setup(){
size(600, 600);

Left = new ArrayList<Float>();
Left.add(-3.0);
Right = new ArrayList<Float>();
Right.add(2.0);
Top = new ArrayList<Float>();
Top.add(2.0);
Bottom = new ArrayList<Float>();
Bottom.add(-2.0);

noFill();
stroke(255,0,0);
colorMode(HSB);
}
void draw(){
  background(0);
  loadPixels();
  for(int y = 0; y < height; y++){
    for(int x = 0; x < width; x++){      
        int count = 0;
        //currentPoint: mapped from display coordinates to left-right, top-bottom coordinates of plotting graph
        Complex currentPoint = new Complex(
        map(x, 0, width, Left.get(Left.size() - 1), Right.get(Right.size() - 1)),
        map(y, 0, height, Bottom.get(Bottom.size() - 1), Top.get(Top.size() - 1))
        );
        //Two values needed for swapping while counting in a do-while loop
        Complex firstValue = Mandelbrot(new Complex(0,0) , currentPoint);
        Complex secondValue = new Complex(0, 0);
        
        boolean converges = true;
        
        do{
          if(count >= maxIterations)break;
          secondValue = Mandelbrot(firstValue, currentPoint);
          Complex temp = firstValue;
          firstValue = secondValue;
          secondValue = temp;
          if(Math.abs(firstValue.abs()) > 2) {
            converges = false;
            break;
          }
          count++;
        }    
        while(Math.abs(firstValue.abs() - secondValue.abs()) > epsilon);
        int index = x + y * width;
        pixels[index] = converges? color(0) : color(map(count, 0, 50, 30, 255), 255,255);
    }
  }
  updatePixels();
  rect(mouseX - zoomValue/2 , mouseY - zoomValue/2, zoomValue, zoomValue);
}

Complex Mandelbrot(Complex z, Complex c){
  return z.multiply(z).add(c);
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
if(e <= 0){
  float newLeft = map(mouseX - zoomValue/2, 0, width, Left.get(Left.size() - 1), Right.get(Right.size() - 1));
        float newRight = map(mouseX + zoomValue/2, 0, width,  Left.get(Left.size() - 1), Right.get(Right.size() - 1));
        float newBottom = map(mouseY - zoomValue/2, 0, height, Bottom.get(Bottom.size() - 1), Top.get(Top.size() - 1));
        float newTop = map(mouseY + zoomValue/2, 0, height, Bottom.get(Bottom.size() - 1), Top.get(Top.size() - 1));
        Left.add(newLeft);
        Right.add(newRight);
        Top.add(newTop);
        Bottom.add(newBottom);
}
else{
  if(Left.size() > 1){
    Left.remove(Left.size() - 1);
    Right.remove(Right.size() - 1);
    Top.remove(Top.size() - 1);
    Bottom.remove(Bottom.size() - 1);
  }
}
}

class Complex{
float real;
float img;

public Complex(){}
public Complex(float real, float img){
  this.real = real;
  this.img = img;
}
public Complex multiply(Complex that){
  float newReal = this.real * that.real - this.img * that.img;
  float newImg = this.real * that.img + this.img * that.real;
    return new Complex(newReal, newImg);
} 

public Complex add(Complex that){
  float newReal = this.real + that.real;
  float newImg = this.img + that.img;
  return new Complex(newReal, newImg);
}

public float abs(){
    return (float)Math.sqrt(Math.pow(this.real, 2) + Math.pow(this.img, 2));
} 
}

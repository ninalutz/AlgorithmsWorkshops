int[] array = new int[30];
int maxVal = 50;
int speed = 4;
int xStart = 90;

void setup() {
  size(700, 650);
  for (int i=0; i<array.length; i++) {
    array[i] = (int)random(maxVal);
  }
  frameRate(speed);
  colorMode(HSB);
}

int i=0;

void draw() {
  background(0);

  for (int j=0; j<array.length; j++) {
    if (array[i]>array[j]) {
      int temp = array[j];
      array[j] = array[i];
      array[i] = temp;
    }
    
    //Draw values here!
    fill(255);
    text(array[j], 50, 30+20*j);
    
    //Get color to go with values
    float c = map(array[j], 0, maxVal, 0, 360);
    stroke(c, 250, 250);
    strokeWeight(10);
    
    //Draw a line
    line(xStart, 25+20*j, xStart+5*array[j], 25+20*j);
  }
  
  i++;  
  if (i>array.length-1)
    noLoop();
}

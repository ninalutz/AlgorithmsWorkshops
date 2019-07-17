// This Node Class Will Represent people in our class

class Node {
  
  String name;
  int year;
  color favorite;
  
  PVector screenLocation;
  boolean locked; // Am I editing my Node location
  
  Node(String _name, int _year) {
    name = _name;
    year = _year;
     screenLocation = new PVector(random(50, width), random(50, height - 50));
    if(year == 10) screenLocation = new PVector(random(width/3), random(50, height - 50));
    if(year == 11)  screenLocation = new PVector(random(width/3, 2*width/3), random(50, height - 50));
    if(year == 12)  screenLocation = new PVector(random(2*width/3, width - 50), random(50, height - 50));
   
  }

  
  // See if my mouse cursor is -near- my Node
  boolean hoverEvent() {
    
    float xDistance = abs(mouseX - screenLocation.x);
    float yDistance = abs(mouseY - screenLocation.y);
    
    if (xDistance <= 15 && yDistance <=15) {
      return true;
    } else {
      return false;
    }
    
  }
  
  // Is my Node selected by the mouse?
  boolean checkSelection() {
    if (hoverEvent()) {
      locked = true;
    } else {
      locked = false;
    }
    return locked;
  }
  
  // Update Node location if locked on
  void update() {
    if (locked) {
      screenLocation = new PVector(mouseX, mouseY);
    }
  }
  
  void drawNode() {
    noStroke(); // No circle outline
    
    if (hoverEvent()) {
      fill(0, 20, 200);
    } else {
      fill(0);  // White Fill
    }
    
    ellipse(screenLocation.x, screenLocation.y, 30, 30);
    
    text(name + "\n" + "Year: " + year, screenLocation.x + 30, screenLocation.y + 30);
  }
  
}

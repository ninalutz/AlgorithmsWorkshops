class Node {
  PVector screenLocation;
  boolean locked; 
  String name;
  boolean onPath, start, end;
  
  Node(String _name) {
    name = _name;
    screenLocation = new PVector(random(50, width), random(50, height - 50));
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
  
  void draw() {
    if (hoverEvent()) {
      fill(255, 255, 0);
    }
    
    else{fill(255, 200, 0);}
    
    if(onPath){
      fill(0, 255, 255);
    }
    
    if(start) fill(0, 255, 0);
    if(end) fill(255, 0, 0);
    
    ellipse(screenLocation.x, screenLocation.y, 30, 30);
    fill(0);
    text(name, screenLocation.x, screenLocation.y + 7);
  }
  
  String getName() {return name;}
  
}

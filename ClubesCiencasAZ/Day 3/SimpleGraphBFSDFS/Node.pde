class Node {
  PVector screenLocation;
  boolean locked; 
  String name;
  
  Node(String _name) {
    name = _name;
    screenLocation = new PVector(random(50, width), random(50, height - 50));
  }
  
  void draw() {
    fill(255, 200, 0);
    ellipse(screenLocation.x, screenLocation.y, 30, 30);
    fill(0);
    text(name, screenLocation.x, screenLocation.y);
  }
  
}

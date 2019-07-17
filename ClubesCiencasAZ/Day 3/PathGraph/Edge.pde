class Edge {
  Node origin;
  Node destination;
  String type;
  int weight;
  
  Edge(Node p1, Node p2) {
    origin = p1;
    destination = p2;
    weight = int(random(1,13));
  }
  
  void draw() {
    float x1 = origin.screenLocation.x;
    float y1 = origin.screenLocation.y;
    float x2 = destination.screenLocation.x;
    float y2 = destination.screenLocation.y;
    
    strokeWeight(2); // 5 pixels wide line
    stroke(20); // White, but translucent 100/255

    textSize(14);
    text(weight, (x1+x2)/2, (y1+y2)/2);
    line(x1, y1, x2, y2);
  }
  
  Node getSource(){ return origin;}
  Node getDestination(){ return destination;}
  
  int getWeight(){ return weight;}
}

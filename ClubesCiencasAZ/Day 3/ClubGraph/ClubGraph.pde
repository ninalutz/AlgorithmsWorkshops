/**
Simple Graph relations

Idea taken from Ira Winder for 11.S195 
Adapted here in different code by Nina Lutz for Clubes de Ciencia 2019

*/


ArrayList<Node> people;
ArrayList<Edge> cohort;
Table data;

// Runs Once
void setup() {
  size(1400, 700);
  data = loadTable("clubInfo.csv", "header");
  initialize();
}


void draw() {
  
  background(255); 

  // Draw Edges
  for (Edge c: cohort) {
    c.draw();
  }
  
    
  // Draw Nodes
  for (Node p: people) {
    p.update(); // updates location IF selected
    p.drawNode();
  }
  
}

void mousePressed() {
  for (Node p: people) {
    if(p.checkSelection()) {
      break;
    } 
  }
}

void mouseReleased() {
  for (Node p: people) {
    p.locked = false;
  }
}

void keyPressed() {
  if(key == ' ') initialize();
}

void initialize() {
  people = new ArrayList<Node>();
  cohort = new ArrayList<Edge>();
  
  //Makes new nodes for each row in spreadsheet
  for (int i=0; i<data.getRowCount(); i++) { 
    String name = data.getString(i, "Name");
    int year = data.getInt(i, "Grade");
    Node p = new Node(name, year);
    people.add(p);
  }
  
  // Who are edge connections based on year?
  for (Node origin: people) {
    for (Node destination: people) {
      // Is person referencing themself?
      if (!origin.name.equals(destination.name)) {
        // Are Origin and Dest same year?
        if (origin.year == (destination.year)) {
          cohort.add(new Edge(origin, destination));
        }
      }
    }
  }
  
}

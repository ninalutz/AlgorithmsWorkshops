List<Edge> edges;
HashSet<Node> nodes;
List<Node> nodesList;
int numNodes = 12;
DijkstraAlgorithm finder;
Graph g;

void setup(){
  size(1200, 500);
  nodes = new HashSet();
  edges = new ArrayList<Edge>();
  nodesList = new ArrayList<Node>();

  for(int i = 0; i<numNodes; i++){
    Node n = new Node(str(i));
    nodes.add(n);
    nodesList.add(n);
  }
  
  for(Node n1 : nodes){
    for(Node n2 : nodes){
        float x = random(0, 1);
        if(x < 0.7){
          Edge e = new Edge(n1, n2);
          edges.add(e);
        }
    }
  }

  g = new Graph(nodesList, edges);
  finder = new DijkstraAlgorithm(g);
  
  finder.execute(nodesList.get(0));
  LinkedList<Node> path = finder.getPath(nodesList.get(5));

  if(path.size() > 0){
    for (Node vertex : path) {
        System.out.println(vertex.getName());
    }
  }
}


void draw(){
  background(255);
  for(Edge e : edges) e.draw();
  for(Node n : nodes) n.draw();
}

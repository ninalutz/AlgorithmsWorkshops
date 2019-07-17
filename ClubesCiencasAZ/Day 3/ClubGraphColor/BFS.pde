//Use this class to color 

class BFS{
  ArrayList<Node> nodes;
  ArrayList<Edge> edges;
  
  BFS(ArrayList<Node> nodes, ArrayList<Edge> edges){
    this.nodes = nodes;
    this.edges = edges;
  }
  
  void colorNode(){
    //Hint -- 1 is the root 
    for(int i = 0; i<nodes.size(); i++){
      //Color node of name 1 
      if(int(nodes.get(i).name) == 1 
      || int(nodes.get(i).name) == 8){
        color c =  color(255, 0, 0);
        nodes.get(i).fillColor = c; //this changes the color 
      }
      if(int(nodes.get(i).name) == 2 
      || int(nodes.get(i).name) == 3){
        color c =  color(0, 255, 0);
        nodes.get(i).fillColor = c; //this changes the color 
      }
      if(int(nodes.get(i).name) == 4 || 
      int(nodes.get(i).name) == 5
      || int(nodes.get(i).name) == 6
      || int(nodes.get(i).name) == 7){
        color c =  color(0, 0, 250);
        nodes.get(i).fillColor = c; //this changes the color 
      }
      //Now how would you color the rest of the nodes to be in BFS colors?
    }
  }
}

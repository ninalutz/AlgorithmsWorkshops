import java.util.List;

public class Graph {
    private final List<Node> Nodes;
    private final List<Edge> edges;

    public Graph(List<Node> Nodes, List<Edge> edges) {
        this.Nodes = Nodes;
        this.edges = edges;
    }  public List<Node> getNodes() {
        return Nodes;
    }

    public List<Edge> getEdges() {
        return edges;
    }



}

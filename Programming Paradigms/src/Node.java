import java.util.ArrayList;
import java.util.List;

class Node<T> {
    private T data;
    private List<Node<T>> children = new ArrayList<>();
    private Node<T> parent = null;

    Node(T data) {
        this.data = data;
    }

    void addChild(Node<T> child) {
        child.setParent(this);
        this.children.add(child);
    }

    List<Node<T>> getChildren() {
        return children;
    }

    T getData() {
        return data;
    }

    Node<T> getParent() {
        return parent;
    }

    private void setParent(Node<T> parent) {
        this.parent = parent;
    }
}

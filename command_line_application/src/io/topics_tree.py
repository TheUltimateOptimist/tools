from rich.tree import Tree
from rich.console import Console

class TopicsTree:
    def __init__(self, parent_id, parent_name: str, nodes: list[list[int]]) -> None:
        self.parent_id = parent_id
        self.parent_name = parent_name
        self.nodes = nodes

    def print(self) -> None:
        root = Tree(f"{self.parent_id}: {self.parent_name}")
        trees = [(self.parent_id, root)]
        while len(self.nodes) > 0:
            new_trees = []
            for tree in trees:
                new_nodes = []
                for node in self.nodes:
                    if node[1] == tree[0]:
                        text = f"{node[2]}: {node[0]}"
                        if len(node) > 3:
                            text = f"{text} -> {node[3]/2}h"
                        new_trees.append((node[2], tree[1].add(text)))
                    else:
                        new_nodes.append(node)
                self.nodes = new_nodes
            trees = new_trees
        Console().print(root)

                        

            


    
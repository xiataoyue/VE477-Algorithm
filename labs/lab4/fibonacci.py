class Node:
    def __init__(self, data):
        self.data = data
        self.parent = None
        self.child = None
        self.left = None
        self.right = None
        self.degree = 0
        self.mark = False

    def remove_child(self, node):
        if self.child is None:
            raise ValueError("No children")
        if self.degree == 1:
            self.child = None
        else:
            if self.child is node:
                self.child = node.right
            node.left.right = node.right
            node.right.left = node.left
        self.degree -= 1

    def add_child(self, node):
        if self.child is None:
            self.child = node
            node.right = node.left = node
        else:
            self.child.right.left = node
            node.right = self.child.right
            node.left = self.child
            self.child.right = node
        node.parent = self
        self.degree += 1
        node.mark = False


class FibonacciHeap:
    def __init__(self):
        self.make_heap()

    def make_heap(self):
        self.min_node = None
        self.total_nodes = 0
        self.root_num = 0

    def minimum(self):
        return self.min_node

    def merge_to_list(self, node):
        if self.min_node is None:
            node.left = node.right = node
        else:
            node.right = self.min_node.right
            node.left = self.min_node
            self.min_node.right.left = node
            self.min_node.right = node
        self.root_num += 1

    def insert(self, data):
        n = Node(data)
        n.left = n.right = n
        if self.min_node is None:
            self.min_node = n
        else:
            self.merge_to_list(n)

        if self.min_node is None or self.min_node.data > n.data:
            self.min_node = n
        self.total_nodes += 1

    def union(self, fib):
        h = FibonacciHeap()

        if self.min_node is None:
            h.min_node = fib.min_node
        else:
            h.min_node = self.min_node
            h.min_node.right.left = fib.min_node.left
            fib.min_node.left.right = h.min_node.right
            h.min_node.right = fib.min_node
            fib.min_node.left = h.min_node

        if fib.min_node.data < self.min_node.data:
            h.min_node = fib.min_node
        h.total_nodes = self.total_nodes + fib.total_nodes
        h.root_num = self.root_num + fib.root_num
        return h

    def cut(self, child, parent):
        if child.mark:
            child.mark = False
        parent.remove_child(child)
        child.parent = None
        self.merge_to_list(child)

    def cascading_cut(self, node):
        x = node.parent
        if x:
            if not node.mark:
                node.mark = True
            else:
                self.cut(node, x)
                self.cascading_cut(x)

    def decrease_key(self, node, data):
        if data > node.data:
            raise ValueError("new data is larger than current data")
        node.key = data
        x = node.parent
        if x and node.data < x.data:
            self.cut(node, x)
            self.cascading_cut(x)
        if node.data < self.min_node.data:
            self.min_node = node

    def remove_root_node(self, node):
        node.right.left = node.left
        node.left.right = node.right
        self.root_num -= 1

    def link(self, n1, n2):
        self.remove_root_node(n1)
        n2.add_child(n1)

    def consolidate(self):
        x = [None] * self.total_nodes
        m = self.min_node
        num = self.root_num
        for i in range(num):
            temp = m
            m = m.right
            deg = temp.degree
            while x[deg] is not None:
                temp1 = x[deg]
                if temp.data > temp1.data:
                    self.link(temp, temp1)
                else:
                    self.link(temp1, temp)
                x[deg] = None
                deg += 1
            x[deg] = temp if temp.data < temp1.data else temp1
        self.min_node = None
        for i in range(len(x)):
            if x[i]:
                if self.min_node is None:
                    self.min_node = x[i]
                else:
                    if x[i].data < self.min_node.data:
                        self.min_node = x[i]

    def extract_min(self):
        m = self.min_node
        if m is not None:
            c = m.child
            if c is not None:
                for i in range(m.degree):
                    r = c.right
                    self.merge_to_list(c)
                    c.parent = None
                    c = r
            self.remove_root_node(m)
            if m == m.right:
                self.min_node = None
            else:
                self.min_node = m.right
                self.consolidate()
            self.total_nodes -= 1
        return m

    def delete(self, node):
        self.decrease_key(node, -float("inf"))
        self.extract_min()

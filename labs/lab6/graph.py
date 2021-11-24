class Vertex:
    def __init__(self, name, value):
        self.name = name
        self.value = value
        self.adjacent = {}


class SparseGraph:
    def __init__(self):
        self.edge_dict = {}
        self.vertex_dict = {}

    def add_edge(self, start: 'Vertex', end: 'Vertex', weight):
        edge = (start, end)
        if start.name not in self.vertex_dict.keys():
            self.vertex_dict[start.name] = start
        if end.name not in self.vertex_dict.keys():
            self.vertex_dict[end.name] = end
        self.edge_dict[edge] = weight

    def remove_vertex(self, v: 'Vertex'):
        if v.name not in self.vertex_dict.keys():
            raise LookupError("No such vertex in graph")
        self.vertex_dict.pop(v.name)
        for edge in self.edge_dict.keys():
            if v in edge:
                self.edge_dict.pop(edge)

    def set_edge_weight(self, start: 'Vertex', end: 'Vertex', weight):
        if (start, end) in self.edge_dict.keys():
            self.edge_dict[(start, end)] = weight
        elif (end, start) in self.edge_dict.keys():
            self.edge_dict[(end, start)] = weight
        else:
            raise LookupError("No edge linking the two vertices")

    def remove_edge(self, start: 'Vertex', end: 'Vertex'):
        if (start, end) in self.edge_dict.keys():
            self.edge_dict.pop((start, end))
        else:
            raise LookupError("No such edge exists in the graph")

    def is_adjacent(self, u, v):
        if (u, v) in self.edge_dict.keys() or (v, u) in self.edge_dict.keys():
            return True
        else:
            return False

    def get_vertex_value(self, v_name):
        if v_name in self.vertex_dict.keys():
            return self.vertex_dict[v_name].value
        else:
            raise LookupError("No such vertex in graph")

    def add_vertex(self, v_name, value):
        if v_name in self.vertex_dict.keys():
            return
        self.vertex_dict[v_name] = Vertex(v_name, value)

    def get_edge_weight(self, start: 'Vertex', end: 'Vertex'):
        if (start, end) in self.edge_dict.keys():
            return self.edge_dict[(start, end)]
        elif (end, start) in self.edge_dict.keys():
            return self.edge_dict[(end, start)]
        else:
            raise LookupError("No such edge in graph")

    def set_vertex_value(self, name, value):
        if name in self.vertex_dict.keys():
            self.vertex_dict[name].value = value

    def get_vertex(self, v_name):
        if v_name not in self.vertex_dict.keys():
            raise LookupError("No such vertex in graph")
        return self.vertex_dict[v_name]


class DenseGraph:
    def __init__(self):
        self.vertex_dict = {}

    def add_edge(self, start: 'Vertex', end: 'Vertex', weight):
        if start.name not in self.vertex_dict.keys():
            self.vertex_dict[start.name] = start
        if end.name not in self.vertex_dict.keys():
            self.vertex_dict[end.name] = end
        if end in start.adjacent.keys():
            self.set_edge_weight(start, end, weight)
            return
        start.adjacent[end] = weight
        end.adjacent[start] = 0

    def remove_vertex(self, v_name):
        if v_name not in self.vertex_dict.keys():
            raise LookupError("No such vertex in graph")
        v = self.vertex_dict[v_name]
        v.adjacent.clear()
        self.vertex_dict.pop(v_name)

    def set_edge_weight(self, start: 'Vertex', end: 'Vertex', weight):
        if start.name not in self.vertex_dict.keys():
            raise LookupError("Start vertex not in graph")
        if end not in start.adjacent.keys():
            raise LookupError("End vertex not in graph")
        start.adjacent[end] = weight

    def remove_edge(self, start: 'Vertex', end: 'Vertex'):
        if start.name not in self.vertex_dict.keys():
            raise LookupError("Start vertex not in graph")
        if end not in start.adjacent.keys():
            raise LookupError("End vertex not in graph")
        start.adjacent.pop(end)
        end.adjacent.pop(start)

    def is_adjacent(self, u: 'Vertex', v: 'Vertex'):
        if u.name not in self.vertex_dict.keys() or v.name not in self.vertex_dict.keys():
            raise LookupError("No such vertex in graph")
        if u.name in self.vertex_dict.keys():
            if v in u.adjacent.keys():
                return True
        if v.name in self.vertex_dict.keys():
            if u in v.adjacent.keys():
                return True
        return False

    def get_vertex_value(self, v_name):
        if v_name not in self.vertex_dict.keys():
            raise LookupError("No such vertex in graph")
        return self.vertex_dict[v_name].value

    def add_vertex(self, v_name, value):
        if v_name not in self.vertex_dict.keys():
            v = Vertex(v_name, value)
            self.vertex_dict[v_name] = v

    def get_edge_weight(self, start: 'Vertex', end: 'Vertex'):
        if start.name not in self.vertex_dict.keys():
            raise LookupError("Start vertex not in graph")
        if end not in start.adjacent.keys():
            raise LookupError("End vertex not in graph")
        return start.adjacent[end]

    def set_vertex_value(self, v_name, value):
        if v_name not in self.vertex_dict.keys():
            raise LookupError("No such vertex in graph")
        self.vertex_dict[v_name] = value

    def get_vertex(self, v_name):
        if v_name not in self.vertex_dict.keys():
            return None
        return self.vertex_dict[v_name]

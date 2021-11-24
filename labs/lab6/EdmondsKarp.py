from graph import DenseGraph, Vertex


def bfs(g: 'DenseGraph', s: 'Vertex', t: 'Vertex', prev: 'dict'):
    visited = {}
    for vertex in g.vertex_dict.values():
        visited[vertex] = False

    q = [s]
    visited[s] = True
    while len(q) != 0:
        u = q.pop(0)
        for v in u.adjacent.keys():
            if (not visited[v]) and (u.adjacent[v] > 0):
                prev[v] = u
                visited[v] = True
                if v == t:
                    return True
                q.append(v)

    return visited[t]


def edmonds_karp(g: 'DenseGraph', s: 'Vertex', t: 'Vertex'):
    prev = {}
    for vertex in g.vertex_dict.values():
        prev[vertex] = None
    max_flow = 0
    while bfs(g, s, t, prev):
        min_cut = float('inf')
        current = t
        while current != s:
            p = prev[current]
            min_cut = min(min_cut, p.adjacent[current])
            current = prev[current]

        max_flow += min_cut
        # print(max_flow)
        current = t
        while current != s:
            p = prev[current]
            g.set_edge_weight(p, current, p.adjacent[current] - min_cut)
            g.set_edge_weight(current, p, current.adjacent[p] + min_cut)
            current = prev[current]
    return max_flow


if __name__ == '__main__':
    graph = DenseGraph()
    edge_num = int(input())

    for i in range(edge_num):
        elements = input().split()
        graph.add_vertex(elements[0], 0)
        graph.add_vertex(elements[1], 0)
        start = graph.get_vertex(elements[0])
        end = graph.get_vertex(elements[1])
        capacity = int(elements[2])
        graph.add_edge(start, end, capacity)
    source = graph.get_vertex(input())
    sink = graph.get_vertex(input())

    print(edmonds_karp(graph, source, sink))

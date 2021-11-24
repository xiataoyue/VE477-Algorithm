from graph import DenseGraph, Vertex
from EdmondsKarp import bfs, edmonds_karp


if __name__ == '__main__':
    graph = DenseGraph()
    v_num = int(input())
    e_num = int(input())

    left = []
    right = []
    for i in range(e_num):
        elements = input().split()
        graph.add_vertex(elements[0], 0)
        graph.add_vertex(elements[1], 0)
        start = graph.get_vertex(elements[0])
        end = graph.get_vertex(elements[1])
        graph.add_edge(start, end, 1)
        if start not in left:
            left.append(start)
        if end not in right:
            right.append(end)

    # source_sink = input().split()
    graph.add_vertex('source', 0)
    graph.add_vertex('sink', 0)
    source = graph.get_vertex('source')
    sink = graph.get_vertex('sink')
    for v in left:
        graph.add_edge(source, v, 1)
    for v in right:
        graph.add_edge(v, sink, 1)
    print(edmonds_karp(graph, source, sink))

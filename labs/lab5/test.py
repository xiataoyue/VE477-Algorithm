from graph import SparseGraph as SG, DenseGraph as DG

sg = SG()
sg.add_vertex("s", 12)
sg.add_vertex("t", 13)
s = sg.get_vertex("s")
t = sg.get_vertex("t")
print(s.value, t.value)
sg.add_edge(s, t, 101)
print(sg.get_edge_weight(s, t))
print(sg.is_adjacent(s, t))
sg.remove_edge(s, t)
print(sg.is_adjacent(s, t))
sg.get_edge_weight(s, t)

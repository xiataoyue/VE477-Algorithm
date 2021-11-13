from fibonacci import *


class Edge:
    def __init__(self, nodeA, nodeB, weight):
        self.start = nodeA
        self.end = nodeB
        self.weight = weight


# def print_child(n: 'Node', rev):
#     if n.child is None:
#         print("()", end=" ")
#     else:
#         c = n.child
#         temp = c
#         print("(", end="")
#         while temp != c.right:
#             print(rev[c], end=" ")
#             c = c.right
#         print(rev[c], end=" ")
#         print(")", end=" ")


# def print_fib(f: 'FibonacciHeap', rev):
#     curr = f.minimum()
#     if curr is None:
#         print("No node in fib.")
#     elif curr == curr.right:
#         print("Only min: ", rev[curr])
#     else:
#         temp = curr
#         print("nodes:", end=" ")
#         while temp != curr.right:
#             print(rev[curr], end=" ")
#             print_child(curr, rev)
#             curr = curr.right
#         print(rev[curr], end=" ")
#         print_child(curr, rev)
#         print("\n")


node_dict = {}
edge_num = int(input())

edge_dict = {}
for i in range(edge_num):
    line = input().split()
    if line[0] not in node_dict.keys():
        node_dict[line[0]] = Node(float("inf"))
    if line[1] not in node_dict.keys():
        node_dict[line[1]] = Node(float("inf"))
    weight = int(line[2])
    edge = Edge(node_dict[line[0]], node_dict[line[1]], weight)
    if node_dict[line[0]] not in edge_dict.keys():
        edge_dict[node_dict[line[0]]] = []
        edge_dict[node_dict[line[0]]].append(edge)
    else:
        edge_dict[node_dict[line[0]]].append(edge)


start = input()
node_dict[start].data = 0
end = input()
end_node = node_dict[end]

# for key, value in node_dict.items():
#     print(value.data)
# for e in edge_list:
#     print(e.weight, end=" ")

fib = FibonacciHeap()
for key, node in node_dict.items():
    fib.insert(node)

rev_dict = {}
for key, value in node_dict.items():
    rev_dict[value] = key

# print("b.right:", rev_dict[node_dict["b"].right])

v = node_dict[start]

while v is not node_dict[end]:
    # if fib.minimum() is not None:
    #     print("min:", rev_dict[fib.minimum()])
    # else:
    #     print("None")
    # print("v:", rev_dict[v], v.data)
    # print("v.right:", rev_dict[v.right])
    # print("total:", fib.total_nodes)
    for edge in edge_dict[v]:
        u = edge.end
        tmp = v.data + edge.weight
        if tmp < u.data:
            # print("Node: " + rev_dict[u])
            # print("data:", node_dict[rev_dict[u]].data)
            # print("min node:", rev_dict[fib.minimum()])
            # print_fib(fib, rev_dict)
            fib.decrease_key(u, tmp)
            u.prev = v
    v = fib.extract_min()

result = []
t = end_node
result.append(rev_dict[t])
while t.prev is not None:
    result.append(rev_dict[t.prev])
    t = t.prev
result.reverse()
print(result)

#include <stdio.h>
#include <stdlib.h>

typedef struct vertex_t {
    int parent;
    int rank;
} Vertex;

typedef struct edge_t {
    int v1;
    int v2;
    int weight;
} Edge;

typedef struct graph_t {
    int EdgeNum;
    int vertexNum;
    Edge *edges;
} Graph;

void insertEdge(Graph *g, int eSize) {
    for(int i = 0; i < eSize; i++) {
        int v1, v2, weight;
        scanf("%d %d %d", &v1, &v2, &weight);
        if(v1 > v2) {
            int temp = v1;
            v1 = v2;
            v2 = temp;
        }
        g->edges[i].v1 = v1;
        g->edges[i].v2 = v2;
        g->edges[i].weight = weight;
    }
}

Graph *initGraph(int eSize, int vSize) {
    Graph *g = (Graph *) malloc(sizeof(Graph));
    g->vertexNum = vSize;
    g->EdgeNum = eSize;
    g->edges = (Edge *) malloc(sizeof(Edge) * eSize);

    insertEdge(g, eSize);
    return g;
}

Vertex *initVertexes(int vSize) {
    Vertex *v = (Vertex *) malloc(sizeof(Vertex) * vSize);
    for(int i = 0; i < vSize; i++) {
        v[i].parent = i;
        v[i].rank = 0;
    }
    return v;
}

// According to the pseudocode in lecture c1
int Find(Vertex *v, int i) {
    if(v[i].parent != i) {
        return Find(v, v[i].parent);
    }
    return v[i].parent;
}

void Union(Vertex *v, int v1, int v2) {
    int v1Root = Find(v, v1);
    int v2Root = Find(v, v2);

    if(v[v1Root].rank > v[v2Root].rank) v[v2Root].parent = v1Root;
    else v[v1Root].parent = v2Root;

    if(v[v1Root].rank == v[v2Root].rank) v[v2Root].rank ++;
}

int EdgeCompare(const void *x, const void *y) {
    Edge *e1 = (Edge *) x;
    Edge *e2 = (Edge *) y;

    if(e1->weight < e2->weight) return -1;
    else if(e1->weight == e2->weight) return 0;
    else return 1;
}

int VertexCompare(const void *x, const void *y) {
    Edge *e1 = (Edge *) x;
    Edge *e2 = (Edge *) y;

    if(e1->v1 < e2->v1) return -1;
    else if(e1->v1 > e2->v1) return 1;
    else {
        if(e1->v2 < e2->v2) return -1;
        else return 1;
    }
}

void kruskal(Graph *g) {
    qsort(g->edges, g->EdgeNum, sizeof(Edge), EdgeCompare);
    Edge *MST = (Edge *) malloc(sizeof(Edge) * (g->vertexNum - 1));
    Vertex *v = initVertexes(g->vertexNum);

    int i = 0;
    int j = 0;

    while(i < g->EdgeNum && j < g->vertexNum - 1) {
        Edge temp = g->edges[i];
        i++;

        int v1Root = Find(v, temp.v1);
        int v2Root = Find(v, temp.v2);
        if(v1Root != v2Root) {
            MST[j] = temp;
            j++;
            Union(v, v1Root, v2Root);
        }
    }

    free(v);
    qsort(MST, j, sizeof(Edge), VertexCompare);

    for(int k = 0; k < j; k++) {
        printf("%d--%d\n", MST[k].v1, MST[k].v2);
    }
    free(MST);
}

int main() {
    int eSize, vSize;
    scanf("%d", &eSize);
    scanf("%d", &vSize);

    Graph *graph = initGraph(eSize, vSize);
    kruskal(graph);
    free(graph->edges);
    free(graph);

    return 0;
}

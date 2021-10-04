#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct edge_t {
    int v1;
    int v2;
} Edge;

typedef struct graph_t {
    int vSize;
    int eSize;
    int **adj;
} Graph;

void insertEdges(Graph *g, int eSize) {
    for(int i = 0; i < eSize; i++) {
        int v1, v2, weight;
        scanf("%d %d %d", &v1, &v2, &weight);

        g->adj[v1][v2] = weight;
        g->adj[v2][v1] = weight;
    }
}

Graph *initGraph(int vSize, int eSize) {
    Graph *g = (Graph *) malloc(sizeof(Graph));
    g->vSize = vSize;
    g->eSize = eSize;
    g->adj = (int **) malloc(sizeof(int *) * vSize);
    for(int i = 0; i < vSize; i++) {
        g->adj[i] = (int *) malloc(sizeof(int) * vSize);
    }
    for(int i = 0; i < vSize; i++) {
        for (int j = 0; j < vSize; j++) {
            if(i == j) g->adj[i][j] = 0;
            else {
                g->adj[i][j] = INT_MAX;
            }
        }
    }

    insertEdges(g, eSize);
    return g;
}

int EdgeCompare(const void *x, const void *y) {
    Edge *former = (Edge *) x;
    Edge *latter = (Edge *) y;

    if(former->v1 < latter->v1) return -1;
    else if(former->v1 > latter->v1) return 1;
    else {
        if(former->v2 < latter->v2) return -1;
        else return 1;
    }
}

void prim(Graph *g) {
    int lowCost[g->vSize];
    int mst[g->vSize];
    Edge *edges = (Edge *) malloc(sizeof(Edge) * g->vSize);
    mst[0] = -1;

    for(int i = 1; i < g->vSize; i++) {
        lowCost[i] = INT_MAX;
        mst[i] = 0;
    }
    lowCost[0] = INT_MAX;

    for(int i = 0; i < g->vSize; i++) {
        int min = INT_MAX;
        int minVertex = 0;

        for(int j = 0; j < g->vSize; j++) {
            if(lowCost[j] < min && lowCost[j] != 0) {
                min = lowCost[j];
                minVertex = j;
            }
        }
        edges[i].v1 = minVertex;
        edges[i].v2 = mst[minVertex];

        lowCost[minVertex] = 0;
        for(int j = 0; j < g->vSize; j++) {
            if(g->adj[minVertex][j] < lowCost[j]) {
                lowCost[j] = g->adj[minVertex][j];
                mst[j] = minVertex;
            }
        }
    }

    for(int i = 0; i < g->vSize; i++) {
        if(edges[i].v1 > edges[i].v2) {
            int temp = edges[i].v1;
            edges[i].v1 = edges[i].v2;
            edges[i].v2 = temp;
        }
    }

    qsort(edges, g->vSize, sizeof(Edge), EdgeCompare);
    for(int i = 1; i < g->vSize; i++) {
        printf("%d--%d\n", edges[i].v1, edges[i].v2);
    }
    free(edges);
}

int main() {
    int vSize, eSize;
    scanf("%d", &eSize);
    scanf("%d", &vSize);
    Graph *graph = initGraph(vSize, eSize);
    prim(graph);
    for(int i = 0; i < vSize; i++) {
        free(graph->adj[i]);
    }
    free(graph->adj);
    free(graph);
}
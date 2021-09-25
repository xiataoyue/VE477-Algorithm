#include "hash.h"
#include <stdlib.h>

// define your only data structure here, you may define hashtable, buckets, elements, etc...
typedef struct element {
    int key;
    int value;
    struct element *prev;
    struct element *next;
} elem;

typedef struct hashtable {
    elem  *first;
} hash;

void *initializer(int size)
{
    // your code here
    hash *newHash = (hash *) malloc(sizeof(hash) * size);
    for(int i = 0; i < size; i++) {
        newHash[i].first = NULL;
    }
    return newHash;
}

void insert(void* hashtable, int size, int key, int value)
{
    // your code here
    
}

void delete(void* hashtable, int size, int key)
{
    // your code here
}

void* search(void* hashtable, int size, int key)
{
    // your code here
}

int getValue(void* element)
{
    // your code here
}

void freeHashtable(void* hashtable, int size)
{
    // your code here
}

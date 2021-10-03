#include "hash.h"
#include <stdlib.h>

// define your only data structure here, you may define hashtable, buckets, elements, etc...
typedef struct Item {
    int key;
    int value;
    struct Item *prev;
    struct Item *next;
} item;

typedef struct HashTable {
    item  *first;
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
    hash *temp = hashtable;
    int index = key % size;

    if(temp[index].first == NULL) {
        item *newItem = (item *) malloc(sizeof(item));
        newItem->key = key;
        newItem->value = value;
        newItem->prev = NULL;
        newItem->next = NULL;
        temp[index].first = newItem;
        return;
    }

    item *newItem = search(temp, size, key);
    if(newItem != NULL) {
        newItem->value = value;
        return;
    }
    else {
        item *newEle = (item *) malloc(sizeof(item));
        item *curr = temp[index].first;
        newEle->key = key;
        newEle->value = value;
        newEle->prev = NULL;
        newEle->next = curr;
        temp[index].first = newEle;
        curr->prev = newEle;
    }
}

void delete(void* hashtable, int size, int key)
{
    // your code here
    hash *temp = hashtable;
    int index = key % size;

    item *itemToDelete = search(temp, size, key);

    if(itemToDelete != NULL) {
        if(itemToDelete->prev == NULL && itemToDelete->next == NULL) {
            temp[index].first = NULL;
            free(itemToDelete);
        }
        else if(itemToDelete->prev == NULL) {
            itemToDelete->next->prev = NULL;
            temp[index].first = itemToDelete->next;
            itemToDelete->next = NULL;
            free(itemToDelete);
        }
        else if(itemToDelete->next == NULL) {
            itemToDelete->prev->next = NULL;
            itemToDelete->prev = NULL;
            free(itemToDelete);
        }
        else {
            itemToDelete->prev->next = itemToDelete->next;
            itemToDelete->next->prev = itemToDelete->prev;
            itemToDelete->prev = NULL;
            itemToDelete->next = NULL;
            free(itemToDelete);
        }
    }
}

void* search(void* hashtable, int size, int key)
{
    // your code here
    hash *temp = hashtable;
    int index = key % size;
    for(item *curr = temp[index].first; curr != NULL; curr = curr->next) {
        if(curr->key == key) {
            return curr;
        }
    }
    return NULL;
}

int getValue(void* element)
{
    // your code here
    item *temp = element;
    return temp->value;
}

void freeHashtable(void* hashtable, int size)
{
    // your code here
    hash *tempHash = hashtable;

    for(int i = 0; i < size; i++) {
        item *curr = tempHash[i].first;
        while(curr) {
            item * tempItem = curr;
            curr = curr->next;
            tempItem->prev = NULL;
            tempItem->next = NULL;
            free(tempItem);
        }
        tempHash[i].first = NULL;
    }
    free(tempHash);
}

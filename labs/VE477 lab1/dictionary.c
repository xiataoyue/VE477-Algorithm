#include "dictionary.h"
#include <stdlib.h>

// define your only data structure here, you may define dictionary, elements, etc...


typedef struct Item{
    int key;
    int value;
    struct Item *prev;
    struct Item *next;
} item;

typedef struct Dict {
    item *first;
    item *last;
} dict;

void *initializer()
{
    // your code here
    dict * newDict = (dict *) malloc(sizeof(dict));
    newDict->first = NULL;
    newDict->last = NULL;
    return newDict;
}

void *search(void *dictionary, int key)
{
    // your code here
    dict *temp = dictionary;
    for(item *point = temp->first; point != NULL; point = point->next) {
        if(point->key == key) return point;
    }
    return NULL;
}

void insert(void *dictionary, int key, int value)
{
    // your code here
    dict *temp = dictionary;
    if(temp->first == NULL) {
        item *newItem = (item *) malloc(sizeof(item));
        newItem->key = key;
        newItem->value = value;
        newItem->prev = NULL;
        newItem->next = NULL;
        temp->first = temp->last = newItem;
        return;
    }

    item *afterSearch = search(temp, key);
    if(afterSearch != NULL) {
        afterSearch->value = value;
        return;
    }

    item * newIt = (item *) malloc(sizeof(item));
    newIt->key = key;
    newIt->value = value;

    for(item *curr = temp->first; curr != NULL; curr = curr->next) {
        if(key < curr->key) {
            if(curr == temp->first) {
                newIt->prev = NULL;
                newIt->next = curr;
                curr->prev = newIt;
                temp->first = newIt;
            }
            else {
                newIt->prev = curr->prev;
                newIt->next = curr;
                newIt->prev->next = newIt;
                curr->prev = newIt;
            }
            return;
        }
        else {
            if(curr == temp->last) {
                newIt->next = NULL;
                newIt->prev = curr;
                curr->next = newIt;
                temp->last = newIt;
                return;
            }
        }
    }
}

void delete(void *dictionary, int key)
{
    // your code here
    dict *temp = dictionary;
    item *itemToDelete = search(temp, key);

    if(itemToDelete != NULL) {
        if (itemToDelete->prev == NULL && itemToDelete->next == NULL) {
            temp->first = NULL;
            temp->last = NULL;
            free(itemToDelete);
        }
        else if(itemToDelete->prev == NULL) {
            itemToDelete->next->prev = NULL;
            temp->first = itemToDelete->next;
            itemToDelete->next = NULL;
            free(itemToDelete);
        }
        else if(itemToDelete->next == NULL) {
            itemToDelete->prev->next = NULL;
            temp->last = itemToDelete->prev;
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

void *minimum(void *dictionary)
{
    // your code here
    dict *temp = dictionary;
    return temp->first;
}

void *maximum(void *dictionary)
{
    // your code here
    dict *temp = dictionary;
    return temp->last;
}

void *predecessor(void *dictionary, int key)
{
    // your code here
    dict *temp = dictionary;
    item *curr = search(temp, key);
    if(curr != NULL) {
        return curr->prev;
    }
    return NULL;
}

void *successor(void *dictionary, int key)
{
    // your code here
    dict *temp = dictionary;
    item *curr = search(temp, key);
    if(curr != NULL) {
        return curr->next;
    }
    return NULL;
}


int getkey(void *element)
{
    // your code here
    item *temp = element;
    return temp->key;
}

int getvalue(void *element)
{
    // your code here
    item *temp = element;
    return temp->value;
}

void free_dict(void *dictionary)
{
    // your code here
    dict *tempDict = dictionary;
    item *tempItem = tempDict->first;
    while(tempItem != NULL) {
        item *temp = tempItem;
        tempItem = tempItem->next;
        temp->prev = NULL;
        temp->next = NULL;
        free(temp);
    }
    tempDict->first = NULL;
    tempDict->last = NULL;
    free(tempDict);
}

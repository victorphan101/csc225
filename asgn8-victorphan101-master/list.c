/*
 * Defines functions for linked lists.
 * CSC 225, Assignment 8
 * Given code, Spring '21
 */

#include <stdlib.h>
#include "list.h"

/* lstcreate: Creates an empty linked list. */
List *lstcreate() {
    /* TODO: Complete this function, given no arguments:
     * ...return a pointer to a new, dynamically allocated List structure. */
     List *list = NULL;
     list = (List *)malloc(sizeof(List));
     list->size = 0;
     list->head = NULL;
     return list;
}

/* lstdestroy: Destroys an existing linked list. */
void lstdestroy(List *lst) {
    /* TODO: Complete this function, given:
     *  lst - A pointer to a List structure
     * ...deallocate all memory associated with "lst". */
     Node *temp, *head = lst->head;
     while(head!= NULL){
        temp = head;
        head = head-> next;
        free(temp);
     }
     free(lst);
}

/* lstsize: Computes the size of a linked list. */
unsigned int lstsize(List *lst) {
    /* TODO: Complete this function, given:
     *  lst - A pointer to a List structure
     * ...return the number of nodes in "lst". */
    return lst->size;
}

/* lstget: Gets an element in a linked list at an index. */
void *lstget(List *lst, unsigned int idx) {
    /* TODO: Complete this function, given:
     *  lst - A pointer to a List structure
     *  idx - A non-negative index
     * ...return a pointer to element "idx" of "lst", NULL if "idx" outside
     * the range [0, size - 1] */
     Node *temp;
     int ptr=0;
     if (idx>=lst->size){
        return NULL;
     }
     temp = lst->head;
     while(ptr < idx){
        temp = temp-> next;
        ptr+=1;
     }
     return temp->value;
}

/* lstset: Sets an element in a linked list at an index. */
int lstset(List *lst, unsigned int idx, void *value) {
    /* TODO: Complete this function, given:
     *  lst   - A pointer to a List structure
     *  idx   - A non-negative index
     *  value - A pointer to a desired element
     * ...set element "idx" of "lst" to "value"; return 0 on success, 1 if
     *  "idx" outside the range [0, size - 1]. */
     Node *temp;
     int ptr=0;
     if (idx>=lst->size){
        return 1;
     }
     temp = lst->head;
     while(ptr < idx){
        temp = temp-> next;
        ptr+=1;
     }
     temp->value = value;
     return 0;

}

/* lstadd: Adds an element to a linked list at an index. */
int lstadd(List *lst, unsigned int idx, void *value) {
    /* TODO: Complete this function, given:
     *  lst   - A pointer to a List structure
     *  idx   - A non-negative index
     *  value - A pointer to a desired element
     * ...add "value" as element "idx" of "lst"; return 0 on success, 1 if
     * "idx" outside the range [0, size]. */
     Node *newNode, *temp, *after;
     int ptr=0;
     temp = lst->head;
     if (idx == 0){
        if (lst->size == 0){
            newNode = (Node *)malloc(sizeof(Node));
            newNode->value = value;
            newNode->next = NULL;
            lst->head = newNode;
            lst->size += 1;
            return 0;
        }
        newNode = (Node *)malloc(sizeof(Node));
        newNode->value = value;
        newNode->next = lst->head;
        lst->head = newNode;
        lst->size+=1;
        return 0;
     }
     /*if add out of the list*/
     if (idx>(lst->size)){
        return 1;
     }

     while(ptr < idx-1){
        temp = temp-> next;
        ptr+=1;
     }
     newNode = (Node *)malloc(sizeof(Node));
     newNode->value = value;
     newNode->next = NULL;

     /*if add to end of list*/
     if (idx==lst->size){
        after = NULL;
     }
     /*if add inbetween list*/
     else{
        after = temp->next;
     }
     temp->next = newNode;
     newNode->next = after;
     lst->size+=1;
     return 0;
}

/* lstremove: Removes an element from a linked list at an index. */
void *lstremove(List *lst, unsigned int idx) {
    /* TODO: Complete this function, given:
     *  lst - A pointer to a List structure
     *  idx - A non-negative index
     * ...remove element "idx" of "lst"; return a pointer to the removed
     * element, NULL if "idx" outside the range [0, size - 1]. */
     Node *temp, *returned;
     int ptr=0;
     void *ret;
     /*out of list*/
     if (lst->size ==0 || idx>=lst->size){
        return NULL;
     }
     temp = lst->head;
     if (idx == 0){
        returned = temp;
        lst->head = lst->head->next;
        lst->size -=1;
        ret = returned->value;
        free(returned);
        return ret;
     }
     while(ptr<idx-1){
        temp = temp-> next;
        ptr+=1;
     }
     /*at the end of list*/
     if (idx==lst->size){
        returned = temp->next;
        temp->next = NULL;
        lst->size-=1;
        ret = returned->value;
        free(returned);
        return ret;
     }
     /*inbetween list*/
     returned = temp->next;
     temp->next = temp->next->next;
     lst->size-=1;
     ret = returned->value;
     free(returned);
     return ret;
}

/* lsttoarr: Creates an array from a linked list.*/
void **lsttoarr(List *lst) {
    /* TODO: Complete this function, given:
     *  lst - A pointer to a List structure
     * ...return a dynamically allocated array of void pointers containing the
     * elements of "lst", in the same order.*/
     void **arr;
     int i;
     Node *temp = lst->head;
     arr = (void **)malloc(sizeof(void *) * (lst->size));
     for (i=0; i<lst->size; i++){
        arr[i] = temp->value;
        temp = temp->next;
     }
     return arr;
}

/* arrtolst: Creates a linked list from an array. */
List *arrtolst(void **arr, unsigned int n) {
    /* TODO: Complete this function, given:
     *  arr - An array of void pointers
     *  n   - The length of the given array
     * ...return a pointer to a new, dynamically allocated list containing the
     * elements of "arr", in the same order. */
     int ptr;
     List *list = lstcreate();
     for (ptr=0; ptr<n; ptr++){
        lstadd(list, ptr, *(arr+ptr));
     }
     return list;
}


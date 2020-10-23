#ifndef STACK_H
#define STACK_H
#include "ident.h"
typedef struct Stack{
  void **arr;      
  unsigned int size;       
} Stack;             

extern void init(Stack *);
extern void* top(Stack stack);
extern void push(Stack *stack, void *data);
extern void* pop(Stack *stack);
extern void* print_stack_info(Stack s);
extern unsigned int get_size(Stack stack);

#endif

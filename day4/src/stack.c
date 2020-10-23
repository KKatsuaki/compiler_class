// this is stack library for the compiler class
// authoer Katsukai Kamimae

#include<stdlib.h>
#include<stdio.h>
#include<string.h>

#include "ident.h"

typedef unsigned int uint;

struct Stack{
  struct Ident **arr;
  unsigned int size;
};

void init(struct Stack *stack){
  stack->arr = NULL;
  stack->size = 0;
}

void print_stack_info(struct Stack stack){
  printf("current size is %u\n",stack.size);
}

void push(struct Stack *stack, void* ident){
  Ident*tmp = (Ident*) ident;
  stack->size += 1;
  stack->arr = realloc(stack->arr, sizeof(void *) * stack->size);
  stack->arr[stack->size-1] = ident;
  printf("%s was stacked, ",tmp->name);
  print_stack_info(*stack);
}

void* top(struct Stack stack){
  if (stack.arr == NULL){
    return NULL;
  }else{
    return *(stack.arr + stack.size - 1);
  }
}

void* pop(struct Stack *stack){
  void * tmp;
  if (stack->arr == NULL){
    return NULL;
  }else{
    tmp = *(stack->arr + stack->size - 1);
    stack->arr = realloc(stack->arr, sizeof(void *) * --stack->size + 1);
    if (stack -> arr == NULL){
      return NULL;
    }else{
      return tmp;
    }
  }
}

uint get_size(struct Stack stack){
  return stack.size;  
}

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
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
  //printf("%s was stacked, ",_ident_str(*tmp,0));
  //print_stack_info(*stack);
}

Ident* top(struct Stack stack){
  if (stack.arr == NULL){
    return NULL;
  }else{
    return *(stack.arr + stack.size - 1);
  }
}

Ident* pop(struct Stack *stack){
  Ident* tmp;
  if (stack->arr == NULL){
    return NULL;
  }else{
    tmp = *(stack->arr + stack->size - 1);
    stack->arr = realloc(stack->arr, sizeof(Ident *) * --stack->size + 1);
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

Ident* search(str name, struct Stack s, int eval_method){	   
  int i;				   
  int eval ;
  for(i = s.size-1; i > 0; i--){
    eval = strcmp(s.arr[i]->name, name);
    if(!eval){
      return s.arr[i];		   
    }else if(s.arr[i]->t == NONE && eval_method == 1){
      return NULL;
    }
  }					   
  return NULL;			   
}					   

void remove_til_sep(struct Stack *s){
  Ident **arr;
  Ident *tmp;

  arr = s->arr;

  if(search("SEP",*s,1)){
    while(arr[s->size-1]->t != NONE){
      tmp = pop(s);
      free(tmp);
      s -> size -= 1;
    }
  }
}

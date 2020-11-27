#include <stdio.h>
#include <stdlib.h>

#include "env.h"

list *h, *t;

void addlist(char* name, int offset, int level){
  list *tmp;

  tmp = (list*)malloc(sizeof(list));
  if (tmp == NULL){
    perror("memory allocation");
    exit(EXIT_FAILURE);
  }

  tmp->name   = name;
  tmp->a      = offset;
  tmp->l      = level;

  tmp->prev = t;
  t = tmp;
}

list *search(char* name){
  list *tmp;

  for(tmp=t;
      tmp != h;
      tmp = tmp->prev){
    if (strcmp(name, tmp->name)==0){
      return tmp;
    }
  }

  return NULL;
}

void initialize(){

  /* initialize the list */
  h = (list*)malloc(sizeof(list));
  if (h == NULL){
    perror("memory allocation");
    exit(EXIT_FAILURE);
  }


  t = h;
  h->prev = NULL;
  h->name = "";
}

list* gettail(){
  return t;
}

void sem_error1(char* kind){
  fprintf(stderr,
	  "this identifier has"
	  " been already declared(%s)!\n", kind);
  exit(EXIT_FAILURE);
}

void sem_error2(char* kind){
  fprintf(stderr,
	  "this identifier(%s) has not been declared!\n",
	  kind);
  exit(EXIT_FAILURE);
}

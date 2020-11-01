#include<stdio.h>
#include<stdlib.h>
#include<string.h>

typedef char* str;   
                     
typedef enum Type{   
  CHAR_T,            
  INT_T,             
  NONE,              
} Type;              
                     
typedef struct Ident{
  str name;
  Type t;
  void * val;
} Ident;

str print_type(Type t);

Ident* new_ident(Type type, str name){			  
  Ident *tmp;
  tmp = (Ident*)malloc(sizeof(Ident));
  tmp->name = (str) calloc(strlen(name) + 1, sizeof(char));

  if (tmp->name == NULL){
    exit(-1);
  }
  
  strcpy(tmp->name,name);				  
  tmp->t = type;						  
  tmp->val = NULL;
  return tmp;						  
}

void set_int(Ident *self, int val){
  self->val = (int*) malloc(sizeof(int));
  *(int*)(self->val) = val;
}

int get_int(Ident self){
  return *((int*)self.val);
}

void set_str(Ident *self, char *val){
  self -> val = calloc(strlen(val),sizeof(char));
  strcpy((char*)self->val, val);
}

char *get_str(Ident self){
  return self.val;
}

void print_ident(Ident ident){		   
  printf("type: %s\t%s\n",print_type(ident.t),ident.name);
}

str print_type(Type t){
    switch(t){                         
    case NONE:return "NONE";
    case INT_T:return "INT";
    case CHAR_T:return "CHAR";
    default:return NULL;
    }
}


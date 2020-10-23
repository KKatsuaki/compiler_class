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
} Ident;

str print_type(Type t);

Ident* new_ident(Type type, str name){			  
  Ident *tmp;
  tmp = (Ident*)malloc(sizeof(Ident));
  
  tmp->name = (str) malloc(sizeof(char) * strlen(name) + 1);

  if (tmp->name == NULL){				  
    exit(-1);						  
  }							  
  
  strcpy(tmp->name,name);				  
  tmp->t = type;						  
  
  return tmp;						  
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


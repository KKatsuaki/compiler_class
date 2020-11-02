#include<stdio.h>
#include<stdlib.h>
#include<string.h>

typedef char* str;   
                     
typedef enum Type{   
  CHAR_T,            
  INT_T,             
  NONE,              
} Type;

typedef union Val{
  int int_v;
  char *str_v;
}Val;
                     
typedef struct Ident{
  str name;          
  Type t;
  Val *val;
} Ident;

void set_val(Ident *ident, Val *val);
str _type_str(Type t);

Ident* new_ident(Type type, str name){			  
  Ident *tmp;
  tmp = (Ident*)malloc(sizeof(Ident));
  
  tmp->name = (str) malloc(sizeof(char) * strlen(name) + 1);
  set_val(tmp,NONE);
  if (tmp->name == NULL){				  
    exit(-1);						  
  }							  
  
  strcpy(tmp->name,name);				  
  tmp->t = type;						  
  
  return tmp;						  
}

str _ident_str(Ident i, int show_val){
  str tmp;
  int int_val;
  char *char_val;
  tmp = malloc(sizeof(char) * 255);
  if(show_val){
  switch (i.t){
  case INT_T: {
    sprintf(tmp,"name: %s type: %s val:%d",i.name, _type_str(i.t),i.val->int_v); break;}
  case CHAR_T:{
    sprintf(tmp,"name: %s type: %s val: %s",i.name, _type_str(i.t),i.val->str_v);
    break;
  }
  case NONE:
  default:   sprintf(tmp,"name: %s type: %s",i.name, _type_str(i.t));
  };
  }else{
    sprintf(tmp,"name: %s type: %s",i.name, _type_str(i.t));
  }
  tmp = realloc(tmp, sizeof(char) * strlen(tmp) +1);
  return  tmp;
}

void print_ident(Ident ident, int show_val){		   
  printf("%s\n",_ident_str(ident,show_val));
}

str _type_str(Type t){
    switch(t){                         
    case NONE:return "NONE";
    case INT_T:return "INT";
    case CHAR_T:return "CHAR";
    default:return NULL;
    }
}

Val get_val(Ident ident){
  return *(ident.val);
}

void set_val(Ident *ident, Val *val){
  ident->val = val;
}


#ifndef IDENT_H
#define IDENT_H

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

extern Ident* new_ident(Type type, str name);
extern void print_ident(Ident ident);

#endif

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
  void *val;
} Ident;

extern Ident* new_ident(Type type, str name);
extern void print_ident(Ident ident);
extern void set_int(Ident *, int );
extern void set_str(Ident *, str);
extern int get_int(Ident);
extern str get_str(Ident);
#endif

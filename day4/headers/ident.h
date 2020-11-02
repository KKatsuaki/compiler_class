#ifndef IDENT_H
#define IDENT_H

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
  Val val;           
} Ident;             

extern str _type_str(Type t);
extern str _ident_str(Ident i, int show_val);
extern Ident* new_ident(Type type, str name);
extern void print_ident(Ident ident, int show_val);
extern void set_val(Ident *ident, Val *val);
extern Val get_val(Ident ident);

#endif

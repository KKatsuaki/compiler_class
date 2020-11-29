#ifndef _ENV_H_
#define _ENV_H_

#define SYSTEM_AREA 3

typedef
struct LIST {
  char        *name;
  int          a;
  int          l;
  struct LIST *prev;
} list;


list* search(char*);
void addlist(char*, int, int);

list* gettail();
void initialize();

void sem_error1(char* kind);
void sem_error2(char* kind);


#endif

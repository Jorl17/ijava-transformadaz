#ifndef IDLIST_T_H
#define IDLIST_T_H 1
typedef struct _idlist idlist_t;

struct _idlist
{
	char *name;
	idlist_t *next;
};

#endif

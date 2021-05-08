#include <defs.h>
#include <proc.h>
#include <string.h>
#include <syscall.h>
#include <stdio.h>

int get_pdb(void *base)
{
    return sys_get_pdb(base);
}
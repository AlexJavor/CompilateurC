#include "instru_asm.h"
#include "symbol_table.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void create_add_line(char *name_var1, char *name_var2, char *name_var_res)
{
    int addr1 = find_symbol_by_name(name_var1);
    int addr2 = find_symbol_by_name(name_var2);
    int addr_res = find_symbol_by_name(name_var_res);
    printf("ADD %d %d %d\n", addr_res, addr1, addr2);
}

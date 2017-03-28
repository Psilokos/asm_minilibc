#include <stdio.h>
#include <stdlib.h>
#include "asm-minilibc.h"

int		main(__attribute__ (( unused )) int argc, char *argv[])
{
  char		*foobar = malloc(strlen(argv[1]) + 1);

  puts(memmove(foobar, argv[1], strlen(argv[1]) + 1));
  return (EXIT_SUCCESS);
}

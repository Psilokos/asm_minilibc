#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/time.h>
#include "asm-minilibc.h"

#define BUF_SIZE	(43)

static inline void	measure_time(char *fct_name);
static inline void	print_time(void);

struct timeval	last_time;

typedef struct __attribute__ (( packed ))	no_pad
{
  char						lol[BUF_SIZE];	/* defined last  => lower in memory */
  char						lel[BUF_SIZE];	/* defined first => higher in memory */
}						no_pad;

int		main(__attribute__ (( unused )) int argc, char *argv[])
{
  no_pad	np = {0};
  char		*lel = "&-------ThIs Is A tEsT!-------&";
  char		*lol = "&-------This is a taste!-------&";
  char		*lul = "utgi";
  char		*lil = "s! ";
  char		*lal = "- &";

  printf("strlen(\"%s\") => %ld\n", argv[1], strlen(argv[1]));
  printf("strcmp(\"%s\", \"%s\") => %d\n", argv[1], argv[2], strcmp(argv[1], argv[2]));
  printf("strncmp(\"%s\", \"%s\", %ld) => %d\n", argv[1], argv[2], strlen(argv[2]), strncmp(argv[1], argv[2], strlen(argv[2])));
  printf("memcmp(\"%s\", \"%s\", %ld) => %d\n", argv[1], argv[2], strlen(argv[2]), memcmp(argv[1], argv[2], strlen(argv[2])));
  printf("memset(lol, '%c', %ld) => \"%s\"\n", 42, BUF_SIZE - 1, memset(np.lol, 42, BUF_SIZE - 1));
  printf("strchr(\"%s\"(0x%016x), '%c') => 0x%016x\n",
  	 argv[1], argv[1], *argv[3], strchr(argv[1], *argv[3]));
  printf("strrchr(\"%s\"(0x%016x), '%c') => 0x%016x\n",
  	 argv[1], argv[1], *argv[3], strrchr(argv[1], *argv[3]));
  printf("memcpy(lel, lol, %ld) => \"%s\"\n", (BUF_SIZE - 1) / 2,
  	 memcpy(np.lel, np.lol, (BUF_SIZE - 1) / 2));
  printf("memset(lol + %ld, '%c', %ld) => \"%s\"\n", (BUF_SIZE - 1) / 2, '#',
  	 (BUF_SIZE - 1) / 2, memset(np.lol + (BUF_SIZE - 1) / 2, '#', (BUF_SIZE - 1) / 2));
  np.lol[BUF_SIZE - 1] = '$';
  printf("memmove(lel, lol + %ld, %ld) => \"%s\"\n", (BUF_SIZE - 1) / 2,
  	 BUF_SIZE - 1, memmove(np.lel, np.lol + (BUF_SIZE - 1) / 2, BUF_SIZE - 1));
  np.lol[BUF_SIZE - 1] = 0;
  printf("strcasecmp(\"%s\", \"%s\") => %d\n", lel, lol, strcasecmp(lel, lol));
  printf("strncasecmp(\"%s\", \"%s\", %ld) => %d\n", lel, lol, strlen(lol), strncasecmp(lel, lol, strlen(lol)));
  printf("strstr(\"%s\", \"%s\") => \"%s\"\n", argv[1], argv[2], strstr(argv[1], argv[2]));
  printf("strpbrk(\"%s\", \"%s\") => \"%s\"\n", lel, lul, strpbrk(lel, lul));
  printf("strcpbrk(\"%s\", \"%s\") => \"%s\"\n", lel, lal, strcpbrk(lel, lal));
  printf("strcspn(\"%s\", \"%s\") => %ld\n", lol, lil, strcspn(lol, lil));
  return (EXIT_SUCCESS);
}

static inline void	measure_time(char *fct_name)
{
  printf("%s: ", fct_name);
  fflush(stdout);
  gettimeofday(&last_time, NULL);
}

static inline void	print_time(void)
{
  struct timeval	cur_time;

  gettimeofday(&cur_time, NULL);
  cur_time.tv_sec -= last_time.tv_sec;
  if ((cur_time.tv_usec -= last_time.tv_usec) < 0)
    {
      --cur_time.tv_sec;
      cur_time.tv_usec += 1000000;
    }
  printf("%d.%06ds\n", cur_time.tv_sec, cur_time.tv_usec);
}

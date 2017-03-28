/*
** asm-minilibc.h for asm-minilibc in /home/lecouv/rendu/asm_minilibc
** 
** Made by Victorien LE COUVIOUR--TUFFET
** Login   <lecouv@epitech.eu>
** 
** Started on  Wed Mar  9 19:16:51 2016 Victorien LE COUVIOUR--TUFFET
** Last update Mon Mar 14 21:26:48 2016 Victorien LE COUVIOUR--TUFFET
*/

#ifndef ASM_MINILIBC_H_
# define ASM_MINILIBC_H_

/*
** string related
*/
char		*index(char const *s, int c);	/* deprecated: use strchr */
char		*rindex(char const *s, int c);	/* deprecated: use strrchr */
char		*strchr(char const *s, int c);
char		*strrchr(char const *s, int c);
char		*strstr(char const *haystack, char const *needle);
char		*strpbrk(char const *s, char const *accept);
char		*strcpbrk(char const *s, char const *reject);
size_t		strlen(char const *s);
int		strcmp(char const *s1, char const *s2);
int		strncmp(char const *s1, char const *s2, size_t n);
int		strcasecmp(char const *s1, char const *s2);
int		strncasecmp(char const *s1, char const *s2, size_t n);

/*
** memory related
*/
int		memcmp(void const *s1, void const *s2, size_t n);
void		*memcpy(void *dest, void const *src, size_t n);
void		*memmove(void *dest, void const *src, size_t n);
void		*memset(void *s, int c, size_t n);

#endif

##
## Makefile for asm_minilibc in /home/lecouv/rendu/asm_minilibc
## 
## Made by Victorien LE COUVIOUR--TUFFET
## Login   <lecouv@epitech.eu>
## 
## Started on  Mon Feb 15 23:01:32 2016 Victorien LE COUVIOUR--TUFFET
## Last update Mon Mar 14 22:04:02 2016 Victorien LE COUVIOUR--TUFFET
##

ifndef ARCH
	ARCH	= x86_64
endif

NAME		= libasm.so

SRC_DIR		= $(ARCH)-src/

AS		= nasm
ASFLAGS_i386	= -f elf32 -i $(SRC_DIR)
ASFLAGS_x86_64	= -f elf64 -i $(SRC_DIR)

LD		= ld
LDFLAGS		= -shared --export-dynamic -m elf_$(ARCH)

SRCS		= $(SRC_DIR)memcmp.s		\
		  $(SRC_DIR)memcpy.s		\
		  $(SRC_DIR)memmove.s		\
		  $(SRC_DIR)memset.s		\
		  $(SRC_DIR)strcasecmp.s	\
		  $(SRC_DIR)strchr.s		\
		  $(SRC_DIR)strcmp.s		\
		  $(SRC_DIR)strcpbrk.s		\
		  $(SRC_DIR)strcspn.s		\
		  $(SRC_DIR)strlen.s		\
		  $(SRC_DIR)strncasecmp.s	\
		  $(SRC_DIR)strncmp.s		\
		  $(SRC_DIR)strpbrk.s		\
		  $(SRC_DIR)strrchr.s		\
		  $(SRC_DIR)strstr.s		\
		  $(SRC_DIR)tolower.s		\
		  $(SRC_DIR)toupper.s

OBJS		= $(SRCS:.s=.o)

RM		= rm -f

all:		$(NAME)

$(NAME):	$(OBJS)
		$(LD) $(LDFLAGS) $(OBJS) -o $@

%.o:		%.s
		$(AS) $(ASFLAGS_$(ARCH)) $< -o $@

clean:
		$(RM) $(OBJS)

fclean:		clean
		$(RM) $(NAME)

re:		fclean all

.PHONY:		all clean fclean re

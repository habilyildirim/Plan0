#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

void clear_screen()
{
	write(1, "\033[2J\033[H", 7);
}

void init_output(char* out)
{
	write(1, out, strlen(out));
}

int main()
{
	init_output("Starting System...\n");
	sleep(1);
	clear_screen();

	init_output("OK> ");
    return 0;
}

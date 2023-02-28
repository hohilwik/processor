#include<stdio.h>
#include<string.h>
#include<stdlib.h>
int main()
{
	system("xxd -ps -c 1 prog_binary.out > prog_hex.txt");
	FILE *prog_bin;
	FILE *arr_gen;
	prog_bin = fopen("prog_hex.txt", "r");
	arr_gen = fopen("arr_generated.txt", "w+");
	
	//proc_mem[index] = 8'h//
	
	int index=0;
	//char str[10];
	char *str = NULL;
	size_t line_buf_size = 0;
	
	
	while( !feof(prog_bin) )
	{
		//fscanf(prog_bin, "%[^\n]s", str);
		getline(&str, &line_buf_size, prog_bin);
		str[line_buf_size-1]='\0';
		fprintf(arr_gen, "proc_mem[%d] = 8'h", index);
		fprintf(arr_gen, "%s;\n", str);
		index++;
	}
	
	fclose(prog_bin);
	
	for(int i=index; i<2048; i++)
	{
		fprintf(arr_gen, "proc_mem[%d] = 8'h", i);
		fprintf(arr_gen, "00;\n");
	}
	
	fclose(arr_gen);
	
	return 0;
	
}